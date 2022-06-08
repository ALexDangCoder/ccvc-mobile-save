import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayPickerWidget extends StatefulWidget {
  const DayPickerWidget({
    Key? key,
    required this.onChange,
    this.initDate,
    this.initDayPicked = 1, required this.onDateChange,
  }) : super(key: key);
  final Function(String, int) onChange;
  final Function(String) onDateChange;
  final DateTime? initDate;
  final int initDayPicked;

  @override
  _DayPickerWidgetState createState() => _DayPickerWidgetState();
}

class _DayPickerWidgetState extends State<DayPickerWidget> {
  // final List<String> listDays = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
  late int selectedIndex;
  bool isShowDatePicker = false;
  late String date;
  late final Debouncer deboucer;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initDayPicked;
    date = widget.initDate == null
        ? (DateTime.now().add(const Duration(minutes: 1))).dateTimeFormatter(
            pattern: DateFormatApp.date,
          )
        : widget.initDate!.dateTimeFormatter(
            pattern: DateFormatApp.date,
          );
    deboucer = Debouncer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            daysOfWeek.length,
            (index) => GestureDetector(
              onTap: () {
                widget.onChange(daysOfWeek[index].label, daysOfWeek[index].id);
                selectedIndex = index;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(9),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? textDefault
                      : textDefault.withOpacity(
                          0.1,
                        ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  daysOfWeek[index].label,
                  style: textNormal(
                    selectedIndex == index ? backgroundColorApp : textDefault,
                    12,
                  ).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        spaceH24,
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            isShowDatePicker = !isShowDatePicker;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.lap_den,
                style: textNormal(color586B8B, 16),
              ),
              Row(
                children: [
                  Text(
                    date,
                    style: textNormal(color586B8B, 16),
                  ),
                  spaceW25,
                  ImageAssets.svgAssets(
                    ImageAssets.icDropDown,
                    color: colorA2AEBD,
                  ),
                ],
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          height: isShowDatePicker ? 200 : 1,
          child: isShowDatePicker
              ? CupertinoDatePicker(
                  maximumDate: DateTime(2099, 12, 30),
                  maximumYear: 2099,
                  minimumYear: DateTime.now().year,
                  backgroundColor: backgroundColorApp,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  initialDateTime: date.convertStringToDate(
                    formatPattern: DateFormatApp.date,
                  ),
                  onDateTimeChanged: (value) {
                    deboucer.run(() {
                      date = value.dateTimeFormatter(
                        pattern: DateFormatApp.date,
                      );
                      widget.onDateChange(date);
                      setState(() {});
                    });
                  },
                )
              : const SizedBox.shrink(),
        ),
        Visibility(
          visible: !isShowDatePicker,
          child: Container(
            margin: const EdgeInsets.only(top: 11),
            height: 1,
            color: colorA2AEBD.withOpacity(0.1),
          ),
        )
      ],
    );
  }
}
