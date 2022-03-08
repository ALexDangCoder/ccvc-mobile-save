import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/danh_sach_lich_hop_tablet/danh_sach_lich_hop_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_danh_sach_ngay_tuan_thang_tablet/lich_hop_theo_danh_sach_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_thang_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_tuan_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'danh_sach_lich_hop/danh_sach_lich_hop.dart';
import 'lich_hop_danh_sach_ngay_tuan_thang/lich_hop_theo_danh_sach_ngay.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_ngay.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_thang.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_tuan.dart';

enum Type_Choose_Option_Day {
  DAY,
  WEEK,
  MONTH,
}
enum Type_Choose_Option_List {
  DANH_SACH,
  DANG_LICH,
  DANG_LIST,
}

extension lichHopOptionDayCubit on Type_Choose_Option_Day {
  Widget getLichHopStateDangList({required LichHopCubit cubit}) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return LichHopTheoDanhSachNgay(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return LichHopTheoDanhSachNgay(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.MONTH:
        return LichHopTheoDanhSachNgay(
          cubit: cubit,
        );
      default:
        return SizedBox();
    }
  }

  Widget getTableCalendar({
    required CalenderCubit cubit,
    Type_Choose_Option_Day type = Type_Choose_Option_Day.DAY,
  }) {
    switch (this) {
      case Type_Choose_Option_Day.MONTH:
        return TableCalendarWidget(
          isCalendar: false,
          type: type,
          onChange: (DateTime start, DateTime end) {
            log("$start      $end");
          },
          onChangeRange:
              (DateTime? start, DateTime? end, DateTime? focusedDay) {},
        );

      default:
        return TableCalendarWidget(
          type: type,
          onChange: (DateTime start, DateTime end) {
           cubit.callApiNgay(start, end);
          },
          onChangeRange:
              (DateTime? start, DateTime? end, DateTime? focusedDay) {},
        );
    }
  }

  Widget getTextWidget({
    required TableCalendarCubit cubit,
    Color textColor = textDefault,
  }) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return StreamBuilder<DateTime>(
            stream: cubit.moveTimeSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? cubit.selectedDay;
              return Text(
                data.formatDayCalendar,
                style: textNormalCustom(
                  color: textColor,
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w500,
                ),
              );
            });

      case Type_Choose_Option_Day.WEEK:
        return StreamBuilder<DateTime>(
            stream: cubit.moveTimeSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? cubit.selectedDay;
              return Text(
                data.startEndWeek,
                style: textNormalCustom(
                  color: textColor,
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w500,
                ),
              );
            });

      case Type_Choose_Option_Day.MONTH:
        return StreamBuilder<DateTime>(
            stream: cubit.moveTimeSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? cubit.selectedDay;

              return Text(
                'Tháng ${data.month}',
                style: textNormalCustom(
                  color: textColor,
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w500,
                ),
              );
            });
    }
  }

  Widget getLichHopStateDangLich() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const LichHopTheoNgay();
      case Type_Choose_Option_Day.WEEK:
        return const LichHopTheoTuan();
      case Type_Choose_Option_Day.MONTH:
        return const LichHopTheoThang();
      default:
        return const SizedBox();
    }
  }

  Widget getLichHopStateDanhSach(LichHopCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return DanhSachLichHop(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return DanhSachLichHop(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.MONTH:
        return DanhSachLichHop(cubit: cubit);
      default:
        return const SizedBox();
    }
  }

  // icons
  Widget getLichHopIconsMobile() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return SvgPicture.asset(
          ImageAssets.icCalenderDayBig,
        );
      case Type_Choose_Option_Day.WEEK:
        return SvgPicture.asset(
          ImageAssets.icCalenderWeekBig,
        );
      case Type_Choose_Option_Day.MONTH:
        return SvgPicture.asset(
          ImageAssets.icCalenderMonthBig,
        );
      default:
        return Container();
    }
  }
}

extension lichHopCubit on LichHopState {
  Widget lichHop({required LichHopCubit cubit}) {
    if (this is LichHopStateDangList) {
      return type.getLichHopStateDangList(cubit: cubit);
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopStateDangLich();
    } else if (this is LichHopStateDangDanhSach) {
      return type.getLichHopStateDanhSach(cubit);
    } else {
      return const SizedBox();
    }
  }

  Widget lichLamViecIconsMobile() {
    if (this is LichHopStateDangList) {
      return type.getLichHopIconsMobile();
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopIconsMobile();
    } else if (this is LichHopStateDangDanhSach) {
      return type.getLichHopIconsMobile();
    } else {
      return const SizedBox();
    }
  }
}

extension lichHopOptionDayCubitTablet on Type_Choose_Option_Day {
  Widget getLichHopStateDangListTablet(LichHopCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return LichHopTheoDanhSachNgayTablet(cubit: cubit);
      case Type_Choose_Option_Day.WEEK:
        return LichHopTheoDanhSachNgayTablet(cubit: cubit);
      case Type_Choose_Option_Day.MONTH:
        return LichHopTheoDanhSachNgayTablet(cubit: cubit);
      default:
        return const SizedBox();
    }
  }

  Widget getLichHopStateDangLichTablet() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const LichHopTheoNgayTablet();
      case Type_Choose_Option_Day.WEEK:
        return const LichHopTheoTuanTablet();
      case Type_Choose_Option_Day.MONTH:
        return const LichHopTheoThangTablet();
      default:
        return const SizedBox();
    }
  }

  Widget getLichHopStateDanhSachTablet(LichHopCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return DanhSachLichHopNgayTablet(cubit: cubit);
      case Type_Choose_Option_Day.WEEK:
        return DanhSachLichHopNgayTablet(cubit: cubit);
      case Type_Choose_Option_Day.MONTH:
        return DanhSachLichHopNgayTablet(cubit: cubit);
      default:
        return const SizedBox();
    }
  }
}

extension lichHopCubitTablet on LichHopState {
  Widget lichHopTablet(LichHopCubit cubit) {
    if (this is LichHopStateDangList) {
      return type.getLichHopStateDangListTablet(cubit);
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopStateDangLichTablet();
    } else if (this is LichHopStateDangDanhSach) {
      return type.getLichHopStateDanhSachTablet(cubit);
    } else {
      return const SizedBox();
    }
  }
}
