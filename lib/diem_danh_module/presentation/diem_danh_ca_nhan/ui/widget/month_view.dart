import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {
  final List<DateTime> listData;
  final DateTime changeDay;
  final Function(DateTime value) onChange;

  const MonthView({
    Key? key,
    required this.listData,
    required this.onChange,
    required this.changeDay,
  }) : super(key: key);

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  bool isMatchDay(
    DateTime a,
    DateTime b,
  ) {
    if (a.year == b.year && a.month == b.month && a.day == b.day) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3,
      shrinkWrap: true,
      crossAxisCount: 3,
      children: widget.listData
          .map(
            (e) => GestureDetector(
              onTap: () {
                widget.onChange(e);
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isMatchDay(e, widget.changeDay)
                        ? AppTheme.getInstance().colorField().withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    e.getMonth,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isMatchDay(e, widget.changeDay)
                          ? AppTheme.getInstance().colorField()
                          : color667793,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
