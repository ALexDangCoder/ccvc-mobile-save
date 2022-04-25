import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/selectdate/custom_selectdate.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/sua_danh_ba_ca_nhan/widget/input_infor_user_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class LichLapTuyChinhChiTietHopWidget extends StatefulWidget {
  final List<int> initData;
  final Function(List<int> vl) onChange;
  final DetailMeetCalenderCubit cubit;

  const LichLapTuyChinhChiTietHopWidget({
    Key? key,
    required this.cubit,
    required this.onChange,
    required this.initData,
  }) : super(key: key);

  @override
  _LichLapTuyChinhChiTietHopWidgetState createState() =>
      _LichLapTuyChinhChiTietHopWidgetState();
}

class _LichLapTuyChinhChiTietHopWidgetState
    extends State<LichLapTuyChinhChiTietHopWidget> {
  List<int> listSelect = [];
  late List<DayOffWeek> listDayOffWeek;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDayOffWeek = [
      DayOffWeek(index: 0, name: 'CN', isChoose: false),
      DayOffWeek(index: 1, name: 'T2', isChoose: false),
      DayOffWeek(index: 2, name: 'T3', isChoose: false),
      DayOffWeek(index: 3, name: 'T4', isChoose: false),
      DayOffWeek(index: 4, name: 'T5', isChoose: false),
      DayOffWeek(index: 5, name: 'T6', isChoose: false),
      DayOffWeek(index: 6, name: 'T7', isChoose: false),
    ];
    for (final e in widget.initData) {
      for (final d in listDayOffWeek) {
        if (e == d.index) {
          d.isChoose = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 14.0, top: 14.0),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: listDayOffWeek
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        e.isChoose = !(e.isChoose ?? false);
                        if (e.isChoose == true) {
                          listSelect.add(e.index ?? 0);
                          widget.onChange(listSelect);
                          setState(() {});
                        } else {
                          listSelect.remove(e.index ?? 0);
                        }
                      },
                      child: itemLichLapTuyChinh(
                        title: e.name ?? '',
                        isCheck: e.isChoose ?? false,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          InputInfoUserWidget(
            title: S.current.lap_den_ngay,
            child: CustomSelectDate(
              value: DateTime.now().toString(),
              onSelectDate: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

Widget itemLichLapTuyChinh({required bool isCheck, required String title}) {
  return Container(
      margin: EdgeInsets.only(left: 14.0),
      height: 32.0,
      width: 32.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCheck ? textDefault : textDefault.withOpacity(0.1)),
      child: Center(
        child: Text(
          title,
          style: textNormal(isCheck ? backgroundColorApp : textDefault, 14),
        ),
      ));
}
