import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/menu/menu_calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuWidget extends StatefulWidget {
  final bool isBaoCaoThongKe;
  final Function(String typeCalendar) onTap;
  final Stream<DashBoardLichHopModel> streamDashBoard;
  final List<ItemThongBaoModelMyCalender> listItem;
  final Function(MenuModel model) onTapLanhDao;
  final MenuCalendarCubit cubit;
  final String title;

  const MenuWidget({
    Key? key,
    this.isBaoCaoThongKe = true,
    required this.onTap,
    required this.listItem,
    required this.onTapLanhDao,
    required this.cubit,
    required this.streamDashBoard,
    required this.title,
  }) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 58,
            ),
            headerWidget(menu: widget.title),
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
                                  .add([true, false, false]);
                              widget.onTap(S.current.theo_dang_lich);
                              Navigator.pop(
                                context,
                                TypeCalendarMenu.LichCuaToi,
                              );
                            },
                            isSelect: snapshot.data?[0] ?? true,
                          ),
                          TheoDangLichWidget(
                            icon: ImageAssets.icTheoDangDanhSachGrey,
                            name: S.current.theo_dang_danh_sach,
                            onTap: () {
                              widget.cubit.selectTypeCalendarSubject
                                  .add([false, true, false]);
                              widget.onTap(S.current.theo_dang_danh_sach);
                              Navigator.pop(
                                context,
                                TypeCalendarMenu.LichCuaToi,
                              );
                            },
                            isSelect: snapshot.data?[1] ?? true,
                          ),
                          if (widget.isBaoCaoThongKe)
                            TheoDangLichWidget(
                              icon: ImageAssets.icCalendar,
                              name: S.current.bao_cao_thong_ke,
                              onTap: () {
                                widget.cubit.selectTypeCalendarSubject
                                    .add([false, false, true]);
                                widget.onTap(S.current.bao_cao_thong_ke);
                                Navigator.pop(
                                  context,
                                  TypeCalendarMenu.BaoCaoThongKe,
                                );
                              },
                              isSelect: snapshot.data?[2] ?? true,
                            )
                          else
                            Container(),
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
                        children: widget.listItem
                            .map(
                              (e) => StreamBuilder<DashBoardLichHopModel>(
                                  stream: widget.streamDashBoard,
                                  builder: (context, snapshot) {
                                    final dataDashBoard = snapshot.data ??
                                        DashBoardLichHopModel.empty();
                                    return ContainerMenuWidget(
                                      name: e.typeMenu.getTitleLichHop(),
                                      icon: e.typeMenu.getIconMobile(),
                                      type: e.type,
                                      index: e.typeMenu.getIndexMenuLichHop(
                                        dataDashBoard,
                                      ),
                                      childExpand: Column(
                                        children: e.listWidget
                                                ?.map(
                                                  (e) => ContainerMenuWidget(
                                                    icon: e.typeMenu
                                                        .getIconMobile(),
                                                    name: e.typeMenu ==
                                                            TypeCalendarMenu
                                                                .LichTheoLanhDao
                                                        ? e.menuModel
                                                                ?.tenDonVi ??
                                                            ''
                                                        : e.typeMenu
                                                            .getTitleLichHop(),
                                                    index: e.typeMenu ==
                                                            TypeCalendarMenu
                                                                .LichTheoLanhDao
                                                        ? e.menuModel?.count ??
                                                            0
                                                        : e.typeMenu
                                                            .getIndexMenuLichHop(
                                                            dataDashBoard,
                                                          ),
                                                    isIcon: false,
                                                    onTap: () {
                                                      if (e.typeMenu ==
                                                          TypeCalendarMenu
                                                              .LichTheoLanhDao) {
                                                        widget.onTapLanhDao(
                                                          e.menuModel ??
                                                              MenuModel.empty(),
                                                        );
                                                      }
                                                      Navigator.pop(
                                                        context,
                                                        e.typeMenu,
                                                      );
                                                    },
                                                  ),
                                                )
                                                .toList() ??
                                            [],
                                      ),
                                      onTap: () {
                                        if (e.typeMenu ==
                                            TypeCalendarMenu.LichCuaToi) {
                                          Navigator.pop(
                                            context,
                                            e.typeMenu,
                                          );
                                        }
                                      },
                                    );
                                  }),
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
      ),
      tabletScreen: Scaffold(
        appBar: BaseAppBar(
          title: widget.title,
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
        body: StreamBuilder<List<bool>>(
          stream: widget.cubit.selectTypeCalendarSubject.stream,
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
                    widget.cubit.selectTypeCalendarSubject
                        .add([true, false, false]);
                    widget.onTap(S.current.theo_dang_lich);
                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[0] ?? true,
                ),
                const SizedBox(
                  height: 16,
                ),
                TheoDangLichWidget(
                  icon: ImageAssets.icTheoDangDanhSachGrey,
                  name: S.current.theo_dang_danh_sach,
                  onTap: () {
                    widget.cubit.selectTypeCalendarSubject
                        .add([false, true, false]);
                    widget.onTap(S.current.theo_dang_danh_sach);

                    Navigator.pop(context);
                  },
                  isSelect: snapshot.data?[1] ?? true,
                ),
                const SizedBox(
                  height: 16,
                ),
                if (widget.isBaoCaoThongKe)
                  TheoDangLichWidget(
                    icon: ImageAssets.icCalendar,
                    name: S.current.bao_cao_thong_ke,
                    onTap: () {
                      widget.cubit.selectTypeCalendarSubject
                          .add([false, false, true]);
                      widget.onTap(S.current.bao_cao_thong_ke);

                      Navigator.pop(context);
                    },
                    isSelect: snapshot.data?[2] ?? true,
                  )
                else
                  Container(),
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
                        children: widget.listItem
                            .map(
                              (e) => StreamBuilder<DashBoardLichHopModel>(
                                  stream: widget.streamDashBoard,
                                  builder: (context, snapshot) {
                                    final dataDashBoard = snapshot.data ??
                                        DashBoardLichHopModel.empty();
                                    return ContainerMenuWidgetTablet(
                                      name: e.typeMenu.getTitleLichHop(),
                                      icon: e.typeMenu.getIconTablet(),
                                      type: e.type,
                                      index: e.typeMenu.getIndexMenuLichHop(
                                        dataDashBoard,
                                      ),
                                      childExpand: Column(
                                        children: e.listWidget
                                                ?.map(
                                                  (e) =>
                                                      ContainerMenuWidgetTablet(
                                                    icon: e.typeMenu
                                                        .getIconMobile(),
                                                    name: e.typeMenu ==
                                                            TypeCalendarMenu
                                                                .LichTheoLanhDao
                                                        ? e.menuModel
                                                                ?.tenDonVi ??
                                                            ''
                                                        : e.typeMenu
                                                            .getTitleLichHop(),
                                                    index: e.typeMenu ==
                                                            TypeCalendarMenu
                                                                .LichTheoLanhDao
                                                        ? e.menuModel?.count ??
                                                            0
                                                        : e.typeMenu
                                                            .getIndexMenuLichHop(
                                                            dataDashBoard,
                                                          ),
                                                    isIcon: false,
                                                    onTap: () {
                                                      if (e.typeMenu ==
                                                          TypeCalendarMenu
                                                              .LichTheoLanhDao) {
                                                        widget.onTapLanhDao(
                                                          e.menuModel ??
                                                              MenuModel.empty(),
                                                        );
                                                      }
                                                      Navigator.pop(
                                                        context,
                                                        e.typeMenu,
                                                      );
                                                    },
                                                  ),
                                                )
                                                .toList() ??
                                            [],
                                      ),
                                      onTap: () {
                                        if (e.typeMenu ==
                                            TypeCalendarMenu.LichCuaToi) {
                                          Navigator.pop(
                                            context,
                                            e.typeMenu,
                                          );
                                        }
                                      },
                                    );
                                  }),
                            )
                            .toList(),
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
