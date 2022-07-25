import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectSearchDonViWidget extends StatefulWidget {
  final ThemDonViCubit themDonViCubit;
  final List<Node<DonViModel>> data;

  const SelectSearchDonViWidget(
      {Key? key, required this.themDonViCubit, this.data = const []})
      : super(key: key);

  @override
  State<SelectSearchDonViWidget> createState() =>
      _SelectSearchDonViWidgetState();
}

class _SelectSearchDonViWidgetState extends State<SelectSearchDonViWidget> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    widget.themDonViCubit.selectNode.addAll(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Node<DonViModel>>>(
      stream: widget.themDonViCubit.selectDonVi,
      initialData: widget.data,
      builder: (context, snapshot) {
        final data = snapshot.data ?? <Node<DonViModel>>[];
        if (data.isNotEmpty) {
          return SelectDonViCell(
            controller: controller,
            listSelect: data,
            onChange: (value) {
              widget.themDonViCubit.onSearch(value);
            },
            onDelete: (value) {
              widget.themDonViCubit.removeTag(value);
            },
          );
        } else {
          return BaseSearchBar(
            hintText: S.current.nhap_ten_don_vi_phong_ban,
            controller: controller,
            onChange: (value) {
              widget.themDonViCubit.onSearch(value);
            },
          );
        }
      },
    );
  }
}

class SelectDonViCell extends StatelessWidget {
  final List<Node<DonViModel>> listSelect;
  final Function(Node<DonViModel>) onDelete;
  final TextEditingController controller;
  final Function(String) onChange;

  const SelectDonViCell({
    Key? key,
    required this.listSelect,
    required this.onDelete,
    required this.controller,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(7.0.textScale(space: 5)),
      decoration: BoxDecoration(
          boxShadow: APP_DEVICE == DeviceType.MOBILE
              ? []
              : [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  )
                ],
          border: Border.all(
            color: APP_DEVICE == DeviceType.MOBILE
                ? borderButtomColor
                : borderColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.all(Radius.circular(6.0.textScale())),
          color: Colors.white),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(listSelect.length + 1, (index) {
          if (index == listSelect.length) {
            return Container(
              width: 200,
              color: Colors.transparent,
              child: TextField(
                onChanged: onChange,
                controller: controller,
                style: textNormal(textTitle, 14.0.textScale()),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
              ),
            );
          }
          final data = listSelect[index];
          return tag(
            title: data.value.name,
            onDelete: () {
              onDelete(data);
            },
          );
        }),
      ),
    );
  }

  Widget tag({required String title, required Function onDelete}) {
    return GestureDetector(
      onTap: () {
        onDelete();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: APP_DEVICE == DeviceType.MOBILE
              ? AppTheme.getInstance().colorField().withOpacity(0.1)
              : AppTheme.getInstance().colorField(),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                style: textNormal(
                  APP_DEVICE == DeviceType.MOBILE
                      ? AppTheme.getInstance().colorField()
                      : backgroundColorApp,
                  12.0.textScale(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onDelete();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 9.25),
                child: SvgPicture.asset(
                  ImageAssets.icClose,
                  width: 7.5,
                  height: 7.5,
                  color: APP_DEVICE == DeviceType.MOBILE
                      ? AppTheme.getInstance().colorField()
                      : backgroundColorApp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
