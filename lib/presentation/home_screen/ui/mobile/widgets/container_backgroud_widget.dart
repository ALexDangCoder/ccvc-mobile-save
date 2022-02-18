import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/select_key_row.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContainerBackgroundWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final String urlIcon;
  final Widget? leadingIcon;
  final Widget? dialogSelect;
  final EdgeInsetsGeometry? padding;
  final Function()? onTapIcon;
  final double spacingTitle;
  final EdgeInsetsGeometry paddingChild;
  final SelectKeyDialog? selectKeyDialog;
  final bool isUnit;
  final double minHeight;
  final List<SelectKey>? listSelect;
  final Function(SelectKey)? onChangeKey;
  const ContainerBackgroundWidget({
    Key? key,
    required this.child,
    required this.title,
    this.urlIcon = ImageAssets.icMore,
    this.leadingIcon,
    this.dialogSelect,
    this.padding,
    this.onTapIcon,
    this.spacingTitle = 20,
    this.paddingChild = const EdgeInsets.symmetric(vertical: 20),
    this.selectKeyDialog,
    this.isUnit = false,
    this.minHeight = 465,
    this.listSelect,
    this.onChangeKey,
  }) : super(key: key);

  @override
  _ContainerBackgroudWidgetState createState() =>
      _ContainerBackgroudWidgetState();
}

class _ContainerBackgroudWidgetState extends State<ContainerBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.getInstance().backGroundColor(),
      padding: widget.paddingChild,
      margin: const EdgeInsets.only(top: 6),
      constraints: BoxConstraints(minHeight: widget.minHeight),
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MouseRegion(
                          onHover: (_) {
                            HomeProvider.of(context).homeCubit.closeDialog();
                          },
                          child: Row(
                            children: [
                              if (widget.leadingIcon == null)
                                const SizedBox()
                              else
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: widget.leadingIcon,
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: textNormalCustom(
                                      fontSize: 16,
                                      color:
                                          AppTheme.getInstance().titleColor(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  if (widget.selectKeyDialog != null)
                                    StreamBuilder<bool>(
                                      stream: widget.selectKeyDialog!
                                          .selectKeyDialog.stream,
                                      builder: (context, snapshot) {
                                        return Text(
                                          subTitle(),
                                          style: textNormal(textBodyTime, 12),
                                        );
                                      },
                                    )
                                  else
                                    const SizedBox()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.onTapIcon != null) {
                            widget.onTapIcon!();
                          } else {}
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.transparent,
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(widget.urlIcon),
                        ),
                      )
                    ],
                  ),
                ),
                if (widget.listSelect == null)
                  const SizedBox()
                else
                  Container(
                    margin: const EdgeInsets.only(top: 17),
                    height: 32,
                    color: Colors.transparent,
                    width: double.infinity,
                    child: SelectKeyRow(
                      listSelect: widget.listSelect!,
                      onChange: (value) {
                        if (widget.onChangeKey != null) {
                          HomeProvider.of(context).homeCubit.closeDialog();
                          widget.onChangeKey!(value);
                        }
                      },
                    ),
                  ),
                SizedBox(
                  height: widget.spacingTitle,
                ),
                MouseRegion(
                  onHover: (_) {
                    HomeProvider.of(context).homeCubit.closeDialog();
                  },
                  child: Padding(
                    padding: widget.padding ??
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                    child: widget.child,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 16,
            child: widget.dialogSelect ?? const SizedBox(),
          )
        ],
      ),
    );
  }

  String subTitle() {
    final data = widget.selectKeyDialog;
    if (widget.isUnit) {
      if (data?.selectKeyTime == SelectKey.TUY_CHON) {
        return '${data!.selectKeyDonVi.getText()} - ${data.startDate.toStringWithListFormat} - ${data.endDate.toStringWithListFormat}';
      }
      return '${data!.selectKeyDonVi.getText()} - ${data.selectKeyTime.getText()}';
    }
    if (data?.selectKeyTime == SelectKey.TUY_CHON) {
      return '${data!.startDate.toStringWithListFormat} - ${data.endDate.toStringWithListFormat}';
    }
    return data!.selectKeyTime.getText();
  }
}
