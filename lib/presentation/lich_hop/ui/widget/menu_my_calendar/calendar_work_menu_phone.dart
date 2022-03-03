import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCalendarMenu extends StatefulWidget {
  final CalenderCubit cubit;

  const MyCalendarMenu({Key? key, required this.cubit}) : super(key: key);

  @override
  State<MyCalendarMenu> createState() => _MyCalendarMenuState();
}

class _MyCalendarMenuState extends State<MyCalendarMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 58,
          ),
          headerWidget(menu: S.current.hop),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                StreamBuilder<List<bool>>(
                  stream: widget.cubit.selectTypeCalendarSubject.stream,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        TheoDangLichWidget(
                          icon: ImageAssets.icTheoDangLich,
                          name: S.current.theo_dang_lich,
                          onTap: () {
                            widget.cubit.selectTypeCalendarSubject
                                .add([true, false]);
                            widget.cubit.chooseTypeListLv(
                                Type_Choose_Option_List.DANG_LICH);
                            Navigator.pop(context);
                          },
                          isSelect: snapshot.data?[0] ?? true,
                        ),
                        TheoDangLichWidget(
                          icon: ImageAssets.icTheoDangDanhSachGrey,
                          name: S.current.theo_dang_danh_sach,
                          onTap: () {
                            widget.cubit.selectTypeCalendarSubject
                                .add([false, true]);
                            widget.cubit.chooseTypeListLv(
                                Type_Choose_Option_List.DANG_LIST);
                            Navigator.pop(context);
                          },
                          isSelect: snapshot.data?[1] ?? true,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: bgDropDown,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: listThongBaoMyCalendar
                          .map(
                            (e) => ContainerMenuWidget(
                              name: e.typeMenu.getTitle(),
                              icon: e.icon,
                              type: e.type,
                              index: e.index ?? 0,
                              childExpand: Column(
                                children: e.typeMenu ==
                                        TypeCalendarMenu.LichCuaToi || e.typeMenu ==
                                    TypeCalendarMenu.LichHopLanhDao
                                    ? listTheoTrangThai
                                        .map(
                                          (e) => ContainerMenuWidget(
                                            icon: e.icon,
                                            name: e.typeMenu.getTitle(),
                                            index: e.index ?? 0,
                                            isIcon: false,
                                            onTap: () {
                                              e.onTap(
                                                  context, widget.cubit);
                                            },
                                          ),
                                        )
                                        .toList()
                                    : listBaoCaoThongKe
                                        .map(
                                          (e) => ContainerMenuWidget(
                                            icon: e.icon,
                                            name: e.typeMenu.getTitle(),
                                            index: e.index ?? 0,
                                            isIcon: false,
                                            onTap: () {
                                              e.onTap(
                                                  context, widget.cubit);
                                            },
                                          ),
                                        )
                                        .toList(),
                              ),
                              onTap: () {
                                e.onTap(context, widget.cubit);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerWidget({required String menu}) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(ImageAssets.icHeaderLVVV),
        const SizedBox(
          width: 12,
        ),
        Text(
          menu,
          style: textNormalCustom(
            color: titleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
