
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_danh_sach_ngay_tuan_thang/thong_ke_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/danh_sach_lich_hop_tablet/danh_sach_lich_hop_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_danh_sach_ngay_tuan_thang_tablet/lich_hop_theo_danh_sach_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_danh_sach_ngay_tuan_thang_tablet/thong_ke_lich_hop_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_thang_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_tuan_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_cubit.dart';
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
  DANG_THONG_KE,
}

extension type_Choose_Option_List on Type_Choose_Option_List {
  String getTitle() {
    switch (this) {
      case Type_Choose_Option_List.DANH_SACH:
        return S.current.danh_sach_lich_hop;

      case Type_Choose_Option_List.DANG_LIST:
        return S.current.lich_hop_cua_toi;

      case Type_Choose_Option_List.DANG_LICH:
        return S.current.lich_hop_cua_toi;

      case Type_Choose_Option_List.DANG_THONG_KE:
        return S.current.thong_ke_lich_hop;
    }
  }
}

extension lichHopOptionDayCubit on Type_Choose_Option_Day {
  Widget getLichHopStateDangList({
    required LichHopCubit cubit,
    required Type_Choose_Option_Day type,
  }) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return LichHopTheoDanhSachNgay(
          cubit: cubit,
          type: type,
          key: UniqueKey(),
        );
      case Type_Choose_Option_Day.WEEK:
        return LichHopTheoDanhSachNgay(
          cubit: cubit,
          type: type,
        );
      case Type_Choose_Option_Day.MONTH:
        return LichHopTheoDanhSachNgay(
          cubit: cubit,
          type: type,
        );
      default:
        return const SizedBox();
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
                  color: AppTheme.getInstance().colorField(),
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
                color: AppTheme.getInstance().colorField(),
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        );

      case Type_Choose_Option_Day.MONTH:
        return StreamBuilder<DateTime>(
            stream: cubit.moveTimeSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? cubit.selectedDay;
              final dateTimeFormRange =
                  data.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);

              final dataString =
                  '${dateTimeFormRange[0].day} - ${dateTimeFormRange[1].formatDayCalendar}';
              return Text(
                dataString,
                style: textNormalCustom(
                  color: AppTheme.getInstance().colorField(),
                  fontSize: 14.0.textScale(),
                  fontWeight: FontWeight.w500,
                ),
              );
            });
    }
  }

  Widget getTextLLVWidget({
    required CalenderCubit cubit,
    Color textColor = textDefault,
  }) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return StreamBuilder<DateTime>(
          stream: cubit.moveTimeSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? cubit.selectDay;
            return Text(
              data.formatDayCalendar,
              style: textNormalCustom(
                color: textColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        );

      case Type_Choose_Option_Day.WEEK:
        return StreamBuilder<DateTime>(
          stream: cubit.moveTimeSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? cubit.selectDay;
            return Text(
              data.startEndWeek,
              style: textNormalCustom(
                color: textColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        );

      case Type_Choose_Option_Day.MONTH:
        return StreamBuilder<DateTime>(
          stream: cubit.moveTimeSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? cubit.selectDay;
            final dateTimeFormRange =
                data.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);

            final dataString =
                '${dateTimeFormRange[0].day} - ${dateTimeFormRange[1].formatDayCalendar}';
            return Text(
              dataString,
              style: textNormalCustom(
                color: textColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        );
    }
  }

  Widget getTextLHWidget({
    required LichHopCubit cubit,
    Color textColor = textDefault,
  }) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return StreamBuilder<DateTime>(
            stream: cubit.moveTimeSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? cubit.selectDay;
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
            final data = snapshot.data ?? cubit.selectDay;
            return Text(
              data.startEndWeek,
              style: textNormalCustom(
                color: textColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        );

      case Type_Choose_Option_Day.MONTH:
        return StreamBuilder<DateTime>(
          stream: cubit.moveTimeSubject.stream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? cubit.selectDay;
            final dateTimeFormRange =
                data.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);

            final dataString =
                '${dateTimeFormRange[0].day} - ${dateTimeFormRange[1].formatDayCalendar}';
            return Text(
              dataString,
              style: textNormalCustom(
                color: textColor,
                fontSize: 14.0.textScale(),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        );
    }
  }

  Widget getLichHopStateDangLich({
    required LichHopCubit cubit,
  }) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return LichHopTheoNgay(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return LichHopTheoTuan(cubit: cubit);
      case Type_Choose_Option_Day.MONTH:
        return LichHopTheoThang(cubit: cubit);
      default:
        return const SizedBox();
    }
  }

  Widget getThongKe(LichHopCubit cubit) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return ThongKeLichHopScreen(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return ThongKeLichHopScreen(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.MONTH:
        return ThongKeLichHopScreen(
          cubit: cubit,
        );
      default:
        return const SizedBox();
    }
  }

  Widget getThongKeTablet(LichHopCubit cubit) {
    return ThongKeLichHopTablet(
      cubit: cubit,
    );
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
  Widget lichHop({
    required LichHopCubit cubit,
    required Type_Choose_Option_Day type,
  }) {
    if (this is LichHopStateDangList) {
      return type.getLichHopStateDangList(
        cubit: cubit,
        type: type,
      );
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopStateDangLich(
        cubit: cubit,
      );
    } else if (this is LichHopStateDangDanhSach) {
      return type.getLichHopStateDanhSach(cubit);
    } else if (this is LichHopStateDangThongKe) {
      return type.getThongKe(cubit);
    } else {
      return const SizedBox();
    }
  }

  Widget lichLamViecIconsMobile() {
    return type.getLichHopIconsMobile();
  }
}

extension lichHopOptionDayCubitTablet on Type_Choose_Option_Day {
  Widget getLichHopStateDangListTablet(
    LichHopCubit cubit,
    Type_Choose_Option_Day type,
  ) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return LichHopTheoDanhSachNgayTablet(
          cubit: cubit,
          isHindText: false,
          type: type,
        );
      case Type_Choose_Option_Day.WEEK:
        return LichHopTheoDanhSachNgayTablet(
          cubit: cubit,
          isHindText: false,
          type: type,
        );
      case Type_Choose_Option_Day.MONTH:
        return LichHopTheoDanhSachNgayTablet(
          cubit: cubit,
          isHindText: false,
          type: type,
        );
      default:
        return const SizedBox();
    }
  }

  Widget getLichHopStateDangLichTablet({required LichHopCubit cubit}) {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return LichHopTheoNgayTablet(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.WEEK:
        return LichHopTheoTuanTablet(
          cubit: cubit,
        );
      case Type_Choose_Option_Day.MONTH:
        return LichHopTheoThangTablet(
          cubit: cubit,
        );
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
  Widget lichHopTablet(
    LichHopCubit cubit,
    Type_Choose_Option_Day type,
  ) {
    if (this is LichHopStateDangList) {
      return type.getLichHopStateDangListTablet(cubit, type);
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopStateDangLichTablet(cubit: cubit);
    } else if (this is LichHopStateDangDanhSach) {
      return type.getLichHopStateDanhSachTablet(cubit);
    } else if (this is LichHopStateDangThongKe) {
      return type.getThongKeTablet(cubit);
    } else {
      return const SizedBox();
    }
  }
}
