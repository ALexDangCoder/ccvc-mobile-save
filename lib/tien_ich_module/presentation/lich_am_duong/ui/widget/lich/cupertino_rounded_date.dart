import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/bloc/lichh_am_duong_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/tablet/widget/button_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';
import 'package:rxdart/rxdart.dart';

class CupertinoRoundedDatePickerWidgetDialogAmDuong {
  static Future<dynamic> show(
    BuildContext context, {
    Locale? locale,
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    int? minimumYear,
    int? maximumYear,
    Function(DateTime)? onTap,
    int minuteInterval = 1,
    bool use24hFormat = false,
    CupertinoDatePickerMode initialDatePickerMode =
        CupertinoDatePickerMode.date,
    EraMode era = EraMode.CHRIST_YEAR,
    double borderRadius = 16,
    String? fontFamily,
    Color background = Colors.white,
    TextStyle? textStyle,
    double maxHeight = 878,
    double width = 592,
    required LichAmDuongCubit cubit,
  }) async {
    initialDate ??= DateTime.now();
    minimumDate ??= DateTime.now().subtract(const Duration(days: 7));
    maximumDate ??= DateTime.now().add(const Duration(days: 7));
    minimumYear ??= DateTime.now().year - 1;
    maximumYear ??= DateTime.now().year + 1;
    DateTime dateSelect = initialDate;
    final BehaviorSubject<DateTime> dateTimeBloc = BehaviorSubject<DateTime>()
      ..sink.add(initialDate);
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      dateTimeBloc.sink.add(DateTime.now());
                    },
                    child: Text(
                      S.current.today,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().colorField(),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<DateTime>(
                    stream: cubit.changeDateTimeSubject.stream,
                    builder: (context, snapshot) {
                      return FlutterRoundedCupertinoDatePickerWidgetAmDuong(
                        use24hFormat: use24hFormat,
                        onDateTimeChanged: (dateTime) {
                          //dateSelect = dateTime;
                        },
                        onChangeSolar: (date, flag) {
                          final solar = LunarSolarConverter.lunarToSolar(
                            Lunar(
                              lunarDay: date.day,
                              lunarMonth: date.month,
                              lunarYear: date.year,
                            ),
                          );
                          dateSelect = flag
                              ? DateTime(
                                  solar.solarYear ?? 1900,
                                  solar.solarMonth ?? 1,
                                  solar.solarDay ?? 1,
                                )
                              : date;
                        },
                        era: era,
                        background: Colors.transparent,
                        textStyleDate: textStyle ?? const TextStyle(),
                        borderRadius: borderRadius,
                        fontFamily: fontFamily,
                        initialDateTime: snapshot.data ?? DateTime.now(),
                        mode: initialDatePickerMode,
                        minuteInterval: minuteInterval,
                        minimumDate: minimumDate,
                        maximumDate: maximumDate,
                        maximumYear: maximumYear,
                        minimumYear: minimumYear!,
                      );
                    },
                  ),
                ),
                ButtonBottomTablet(
                  onPressed: () {
                    if (onTap != null) {
                      onTap(dateSelect);
                    }
                  },
                  text: S.current.chon_ngay,
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget lineContainer() {
  return Container(
    height: 6,
    width: 48,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: colorECEEF7,
    ),
  );
}
