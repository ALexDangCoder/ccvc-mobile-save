import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCalendarMenuTablet extends StatefulWidget {
  final CalenderCubit cubit;
  const MyCalendarMenuTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _MyCalendarMenuTabletState createState() => _MyCalendarMenuTabletState();
}

class _MyCalendarMenuTabletState extends State<MyCalendarMenuTablet> {
  CalenderCubit cubit = CalenderCubit();

  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;
    cubit.selectTypeCalendarSubject.add([true, false]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.hop,
        leadingIcon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: 10,
            width: 10,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset(
                ImageAssets.icExit,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<List<bool>>(
          stream: cubit.selectTypeCalendarSubject.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                TheoDangLichWidget(
                  icon: ImageAssets.icTheoDangLich,
                  name: S.current.theo_dang_lich,
                  onTap: () {
                    cubit.selectTypeCalendarSubject.add([true, false]);
                    cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LICH);
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[0] ?? true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
                TheoDangLichWidget(
                  icon: ImageAssets.icTheoDangDanhSachGrey,
                  name: S.current.theo_dang_danh_sach,
                  onTap: () {
                    cubit.selectTypeCalendarSubject.add([false, true]);
                    cubit.chooseTypeListLv(Type_Choose_Option_List.DANG_LIST);
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[1] ?? true,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: bgDropDown,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: listThongBaoMyCalendar
                            .map(
                              (e) => ContainerMenuWidgetTablet(
                                name: e.typeMenu.getTitle(),
                                icon: e.icon,
                                type: e.type,
                                index: e.index ?? 0,
                                childExpand: Column(
                                  children: e.typeMenu == TypeCalendarMenu.LichTheoLanhDao
                                      ? listTheoTrangThai
                                          .map(
                                            (e) => ContainerMenuWidgetTablet(
                                              icon: e.icon,
                                              name: e.typeMenu.getTitle(),
                                              index: e.index ?? 0,
                                              isIcon: false,
                                              onTap: () {
                                                e.onTap(context, cubit);
                                              },
                                            ),
                                          )
                                          .toList()
                                      : listLanhDao
                                          .map(
                                            (e) => ContainerMenuWidgetTablet(
                                              icon: e.icon,
                                              name: e.typeMenu.getTitle(),
                                              index: e.index ?? 0,
                                              isIcon: false,
                                              onTap: () {
                                                e.onTap(context, cubit);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                                onTap: () {
                                  e.onTap(context, cubit);
                                },
                              ),
                            )
                            .toList(),
                        // ContainerMenuWidgetTablet(
                        //   name: S.current.lich_cua_toi,
                        //   icon: ImageAssets.icPersonWork,
                        //   childExpand: Container(),
                        //   onTap: () {},
                        // ),
                        // MediaQuery.removePadding(
                        //   context: context,
                        //   removeTop: true,
                        //   child: ContainerMenuWidgetTablet(
                        //     name: S.current.lich_theo_trang_thai,
                        //     icon: ImageAssets.icTheoDangLichCir,
                        //     childExpand: Column(
                        //       children: lichTheoTrangThai
                        //           .map(
                        //             (e) => ContainerMenuWidgetTablet(
                        //               name: e.name,
                        //               onTap: () {
                        //                 e.navigator(context, cubit);
                        //               },
                        //               icon: '',
                        //               index: e.index,
                        //             ),
                        //           )
                        //           .toList(),
                        //     ),
                        //     type: TypeContainer.expand,
                        //     onTap: () {},
                        //   ),
                        // ),
                        // MediaQuery.removePadding(
                        //   context: context,
                        //   removeTop: true,
                        //   child: ContainerMenuWidgetTablet(
                        //     name: S.current.lich_theo_lanh_dao,
                        //     icon: ImageAssets.icLichLanhDaoCir,
                        //     childExpand: Column(
                        //       children: lichLanhDao
                        //           .map((e) => ContainerMenuWidgetTablet(
                        //                 onTap: () {
                        //                   e.navigator(context, cubit);
                        //                 },
                        //                 icon: '',
                        //                 name: e.name,
                        //                 index: e.index,
                        //               ),)
                        //           .toList(),
                        //     ),
                        //     type: TypeContainer.expand,
                        //     onTap: () {},
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
