import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:rxdart/rxdart.dart';

class CupertinoRoundedDatePickerWidgetDialog {
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
  }) async {
    initialDate ??= DateTime.now();
    minimumDate ??= DateTime.now().subtract(const Duration(days: 7));
    maximumDate ??= DateTime.now().add(const Duration(days: 7));
    minimumYear ??= DateTime.now().year - 1;
    maximumYear ??= DateTime.now().year + 1;
    DateTime dateSelect = initialDate;
    bool isDateOver = false;
    final BehaviorSubject<DateTime> dateTimeBloc = BehaviorSubject<DateTime>()
      ..sink.add(initialDate);
    void validateDay(DateTime value) {
      final dayMin = minimumDate;
      if (dayMin != null) {
        if (value.millisecondsSinceEpoch < dayMin.millisecondsSinceEpoch) {
          isDateOver = true;
        }
      }
      final dayMax = maximumDate;
      if (dayMax != null) {
        if (value.millisecondsSinceEpoch > dayMax.millisecondsSinceEpoch) {
          isDateOver = true;
        }
      }
      isDateOver = false;
    }

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
                  borderRadius: BorderRadius.circular(borderRadius)),
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
                        style:
                            textNormalCustom(color: buttonColor, fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<DateTime>(
                      stream: dateTimeBloc.stream,
                      builder: (context, snapshot) {
                        return FlutterRoundedCupertinoDatePickerWidget(
                          use24hFormat: use24hFormat,
                          onDateTimeChanged: (dateTime) {
                            validateDay(dateTime);
                            if (!isDateOver) {
                              dateSelect = dateTime;
                            }
                          },
                          era: era,
                          background: Colors.transparent,
                          textStyleDate: textStyle ?? const TextStyle(),
                          borderRadius: borderRadius,
                          fontFamily: fontFamily,
                          initialDateTime: snapshot.data,
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
                  ButtonBottom(
                    onPressed: () {
                      if (onTap != null) {
                        if (isDateOver) {
                          MessageConfig.show(
                            title: S.current.thoi_gian_chon_khong_hop_le,
                            messState: MessState.error,
                          );
                        }
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
        });
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
