// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget {
  final Widget Function(BuildContext context, DateTime day)? dowBuilder;
  final Widget Function(BuildContext context, DateTime day) dayBuilder;
  final List<DateTime> visibleDays;
  final Decoration? dowDecoration;
  final Decoration? rowDecoration;
  final TableBorder? tableBorder;
  final bool dowVisible;
  final bool isDowTop;
  const CalendarPage({
    Key? key,
    required this.visibleDays,
    this.dowBuilder,
    required this.dayBuilder,
    this.dowDecoration,
    this.rowDecoration,
    this.tableBorder,
    this.dowVisible = true,
    this.isDowTop = true
  })  : assert(!dowVisible || dowBuilder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(

      border: tableBorder,
      children: [
        if (dowVisible && isDowTop) _buildDaysOfWeek(context),
        ..._buildCalendarDays(context),
        if (dowVisible && !isDowTop) _buildDaysOfWeekPading(context),
        if (dowVisible && !isDowTop) _buildDaysOfWeek(context),

      ],
    );
  }

  TableRow _buildDaysOfWeek(BuildContext context) {
    return TableRow(
      decoration: dowDecoration,
      children: List.generate(
        7,
        (index) => dowBuilder!(context, visibleDays[index]),
      ).toList(),
    );
  }
  TableRow _buildDaysOfWeekPading(BuildContext context) {
    return TableRow(
      decoration: dowDecoration,
      children: List.generate(
        7,
            (index) => const SizedBox(
              height: 10,
            ),
      ).toList(),
    );
  }

  List<TableRow> _buildCalendarDays(BuildContext context) {
    final rowAmount = visibleDays.length ~/ 7;

    return List.generate(rowAmount, (index) => index * 7)
        .map((index) => TableRow(
              decoration: rowDecoration,
              children: List.generate(
                7,
                (id) => dayBuilder(context, visibleDays[index + id]),
              ),
            ))
        .toList();
  }
}
