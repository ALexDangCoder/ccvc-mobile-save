import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/dang_lich_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../item_thong_bao.dart';

class CalendarWorkMenu extends StatefulWidget {
  const CalendarWorkMenu({Key? key}) : super(key: key);

  @override
  State<CalendarWorkMenu> createState() => _CalendarWorkMenuState();
}

class _CalendarWorkMenuState extends State<CalendarWorkMenu> {
  CalenderCubit cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return CalendarWorkPhoneInher(
      cubit: cubit,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 58,
            ),
            headerWidget(menu: S.current.lich_lam_viec),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              flex: 8,
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
                      TheoDangLichWidget(
                        icon: ImageAssets.icTheoDangDanhSachGrey,
                        name: S.current.theo_dang_danh_sach,
                        onTap: () {
                          cubit.selectTypeCalendarSubject.add([false, true]);
                        },
                        isSelect: snapshot.data![1],
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
                          child: Column(
                            children: [
                              ContainerMenuWidget(
                                name: S.current.lich_cua_toi,
                                icon: ImageAssets.icPerson,
                                childExpand: Container(),
                                onTap: () {},
                              ),
                              MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ContainerMenuWidget(
                                  name: S.current.lich_theo_trang_thai,
                                  icon: ImageAssets.icLichTheoTrangThai,
                                  childExpand: Column(
                                    children: lichTheoTrangThai
                                        .map(
                                          (e) => ContainerMenuWidget(
                                            name: e.name,
                                            onTap: () {
                                              e.navigator(context, cubit);
                                            },
                                            icon: '',
                                            index: e.index,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  type: TypeContainer.expand,
                                  onTap: () {},
                                ),
                              ),
                              MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ContainerMenuWidget(
                                  name: S.current.lich_theo_lanh_dao,
                                  icon: ImageAssets.icLichLanhDao,
                                  childExpand: Column(
                                    children: lichLanhDao
                                        .map(
                                          (e) => ContainerMenuWidget(
                                            onTap: () {
                                              e.navigator(context, cubit);
                                            },
                                            icon: '',
                                            name: e.name,
                                            index: e.index,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  type: TypeContainer.expand,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
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

class CalendarWorkPhoneInher extends InheritedWidget {
  final CalenderCubit cubit;

  const CalendarWorkPhoneInher({
    Key? key,
    required this.cubit,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CalendarWorkPhoneInher of(BuildContext context) {
    final CalendarWorkPhoneInher? result =
    context.dependOnInheritedWidgetOfExactType<CalendarWorkPhoneInher>();
    assert(result != null, 'No elenment');
    return result!;
  }
}
