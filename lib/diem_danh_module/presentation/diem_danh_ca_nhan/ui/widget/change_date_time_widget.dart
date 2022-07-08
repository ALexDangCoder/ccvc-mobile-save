import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/widget/month_view.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/slide_expand.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeDateTimeWidget extends StatefulWidget {
  final int startYear;
  final int endYear;
  final Function(DateTime value) onChange;
  final DiemDanhCubit cubit;

  const ChangeDateTimeWidget({
    Key? key,
    required this.cubit,
    required this.onChange,
    this.startYear = 2018,
    required this.endYear,
  })  : assert(endYear > 0 && startYear > 0),
        assert(endYear > startYear),
        super(key: key);

  @override
  _ChangeDateTimeWidgetState createState() => _ChangeDateTimeWidgetState();
}

class _ChangeDateTimeWidgetState extends State<ChangeDateTimeWidget> {
  ///list year
  List<int> listYear = [];

  ///current date
  DateTime currentMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  ///current index of page
  late int currentIndex;

  /// year return list month
  late int yearPage;

  /// show month
  bool isExpand = false;
  late final PageController controller;

  Duration duration = const Duration(milliseconds: 300);
  Curve curve = Curves.easeOut;

  @override
  void initState() {
    super.initState();
    initDataYear();
    controller = PageController(
      initialPage: indexPageOfYear(currentMonth.year),
    );
    currentIndex = indexPageOfYear(currentMonth.year);
    yearPage = currentMonth.year;
  }

  int getYearFromPage(int page) {
    return listYear[page];
  }

  void initDataYear() {
    for (int i = 0; i < _itemCount; i++) {
      listYear.add(widget.startYear + i);
    }
  }

  int indexPageOfYear(int year) {
    return listYear.indexOf(year);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return MonthView(
      listData: listData(yearPage),
      onChange: (data) {
        currentMonth = data;
        setState(() {});
      },
      changeDay: currentMonth,
    );
  }

  List<DateTime> listData(int year) {
    final List<DateTime> data = [];

    for (int i = 1; i <= 12; i++) {
      data.add(DateTime(year, i));
    }
    return data;
  }

  int get _itemCount {
    return widget.endYear - widget.startYear + 1;
  }

  void _onPageChange(int index) {
    yearPage = getYearFromPage(index);

    currentIndex = index;

    setState(() {});
  }

  /// move current page
  void moveCurrentPage() {
    controller.animateToPage(
      indexPageOfYear(currentMonth.year),
      duration: duration,
      curve: curve,
    );
  }

  void nextMonth() {
    moveCurrentPage();
    if (currentMonth.month == 12 && currentMonth.year < widget.endYear) {
      controller.nextPage(duration: duration, curve: curve);
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    } else if (currentIndex < _itemCount &&
        currentMonth.year < widget.endYear) {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    } else if (currentIndex == _itemCount - 1 &&
        currentMonth.year == widget.endYear &&
        currentMonth.month < 12) {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    }
    yearPage = currentMonth.year;
    widget.onChange(currentMonth);
    setState(() {});
  }

  void previousMonth() {
    moveCurrentPage();

    if (currentMonth.month == 1 && currentMonth.year > widget.startYear) {
      controller.previousPage(duration: duration, curve: curve);
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    } else if (currentIndex > 0 && currentMonth.year > widget.startYear) {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    } else if (currentIndex == 0 &&
        currentMonth.year == widget.startYear &&
        currentMonth.month > 1) {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    }
    yearPage = currentMonth.year;

    widget.onChange(currentMonth);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            isExpand = !isExpand;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: colorF9FAFF,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: previousMonth,
                  child: const Icon(
                    Icons.navigate_before_rounded,
                    color: colorA2AEBD,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Tháng ${currentMonth.formatMonthAndYear}',
                    style: textNormalCustom(
                      color: color7966FF,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: nextMonth,
                  child: const Icon(
                    Icons.navigate_next_rounded,
                    color: colorA2AEBD,
                  ),
                ),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: ExpandablePageView.builder(
            itemCount: _itemCount,
            controller: controller,
            onPageChanged: _onPageChange,
            itemBuilder: _itemBuilder,
          ),
        ),
      ],
    );
  }
}
