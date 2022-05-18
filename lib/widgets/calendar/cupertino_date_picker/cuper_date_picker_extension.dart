import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/build_picker.dart';
import 'package:ccvc_mobile/widgets/calendar/cupertino_date_picker/cupertino_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

extension CupertinoDataPicker on CupertinoDatePickerDateState {
  Widget buildDayPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    final int daysInCurrentMonth =
        DateTime(selectedYear, (selectedMonth + 1) % 12, 0).day;

    return BuildPicker(
      offAxisFraction: offAxisFraction,
      controller: dayController,
      backgroundColor: widget.background,
      canBorderLeft: true,
      children: List<Widget>.generate(daysInCurrentMonth, (int index) {
        TextStyle textStyle = themeTextStyle(context);
        if (index >= daysInCurrentMonth) {
          textStyle = textStyle.copyWith(
            color: CupertinoColors.inactiveGray,
          );
        }
        return itemPositioningBuilder(
          context,
          Text(
            _getDayOfWeek(index),
            style: widget.textStyleDate,
          ),
        );
      }),
      onSelectItem: (index) {
        selectedDay = index + 1;
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

  Widget buildMonthPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    return BuildPicker(
      offAxisFraction: offAxisFraction,
      controller: monthController,
      backgroundColor: widget.background,
      children: List<Widget>.generate(12, (int index) {
        return itemPositioningBuilder(
          context,
          Text('${S.current.thang} ${index + 1}', style: widget.textStyleDate),
        );
      }),
      onSelectItem: (index) {
        selectedMonth = index + 1;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateTimeChanged(
            DateTime(selectedYear, selectedMonth, selectedDay),
          );
        }
      },
    );
  }

  Widget buildLunar(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    int counter = 0;
    return BuildPicker(
      looping: false,
      offAxisFraction: offAxisFraction,
      controller: lunarController,
      backgroundColor: widget.background,
      children: List<Widget>.generate(2, (int index) {
        return itemPositioningBuilder(
          context,
          Text(index == 0 ? 'Duong' : 'Am', style: widget.textStyleDate),
        );
      }),
      onSelectItem: (index) {
        counter++;
        if (index == 0) {
        } else {
          final solar = Solar(
            solarDay: selectedDay,
            solarMonth: selectedMonth,
            solarYear: selectedYear,
          );
          final lunar = LunarSolarConverter.solarToLunar(solar);

          if (counter == 1) {
            dayController.animateToItem(
              (lunar.lunarDay ?? 1) - 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
            monthController.animateToItem(
              (lunar.lunarMonth ?? 1) - 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
            yearController.animateToItem(
              lunar.lunarYear ?? 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
          }
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
        selectedYear = index;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateTimeChanged(
            DateTime(selectedYear, selectedMonth, selectedDay),
          );
        }
      },
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.minimumYear) return null;

        if (widget.maximumYear != null && index > widget.maximumYear!) {
          return null;
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
    pickerBuilders.addAll(
        [buildLunar, buildDayPicker, buildMonthPicker, buildYearPicker]);
    columnWidths.addAll([
      estimatedColumnWidths[PickerColumnType.lunar.index]!,
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
}
