import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/build_picker.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';

extension CupertinoDataPicker on CupertinoDatePickerDateState {
  List<int> countDay() {
    final dataDay = <int>[];
    final int daysInCurrentMonth =
        DateTime(selectedYear, (selectedMonth + 1) % 12, 0).day;
    for (int i = 0; i < daysInCurrentMonth; i++) {
      if (widget.maximumDate != null) {
        final day = i + 1;
        if (day > widget.maximumDate!.day &&
            selectedYear == widget.maximumDate?.year &&
            selectedMonth == widget.maximumDate?.month) {
          continue;
        }
      }
      if (widget.minimumDate != null) {
        final day = i + 1;
        if (day < widget.minimumDate!.day &&
            selectedYear == widget.minimumDate?.year &&
            selectedMonth == widget.minimumDate?.month) {
          continue;
        }
      }
      dataDay.add(i);
    }

    return dataDay;
  }

  Widget buildDayPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    final int daysInCurrentMonth =
        DateTime(selectedYear, (selectedMonth + 1) % 12, 0).day;

    days = countDay();
    return BuildPicker(
      looping: days.length > 4,
      offAxisFraction: offAxisFraction,
      controller: dayController,
      backgroundColor: widget.background,
      canBorderLeft: true,
      children: List<Widget>.generate(days.length, (int index) {
        TextStyle textStyle = themeTextStyle(context);
        if (days[index] >= daysInCurrentMonth) {
          textStyle = textStyle.copyWith(
            color: CupertinoColors.inactiveGray,
          );
        }
        return itemPositioningBuilder(
          context,
          Text(
            _getDayOfWeek(days[index]),
            style: widget.textStyleDate,
          ),
        );
      }),
      onSelectItem: (index) {
        isSelectDay = true;
        selectedDay = days[index] + 1;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateTimeChanged(
            DateTime(selectedYear, selectedMonth, selectedDay),
          );
        }
      },
    );
  }

  String _getDayOfWeek(int index) {
    return localizations.datePickerDayOfMonth(index + 1);
  }

  List<int> countMonth() {
    final dataMonth = <int>[];
    for (int i = 0; i < 12; i++) {
      final month = i + 1;
      if (widget.maximumDate != null) {
        if (month > widget.maximumDate!.month &&
            selectedYear == widget.maximumDate?.year) {
          continue;
        }
      }
      if (widget.minimumDate != null) {
        if (month < widget.minimumDate!.month &&
            selectedYear == widget.minimumDate?.year) {
          continue;
        }
      }
      dataMonth.add(month);
    }
    return dataMonth;
  }

  Widget buildMonthPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    months = countMonth();
    return BuildPicker(
      offAxisFraction: offAxisFraction,
      controller: monthController,
      backgroundColor: widget.background,
      children: List<Widget>.generate(months.length, (int index) {
        return itemPositioningBuilder(
          context,
          Text(
            '${S.current.thang} ${months[index]}',
            style: widget.textStyleDate,
          ),
        );
      }),
      onSelectItem: (index) {
        isSelectDay = false;
        selectedMonth = months[index];
        if (widget.minimumDate != null &&
            widget.minimumDate!.year == selectedYear &&
            widget.minimumDate!.month == selectedMonth &&
            selectedDay < widget.minimumDate!.day) {
          selectedDay = widget.minimumDate!.day;
        }
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateTimeChanged(
            DateTime(selectedYear, selectedMonth, selectedDay),
          );
        }
      },
    );
  }

  Widget buildYearPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    return CupertinoPicker.builder(
      scrollController: yearController,
      itemExtent: kItemExtent,
      useMagnifier: kUseMagnifier,
      magnification: kMagnification,
      backgroundColor: widget.background,
      squeeze: kSqueeze,
      diameterRatio: 3,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlayWidget(
        canBorderRight: true,
      ),
      onSelectedItemChanged: (int index) {
        isSelectDay = false;

        selectedYear = index;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateTimeChanged(
            DateTime(selectedYear, selectedMonth, selectedDay),
          );
        }
      },
      itemBuilder: (BuildContext context, int index) {
        if (widget.maximumDate != null) {
          if (index > widget.maximumDate!.year) {
            return null;
          }
        }

        if (widget.minimumDate != null) {
          if (index < widget.minimumDate!.year) {
            return null;
          }
        }
        String strYear = localizations.datePickerYear(index);
        if (widget.era == EraMode.BUDDHIST_YEAR) {
          strYear = calculateYearEra(widget.era, index).toString();
        }

        return itemPositioningBuilder(
          context,
          Text(
            strYear,
            style: widget.textStyleDate,
          ),
        );
      },
    );
  }

  void addPickerCell(
    List<ColumnBuilder> pickerBuilders,
    List<double> columnWidths,
    List<Widget> pickers,
  ) {
    pickerBuilders.addAll([buildDayPicker, buildMonthPicker, buildYearPicker]);
    columnWidths.addAll([
      estimatedColumnWidths[PickerColumnType.dayOfMonth.index]!,
      estimatedColumnWidths[PickerColumnType.month.index]!,
      estimatedColumnWidths[PickerColumnType.year.index]!
    ]);

    for (int i = 0; i < columnWidths.length; i++) {
      final double offAxisFraction = (i - 1) * 0.3 * textDirectionFactor;
      pickers.add(
        LayoutId(
          id: i,
          child: pickerBuilders[i](
            offAxisFraction,
            (BuildContext context, Widget? child) {
              return Container(
                alignment: Alignment.center,
                child: child,
              );
            },
          ),
        ),
      );
    }
  }

  DateTime validateDay(DateTime value) {
    final dayMin = widget.minimumDate;
    if (dayMin != null) {
      if (value.millisecondsSinceEpoch < dayMin.millisecondsSinceEpoch) {
        return dayMin;
      }
    }
    final dayMax = widget.maximumDate;
    if (dayMax != null) {
      if (value.millisecondsSinceEpoch > dayMax.millisecondsSinceEpoch) {
        return dayMax;
      }
    }
    return value;
  }
}
