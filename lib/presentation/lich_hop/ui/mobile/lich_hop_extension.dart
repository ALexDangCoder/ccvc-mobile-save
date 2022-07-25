import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/calendar_tablet/src/table_calendar_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

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

