import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/tablet/Widget_tablet/cell_phat_bieu_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import '../dang_ky_phat_bieu_widget.dart';
import '../icon_tiltle_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/icon_tiltle_widget.dart';

class PhatBieuWidgetTablet extends StatefulWidget {
  const PhatBieuWidgetTablet({Key? key}) : super(key: key);

  @override
  _PhatBieuWidgetTabletState createState() => _PhatBieuWidgetTabletState();
}

class _PhatBieuWidgetTabletState extends State<PhatBieuWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    final DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.getValueStatus(S.current.danh_sach_phat_bieu);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: choXuLyColor),
                      ),
                      child: Text(
                        '${S.current.danh_sach_phat_bieu} (${cubit.listHistory.length})',
                        style: textNormalCustom(
                          color: choXuLyColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      cubit.getValueStatus(S.current.cho_duyet);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: itemWidgetNotUse),
                      ),
                      child: Text(
                        '${S.current.cho_duyet} (${cubit.listHistory.length})',
                        style: textNormalCustom(
                          color: itemWidgetNotUse,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      cubit.getValueStatus(S.current.da_duyet);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: itemWidgetUsing),
                      ),
                      child: Text(
                        '${S.current.da_duyet} (${cubit.listHistory.length})',
                        style: textNormalCustom(
                          color: itemWidgetUsing,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      cubit.getValueStatus(S.current.huy_duyet);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: backgroundColorApp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: statusCalenderRed),
                      ),
                      child: Text(
                        '${S.current.huy_duyet} (${cubit.listHistory.length})',
                        style: textNormalCustom(
                          color: statusCalenderRed,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconWithTiltleWidget(
              icon: ImageAssets.icVoice2,
              title: S.current.dang_ky_phat_bieu,
              onPress: () {
                showDiaLogTablet(
                  context,
                  title: S.current.dang_ky_phat_bieu,
                  child: const DangKyPhatBieuWidget(),
                  isBottomShow: false,
                  funcBtnOk: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            StreamBuilder<List<PhatBieuModel>>(
              initialData: cubit.listPhatBieu,
              stream: cubit.streamPhatBieu,
              builder: (context, snapshot) {
                final _list = snapshot.data ?? [];
                if (_list.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CellPhatBieu(
                            infoModel: _list[index],
                            cubit: cubit,
                            index: index,
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 200,
                      child: NodataWidget(),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              child: StreamBuilder<List<PhatBieuModel>>(
                initialData: cubit.listPhatBieu,
                stream: cubit.streamPhatBieu,
                builder: (context, snapshot) {
                  if (cubit.typeStatus.value == S.current.cho_duyet) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 250),
                      child: DoubleButtonBottom(
                        title1: S.current.huy_duyet,
                        title2: S.current.duyet,
                        onPressed1: () {
                          Navigator.pop(context);
                        },
                        onPressed2: () {},
                      ),
                    );
                  } else if (cubit.typeStatus.value == S.current.da_duyet) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 300),
                      child: ButtonCustomBottom(
                        title: S.current.huy_duyet,
                        onPressed: () {},
                        isColorBlue: false,
                      ),
                    );
                  } else if (cubit.typeStatus.value == S.current.huy_duyet) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 300),
                      child: ButtonCustomBottom(
                        title: S.current.duyet,
                        onPressed: () {},
                        isColorBlue: true,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<Widget> ButtonStatus(
  //     {required Function onTap, required int lengthList}) async {
  //   return GestureDetector(
  //     onTap: () {
  //       onTap;
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       decoration: BoxDecoration(
  //         color: backgroundColorApp,
  //         borderRadius: const BorderRadius.all(Radius.circular(30)),
  //         border: Border.all(color: statusCalenderRed),
  //       ),
  //       child: Text(
  //         '${S.current.huy_duyet} (${lengthList})',
  //         style: textNormalCustom(
  //           color: statusCalenderRed,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
