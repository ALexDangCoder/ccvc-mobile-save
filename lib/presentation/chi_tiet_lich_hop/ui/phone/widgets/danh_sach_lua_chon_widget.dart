import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lua_chon_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhSachLuaChonWidget extends StatefulWidget {
  final Function(List<SuaDanhSachLuaChonModel>) onchange;
  final DetailMeetCalenderCubit detailMeetCalenderCubit;
  final List<SuaDanhSachLuaChonModel> initData;

  const DanhSachLuaChonWidget({
    Key? key,
    required this.detailMeetCalenderCubit,
    required this.onchange,
    required this.initData,
  }) : super(key: key);

  @override
  State<DanhSachLuaChonWidget> createState() => _DanhSachLuaChonWidgetState();
}

class _DanhSachLuaChonWidgetState extends State<DanhSachLuaChonWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SuaDanhSachLuaChonModel>>(
      stream: widget.detailMeetCalenderCubit.suaDanhSachLuaChon,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return SelectDonViCell(
          controller: controller,
          initData: data,
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
  final TextEditingController controller;
  late List<SuaDanhSachLuaChonModel> initData;
  final DetailMeetCalenderCubit cubit;
  final Function(List<SuaDanhSachLuaChonModel>) onchange;

  SelectDonViCell({
    Key? key,
    required this.controller,
    required this.initData,
    required this.cubit,
    required this.onchange,
  }) : super(key: key);

  @override
  State<SelectDonViCell> createState() => _SelectDonViCellState();
}

class _SelectDonViCellState extends State<SelectDonViCell> {
  @override
  void initState() {
    widget.cubit.addLuaChon.clear();
    widget.cubit.danhSachLuaChonNew.clear();
    super.initState();
  }

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
          ...widget.initData
              .map(
                (e) => tag(
                  title: e.tenLuaChon ?? '',
                  onDelete: () {
                    final listOld =
                        widget.cubit.suaDanhSachLuaChon.valueOrNull ?? [];
                    listOld.removeWhere(
                      (element) => e.tenLuaChon == element.tenLuaChon,
                    );
                    widget.cubit.suaDanhSachLuaChon.sink.add(listOld);
                    widget.onchange(listOld);
                  },
                ),
              )
              .toList(),
          Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.transparent,
                child: TextField(
                  maxLength: 30,
                  controller: widget.controller,
                  style: textNormal(textTitle, 14.0.textScale()),
                  decoration: const InputDecoration(
                    isDense: true,
                    counter: SizedBox(),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    isCollapsed: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: GestureDetector(
                  onTap: () {
                    if (widget.controller.text.trim().isNotEmpty) {
                      widget.cubit.danhSachLuaChonNew = widget.cubit
                          .paserListString([widget.controller.text.trim()]);
                      widget.cubit.suaDanhSachLuaChon.sink.add([
                        ...widget.initData,
                        ...widget.cubit.danhSachLuaChonNew
                      ]);
                      widget.controller.text = '';
                      widget.onchange([
                        ...widget.initData,
                        ...widget.cubit.danhSachLuaChonNew
                      ]);
                    }
                  },
                  child: SvgPicture.asset(ImageAssets.ic_plus_bieu_quyet),
                ),
              )
            ],
          ),
        ],
      ),
    );
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
