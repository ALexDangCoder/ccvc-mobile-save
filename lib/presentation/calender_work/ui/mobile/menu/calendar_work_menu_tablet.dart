import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarWorkMenuTablet extends StatefulWidget {
  const CalendarWorkMenuTablet({Key? key}) : super(key: key);

  @override
  _CalendarWorkMenuTabletState createState() => _CalendarWorkMenuTabletState();
}

class _CalendarWorkMenuTabletState extends State<CalendarWorkMenuTablet> {
  CalenderCubit cubit = CalenderCubit();

  @override
  void initState() {
    super.initState();
    cubit.selectTypeCalendarSubject.add([true, false]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.menu_lich_lam_viec,
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
                TheoDangLichWidget(
                  icon: ImageAssets.icTheoDangLich,
                  name: S.current.lich_lam_viec,
                  onTap: () {
                    cubit.selectTypeCalendarSubject.add([true, false]);
                  },
                  isSelect: snapshot.data![0],
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
                  },
                  isSelect: snapshot.data![1],
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
                        children: [
                          ContainerMenuWidgetTablet(
                            name: S.current.lich_cua_toi,
                            icon: ImageAssets.icPersonWork,
                            childExpand: Container(),
                            onTap: () {},
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ContainerMenuWidgetTablet(
                              name: S.current.lich_theo_trang_thai,
                              icon: ImageAssets.icTheoDangLichCir,
                              childExpand: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ContainerMenuWidgetTablet(
                                    isIcon: false,
                                    name: S.current.lich_theo_trang_thai,
                                    icon: ImageAssets.icLichLanhDaoCir,
                                    index: 15,
                                    childExpand: Container(),
                                    onTap: () {},
                                  );
                                },
                              ),
                              type: TypeContainer.expand,
                              onTap: () {},
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ContainerMenuWidgetTablet(
                              name: S.current.lich_theo_lanh_dao,
                              icon: ImageAssets.icLichLanhDaoCir,
                              childExpand: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return ContainerMenuWidgetTablet(
                                    isIcon: false,
                                    name: S.current.lich_theo_trang_thai,
                                    icon: ImageAssets.icLichTheoTrangThai,
                                    index: 15,
                                    childExpand: Container(),
                                    onTap: () {},
                                  );
                                },
                              ),
                              type: TypeContainer.expand,
                              onTap: () {},
                            ),
                          ),
                        ],
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
