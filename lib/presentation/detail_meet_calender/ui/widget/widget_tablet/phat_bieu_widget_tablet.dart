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
              child: StreamBuilder<List<PhatBieuModel>>(
                initialData: cubit.listPhatBieu,
                stream: cubit.streamPhatBieu,
                builder: (context, snapshot) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonStatus(
                        lengthList: cubit.listPhatBieu.length,
                        onTap: () {
                          cubit.getValueStatus(S.current.danh_sach_phat_bieu);
                        },
                        text: S.current.danh_sach_phat_bieu,
                        backgroup: cubit.typeStatus.value ==
                                S.current.danh_sach_phat_bieu
                            ? choXuLyColor
                            : backgroundColorApp,
                        colorText: cubit.typeStatus.value ==
                                S.current.danh_sach_phat_bieu
                            ? backgroundColorApp
                            : choXuLyColor,
                        colorBorder: choXuLyColor,
                      ),
                      const SizedBox(width: 16),
                      ButtonStatus(
                        lengthList: cubit.listPhatBieu.length,
                        onTap: () {
                          cubit.getValueStatus(S.current.cho_duyet);
                        },
                        text: S.current.cho_duyet,
                        backgroup: cubit.typeStatus.value == S.current.cho_duyet
                            ? itemWidgetNotUse
                            : backgroundColorApp,
                        colorText: cubit.typeStatus.value == S.current.cho_duyet
                            ? backgroundColorApp
                            : itemWidgetNotUse,
                        colorBorder: itemWidgetNotUse,
                      ),
                      const SizedBox(width: 16),
                      ButtonStatus(
                        lengthList: cubit.listPhatBieu.length,
                        onTap: () {
                          cubit.getValueStatus(S.current.da_duyet);
                        },
                        text: S.current.da_duyet,
                        backgroup: cubit.typeStatus.value == S.current.da_duyet
                            ? itemWidgetUsing
                            : backgroundColorApp,
                        colorText: cubit.typeStatus.value == S.current.da_duyet
                            ? backgroundColorApp
                            : itemWidgetUsing,
                        colorBorder: itemWidgetUsing,
                      ),
                      const SizedBox(width: 16),
                      ButtonStatus(
                        lengthList: cubit.listPhatBieu.length,
                        onTap: () {
                          cubit.getValueStatus(S.current.huy_duyet);
                        },
                        text: S.current.huy_duyet,
                        backgroup: cubit.typeStatus.value == S.current.huy_duyet
                            ? statusCalenderRed
                            : backgroundColorApp,
                        colorText: cubit.typeStatus.value == S.current.huy_duyet
                            ? backgroundColorApp
                            : statusCalenderRed,
                        colorBorder: statusCalenderRed,
                      ),
                    ],
                  );
                },
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

  Widget ButtonStatus({
    required String text,
    required Function() onTap,
    required int lengthList,
    required Color colorText,
    required Color colorBorder,
    required Color backgroup,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroup,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: colorBorder),
        ),
        child: Text(
          '${text} (${lengthList})',
          style: textNormalCustom(
            color: colorText,
          ),
        ),
      ),
    );
  }
}
