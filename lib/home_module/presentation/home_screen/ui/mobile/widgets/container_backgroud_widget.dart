import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/widgets/select_key_row.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/enum_ext.dart';

class ContainerBackgroundWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final String urlIcon;
  final Widget? leadingIcon;
  final Widget? dialogSelect;
  final EdgeInsetsGeometry? padding;
  final Function()? onTapIcon;
  final double spacingTitle;
  final bool isShowSubTitle;
  final EdgeInsetsGeometry paddingChild;
  final SelectKeyDialog? selectKeyDialog;
  final bool isUnit;
  final double minHeight;
  final List<SelectKey>? listSelect;
  final Function(SelectKey)? onChangeKey;
  final bool isCustomDialog;
  final Function()? onTapTitle;
  final bool isShowCaNhan;

  const ContainerBackgroundWidget({
    Key? key,
    required this.child,
    required this.title,
    this.urlIcon = ImageAssets.icMore,
    this.leadingIcon,
    this.dialogSelect,
    this.padding,
    this.onTapIcon,
    this.isShowSubTitle = true,
    this.spacingTitle = 20,
    this.paddingChild = const EdgeInsets.symmetric(vertical: 20),
    this.selectKeyDialog,
    this.isUnit = false,
    this.minHeight = 465,
    this.listSelect,
    this.onChangeKey,
    this.isShowCaNhan = false,
    this.isCustomDialog = false,
    this.onTapTitle,
  }) : super(key: key);

  @override
  _ContainerBackgroudWidgetState createState() =>
      _ContainerBackgroudWidgetState();
}

class _ContainerBackgroudWidgetState extends State<ContainerBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorApp,
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
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.onTapTitle != null) {
                                        widget.onTapTitle!();
                                      }
                                    },
                                    child: Text(
                                      widget.title,
                                      style: textNormalCustom(
                                        fontSize: 16,
                                        color: textTitle,
                                      ),
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
                                        return widget.isShowSubTitle
                                            ? Text(
                                                subTitle(
                                                  isShowCaNhan:
                                                      widget.isShowCaNhan,
                                                ),
                                                style: textNormal(
                                                  textBodyTime,
                                                  12,
                                                ),
                                              )
                                            : const SizedBox();
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
                      if (widget.isCustomDialog)
                        GestureDetector(
                          onTap: () {
                            if (widget.onTapIcon != null) {
                              widget.onTapIcon!();
                            } else {}
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            color: Colors.transparent,
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                              widget.urlIcon,
                              color: AppTheme.getInstance().colorSelect(),
                            ),
                          ),
                        )
                      else
                        widget.dialogSelect ?? const SizedBox()
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
          if (widget.isCustomDialog)
            Positioned(
              top: 30,
              right: 16,
              child: widget.dialogSelect ?? const SizedBox(),
            )
          else
            const SizedBox()
        ],
      ),
    );
  }

  String subTitle({bool isShowCaNhan = false}) {
    final data = widget.selectKeyDialog;
    if (widget.isUnit) {
      // if (data?.selectKeyTime == SelectKey.TUY_CHON) {
      //   return '${data!.selectKeyDonVi.getText()} - ${data.startDate.toStringWithListFormat} - ${data.endDate.toStringWithListFormat}';
      // }
      return '${data!.selectKeyDonVi.getText()}';
    }
    return isShowCaNhan
        ? '${S.current.ca_nhan} - ${data!.selectKeyTime.getText()}'
        : '${data!.selectKeyTime.getText()}';
  }
}
