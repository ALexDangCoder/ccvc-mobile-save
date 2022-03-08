import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import 'cell_phat_bieu_widget.dart';
import 'dang_ky_phat_bieu_widget.dart';

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
            IconWithTiltleWidget(
              icon: ImageAssets.icMic,
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
            buttonStatePhatBieu(cubit: cubit),
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
                  return const SizedBox(
                    height: 200,
                    child: NodataWidget(),
                  );
                }
              },
            ),
            buttonPhatBieu(cubit: cubit)
          ],
        ),
      ),
    );
  }

  Widget buttonPhatBieu({required DetailMeetCalenderCubit cubit}) {
    return SizedBox(
      child: StreamBuilder<List<PhatBieuModel>>(
        stream: cubit.streamPhatBieu,
        builder: (context, snapshot) {
          if (cubit.typeStatus.value == cubit.choDuyet) {
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
          } else if (cubit.typeStatus.value == cubit.daDuyet) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300),
              child: ButtonCustomBottom(
                title: S.current.huy_duyet,
                onPressed: () {},
                isColorBlue: false,
              ),
            );
          } else if (cubit.typeStatus.value == cubit.huyDuyet) {
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
    );
  }

  Widget buttonStatePhatBieu({required DetailMeetCalenderCubit cubit}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: StreamBuilder<int>(
        stream: cubit.typeStatus,
        builder: (context, snapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonStatus(
                lengthList: cubit.dataSoLuongPhatBieu.danhSachPhatBieu,
                onTap: () {
                  cubit.getValueStatus(1);
                },
                text: S.current.danh_sach_phat_bieu,
                backgroup: cubit.typeStatus.value == cubit.danhSachphatBieu
                    ? choXuLyColor
                    : backgroundColorApp,
                colorText: cubit.typeStatus.value == cubit.danhSachphatBieu
                    ? backgroundColorApp
                    : choXuLyColor,
                colorBorder: choXuLyColor,
              ),
              const SizedBox(width: 16),
              ButtonStatus(
                lengthList: cubit.dataSoLuongPhatBieu.choDuyet,
                onTap: () {
                  cubit.getValueStatus(2);
                },
                text: S.current.cho_duyet,
                backgroup: cubit.typeStatus.value == cubit.choDuyet
                    ? itemWidgetNotUse
                    : backgroundColorApp,
                colorText: cubit.typeStatus.value == cubit.choDuyet
                    ? backgroundColorApp
                    : itemWidgetNotUse,
                colorBorder: itemWidgetNotUse,
              ),
              const SizedBox(width: 16),
              ButtonStatus(
                lengthList: cubit.dataSoLuongPhatBieu.daDuyet,
                onTap: () {
                  cubit.getValueStatus(3);
                },
                text: S.current.da_duyet,
                backgroup: cubit.typeStatus.value == cubit.daDuyet
                    ? itemWidgetUsing
                    : backgroundColorApp,
                colorText: cubit.typeStatus.value == cubit.daDuyet
                    ? backgroundColorApp
                    : itemWidgetUsing,
                colorBorder: itemWidgetUsing,
              ),
              const SizedBox(width: 16),
              ButtonStatus(
                lengthList: cubit.dataSoLuongPhatBieu.huyDuyet,
                onTap: () {
                  cubit.getValueStatus(4);
                },
                text: S.current.huy_duyet,
                backgroup: cubit.typeStatus.value == cubit.huyDuyet
                    ? statusCalenderRed
                    : backgroundColorApp,
                colorText: cubit.typeStatus.value == cubit.huyDuyet
                    ? backgroundColorApp
                    : statusCalenderRed,
                colorBorder: statusCalenderRed,
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget ButtonStatus({
  required String text,
  required Function() onTap,
  required int? lengthList,
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
<<<<<<< HEAD
        '$text ($lengthList)',
=======
        '${text} (${lengthList})',
>>>>>>> develop
        style: textNormalCustom(
          color: colorText,
        ),
      ),
    ),
  );
}
