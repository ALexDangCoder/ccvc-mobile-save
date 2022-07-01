import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CacLuaChonDonViWidget extends StatefulWidget {
  final Function(List<String>) onchange;
  final DetailMeetCalenderCubit detailMeetCalenderCubit;

  const CacLuaChonDonViWidget({
    Key? key,
    required this.detailMeetCalenderCubit,
    required this.onchange,
  }) : super(key: key);

  @override
  State<CacLuaChonDonViWidget> createState() => _CacLuaChonDonViWidgetState();
}

class _CacLuaChonDonViWidgetState extends State<CacLuaChonDonViWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.detailMeetCalenderCubit.themBieuQuyet,
      builder: (context, snapshot) {
        return SelectDonViCell(
          controller: controller,
          listSelect: widget.detailMeetCalenderCubit.cacLuaChonBieuQuyet,
          onSubmitted: (value) {
            if (value != '') {
              widget.detailMeetCalenderCubit.addValueToList(value);
              controller.text = '';
              widget
                  .onchange(widget.detailMeetCalenderCubit.cacLuaChonBieuQuyet);
            }
          },
          onDelete: (value) {
            widget.detailMeetCalenderCubit.removeTag(value);
            widget.onchange(widget.detailMeetCalenderCubit.cacLuaChonBieuQuyet);

            setState(() {});
          },
        );
      },
    );
  }
}

class SelectDonViCell extends StatelessWidget {
  final List<String> listSelect;
  final Function(String) onDelete;
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const SelectDonViCell({
    Key? key,
    required this.listSelect,
    required this.onDelete,
    required this.controller,
    required this.onSubmitted,
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
        color: Colors.white,
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(listSelect.length + 1, (index) {
          if (index == listSelect.length) {
            return Container(
              width: double.infinity,
              color: Colors.transparent,
              child: TextField(
                maxLength: 30,
                onSubmitted: onSubmitted,
                controller: controller,
                style: textNormal(textTitle, 14.0.textScale()),
                decoration: const InputDecoration(
                  isDense: true,
                  counter: SizedBox(),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
              ),
            );
          }
          final data = listSelect[index];
          return tag(
            title: data,
            onDelete: () {
              onDelete(data);
            },
          );
        }),
      ),
    );
  }

  Widget tag({required String title, required Function onDelete}) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: APP_DEVICE == DeviceType.MOBILE ? bgTag : labelColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            child: Text(
              title,
              style: textNormal(
                APP_DEVICE == DeviceType.MOBILE
                    ? linkColor
                    : backgroundColorApp,
                12.0.textScale(),
              ),
              overflow: TextOverflow.ellipsis,
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
                    ? labelColor
                    : backgroundColorApp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
