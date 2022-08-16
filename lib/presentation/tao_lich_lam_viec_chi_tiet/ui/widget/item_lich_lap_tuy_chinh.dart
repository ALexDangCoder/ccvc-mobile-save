import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LichLapTuyChinh extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;

  const LichLapTuyChinh({Key? key, required this.taoLichLamViecCubit})
      : super(key: key);

  @override
  _LichLapTuyChinhState createState() => _LichLapTuyChinhState();
}

class _LichLapTuyChinhState extends State<LichLapTuyChinh> {
  late List<DayOffWeek> listDayOffWeek;
  final _now = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDayOffWeek = [
      DayOffWeek(index: 0, name: 'CN', isChoose: _now == 0),
      DayOffWeek(index: 1, name: 'T2', isChoose: _now == 1),
      DayOffWeek(index: 2, name: 'T3', isChoose: _now == 2),
      DayOffWeek(index: 3, name: 'T4', isChoose: _now == 3),
      DayOffWeek(index: 4, name: 'T5', isChoose: _now == 4),
      DayOffWeek(index: 5, name: 'T6', isChoose: _now == 5),
      DayOffWeek(index: 6, name: 'T7', isChoose: _now == 6),
    ];
    widget.taoLichLamViecCubit.lichLapItem.add(
      listDayOffWeek.indexWhere(
        (element) => element.isChoose == true,
      ),
    );
    widget.taoLichLamViecCubit.lichLapItem1.add(
      listDayOffWeek.indexWhere(
        (element) => element.isChoose == true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 14.0, top: 14.0),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listDayOffWeek
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    e.isChoose = !(e.isChoose ?? false);
                    setState(() {});
                    final a = widget.taoLichLamViecCubit.lichLapItem
                        .add(e.index ?? 0);
                    if (!a) {
                      widget.taoLichLamViecCubit.lichLapItem
                          .remove(e.index ?? 0);
                    }
                    final b = widget.taoLichLamViecCubit.lichLapItem.toList();
                    b.sort();
                    widget.taoLichLamViecCubit.lichLapItem1 = b;
                    listDayOffWeek.forEach((element) {
                      if (element.isChoose ?? false) {
                        flag = false;
                      }
                    });
                    if (flag) {
                      widget.taoLichLamViecCubit.selectLichLap.id = 1;
                      widget.taoLichLamViecCubit.lichLapItem1 = [];
                    }
                  },
                  child: itemLichLapTuyChinh(e.isChoose ?? false, e.name ?? ''),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class SuaLichLapTuyChinh extends StatefulWidget {
  final CreateWorkCalCubit taoLichLamViecCubit;
  final List<int> initDataTuyChinh;

  SuaLichLapTuyChinh(
      {Key? key,
      required this.taoLichLamViecCubit,
      required this.initDataTuyChinh})
      : super(key: key);

  @override
  _SuaLichLapTuyChinhState createState() => _SuaLichLapTuyChinhState();
}

class _SuaLichLapTuyChinhState extends State<SuaLichLapTuyChinh> {
  late List<DayOffWeek> listDayOffWeek;
  late List<DayOffWeek> listDayOffWeekEmpty;
  bool flag = true;
  final _now = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDayOffWeek = [
      DayOffWeek(index: 0, name: ListDayOffWeek.CN, isChoose: _now == 0),
      DayOffWeek(index: 1, name: ListDayOffWeek.T2, isChoose: _now == 1),
      DayOffWeek(index: 2, name: ListDayOffWeek.T3, isChoose: _now == 2),
      DayOffWeek(index: 3, name: ListDayOffWeek.T4, isChoose: _now == 3),
      DayOffWeek(index: 4, name: ListDayOffWeek.T5, isChoose: _now == 4),
      DayOffWeek(index: 5, name: ListDayOffWeek.T6, isChoose: _now == 5),
      DayOffWeek(index: 6, name: ListDayOffWeek.T7, isChoose: _now == 6),
    ];
    listDayOffWeekEmpty = [
      DayOffWeek(index: 0, name: ListDayOffWeek.CN, isChoose: false),
      DayOffWeek(index: 1, name: ListDayOffWeek.T2, isChoose: false),
      DayOffWeek(index: 2, name: ListDayOffWeek.T3, isChoose: false),
      DayOffWeek(index: 3, name: ListDayOffWeek.T4, isChoose: false),
      DayOffWeek(index: 4, name: ListDayOffWeek.T5, isChoose: false),
      DayOffWeek(index: 5, name: ListDayOffWeek.T6, isChoose: false),
      DayOffWeek(index: 6, name: ListDayOffWeek.T7, isChoose: false),
    ];
    widget.taoLichLamViecCubit.lichLapItem1 = widget.initDataTuyChinh;
    if (widget.initDataTuyChinh.isEmpty) {
      widget.taoLichLamViecCubit.lichLapItem.add(
        listDayOffWeek.indexWhere(
          (element) => element.isChoose == true,
        ),
      );
      widget.taoLichLamViecCubit.lichLapItem1.add(
        listDayOffWeek.indexWhere(
          (element) => element.isChoose == true,
        ),
      );
    }

    for (final initDataTuyChinh in widget.initDataTuyChinh) {
      for (final listDay in listDayOffWeekEmpty) {
        if (initDataTuyChinh == listDay.index) {
          listDay.isChoose = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 14.0, top: 14.0),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listDayOffWeekEmpty
              .map(
                (itemDayOffWeek) => GestureDetector(
                  onTap: () {
                    itemDayOffWeek.isChoose =
                        !(itemDayOffWeek.isChoose ?? false);
                    setState(() {});
                    final lichLapItemFist = widget
                        .taoLichLamViecCubit.lichLapItem
                        .add(itemDayOffWeek.index ?? 0);
                    if (!lichLapItemFist) {
                      widget.taoLichLamViecCubit.lichLapItem
                          .remove(itemDayOffWeek.index ?? 0);
                    }
                    final lichLapItemLast =
                        widget.taoLichLamViecCubit.lichLapItem.toList();
                    lichLapItemLast.sort();
                    widget.taoLichLamViecCubit.lichLapItem1 = lichLapItemLast;
                    listDayOffWeekEmpty.forEach((element) {
                      if (element.isChoose ?? false) {
                        flag = false;
                      }
                    });
                    if (flag) {
                      widget.taoLichLamViecCubit.selectLichLap.id =
                          LichLapModel.KHONG_LAP_LAI;
                      widget.taoLichLamViecCubit.lichLapItem1 = [];
                    }
                  },
                  child: itemLichLapTuyChinh(
                    itemDayOffWeek.isChoose ?? false,
                    itemDayOffWeek.name ?? '',
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget itemLichLapTuyChinh(bool isCheck, String title) {
  return Container(
    height: 32.0,
    width: 32.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isCheck
          ? AppTheme.getInstance().colorField()
          : AppTheme.getInstance().colorField().withOpacity(0.1),
    ),
    child: Center(
      child: Text(
        title,
        style: textNormal(
          isCheck ? backgroundColorApp : AppTheme.getInstance().colorField(),
          14,
        ),
      ),
    ),
  );
}
