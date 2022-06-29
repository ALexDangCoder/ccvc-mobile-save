import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/choose_time_item.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/tablet/widget/tablet_calendar_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

import 'choose_calendar_type_widget.dart';

class ChooseTimeCalendarTablet extends StatefulWidget {
  final List<DateTime> calendarDays;
  final Function(DateTime, DateTime, CalendarType, String) onChange;
  final ChooseTimeController? controller;
  final Function(DateTime, DateTime, String)? onChangeYear;
  const ChooseTimeCalendarTablet(
      {Key? key,
      this.calendarDays = const [],
      required this.onChange,
      this.controller,
      this.onChangeYear})
      : super(key: key);

  @override
  _ChooseTimeCalendarTabletState createState() =>
      _ChooseTimeCalendarTabletState();
}

class _ChooseTimeCalendarTabletState extends State<ChooseTimeCalendarTablet> {
  late ChooseTimeController controller;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller == null) {
      controller = ChooseTimeController();
    } else {
      controller = widget.controller!;
    }
    final timePage = controller.pageTableCalendar
        .dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    widget.onChangeYear
        ?.call(timePage.first, timePage.last, textEditingController.text);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final times = dateTimeRange(controller.selectDate.value);
      widget.onChange(times[0], times[1], controller.calendarType.value,
          textEditingController.text);
      controller.selectDate.addListener(() {
        final times = dateTimeRange(controller.selectDate.value);
        widget.onChange(times[0], times[1], controller.calendarType.value,
            textEditingController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        TableCalendarTabletWidget(controller: controller,),
      ],
    );
  }
  Widget header(){
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                ImageAssets.icAddCaledarScheduleMeet,
                color: AppTheme.getInstance().colorField(),
              ),
            ),
          ),
        ),
        ChooseTimeCalendarTypeWidget(
          controller: controller, onChange: (type) {

        },
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                color: backgroundColorApp,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: toDayColor),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      ImageAssets.icSeachTablet,
                      color: AppTheme.getInstance().colorField(),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: S.current.tim_kiem,
                  hintStyle: textNormalCustom(
                    color: textBodyTime,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.textScale(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String dateFormat(DateTime dateTime) {
    switch (controller.calendarType.value) {
      case CalendarType.DAY:
        return dateTime.formatDayCalendar;
      case CalendarType.WEEK:
        return dateTime.startEndWeek;
      case CalendarType.MONTH:
        final dateTimeFormRange =
            dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);

        final dataString =
            '${dateTimeFormRange[0].day} - ${dateTimeFormRange[1].formatDayCalendar}';
        return dataString;
    }
  }

  List<DateTime> dateTimeRange(DateTime dateTime) {
    switch (controller.calendarType.value) {
      case CalendarType.DAY:
        return [dateTime, dateTime];
      case CalendarType.WEEK:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.TUAN_NAY);
      case CalendarType.MONTH:
        return dateTime.dateTimeFormRange(timeRange: TimeRange.THANG_NAY);
    }
  }
}
