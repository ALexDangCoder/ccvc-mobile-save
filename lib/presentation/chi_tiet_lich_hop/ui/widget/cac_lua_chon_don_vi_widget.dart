import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return StreamBuilder<List<String>>(
      stream: widget.detailMeetCalenderCubit.themLuaChonBieuQuyet,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return SelectDonViCell(
          controller: controller,
          listSelect: data,
          cubit: widget.detailMeetCalenderCubit,
          onchange: (value) {
            widget.onchange(value);
          },
        );
      },
    );
  }
}

class SelectDonViCell extends StatefulWidget {
  final List<String> listSelect;
  final TextEditingController controller;
  final DetailMeetCalenderCubit cubit;
  final Function(List<String>) onchange;

  const SelectDonViCell({
    Key? key,
    required this.listSelect,
    required this.controller,
    required this.cubit,
    required this.onchange,
  }) : super(key: key);

  @override
  State<SelectDonViCell> createState() => _SelectDonViCellState();
}

class _SelectDonViCellState extends State<SelectDonViCell> {
  int? maxLength;

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
        children: [
          ...widget.listSelect
              .map(
                (e) => tag(
                  title: e,
                  onDelete: () {
                    final mList = widget.cubit.listThemLuaChon;
                    mList.remove(e);
                    widget.cubit.themLuaChonBieuQuyet.sink.add(mList);
                    widget.onchange(mList);
                  },
                ),
              )
              .toList(),
          Container(
            width: double.infinity,
            color: Colors.transparent,
            child: TextField(
              maxLength: maxLength,
              controller: widget.controller,
              style: textNormal(textTitle, 14.0.textScale()),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (widget.controller.text.trim().isNotEmpty) {
                      widget.cubit.listThemLuaChon
                          .add(getNameNoSpace(widget.controller.text));
                      widget.cubit.themLuaChonBieuQuyet.sink
                          .add(widget.cubit.listThemLuaChon);
                      widget.onchange(widget.cubit.listThemLuaChon);
                      widget.controller.text = '';
                    }
                  },
                  child: SvgPicture.asset(
                    ImageAssets.ic_plus_bieu_quyet,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(),
                isDense: true,
                counter: const SizedBox.shrink(),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                isCollapsed: true,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                final name = getNameNoSpace(value);
                setState(() {
                  maxLength = name.length >= 30 ? value.length : null;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  String getNameNoSpace(String text) {
    final textTrim = text.trim();
    String name = '';
    for (int index = 0; index < textTrim.length; index++) {
      if (name.isEmpty) {
        name += textTrim[index];
      } else if (!(name[name.length - 1] == ' ' && textTrim[index] == ' ')) {
        name += textTrim[index];
      }
    }
    return name;
  }

  Widget tag({required String title, required Function onDelete}) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().colorField().withOpacity(0.1),
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
                AppTheme.getInstance().colorField(),
                12.0.textScale(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              onDelete();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 9.25),
              color: Colors.transparent,
              child: SvgPicture.asset(
                ImageAssets.icClose,
                width: 7.5,
                height: 7.5,
                color: AppTheme.getInstance().colorField(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
