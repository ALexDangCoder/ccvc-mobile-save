import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayPickerWidget extends StatefulWidget {
  const DayPickerWidget({
    Key? key,
    required this.onChange,
    this.initDate,
    this.initDayPicked,
    this.isUpdate = false,
  }) : super(key: key);
  final Function(List<int>) onChange;
  final DateTime? initDate;
  final List<int>? initDayPicked;
  final bool isUpdate;

  @override
  _DayPickerWidgetState createState() => _DayPickerWidgetState();
}

class _DayPickerWidgetState extends State<DayPickerWidget> {
  List<int> selectedIndex = [];

  @override
  void initState() {
    super.initState();
    if (!widget.isUpdate) {
      final currentDay =
          DateFormat('EEEE').format(DateTime.now()).dayToIdLichLap();
      if (currentDay != null) {
        selectedIndex.add(currentDay);
        widget.onChange(selectedIndex);
      }
    } else {
      selectedIndex.addAll(widget.initDayPicked ?? []);
    }
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
                if (selectedIndex.contains(daysOfWeek[index].id)) {
                  selectedIndex.remove(daysOfWeek[index].id);
                } else {
                  selectedIndex.add(daysOfWeek[index].id);
                }
                widget.onChange(selectedIndex);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(9),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: selectedIndex.contains(index)
                      ?  AppTheme.getInstance().colorField()
                      :  AppTheme.getInstance().colorField().withOpacity(
                          0.1,
                        ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  daysOfWeek[index].label,
                  style: textNormal(
                    selectedIndex.contains(index)
                        ? backgroundColorApp
                        :  AppTheme.getInstance().colorField(),
                    12,
                  ).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
