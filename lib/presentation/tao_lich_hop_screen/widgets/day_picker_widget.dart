import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayPickerWidget extends StatefulWidget {
  const DayPickerWidget({
    Key? key,
    required this.onChange,
    this.initDate,
    this.initDayPicked = 1,
  }) : super(key: key);
  final Function(String, int) onChange;
  final DateTime? initDate;
  final int initDayPicked;

  @override
  _DayPickerWidgetState createState() => _DayPickerWidgetState();
}

class _DayPickerWidgetState extends State<DayPickerWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initDayPicked;
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
      ],
    );
  }
}
