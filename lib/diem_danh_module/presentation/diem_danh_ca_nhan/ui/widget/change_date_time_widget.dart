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
  final DateTime? currentMonth;

  const ChangeDateTimeWidget({
    Key? key,
    required this.cubit,
    required this.onChange,
    this.startYear = 2018,
    required this.endYear,
    this.currentMonth,
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
  late DateTime _currentMonth;

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
    _currentMonth = widget.currentMonth ??
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
        );
    initDataYear();
    controller = PageController(
      initialPage: indexPageOfYear(_currentMonth.year),
    );
    currentIndex = indexPageOfYear(_currentMonth.year);
    yearPage = _currentMonth.year;
  }

  /// return year number equivalent to page number
  int getYearFromPage(int page) {
    return listYear[page];
  }

  void initDataYear() {
    for (int i = 0; i < _itemCount; i++) {
      listYear.add(widget.startYear + i);
    }
  }

  ///return page number equivalent to year number
  int indexPageOfYear(int year) {
    return listYear.indexOf(year);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return MonthView(
      listData: listData(yearPage),
      onChange: (data) {
        _currentMonth = data;
        widget.onChange(data);
        setState(() {});
      },
      changeDay: _currentMonth,
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

  void nextMonth() {
    _currentMonth = DateTime(_currentMonth.year + 1, _currentMonth.month);
    widget.onChange(_currentMonth);
    yearPage = _currentMonth.year;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeDateTimeWidget oldWidget) {
    _currentMonth = widget.currentMonth ??
        DateTime(DateTime.now().year, DateTime.now().month);
    super.didUpdateWidget(oldWidget);
  }

  void previousMonth() {
    _currentMonth = DateTime(_currentMonth.year - 1, _currentMonth.month);
    widget.onChange(_currentMonth);

    yearPage = _currentMonth.year;

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
                    'Tháng ${_currentMonth.formatMonthAndYear}',
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
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: _onPageChange,
            itemBuilder: _itemBuilder,
          ),
        ),
      ],
    );
  }
}
