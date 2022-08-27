import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich/build_picker.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/ui/widget/lich/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

const double kItemExtent = 40.0;

const bool kUseMagnifier = true;
const double kMagnification = 1.08;
const double kDatePickerPadSize = 12.0;
const double kSqueeze = 0.7;

extension CupertinoDataPicker on CupertinoDatePickerDateAmDuongState {
  Widget buildDayPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    final int daysInCurrentMonth =
        DateTime(selectedYear, (selectedMonth + 1) % 12, 0).day;

    return BuildPickerCusTom(
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
          widget.onChangeSolar?.call(
            DateTime(selectedYear, selectedMonth, selectedDay),
            flagLunar,
          );
        }
      },
    );
  }

  String _getDayOfWeek(int index) {
    final days = DateTime(selectedYear, selectedMonth, index + 1);
    final day = DateFormat('EEEE').format(days);
    return '$day, ${localizations.datePickerDayOfMonth(index + 1)}';
  }

  Widget buildMonthPicker(
    double offAxisFraction,
    TransitionBuilder itemPositioningBuilder,
  ) {
    return BuildPickerCusTom(
      offAxisFraction: offAxisFraction,
      controller: monthController,
      backgroundColor: widget.background,
      children: List<Widget>.generate(12, (int index) {
        return itemPositioningBuilder(
          context,
          Text('${index + 1}', style: widget.textStyleDate),
        );
      }),
      onSelectItem: (index) {
        selectedMonth = index + 1;
        if (DateTime(selectedYear, selectedMonth, selectedDay).day ==
            selectedDay) {
          widget.onDateTimeChanged(
            DateTime(selectedYear, selectedMonth, selectedDay),
          );
          widget.onChangeSolar?.call(
            DateTime(selectedYear, selectedMonth, selectedDay),
            flagLunar,
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
    return BuildPickerCusTom(
      looping: false,
      offAxisFraction: offAxisFraction,
      controller: lunarController,
      backgroundColor: widget.background,
      onSelectItem: (index) {
        counter++;
        if (index == 0) {
          final solar = Solar(
            solarDay: selectedDay,
            solarMonth: selectedMonth,
            solarYear: selectedYear,
          );
          flagLunar = true;
          widget.onChangeSolar?.call(
            DateTime(selectedYear, selectedMonth, selectedDay),
            flagLunar,
          );
          final lunar = LunarSolarConverter.solarToLunar(solar);
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
        } else {
          flagLunar = false;
          widget.onChangeSolar?.call(
            DateTime(selectedYear, selectedMonth, selectedDay),
            flagLunar,
          );
          final solar = Lunar(
            lunarDay: selectedDay,
            lunarMonth: selectedMonth,
            lunarYear: selectedYear,
          );
          final solars = LunarSolarConverter.lunarToSolar(solar);
          if (counter == 1) {
            dayController.animateToItem(
              (solars.solarDay ?? 1) - 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
            monthController.animateToItem(
              (solars.solarMonth ?? 1) - 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
            yearController.animateToItem(
              solars.solarYear ?? 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn,
            );
          }
        }
      },
      children: List<Widget>.generate(2, (int index) {
        return itemPositioningBuilder(
          context,
          Text(index == 0 ? 'Âm' : 'Dương', style: widget.textStyleDate),
        );
      }),
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
          widget.onChangeSolar?.call(
            DateTime(selectedYear, selectedMonth, selectedDay),
            flagLunar,
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

  void addPickerCellAmDuong(
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
