import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../item_menu_lich_hop.dart';

class MyCalendarMenu extends StatefulWidget {
  final LichHopCubit cubit;
  final Function theoDangLich;
  final Function theoDangDanhSach;

  const MyCalendarMenu({
    Key? key,
    required this.theoDangLich,
    required this.theoDangDanhSach,
    required this.cubit,
  }) : super(key: key);

  @override
  State<MyCalendarMenu> createState() => _MyCalendarMenuState();
}

class _MyCalendarMenuState extends State<MyCalendarMenu> {
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
                                  .add([true, false, false]);
                              widget.theoDangLich();
                              Navigator.pop(context);
                            },
                            isSelect: snapshot.data?[0] ?? true,
                          ),
                          TheoDangLichWidget(
                            icon: ImageAssets.icTheoDangDanhSachGrey,
                            name: S.current.theo_dang_danh_sach,
                            onTap: () {
                              widget.cubit.selectTypeCalendarSubject
                                  .add([false, true, false]);
                              widget.theoDangDanhSach();
                              Navigator.pop(context);
                            },
                            isSelect: snapshot.data?[1] ?? true,
                          ),
                          TheoDangLichWidget(
                            icon: ImageAssets.icCalendar,
                            name: S.current.bao_cao_thong_ke,
                            onTap: () {
                              widget.cubit.selectTypeCalendarSubject
                                  .add([false, false, true]);
                              widget.theoDangDanhSach();
                              Navigator.pop(context);
                            },
                            isSelect: snapshot.data?[2] ?? true,
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
                      child: StreamBuilder<DashBoardLichHopModel>(
                          stream: widget.cubit.dashBoardStream,
                          builder: (context, snapshot) {
                            final dataDashBoard =
                                snapshot.data ?? DashBoardLichHopModel.empty();
                            return Column(
                              children: listThongBaoMyCalendar
                                  .map(
                                    (e) => ContainerMenuWidget(
                                      name: e.typeMenu.getTitle(),
                                      icon: e.icon,
                                      type: e.type,
                                      index: e.typeMenu.getIndexMenuLichHop(
                                        dataDashBoard,
                                      ),
                                      childExpand: Column(
                                        children: (e.typeMenu ==
                                                TypeCalendarMenu
                                                    .LichTheoTrangThai)
                                            ? listTheoTrangThaiLichHop
                                                .map(
                                                  (e) => ContainerMenuWidget(
                                                    icon: e.icon,
                                                    name: e.typeMenu.getTitle(),
                                                    index: e.typeMenu
                                                        .getIndexMenuLichHop(
                                                      dataDashBoard,
                                                    ),
                                                    isIcon: false,
                                                    onTap: () {
                                                      e.onTap(
                                                        context,
                                                        widget.cubit,
                                                      );
                                                    },
                                                  ),
                                                )
                                                .toList()
                                            : listTheoTrangThaiLichHop
                                                .map(
                                                  (e) => ContainerMenuWidget(
                                                    icon: e.icon,
                                                    name: e.typeMenu.getTitle(),
                                                    index: e.index ?? 0,
                                                    isIcon: false,
                                                    onTap: () {
                                                      e.onTap(
                                                        context,
                                                        widget.cubit,
                                                      );
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
                            );
                          },),
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
                    widget.cubit.selectTypeCalendarSubject.add([true, false]);
                    widget.theoDangLich();
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
                    widget.cubit.selectTypeCalendarSubject.add([false, true]);
                    widget.theoDangDanhSach();
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
                                  children: e.typeMenu ==
                                          TypeCalendarMenu.LichTheoLanhDao
                                      ? listTheoTrangThaiLichHop
                                          .map(
                                            (e) => ContainerMenuWidgetTablet(
                                              icon: e.icon,
                                              name: e.typeMenu.getTitle(),
                                              index: e.index ?? 0,
                                              isIcon: false,
                                              onTap: () {
                                                e.onTap(
                                                  context,
                                                  widget.cubit,
                                                );
                                              },
                                            ),
                                          )
                                          .toList()
                                      : listTheoTrangThaiLichHop
                                          .map(
                                            (e) => ContainerMenuWidgetTablet(
                                              icon: e.icon,
                                              name: e.typeMenu.getTitle(),
                                              index: e.index ?? 0,
                                              isIcon: false,
                                              onTap: () {
                                                e.onTap(
                                                  context,
                                                  widget.cubit,
                                                );
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
