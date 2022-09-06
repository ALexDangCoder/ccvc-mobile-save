import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'month_pick.dart';

class DateTimeCus extends StatefulWidget {
  const DateTimeCus({Key? key, required this.onDatePicked, this.initialDate})
      : super(key: key);
  final Function(String) onDatePicked;
  final DateTime? initialDate;

  @override
  _DateTimeCusState createState() => _DateTimeCusState();
}

class _DateTimeCusState extends State<DateTimeCus>
    with SingleTickerProviderStateMixin {
  late DatePickerDartCubit cubit;
  late int year;
  late int month;

  late final AnimationController _controller;
  late final Animation<double> _animation;
  late String selectDate;

  @override
  void initState() {
    super.initState();
    year = widget.initialDate?.year ?? DateTime.now().year;
    month = widget.initialDate?.month ?? DateTime.now().month;
    cubit = DatePickerDartCubit();
    cubit.getDaysOfCurrentMonth(year: year, month: month);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween(begin: 0.3, end: 1.0).animate(_controller);
    selectDate =
        widget.initialDate?.formatddMMYYYY() ?? DateTime.now().formatddMMYYYY();
  }

  @override
  void didUpdateWidget(covariant DateTimeCus oldWidget) {
    year = widget.initialDate?.year ?? DateTime.now().year;
    month = widget.initialDate?.month ?? DateTime.now().month;
    selectDate =
        widget.initialDate?.formatddMMYYYY() ?? DateTime.now().formatddMMYYYY();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (month == 1) {
                    month = 12;
                    year--;
                  } else {
                    month--;
                  }
                  cubit.getDaysOfCurrentMonth(year: year, month: month);
                  setState(() {});
                },
                child: SizedBox(
                  height: 24,
                  width: 30,
                  child: ImageAssets.svgAssets(
                    ImageAssets.icBack,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        MonthPickerCus(year: year, month: month),
                  ).then((value) {
                    try {
                      value as List<int>;
                      if (value.isNotEmpty) {
                        setState(() {});
                        month = value[0];
                        year = value[1];
                        cubit.getDaysOfCurrentMonth(year: year, month: month);
                        setState(() {});
                      }
                    } catch (e) {
                      //
                    }
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${month.monthToString()}, $year',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: AppTheme.getInstance().titleColor(),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (month == 12) {
                    month = 1;
                    year++;
                  } else {
                    month++;
                  }
                  cubit.getDaysOfCurrentMonth(year: year, month: month);
                  setState(() {});
                },
                child: SizedBox(
                  height: 24,
                  width: 30,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: ImageAssets.svgAssets(
                      ImageAssets.icBack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceH8,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: GridView.custom(
            physics: const ClampingScrollPhysics(),
            gridDelegate: _dayPickerGridDelegate,
            childrenDelegate: SliverChildListDelegate(
              [
                daysOfWeekWidget(
                  'T2',
                ),
                daysOfWeekWidget(
                  'T3',
                ),
                daysOfWeekWidget(
                  'T4',
                ),
                daysOfWeekWidget(
                  'T5',
                ),
                daysOfWeekWidget(
                  'T6',
                ),
                daysOfWeekWidget(
                  'T7',
                ),
                daysOfWeekWidget(
                  'CN',
                ),
              ],
              addRepaintBoundaries: false,
            ),
          ),
        ),
        Dismissible(
          resizeDuration: null,
          key: ValueKey(month),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              if (month == 12) {
                month = 1;
                year++;
              } else {
                month++;
              }
            } else {
              if (month == 1) {
                month = 12;
                year--;
              } else {
                month--;
              }
            }
            cubit.getDaysOfCurrentMonth(
              year: year,
              month: month,
            );
            setState(() {});
          },
          background: FadeTransition(
            opacity: _animation,
            child: GridView.custom(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: _dayPickerGridDelegate,
              childrenDelegate: SliverChildListDelegate(
                dayToWidget(
                  30,
                ),
                addRepaintBoundaries: false,
              ),
            ),
          ),
          secondaryBackground: FadeTransition(
            opacity: _animation,
            child: GridView.custom(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: _dayPickerGridDelegate,
              childrenDelegate: SliverChildListDelegate(
                dayToWidget(
                  30,
                ),
                addRepaintBoundaries: false,
              ),
            ),
          ),
          child: GridView.custom(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: _dayPickerGridDelegate,
            childrenDelegate: SliverChildListDelegate(
              dayToWidget(
                cubit.daysOfMonth,
              ),
              addRepaintBoundaries: false,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> dayToWidget(int days) {
    final List<Widget> list = [];
    final int count = cubit.dayToInt('$year-${month.monthToNumString()}-01');
    for (int j = 0; j < count; j++) {
      list.add(Container());
    }
    for (int i = 0; i < days; i++) {
      list.add(daysOfMonthWidget(i));
    }
    return list;
  }

  Widget daysOfMonthWidget(int i) {
    return GestureDetector(
      onTap: () {
        selectDate =
            '${(i + 1).monthToNumString()}-${month.monthToNumString()}-$year';
        widget.onDatePicked(selectDate);
        setState(() {});
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color:
              '${(i + 1).monthToNumString()}-${month.monthToNumString()}-$year' ==
                      selectDate
                  ? AppTheme.getInstance().colorField()
                  : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                '${(i + 1).monthToNumString()}-${month.monthToNumString()}-$year' ==
                        DateTime.now().formatddMMYYYY()
                    ? AppTheme.getInstance().colorField()
                    : Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '${i + 1}',
          style: textNormalCustom(
            color: '${(i + 1).monthToNumString()}-${month.monthToNumString()}-$year' ==
                    DateTime.now().formatddMMYYYY()
                ? ('${(i + 1).monthToNumString()}-${month.monthToNumString()}-$year' ==
                        selectDate
                    ? AppTheme.getInstance().backGroundColor()
                    : AppTheme.getInstance().colorField())
                : ('${(i + 1).monthToNumString()}-${month.monthToNumString()}-$year' ==
                        selectDate
                    ? AppTheme.getInstance().backGroundColor()
                    : AppTheme.getInstance().dfTxtColor()),
          ),
        ),
      ),
    );
  }

  Widget daysOfWeekWidget(String title) {
    return Center(
      child: Text(
        title,
        style: textNormalCustom(
          color: AppTheme.getInstance().unselectedLabelColor(),
        ),
      ),
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    const double tileHeight = 40;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _dayPickerGridDelegate = _DayPickerGridDelegate();

class DatePickerDartCubit extends Cubit<DatePickerDartState> {
  DatePickerDartCubit() : super(DatePickerDartInitial());
  int daysOfMonth = 0;

  void getDaysOfCurrentMonth({required int year, required int month}) {
    daysOfMonth = DateUtils.getDaysInMonth(year, month);
  }

  int dayToInt(String date) {
    final String day = DateFormat('EEEE').format(DateTime.parse(date));
    if (day == 'Tuesday' || day == 'Thứ Ba') {
      return 1;
    }
    if (day == 'Wednesday' || day == 'Thứ Tư') {
      return 2;
    }
    if (day == 'Thursday' || day == 'Thứ Năm') {
      return 3;
    }
    if (day == 'Friday' || day == 'Thứ Sáu') {
      return 4;
    }
    if (day == 'Saturday' || day == 'Thứ Bảy') {
      return 5;
    }
    if (day == 'Sunday' || day == 'Chủ Nhật') {
      return 6;
    }
    return 0;
  }
}

@immutable
abstract class DatePickerDartState {}

class DatePickerDartInitial extends DatePickerDartState {}

extension IntDate on int {
  String monthToNumString() {
    switch (this) {
      case 1:
        return '01';
      case 2:
        return '02';
      case 3:
        return '03';
      case 4:
        return '04';
      case 5:
        return '05';
      case 6:
        return '06';
      case 7:
        return '07';
      case 8:
        return '08';
      case 9:
        return '09';
      default:
        return toString();
    }
  }

  String monthToString() {
    switch (this) {
      case 1:
        return 'Tháng 1';
      case 2:
        return 'Tháng 2';
      case 3:
        return 'Tháng 3';
      case 4:
        return 'Tháng 4';
      case 5:
        return 'Tháng 5';
      case 6:
        return 'Tháng 6';
      case 7:
        return 'Tháng 7';
      case 8:
        return 'Tháng 8';
      case 9:
        return 'Tháng 9';
      case 10:
        return 'Tháng 10';
      case 11:
        return 'Tháng 11';
      case 12:
        return 'Tháng 12';
      default:
        return '';
    }
  }
}

extension StringDateTime on DateTime {
  String formatddMMYYYY() {
    final dateString = DateFormat('dd-MM-yyyy').format(this);
    return dateString;
  }
}
