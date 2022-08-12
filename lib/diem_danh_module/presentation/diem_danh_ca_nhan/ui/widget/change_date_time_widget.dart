import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/widget/month_view.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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
    this.startYear = 1900,
    required this.endYear,
    this.currentMonth,
  })  : assert(endYear > 0 && startYear > 0),
        assert(endYear > startYear),
        super(key: key);

  @override
  ChangeDateTimeWidgetState createState() => ChangeDateTimeWidgetState();
}

class ChangeDateTimeWidgetState extends State<ChangeDateTimeWidget> {
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
  final DateTime _now = DateTime.now();

  /// [isJanuary] Xác định vị trí có phải đang là tháng 1 không.
  ///Để khi bấm lùi tháng thì sẽ vào tháng 12 thay vì vào tháng 1 khi chuyển năm
  bool isJanuary = false;
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
    /// Vuốt sang trái/phải theo năm thì sẽ về mặc định tháng 1
    /// Nếu vào đúng năm hiện tại thì hiển thị tháng hiện tại
    /// Nếu ở tháng 1, chuyển về tháng trước thì sẽ bị chuyển cả năm và tháng
    /// và chuyển vào tháng 12 thay vì chuyển vào tháng 1
    /// Nếu ở tháng 1 năm liền kề của năm hiện tại thì bấm nút chuyển tháng sẽ
    /// về tháng 12 thay vì về tháng hiện tại, sau đó vuốt năm thì lại chuyển
    /// sang tháng 1 của năm đó và chuyển về năm hiện tại thì lại về tháng hiện tại
    yearPage = getYearFromPage(index);
    currentIndex = index;
    _currentMonth = yearPage == _now.year
        ? DateTime(_now.year, _currentMonth.month == 12 ? 12 : _now.month)
        : _currentMonth.month == 12
            ? isJanuary
                ? DateTime(yearPage, 12)
                : DateTime(yearPage)
            : DateTime(yearPage);
    widget.onChange(_currentMonth);
    isJanuary = false;
    setState(() {});
  }

  /// move current page
  void moveCurrentPage() {
    controller.animateToPage(
      indexPageOfYear(_currentMonth.year),
      duration: duration,
      curve: curve,
    );
  }

  void nextMonth() {
    moveCurrentPage();

    /// nếu như thời gian đang ở tháng 12 và phải nhỏ hơn thời gian kết thúc
    /// thì chuyển page và sang tháng 1 năm tiếp theo
    if (_currentMonth.month == DiemDanhConstant.THANG_12 &&
        _currentMonth.year < widget.endYear) {
      controller.nextPage(duration: duration, curve: curve);
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    }

    /// nếu như page khác page cuối cùng và thời gian phải nhỏ hơn thời gian
    /// kết thúc thì sang tháng tiếp theo
    else if (currentIndex < _itemCount && _currentMonth.year < widget.endYear) {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      widget.onChange(_currentMonth);
    }

    /// nếu như page là page cuối cùng và thời gian bằng thời gian
    /// kết thúc và tháng nhỏ hơn tháng 12 thì sang tháng tiếp theo
    else if (currentIndex == _itemCount - 1 &&
        _currentMonth.year == widget.endYear &&
        _currentMonth.month < DiemDanhConstant.THANG_12) {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      widget.onChange(_currentMonth);
    }
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
    moveCurrentPage();

    /// nếu như thời gian đang ở tháng 1 và phải lớn hơn thời gian bắt
    /// đầu thì chuyển page và trở về tháng 12 năm trước đó
    if (_currentMonth.month == DiemDanhConstant.THANG_1 &&
        _currentMonth.year > widget.startYear) {
      controller.previousPage(duration: duration, curve: curve);
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      isJanuary = true;
    }

    /// nếu như page khác page đầu tiên và thời gian phải lớn hơn thời gian
    /// bắt đầu thì sang tháng trước đó
    else if (currentIndex > 0 && _currentMonth.year > widget.startYear) {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      widget.onChange(_currentMonth);
    }

    /// nếu như page đang ở page đầu tiên và thời gian bằng thời gian
    /// bắt đầu và tháng hiện tại lớn hơn 1 thì sang tháng trước đó
    else if (currentIndex == 0 &&
        _currentMonth.year == widget.startYear &&
        _currentMonth.month > 1) {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      widget.onChange(_currentMonth);
    }
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
                    '${S.current.thang} ${_currentMonth.formatMonthAndYear}',
                    style: textNormalCustom(
                      color: AppTheme.getInstance().colorField(),
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
