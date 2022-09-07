part of '../calendar_view.dart';

@immutable
class _CalendarView extends StatefulWidget {
  const _CalendarView(
      this.calendar,
      this.view,
      this.visibleDates,
      this.width,
      this.height,
      this.agendaSelectedDate,
      this.locale,
      this.calendarTheme,
      this.regions,
      this.blackoutDates,
      this.focusNode,
      this.removePicker,
      this.allowViewNavigation,
      this.controller,
      this.resourcePanelScrollController,
      this.resourceCollection,
      this.textScaleFactor,
      this.isMobilePlatform,
      this.minDate,
      this.maxDate,
      this.localizations,
      this.timelineMonthWeekNumberNotifier,
      this.dragDetails,
      this.updateCalendarState,
      this.getCalendarState,
      {Key? key,
        this.onMoreDayClick})
      : super(key: key);

  final List<DateTime> visibleDates;
  final void Function(DateTime day, int count)? onMoreDayClick;
  final List<CalendarTimeRegion>? regions;
  final List<DateTime>? blackoutDates;
  final SfCalendar calendar;
  final CalendarView view;
  final double width;
  final SfCalendarThemeData calendarTheme;
  final double height;
  final String locale;
  final ValueNotifier<DateTime?> agendaSelectedDate,
      timelineMonthWeekNumberNotifier;
  final CalendarController controller;
  final VoidCallback removePicker;
  final UpdateCalendarState updateCalendarState;
  final UpdateCalendarState getCalendarState;
  final bool allowViewNavigation;
  final FocusNode focusNode;
  final ScrollController? resourcePanelScrollController;
  final List<CalendarResource>? resourceCollection;
  final double textScaleFactor;
  final bool isMobilePlatform;
  final DateTime minDate;
  final DateTime maxDate;
  final SfLocalizations localizations;
  final ValueNotifier<_DragPaintDetails> dragDetails;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView>
    with TickerProviderStateMixin {
  // line count is the total time slot lines to be drawn in the view
  // line count per view is for time line view which contains the time slot
  // count for per view
  double? _horizontalLinesCount;

  // all day scroll controller is used to identify the scroll position for draw
  // all day selection.
  ScrollController? _scrollController;
  ScrollController? _timelineViewHeaderScrollController,
      _timelineViewVerticalScrollController,
      _timelineRulerController;

  late AppointmentLayout _appointmentLayout;
  AnimationController? _timelineViewAnimationController;
  Animation<double>? _timelineViewAnimation;
  final Tween<double> _timelineViewTween = Tween<double>(begin: 0.0, end: 0.1);

  //// timeline header is used to implement the sticky view header in horizontal calendar view mode.
  late TimelineViewHeaderView _timelineViewHeader;
  _SelectionPainter? _selectionPainter;
  double _allDayHeight = 0;
  late double _timeIntervalHeight;
  final UpdateCalendarStateDetails _updateCalendarStateDetails =
  UpdateCalendarStateDetails();
  ValueNotifier<SelectionDetails?> _allDaySelectionNotifier =
  ValueNotifier<SelectionDetails?>(null);
  late ValueNotifier<Offset?> _viewHeaderNotifier;
  final ValueNotifier<Offset?> _calendarCellNotifier =
  ValueNotifier<Offset?>(null),
      _allDayNotifier = ValueNotifier<Offset?>(null),
      _appointmentHoverNotifier = ValueNotifier<Offset?>(null);
  final ValueNotifier<bool> _selectionNotifier = ValueNotifier<bool>(false),
      _timelineViewHeaderNotifier = ValueNotifier<bool>(false);
  late bool _isRTL;

  bool _isExpanded = false;
  DateTime? _hoveringDate;
  SystemMouseCursor _mouseCursor = SystemMouseCursors.basic;
  AppointmentView? _hoveringAppointmentView;

  /// The property to hold the resource value associated with the selected
  /// calendar cell.
  int _selectedResourceIndex = -1;
  AnimationController? _animationController;
  Animation<double>? _heightAnimation;
  Animation<double>? _allDayExpanderAnimation;
  AnimationController? _expanderAnimationController;

  /// Store the month widget instance used to update the month view
  /// when the visible appointment updated.
  late MonthViewWidget _monthView;

  /// Used to hold the global key for restrict the new appointment layout
  /// creation.
  /// if set the appointment layout key property as new Global key when create
  /// the appointment layout then each of the time it creates new appointment
  /// layout rather than update the existing appointment layout.
  final GlobalKey _appointmentLayoutKey = GlobalKey();

  BehaviorSubject<Map<DateTime, int>> removeDayCount =
  BehaviorSubject.seeded({});

  Timer? _timer, _autoScrollTimer;
  late ValueNotifier<int> _currentTimeNotifier;

  late ValueNotifier<_ResizingPaintDetails> _resizingDetails;
  double? _maximumResizingPosition;

  BehaviorSubject<int> totalAppRemove = BehaviorSubject.seeded(0);

  @override
  void initState() {
    _resizingDetails = ValueNotifier<_ResizingPaintDetails>(
        _ResizingPaintDetails(position: ValueNotifier<Offset?>(null)));
    _viewHeaderNotifier = ValueNotifier<Offset?>(null)
      ..addListener(_timelineViewHoveringUpdate);
    if (!CalendarViewHelper.isTimelineView(widget.view) &&
        widget.view != CalendarView.month) {
      _animationController = AnimationController(
          duration: const Duration(milliseconds: 200), vsync: this);
      _heightAnimation =
      CurveTween(curve: Curves.easeIn).animate(_animationController!)
        ..addListener(() {
          setState(() {
            /* Animates the all day panel height when
              expanding or collapsing */
          });
        });

      _expanderAnimationController = AnimationController(
          duration: const Duration(milliseconds: 100), vsync: this);
      _allDayExpanderAnimation = CurveTween(curve: Curves.easeIn)
          .animate(_expanderAnimationController!)
        ..addListener(() {
          setState(() {
            /* Animates the all day panel height when
              expanding or collapsing */
          });
        });
    }

    _timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);
    if (widget.view != CalendarView.month) {
      _horizontalLinesCount = CalendarViewHelper.getHorizontalLinesCount(
          widget.calendar.timeSlotViewSettings, widget.view);
      _scrollController =
      ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
        ..addListener(_scrollListener);
      if (CalendarViewHelper.isTimelineView(widget.view)) {
        _timelineRulerController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
          ..addListener(_timeRulerListener);
        _timelineViewHeaderScrollController =
            ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
        _timelineViewAnimationController = AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: this,
            animationBehavior: AnimationBehavior.normal);
        _timelineViewAnimation = _timelineViewTween
            .animate(_timelineViewAnimationController!)
          ..addListener(_scrollAnimationListener);
        _timelineViewVerticalScrollController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
          ..addListener(_updateResourceScroll);
        widget.resourcePanelScrollController
            ?.addListener(_updateResourcePanelScroll);
      }

      _scrollToPosition();
    }

    final DateTime today = DateTime.now();
    _currentTimeNotifier = ValueNotifier<int>(
        (today.day * 24 * 60) + (today.hour * 60) + today.minute);
    _timer = _createTimer();
    super.initState();
  }

  @override
  void didUpdateWidget(_CalendarView oldWidget) {
    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    if (widget.view != CalendarView.month) {
      if (!isTimelineView) {
        _updateTimeSlotView(oldWidget);
      }

      _updateHorizontalLineCount(oldWidget);

      _scrollController ??=
      ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
        ..addListener(_scrollListener);

      if (isTimelineView) {
        _updateTimelineViews(oldWidget);
      }
    }

    /// Update the scroll position with following scenarios
    /// 1. View changed from month or schedule view.
    /// 2. View changed from timeline view(timeline day, timeline week,
    /// timeline work week) to timeslot view(day, week, work week).
    /// 3. View changed from timeslot view(day, week, work week) to
    /// timeline view(timeline day, timeline week, timeline work week).
    ///
    /// This condition used to restrict the following scenarios
    /// 1. View changed to month view.
    /// 2. View changed with in the day, week, work week
    /// (eg., view changed to week from day).
    /// 3. View changed with in the timeline day, timeline week, timeline
    /// work week(eg., view changed to timeline week from timeline day).
    if ((oldWidget.view == CalendarView.month ||
        oldWidget.view == CalendarView.schedule ||
        (oldWidget.view != widget.view && isTimelineView) ||
        (CalendarViewHelper.isTimelineView(oldWidget.view) &&
            !isTimelineView)) &&
        widget.view != CalendarView.month) {
      _scrollToPosition();
    }

    /// Method called to update all day height, when the view changed from
    /// day to week views to avoid the blank space at the bottom of the view.
    final bool isCurrentView =
        _updateCalendarStateDetails.currentViewVisibleDates ==
            widget.visibleDates;
    _updateAllDayHeight(isCurrentView);

    _timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);

    /// Clear the all day panel selection when the calendar view changed
    /// Eg., if select the all day panel and switch to month view and again
    /// select the same month cell and move to day view then the view show
    /// calendar cell selection and all day panel selection.
    if (oldWidget.view != widget.view) {
      _allDaySelectionNotifier = ValueNotifier<SelectionDetails?>(null);
      final DateTime today = DateTime.now();
      _currentTimeNotifier = ValueNotifier<int>(
          (today.day * 24 * 60) + (today.hour * 60) + today.minute);
      _timer?.cancel();
      _timer = null;
    }

    if (oldWidget.calendar.showCurrentTimeIndicator !=
        widget.calendar.showCurrentTimeIndicator) {
      _timer?.cancel();
      _timer = _createTimer();
    }

    if ((oldWidget.view != widget.view ||
        oldWidget.width != widget.width ||
        oldWidget.height != widget.height) &&
        _selectionPainter!.appointmentView != null) {
      _selectionPainter!.appointmentView = null;
    }

    /// When view switched from any other view to timeline view, and resource
    /// enabled the selection must render the first resource view.
    widget.getCalendarState(_updateCalendarStateDetails);
    if (!CalendarViewHelper.isTimelineView(oldWidget.view) &&
        _updateCalendarStateDetails.selectedDate != null &&
        CalendarViewHelper.isResourceEnabled(
            widget.calendar.dataSource, widget.view) &&
        _selectedResourceIndex == -1) {
      _selectedResourceIndex = 0;
    }

    if (!CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view)) {
      _selectedResourceIndex = -1;
    }

    _timer ??= _createTimer();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = CalendarViewHelper.isRTLLayout(context);
    widget.getCalendarState(_updateCalendarStateDetails);
    switch (widget.view) {
      case CalendarView.schedule:
        return Container();
      case CalendarView.month:
        return _getMonthView();
      case CalendarView.day:
      case CalendarView.week:
      case CalendarView.workWeek:
        return _getDayView();
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
      case CalendarView.timelineMonth:
        return _getTimelineView();
    }
  }

  @override
  void dispose() {
    removeDayCount.close();
    totalAppRemove.close();
    _viewHeaderNotifier.removeListener(_timelineViewHoveringUpdate);

    _calendarCellNotifier.removeListener(_timelineViewHoveringUpdate);

    if (_timelineViewAnimation != null) {
      _timelineViewAnimation!.removeListener(_scrollAnimationListener);
    }

    if (widget.resourcePanelScrollController != null) {
      widget.resourcePanelScrollController!
          .removeListener(_updateResourcePanelScroll);
    }

    if (CalendarViewHelper.isTimelineView(widget.view) &&
        _timelineViewAnimationController != null) {
      _timelineViewAnimationController!.dispose();
      _timelineViewAnimationController = null;
    }
    if (_scrollController != null) {
      _scrollController!.removeListener(_scrollListener);
      _scrollController!.dispose();
      _scrollController = null;
    }
    if (_timelineViewHeaderScrollController != null) {
      _timelineViewHeaderScrollController!.dispose();
      _timelineViewHeaderScrollController = null;
    }
    if (_animationController != null) {
      _animationController!.dispose();
      _animationController = null;
    }
    if (_timelineRulerController != null) {
      _timelineRulerController!.dispose();
      _timelineRulerController = null;
    }

    if (_expanderAnimationController != null) {
      _expanderAnimationController!.dispose();
      _expanderAnimationController = null;
    }

    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    super.dispose();
  }

  Timer? _createTimer() {
    return widget.calendar.showCurrentTimeIndicator &&
        widget.view != CalendarView.month &&
        widget.view != CalendarView.timelineMonth
        ? Timer.periodic(const Duration(seconds: 1), (Timer t) {
      final DateTime today = DateTime.now();
      final DateTime viewEndDate =
      widget.visibleDates[widget.visibleDates.length - 1];

      /// Check the today date is in between visible date range and
      /// today date hour and minute is 0(12 AM) because in day view
      /// current time as Feb 16, 23.59 and changed to Feb 17 then view
      /// will update both Feb 16 and 17 views.
      if (!isDateWithInDateRange(
          widget.visibleDates[0], viewEndDate, today) &&
          !(today.hour == 0 &&
              today.minute == 0 &&
              isSameDate(addDays(today, -1), viewEndDate))) {
        return;
      }

      _currentTimeNotifier.value =
          (today.day * 24 * 60) + (today.hour * 60) + today.minute;
    })
        : null;
  }

  /// Updates the resource panel scroll based on timeline scroll in vertical
  /// direction.
  void _updateResourcePanelScroll() {
    if (_updateCalendarStateDetails.currentViewVisibleDates ==
        widget.visibleDates) {
      widget.removePicker();
    }

    if (widget.resourcePanelScrollController == null ||
        !CalendarViewHelper.isResourceEnabled(
            widget.calendar.dataSource, widget.view)) {
      return;
    }

    if (widget.resourcePanelScrollController!.offset !=
        _timelineViewVerticalScrollController!.offset) {
      _timelineViewVerticalScrollController!
          .jumpTo(widget.resourcePanelScrollController!.offset);
    }
  }

  /// Updates the timeline view scroll in vertical direction based on resource
  /// panel scroll.
  void _updateResourceScroll() {
    if (_updateCalendarStateDetails.currentViewVisibleDates ==
        widget.visibleDates) {
      widget.removePicker();
    }

    if (widget.resourcePanelScrollController == null ||
        !CalendarViewHelper.isResourceEnabled(
            widget.calendar.dataSource, widget.view)) {
      return;
    }

    if (widget.resourcePanelScrollController!.offset !=
        _timelineViewVerticalScrollController!.offset) {
      widget.resourcePanelScrollController!
          .jumpTo(_timelineViewVerticalScrollController!.offset);
    }
  }

  Widget _getMonthView() {
    return MouseRegion(
      cursor: _mouseCursor,
      onEnter: _pointerEnterEvent,
      onExit: _pointerExitEvent,
      onHover: _pointerHoverEvent,
      child: Stack(children: <Widget>[
        GestureDetector(
          child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: _addMonthView(_isRTL, widget.locale)),
          onTapUp: _handleOnTapForMonth,
          onLongPressStart: null,
        ),
        _getResizeShadowView()
      ]),
    );
  }

  Widget _getDayView() {
    final bool isCurrentView =
        _updateCalendarStateDetails.currentViewVisibleDates ==
            widget.visibleDates;
    _updateAllDayHeight(isCurrentView);

    return MouseRegion(
      cursor: _mouseCursor,
      onEnter: _pointerEnterEvent,
      onHover: _pointerHoverEvent,
      onExit: _pointerExitEvent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: SizedBox(
                height: widget.height,
                width: widget.width,
                child: _addDayView(
                    widget.width,
                    _timeIntervalHeight * _horizontalLinesCount!,
                    _isRTL,
                    widget.locale,
                    isCurrentView)),
            onTapUp: _handleOnTapForDay,
            onLongPressStart: null,
          ),
          _getResizeShadowView()
        ],
      ),
    );
  }

  /// Method to update alldayHeight calculation for day, week and work week
  /// view, based on the view also based on the timeintervalheight.
  void _updateAllDayHeight(bool isCurrentView) {
    if (widget.view != CalendarView.day &&
        widget.view != CalendarView.week &&
        widget.view != CalendarView.workWeek) {
      return;
    }

    _allDayHeight = 0;
    if (widget.view == CalendarView.day) {
      final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
          widget.calendar.viewHeaderHeight, widget.view);
      if (isCurrentView) {
        _allDayHeight = _kAllDayLayoutHeight > viewHeaderHeight &&
            _updateCalendarStateDetails.allDayPanelHeight > viewHeaderHeight
            ? _updateCalendarStateDetails.allDayPanelHeight >
            _kAllDayLayoutHeight
            ? _kAllDayLayoutHeight
            : _updateCalendarStateDetails.allDayPanelHeight
            : viewHeaderHeight;
        if (_allDayHeight < _updateCalendarStateDetails.allDayPanelHeight) {
          _allDayHeight += kAllDayAppointmentHeight;
        }
      } else {
        _allDayHeight = viewHeaderHeight;
      }
    } else if (isCurrentView) {
      _allDayHeight =
      _updateCalendarStateDetails.allDayPanelHeight > _kAllDayLayoutHeight
          ? _kAllDayLayoutHeight
          : _updateCalendarStateDetails.allDayPanelHeight;
      _allDayHeight = _allDayHeight * _heightAnimation!.value;
    }
  }

  Widget _getTimelineView() {
    return MouseRegion(
        cursor: _mouseCursor,
        onEnter: _pointerEnterEvent,
        onHover: _pointerHoverEvent,
        onExit: _pointerExitEvent,
        child: Stack(children: <Widget>[
          GestureDetector(
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: _addTimelineView(
                  _timeIntervalHeight *
                      (_horizontalLinesCount! * widget.visibleDates.length),
                  widget.height,
                  widget.locale),
            ),
            onTapUp: _handleOnTapForTimeline,
            onLongPressStart: null,
          ),
          _getResizeShadowView()
        ]));
  }

  void _timelineViewHoveringUpdate() {
    if (!CalendarViewHelper.isTimelineView(widget.view) && mounted) {
      return;
    }

    // Updates the timeline views based on mouse hovering position.
    _timelineViewHeaderNotifier.value = !_timelineViewHeaderNotifier.value;
  }

  void _scrollAnimationListener() {
    _scrollController!.jumpTo(_timelineViewAnimation!.value);
  }

  void _scrollToPosition() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (widget.view == CalendarView.month) {
        return;
      }

      widget.getCalendarState(_updateCalendarStateDetails);
      final double scrollPosition = _getScrollPositionForCurrentDate(
          _updateCalendarStateDetails.currentDate!);
      if (scrollPosition == -1 ||
          _scrollController!.position.pixels == scrollPosition) {
        return;
      }

      _scrollController!.jumpTo(
          _scrollController!.position.maxScrollExtent > scrollPosition
              ? scrollPosition
              : _scrollController!.position.maxScrollExtent);
    });
  }

  double _getScrollPositionForCurrentDate(DateTime date) {
    final int visibleDatesCount = widget.visibleDates.length;
    if (!isDateWithInDateRange(widget.visibleDates[0],
        widget.visibleDates[visibleDatesCount - 1], date)) {
      return -1;
    }

    double timeToPosition = 0;
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      timeToPosition = AppointmentHelper.timeToPosition(
          widget.calendar, date, _timeIntervalHeight);
    } else {
      for (int i = 0; i < visibleDatesCount; i++) {
        if (!isSameDate(date, widget.visibleDates[i])) {
          continue;
        }

        if (widget.view == CalendarView.timelineMonth) {
          timeToPosition = _timeIntervalHeight * i;
        } else {
          timeToPosition = (_getSingleViewWidthForTimeLineView(this) * i) +
              AppointmentHelper.timeToPosition(
                  widget.calendar, date, _timeIntervalHeight);
        }

        break;
      }
    }

    if (_scrollController!.hasClients) {
      if (timeToPosition > _scrollController!.position.maxScrollExtent) {
        timeToPosition = _scrollController!.position.maxScrollExtent;
      } else if (timeToPosition < _scrollController!.position.minScrollExtent) {
        timeToPosition = _scrollController!.position.minScrollExtent;
      }
    }

    return timeToPosition;
  }

  /// Used to retain the scrolled date time.
  void _retainScrolledDateTime() {
    if (widget.view == CalendarView.month) {
      return;
    }

    DateTime scrolledDate = widget.visibleDates[0];
    double scrolledPosition = 0;
    if (CalendarViewHelper.isTimelineView(widget.view)) {
      final double singleViewWidth = _getSingleViewWidthForTimeLineView(this);

      /// Calculate the scrolled position date.
      scrolledDate = widget
          .visibleDates[_scrollController!.position.pixels ~/ singleViewWidth];

      /// Calculate the scrolled hour position without visible date position.
      scrolledPosition = _scrollController!.position.pixels % singleViewWidth;
    } else {
      /// Calculate the scrolled hour position.
      scrolledPosition = _scrollController!.position.pixels;
    }

    /// Calculate the current horizontal line based on time interval height.
    final double columnIndex = scrolledPosition / _timeIntervalHeight;

    /// Calculate the time based on calculated horizontal position.
    final double time = ((CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings) /
        60) *
        columnIndex) +
        widget.calendar.timeSlotViewSettings.startHour;
    final int hour = time.toInt();
    final int minute = ((time - hour) * 60).round();
    scrolledDate = DateTime(
        scrolledDate.year, scrolledDate.month, scrolledDate.day, hour, minute);

    /// Update the scrolled position after the widget generated.
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _scrollController!.jumpTo(_getPositionFromDate(scrolledDate));
    });
  }

  /// Calculate the position from date.
  double _getPositionFromDate(DateTime date) {
    final int visibleDatesCount = widget.visibleDates.length;
    _timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        visibleDatesCount,
        _allDayHeight,
        widget.isMobilePlatform);
    double timeToPosition = 0;
    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    if (!isTimelineView) {
      timeToPosition = AppointmentHelper.timeToPosition(
          widget.calendar, date, _timeIntervalHeight);
    } else {
      for (int i = 0; i < visibleDatesCount; i++) {
        if (!isSameDate(date, widget.visibleDates[i])) {
          continue;
        }

        if (widget.view == CalendarView.timelineMonth) {
          timeToPosition = _timeIntervalHeight * i;
        } else {
          timeToPosition = (_getSingleViewWidthForTimeLineView(this) * i) +
              AppointmentHelper.timeToPosition(
                  widget.calendar, date, _timeIntervalHeight);
        }

        break;
      }
    }

    double maxScrollPosition = 0;
    if (!isTimelineView) {
      final double scrollViewHeight = widget.height -
          _allDayHeight -
          CalendarViewHelper.getViewHeaderHeight(
              widget.calendar.viewHeaderHeight, widget.view);
      final double scrollViewContentHeight =
          CalendarViewHelper.getHorizontalLinesCount(
              widget.calendar.timeSlotViewSettings, widget.view) *
              _timeIntervalHeight;
      maxScrollPosition = scrollViewContentHeight - scrollViewHeight;
    } else {
      final double scrollViewContentWidth =
          CalendarViewHelper.getHorizontalLinesCount(
              widget.calendar.timeSlotViewSettings, widget.view) *
              _timeIntervalHeight *
              visibleDatesCount;
      maxScrollPosition = scrollViewContentWidth - widget.width;
    }

    return maxScrollPosition > timeToPosition
        ? timeToPosition
        : maxScrollPosition;
  }

  void _expandOrCollapseAllDay() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _expanderAnimationController!.forward();
    } else {
      _expanderAnimationController!.reverse();
    }
  }

  /// Update the time slot view scroll based on time ruler view scroll in
  /// timeslot views.
  void _timeRulerListener() {
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      return;
    }

    if (_timelineRulerController!.offset != _scrollController!.offset) {
      _scrollController!.jumpTo(_timelineRulerController!.offset);
    }
  }

  void _scrollListener() {
    if (_updateCalendarStateDetails.currentViewVisibleDates ==
        widget.visibleDates) {
      widget.removePicker();
    }

    if (CalendarViewHelper.isTimelineView(widget.view)) {
      widget.getCalendarState(_updateCalendarStateDetails);
      if (widget.view != CalendarView.timelineMonth) {
        _timelineViewHeaderNotifier.value = !_timelineViewHeaderNotifier.value;
      }

      if (_timelineRulerController!.offset != _scrollController!.offset) {
        _timelineRulerController!.jumpTo(_scrollController!.offset);
      }

      if (widget.view == CalendarView.timelineMonth &&
          widget.calendar.showWeekNumber) {
        final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
            widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
        final DateTime? date =
        _getDateFromPosition(_scrollController!.offset, 0, timeLabelWidth);
        if (date != null) {
          widget.timelineMonthWeekNumberNotifier.value = date;
        }
      }

      _timelineViewHeaderScrollController!.jumpTo(_scrollController!.offset);
    }
  }

  void _updateTimeSlotView(_CalendarView oldWidget) {
    _animationController ??= AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _heightAnimation ??=
    CurveTween(curve: Curves.easeIn).animate(_animationController!)
      ..addListener(() {
        setState(() {
          /*Animates the all day panel when it's expanding or
        collapsing*/
        });
      });

    _expanderAnimationController ??= AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _allDayExpanderAnimation ??=
    CurveTween(curve: Curves.easeIn).animate(_expanderAnimationController!)
      ..addListener(() {
        setState(() {
          /*Animates the all day panel when it's expanding or
        collapsing*/
        });
      });

    if (widget.view != CalendarView.day && _allDayHeight == 0) {
      if (_animationController!.status == AnimationStatus.completed) {
        _animationController!.reset();
      }

      _animationController!.forward();
    }
  }

  void _updateHorizontalLineCount(_CalendarView oldWidget) {
    if (widget.calendar.timeSlotViewSettings.startHour !=
        oldWidget.calendar.timeSlotViewSettings.startHour ||
        widget.calendar.timeSlotViewSettings.endHour !=
            oldWidget.calendar.timeSlotViewSettings.endHour ||
        CalendarViewHelper.getTimeInterval(
            widget.calendar.timeSlotViewSettings) !=
            CalendarViewHelper.getTimeInterval(
                oldWidget.calendar.timeSlotViewSettings) ||
        oldWidget.view == CalendarView.month ||
        oldWidget.view == CalendarView.timelineMonth ||
        oldWidget.view != CalendarView.timelineMonth &&
            widget.view == CalendarView.timelineMonth) {
      _horizontalLinesCount = CalendarViewHelper.getHorizontalLinesCount(
          widget.calendar.timeSlotViewSettings, widget.view);
    } else {
      _horizontalLinesCount = _horizontalLinesCount ??
          CalendarViewHelper.getHorizontalLinesCount(
              widget.calendar.timeSlotViewSettings, widget.view);
    }
  }

  void _updateTimelineViews(_CalendarView oldWidget) {
    _timelineRulerController ??=
    ScrollController(initialScrollOffset: 0, keepScrollOffset: true)
      ..addListener(_timeRulerListener);

    _timelineViewAnimationController ??= AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        animationBehavior: AnimationBehavior.normal);

    _timelineViewAnimation ??= _timelineViewTween
        .animate(_timelineViewAnimationController!)
      ..addListener(_scrollAnimationListener);

    _timelineViewHeaderScrollController ??=
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    _timelineViewVerticalScrollController =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    _timelineViewVerticalScrollController!.addListener(_updateResourceScroll);
    widget.resourcePanelScrollController
        ?.addListener(_updateResourcePanelScroll);
  }

  void _getPainterProperties(UpdateCalendarStateDetails details) {
    widget.getCalendarState(_updateCalendarStateDetails);
    details.allDayAppointmentViewCollection =
        _updateCalendarStateDetails.allDayAppointmentViewCollection;
    details.currentViewVisibleDates =
        _updateCalendarStateDetails.currentViewVisibleDates;
    details.visibleAppointments =
        _updateCalendarStateDetails.visibleAppointments;
    details.selectedDate = _updateCalendarStateDetails.selectedDate;
  }

  Widget _addAllDayAppointmentPanel(
      SfCalendarThemeData calendarTheme, bool isCurrentView) {
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);

    if (_allDayHeight == 0 ||
        (widget.view != CalendarView.day &&
            widget.visibleDates !=
                _updateCalendarStateDetails.currentViewVisibleDates)) {
      return const SizedBox.shrink();
    }

    double panelHeight = isCurrentView
        ? _updateCalendarStateDetails.allDayPanelHeight - _allDayHeight
        : 0;
    if (panelHeight < 0) {
      panelHeight = 0;
    }

    /// Remove the all day appointment selection when the selected all
    /// day appointment removed.
    if (_allDaySelectionNotifier.value != null &&
        _allDaySelectionNotifier.value!.appointmentView != null &&
        (!_updateCalendarStateDetails.visibleAppointments.contains(
            _allDaySelectionNotifier.value!.appointmentView!.appointment))) {
      _allDaySelectionNotifier.value = null;
    }

    final double allDayExpanderHeight =
        _allDayHeight + (panelHeight * _allDayExpanderAnimation!.value);
    return SizedBox(
      height: allDayExpanderHeight,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          _getAllDayLayout(
              timeLabelWidth, panelHeight, allDayExpanderHeight, isCurrentView),
        ],
      ),
    );
  }

  Widget _getAllDayLayout(double timeLabelWidth, double panelHeight,
      double allDayExpanderHeight, bool isCurrentView) {
    final Widget _allDayLayout = AllDayAppointmentLayout(
        widget.calendar,
        widget.view,
        widget.visibleDates,
        widget.visibleDates ==
            _updateCalendarStateDetails.currentViewVisibleDates
            ? _updateCalendarStateDetails.visibleAppointments
            : null,
        timeLabelWidth,
        allDayExpanderHeight,
        panelHeight > 0 &&
            (_heightAnimation!.value == 1 || widget.view == CalendarView.day),
        _allDayExpanderAnimation!.value != 0.0 &&
            _allDayExpanderAnimation!.value != 1,
        _isRTL,
        widget.calendarTheme,
        _allDaySelectionNotifier,
        _allDayNotifier,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.width,
        (widget.view == CalendarView.day &&
            _updateCalendarStateDetails.allDayPanelHeight <
                _allDayHeight) ||
            !isCurrentView
            ? _allDayHeight
            : _updateCalendarStateDetails.allDayPanelHeight,
        widget.localizations,
        _getPainterProperties);

    if ((_mouseCursor == SystemMouseCursors.basic ||
        _mouseCursor == SystemMouseCursors.move) ||
        !widget.calendar.allowAppointmentResize) {
      return _allDayLayout;
    } else {
      return GestureDetector(
        child: _allDayLayout,
        onHorizontalDragStart: _onHorizontalStart,
        onHorizontalDragUpdate: _onHorizontalUpdate,
        onHorizontalDragEnd: _onHorizontalEnd,
      );
    }
  }

  Widget _addAppointmentPainter(double width, double height,
      [double? resourceItemHeight]) {
    final List<CalendarAppointment>? visibleAppointments =
    widget.visibleDates ==
        _updateCalendarStateDetails.currentViewVisibleDates
        ? _updateCalendarStateDetails.visibleAppointments
        : null;
    _appointmentLayout = AppointmentLayout(
      widget.calendar,
          (count) {
        this.removeDayCount.sink.add(count);
        int total = 0;
        for (final element in widget.visibleDates) {
          final key = getKey(element);
          total += count[key] ?? 0;
        }
        totalAppRemove.sink.add(total);
      },
      widget.view,
      widget.visibleDates,
      ValueNotifier<List<CalendarAppointment>?>(visibleAppointments),
      _timeIntervalHeight,
      widget.calendarTheme,
      _isRTL,
      _appointmentHoverNotifier,
      widget.resourceCollection,
      resourceItemHeight,
      widget.textScaleFactor,
      widget.isMobilePlatform,
      width,
      height,
      widget.localizations,
      _getPainterProperties,
      key: _appointmentLayoutKey,
    );

    return _appointmentLayout;
  }

  void _onVerticalStart(DragStartDetails details) {
    final double xPosition = details.localPosition.dx;
    double yPosition = details.localPosition.dy;
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    AppointmentView? appointmentView;
    const double padding = 10;
    final bool isForwardResize = _mouseCursor == SystemMouseCursors.resizeDown;
    final bool isBackwardResize = _mouseCursor == SystemMouseCursors.resizeUp;
    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    if (!CalendarViewHelper.isTimelineView(widget.view) &&
        widget.view != CalendarView.month) {
      if (xPosition < timeLabelWidth) {
        return;
      }

      final double allDayPanelHeight = _isExpanded
          ? _updateCalendarStateDetails.allDayPanelHeight
          : _allDayHeight;

      yPosition = yPosition -
          viewHeaderHeight -
          allDayPanelHeight +
          _scrollController!.offset;

      if (isBackwardResize) {
        yPosition += padding;
      } else if (isForwardResize) {
        yPosition -= padding;
      }
      appointmentView =
          _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);
      if (appointmentView == null) {
        return;
      }

      _resizingDetails.value.isAllDayPanel = false;
      yPosition = details.localPosition.dy -
          viewHeaderHeight -
          allDayPanelHeight +
          _scrollController!.offset;

      if (_mouseCursor != SystemMouseCursors.basic &&
          _mouseCursor != SystemMouseCursors.move) {
        _resizingDetails.value.appointmentView = appointmentView.clone();
      } else {
        appointmentView = null;
        return;
      }

      _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
          appointmentView, allDayPanelHeight, viewHeaderHeight);
      _resizingDetails.value.position.value = Offset(
          appointmentView.appointmentRect!.left, details.localPosition.dy);
    }

    _resizingDetails.value.resizingTime = isBackwardResize
        ? _resizingDetails.value.appointmentView!.appointment!.actualStartTime
        : _resizingDetails.value.appointmentView!.appointment!.actualEndTime;
    _resizingDetails.value.scrollPosition = null;
    if (widget.calendar.appointmentBuilder == null) {
      _resizingDetails.value.appointmentColor =
          appointmentView!.appointment!.color;
    }
    if (CalendarViewHelper.shouldRaiseAppointmentResizeStartCallback(
        widget.calendar.onAppointmentResizeStart)) {
      CalendarViewHelper.raiseAppointmentResizeStartCallback(
          widget.calendar,
          _getCalendarAppointmentToObject(
              appointmentView!.appointment, widget.calendar),
          null);
    }
  }

  void _onVerticalUpdate(DragUpdateDetails details) {
    if (_resizingDetails.value.appointmentView == null) {
      return;
    }

    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    double yPosition = details.localPosition.dy;
    final bool isForwardResize = _mouseCursor == SystemMouseCursors.resizeDown;
    final bool isBackwardResize = _mouseCursor == SystemMouseCursors.resizeUp;
    final double allDayPanelHeight = _isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : _allDayHeight;
    if (!CalendarViewHelper.isTimelineView(widget.view) &&
        widget.view != CalendarView.month) {
      _updateMaximumResizingPosition(
          isForwardResize,
          isBackwardResize,
          _resizingDetails.value.appointmentView!,
          allDayPanelHeight,
          viewHeaderHeight);
      if ((isForwardResize && yPosition < _maximumResizingPosition!) ||
          (isBackwardResize && yPosition > _maximumResizingPosition!)) {
        yPosition = _maximumResizingPosition!;
      }

      _updateAutoScrollDay(details, viewHeaderHeight, allDayPanelHeight,
          isForwardResize, isBackwardResize, yPosition);
    }

    _resizingDetails.value.scrollPosition = null;
    _resizingDetails.value.position.value = Offset(
        _resizingDetails.value.appointmentView!.appointmentRect!.left,
        yPosition);
    _updateAppointmentResizingUpdateCallback(isForwardResize, isBackwardResize,
        yPosition, viewHeaderHeight, allDayPanelHeight);
  }

  void _onVerticalEnd(DragEndDetails details) {
    if (_resizingDetails.value.appointmentView == null) {
      _resizingDetails.value.position.value = null;
      return;
    }

    if (_autoScrollTimer != null) {
      _autoScrollTimer!.cancel();
      _autoScrollTimer = null;
    }

    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);

    final double allDayPanelHeight = _isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : _allDayHeight;

    final double currentYPosition =
    _resizingDetails.value.position.value!.dy > widget.height - 1
        ? widget.height - 1
        : _resizingDetails.value.position.value!.dy;
    double yPosition = currentYPosition -
        viewHeaderHeight -
        allDayPanelHeight +
        _scrollController!.offset;

    final CalendarAppointment appointment =
    _resizingDetails.value.appointmentView!.appointment!;
    final double timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);

    final double overAllHeight = _timeIntervalHeight * _horizontalLinesCount!;
    if (overAllHeight < widget.height && yPosition > overAllHeight) {
      yPosition = overAllHeight;
    }

    final DateTime resizingTime = _timeFromPosition(
        appointment.actualStartTime,
        widget.calendar.timeSlotViewSettings,
        yPosition,
        null,
        timeIntervalHeight,
        false)!;

    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);

    DateTime updatedStartTime = appointment.actualStartTime,
        updatedEndTime = appointment.actualEndTime;

    if (AppointmentHelper.canAddSpanIcon(
        widget.visibleDates, appointment, widget.view)) {
      updatedStartTime = appointment.exactStartTime;
      updatedEndTime = appointment.exactEndTime;
    }

    if (_mouseCursor == SystemMouseCursors.resizeDown) {
      updatedEndTime = resizingTime;
    } else if (_mouseCursor == SystemMouseCursors.resizeUp) {
      updatedStartTime = resizingTime;
    }

    final DateTime callbackStartDate = updatedStartTime;
    final DateTime callbackEndDate = updatedEndTime;
    updatedStartTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
        updatedStartTime, widget.calendar.timeZone, appointment.startTimeZone);
    updatedEndTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
        updatedEndTime, widget.calendar.timeZone, appointment.endTimeZone);

    if (CalendarViewHelper.isDraggingAppointmentHasDisabledCell(
        widget.regions!,
        widget.blackoutDates!,
        updatedStartTime,
        updatedEndTime,
        false,
        false,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        timeInterval,
        -1,
        widget.resourceCollection)) {
      if (CalendarViewHelper.shouldRaiseAppointmentResizeEndCallback(
          widget.calendar.onAppointmentResizeEnd)) {
        CalendarViewHelper.raiseAppointmentResizeEndCallback(
            widget.calendar,
            appointment.data,
            null,
            appointment.exactStartTime,
            appointment.exactEndTime);
      }

      _resetResizingPainter();
      return;
    }

    CalendarAppointment? parentAppointment;
    if (appointment.recurrenceRule != null &&
        appointment.recurrenceRule!.isNotEmpty) {
      for (int i = 0;
      i < _updateCalendarStateDetails.appointments.length;
      i++) {
        final CalendarAppointment app =
        _updateCalendarStateDetails.appointments[i];
        if (app.id == appointment.id) {
          parentAppointment = app;
          break;
        }
      }

      widget.calendar.dataSource!.appointments!.remove(parentAppointment!.data);
      widget.calendar.dataSource!.notifyListeners(
          CalendarDataSourceAction.remove, <dynamic>[parentAppointment.data]);

      final DateTime exceptionDate =
      AppointmentHelper.convertTimeToAppointmentTimeZone(
          appointment.exactStartTime, widget.calendar.timeZone, '');
      parentAppointment.recurrenceExceptionDates != null
          ? parentAppointment.recurrenceExceptionDates!.add(exceptionDate)
          : parentAppointment.recurrenceExceptionDates = <DateTime>[
        exceptionDate
      ];

      final dynamic newParentAppointment =
      _getCalendarAppointmentToObject(parentAppointment, widget.calendar);
      widget.calendar.dataSource!.appointments!.add(newParentAppointment);
      widget.calendar.dataSource!.notifyListeners(
          CalendarDataSourceAction.add, <dynamic>[newParentAppointment]);
    } else {
      widget.calendar.dataSource!.appointments!.remove(appointment.data);
      widget.calendar.dataSource!.notifyListeners(
          CalendarDataSourceAction.remove, <dynamic>[appointment.data]);
    }

    appointment.startTime = updatedStartTime;
    appointment.endTime = updatedEndTime;
    appointment.recurrenceId = parentAppointment != null
        ? parentAppointment.id
        : appointment.recurrenceId;
    appointment.recurrenceRule =
    appointment.recurrenceId != null ? null : appointment.recurrenceRule;
    appointment.id = parentAppointment != null ? null : appointment.id;
    final dynamic newAppointment =
    _getCalendarAppointmentToObject(appointment, widget.calendar);
    widget.calendar.dataSource!.appointments!.add(newAppointment);
    widget.calendar.dataSource!.notifyListeners(
        CalendarDataSourceAction.add, <dynamic>[newAppointment]);

    if (CalendarViewHelper.shouldRaiseAppointmentResizeEndCallback(
        widget.calendar.onAppointmentResizeEnd)) {
      CalendarViewHelper.raiseAppointmentResizeEndCallback(widget.calendar,
          newAppointment, null, callbackStartDate, callbackEndDate);
    }

    _resetResizingPainter();
  }

  void _onHorizontalStart(DragStartDetails details) {
    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    double xPosition = details.localPosition.dx;
    CalendarResource? resource;
    double yPosition = details.localPosition.dy;
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    AppointmentView? appointmentView;
    const double padding = 10;
    final bool isForwardResize = _mouseCursor == SystemMouseCursors.resizeRight;
    final bool isBackwardResize = _mouseCursor == SystemMouseCursors.resizeLeft;
    if (!isTimelineView && widget.view != CalendarView.month) {
      if ((!_isRTL && xPosition < timeLabelWidth) ||
          (_isRTL && xPosition > (widget.width - timeLabelWidth))) {
        return;
      }

      if (isBackwardResize) {
        xPosition += padding;
      } else if (isForwardResize) {
        xPosition -= padding;
      }

      appointmentView = _getAllDayAppointmentOnPoint(
          _updateCalendarStateDetails.allDayAppointmentViewCollection,
          xPosition,
          yPosition);
      if (appointmentView == null) {
        return;
      }

      xPosition = details.localPosition.dx;
      yPosition = appointmentView.appointmentRect!.top + viewHeaderHeight;
      _resizingDetails.value.isAllDayPanel = true;
      _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
          appointmentView, null, viewHeaderHeight);
    } else if (isTimelineView) {
      yPosition -= viewHeaderHeight + timeLabelWidth;
      xPosition = _scrollController!.offset + details.localPosition.dx;
      if (_isRTL) {
        xPosition = _scrollController!.offset +
            (_scrollController!.position.viewportDimension -
                details.localPosition.dx);
        xPosition = (_scrollController!.position.viewportDimension +
            _scrollController!.position.maxScrollExtent) -
            xPosition;
      }

      if (isBackwardResize) {
        xPosition += padding;
      } else if (isForwardResize) {
        xPosition -= padding;
      }

      final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
          widget.calendar.dataSource, widget.view);

      if (isResourceEnabled) {
        yPosition += _timelineViewVerticalScrollController!.offset;
      }

      appointmentView =
          _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);
      _resizingDetails.value.isAllDayPanel = false;
      if (appointmentView == null) {
        return;
      }
      if (isResourceEnabled) {
        resource = widget.calendar.dataSource!.resources![
        _getSelectedResourceIndex(appointmentView.appointmentRect!.top,
            viewHeaderHeight, timeLabelWidth)];
      }

      yPosition = appointmentView.appointmentRect!.top +
          viewHeaderHeight +
          timeLabelWidth;
      if (isResourceEnabled) {
        yPosition -= _timelineViewVerticalScrollController!.offset;
      }
      _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
          appointmentView, null, viewHeaderHeight);
    } else if (widget.view == CalendarView.month) {
      _resizingDetails.value.monthRowCount = 0;
      yPosition -= viewHeaderHeight;
      xPosition = details.localPosition.dx;
      if (isBackwardResize) {
        xPosition += padding;
      } else if (isForwardResize) {
        xPosition -= padding;
      }

      appointmentView =
          _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);
      _resizingDetails.value.isAllDayPanel = false;
      if (appointmentView == null) {
        return;
      }

      xPosition = details.localPosition.dx;
      yPosition = appointmentView.appointmentRect!.top + viewHeaderHeight;

      _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
          appointmentView, null, viewHeaderHeight);
    }

    if (_mouseCursor != SystemMouseCursors.basic &&
        _mouseCursor != SystemMouseCursors.move) {
      _resizingDetails.value.appointmentView = appointmentView!.clone();
    } else {
      appointmentView = null;
      return;
    }

    _resizingDetails.value.scrollPosition = null;
    if (widget.calendar.appointmentBuilder == null) {
      _resizingDetails.value.appointmentColor =
          appointmentView.appointment!.color;
    }
    if (isTimelineView && _isRTL) {
      _resizingDetails.value.resizingTime = isForwardResize
          ? _resizingDetails.value.appointmentView!.appointment!.actualStartTime
          : _resizingDetails.value.appointmentView!.appointment!.actualEndTime;
    } else {
      _resizingDetails.value.resizingTime = isBackwardResize
          ? _resizingDetails.value.appointmentView!.appointment!.actualStartTime
          : _resizingDetails.value.appointmentView!.appointment!.actualEndTime;
    }
    _resizingDetails.value.position.value =
        Offset(details.localPosition.dx, yPosition);
    if (CalendarViewHelper.shouldRaiseAppointmentResizeStartCallback(
        widget.calendar.onAppointmentResizeStart)) {
      CalendarViewHelper.raiseAppointmentResizeStartCallback(
          widget.calendar,
          _getCalendarAppointmentToObject(
              appointmentView.appointment, widget.calendar),
          resource);
    }
  }

  void _onHorizontalUpdate(DragUpdateDetails details) {
    if (_resizingDetails.value.appointmentView == null) {
      return;
    }

    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);
    final bool isForwardResize = _mouseCursor == SystemMouseCursors.resizeRight;
    final bool isBackwardResize = _mouseCursor == SystemMouseCursors.resizeLeft;
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    double xPosition = details.localPosition.dx;
    double yPosition = _resizingDetails.value.position.value!.dy;
    late DateTime resizingTime;
    final double timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);

    if (isTimelineView) {
      _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
          _resizingDetails.value.appointmentView!, null, null);
      if ((isForwardResize && xPosition < _maximumResizingPosition!) ||
          (isBackwardResize && xPosition > _maximumResizingPosition!)) {
        xPosition = _maximumResizingPosition!;
      }

      _updateAutoScrollTimeline(
          details,
          timeIntervalHeight,
          isForwardResize,
          isBackwardResize,
          xPosition,
          yPosition,
          timeLabelWidth,
          isResourceEnabled);
    } else if (widget.view == CalendarView.month) {
      final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
          widget.calendar.viewHeaderHeight, widget.view);
      double resizingPosition = details.localPosition.dy - viewHeaderHeight;
      if (resizingPosition < 0) {
        resizingPosition = 0;
      } else if (resizingPosition > widget.height - viewHeaderHeight - 1) {
        resizingPosition = widget.height - viewHeaderHeight - 1;
      }

      final double cellHeight = (widget.height - viewHeaderHeight) /
          widget.calendar.monthViewSettings.numberOfWeeksInView;
      final int appointmentRowIndex =
      (_resizingDetails.value.appointmentView!.appointmentRect!.top /
          cellHeight)
          .truncate();
      int resizingRowIndex = (resizingPosition / cellHeight).truncate();
      final double weekNumberPanelWidth =
      CalendarViewHelper.getWeekNumberPanelWidth(
          widget.calendar.showWeekNumber,
          widget.width,
          widget.isMobilePlatform);
      if (!_isRTL) {
        if (xPosition < weekNumberPanelWidth) {
          xPosition = weekNumberPanelWidth;
        } else if (xPosition > widget.width - 1) {
          xPosition = widget.width - 1;
        }
      } else {
        if (xPosition > widget.width - weekNumberPanelWidth - 1) {
          xPosition = widget.width - weekNumberPanelWidth - 1;
        } else if (xPosition < 0) {
          xPosition = 0;
        }
      }

      /// Handle the appointment resize after and before the current month
      /// dates when hide trailing and leading dates enabled.
      if (!widget.calendar.monthViewSettings.showTrailingAndLeadingDates &&
          widget.calendar.monthViewSettings.numberOfWeeksInView == 6) {
        final DateTime currentMonthDate =
        widget.visibleDates[widget.visibleDates.length ~/ 2];
        final int startIndex = DateTimeHelper.getVisibleDateIndex(
            widget.visibleDates,
            AppointmentHelper.getMonthStartDate(currentMonthDate));
        final int endIndex = DateTimeHelper.getVisibleDateIndex(
            widget.visibleDates,
            AppointmentHelper.getMonthEndDate(currentMonthDate));
        final int startRowCount = startIndex ~/ DateTime.daysPerWeek;
        final int startColumnCount = startIndex % DateTime.daysPerWeek;
        final int endRowCount = endIndex ~/ DateTime.daysPerWeek;
        final int endColumnCount = endIndex % DateTime.daysPerWeek;
        if (resizingRowIndex >= endRowCount) {
          resizingRowIndex = endRowCount;
          resizingPosition = resizingRowIndex * cellHeight;
          final double cellWidth =
              (widget.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
          if (_isRTL) {
            final double currentXPosition =
                (DateTime.daysPerWeek - endColumnCount - 1) * cellWidth;
            xPosition =
            xPosition > currentXPosition ? xPosition : currentXPosition;
          } else {
            final double currentXPosition =
                ((endColumnCount + 1) * cellWidth) + weekNumberPanelWidth - 1;
            xPosition =
            xPosition > currentXPosition ? currentXPosition : xPosition;
          }
        } else if (resizingRowIndex <= startRowCount) {
          resizingRowIndex = startRowCount;
          resizingPosition = resizingRowIndex * cellHeight;
          final double cellWidth =
              (widget.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
          if (_isRTL) {
            double currentXPosition =
                (DateTime.daysPerWeek - startColumnCount) * cellWidth;
            if (currentXPosition != 0) {
              currentXPosition -= 1;
            }

            xPosition =
            xPosition < currentXPosition ? xPosition : currentXPosition;
          } else {
            final double currentXPosition =
                (startColumnCount * cellWidth) + weekNumberPanelWidth;
            xPosition =
            xPosition < currentXPosition ? currentXPosition : xPosition;
          }
        }
      }

      /// Restrict by max resize position only restrict the appointment resize
      /// on previous and next row also so check the row index also to resolve
      /// the issue with both RTL and LTR scenarios.
      if (_isRTL) {
        if (isForwardResize &&
            ((appointmentRowIndex == resizingRowIndex &&
                xPosition < _maximumResizingPosition!) ||
                appointmentRowIndex < resizingRowIndex)) {
          xPosition = _maximumResizingPosition!;
          resizingRowIndex = appointmentRowIndex;
          resizingPosition =
              _resizingDetails.value.appointmentView!.appointmentRect!.top;
        } else if (isBackwardResize &&
            ((appointmentRowIndex == resizingRowIndex &&
                xPosition > _maximumResizingPosition!) ||
                appointmentRowIndex > resizingRowIndex)) {
          xPosition = _maximumResizingPosition!;
          resizingRowIndex = appointmentRowIndex;
          resizingPosition =
              _resizingDetails.value.appointmentView!.appointmentRect!.top;
        }
      } else {
        if (isForwardResize &&
            ((appointmentRowIndex == resizingRowIndex &&
                xPosition < _maximumResizingPosition!) ||
                appointmentRowIndex > resizingRowIndex)) {
          xPosition = _maximumResizingPosition!;
          resizingRowIndex = appointmentRowIndex;
          resizingPosition =
              _resizingDetails.value.appointmentView!.appointmentRect!.top;
        } else if (isBackwardResize &&
            ((appointmentRowIndex == resizingRowIndex &&
                xPosition > _maximumResizingPosition!) ||
                appointmentRowIndex < resizingRowIndex)) {
          xPosition = _maximumResizingPosition!;
          resizingRowIndex = appointmentRowIndex;
          resizingPosition =
              _resizingDetails.value.appointmentView!.appointmentRect!.top;
        }
      }

      resizingTime =
      _getDateFromPosition(xPosition, resizingPosition, timeLabelWidth)!;
      final int rowDifference = isBackwardResize
          ? _isRTL
          ? (appointmentRowIndex - resizingRowIndex).abs()
          : appointmentRowIndex - resizingRowIndex
          : _isRTL
          ? appointmentRowIndex - resizingRowIndex
          : (appointmentRowIndex - resizingRowIndex).abs();
      if (((!_isRTL &&
          ((isBackwardResize &&
              appointmentRowIndex > resizingRowIndex) ||
              (isForwardResize &&
                  appointmentRowIndex < resizingRowIndex))) ||
          (_isRTL &&
              ((isBackwardResize &&
                  appointmentRowIndex < resizingRowIndex) ||
                  (isForwardResize &&
                      appointmentRowIndex > resizingRowIndex)))) &&
          resizingRowIndex != appointmentRowIndex &&
          rowDifference != _resizingDetails.value.monthRowCount) {
        if (isForwardResize) {
          if (_isRTL) {
            if (_resizingDetails.value.monthRowCount > rowDifference) {
              yPosition += cellHeight;
            } else {
              yPosition -= cellHeight;
            }
          } else {
            if (_resizingDetails.value.monthRowCount > rowDifference) {
              yPosition -= cellHeight;
            } else {
              yPosition += cellHeight;
            }
          }
        } else {
          if (_isRTL) {
            if (_resizingDetails.value.monthRowCount > rowDifference) {
              yPosition -= cellHeight;
            } else {
              yPosition += cellHeight;
            }
          } else {
            if (_resizingDetails.value.monthRowCount > rowDifference) {
              yPosition += cellHeight;
            } else {
              yPosition -= cellHeight;
            }
          }
        }
        _resizingDetails.value.monthRowCount = rowDifference;
        _resizingDetails.value.monthCellHeight = cellHeight;
      } else if (resizingRowIndex == appointmentRowIndex &&
          rowDifference == 0) {
        _resizingDetails.value.monthRowCount = rowDifference;
        _resizingDetails.value.monthCellHeight = cellHeight;
        yPosition =
            _resizingDetails.value.appointmentView!.appointmentRect!.top +
                viewHeaderHeight;
      }
    } else {
      if ((isForwardResize && xPosition < _maximumResizingPosition!) ||
          (isBackwardResize && xPosition > _maximumResizingPosition!)) {
        xPosition = _maximumResizingPosition!;
      }

      double currentXPosition = xPosition;
      if (_isRTL) {
        if (currentXPosition > widget.width - timeLabelWidth - 1) {
          currentXPosition = widget.width - timeLabelWidth - 1;
        } else if (currentXPosition < 0) {
          currentXPosition = 0;
        }
      } else {
        if (currentXPosition < timeLabelWidth) {
          currentXPosition = timeLabelWidth;
        } else if (currentXPosition > widget.width - 1) {
          currentXPosition = widget.width - 1;
        }

        currentXPosition -= timeLabelWidth;
      }
      resizingTime =
      _getDateFromPosition(currentXPosition, yPosition, timeLabelWidth)!;
    }

    if (_resizingDetails.value.isAllDayPanel ||
        widget.view == CalendarView.month) {
      resizingTime = DateTime(
          resizingTime.year, resizingTime.month, resizingTime.day, 0, 0, 0);
    }

    _resizingDetails.value.position.value = Offset(xPosition, yPosition);

    if (isTimelineView) {
      _updateAppointmentResizingUpdateCallback(
          isForwardResize, isBackwardResize, yPosition, null, null,
          xPosition: xPosition,
          timeLabelWidth: timeLabelWidth,
          isResourceEnabled: isResourceEnabled,
          details: details);
      return;
    }

    if (CalendarViewHelper.shouldRaiseAppointmentResizeUpdateCallback(
        widget.calendar.onAppointmentResizeUpdate)) {
      CalendarViewHelper.raiseAppointmentResizeUpdateCallback(
          widget.calendar,
          _getCalendarAppointmentToObject(
              _resizingDetails.value.appointmentView!.appointment,
              widget.calendar),
          null,
          resizingTime,
          _resizingDetails.value.position.value!);
    }
  }

  void _onHorizontalEnd(DragEndDetails details) {
    if (_resizingDetails.value.appointmentView == null) {
      _resizingDetails.value.position.value = null;
      return;
    }

    if (_autoScrollTimer != null) {
      _autoScrollTimer!.cancel();
      _autoScrollTimer = null;
    }

    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);

    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);

    double xPosition = _resizingDetails.value.position.value!.dx;
    double yPosition = _resizingDetails.value.position.value!.dy;

    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);

    final CalendarAppointment appointment =
    _resizingDetails.value.appointmentView!.appointment!;
    final double timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);

    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    if (!isTimelineView && widget.view != CalendarView.month) {
      if (_isRTL) {
        if (xPosition > widget.width - timeLabelWidth - 1) {
          xPosition = widget.width - timeLabelWidth - 1;
        } else if (xPosition < 0) {
          xPosition = 0;
        }
      } else {
        if (xPosition < timeLabelWidth) {
          xPosition = timeLabelWidth;
        } else if (xPosition > widget.width - 1) {
          xPosition = widget.width - 1;
        }

        xPosition -= timeLabelWidth;
      }
    } else if (widget.view == CalendarView.month) {
      final double weekNumberPanelWidth =
      CalendarViewHelper.getWeekNumberPanelWidth(
          widget.calendar.showWeekNumber,
          widget.width,
          widget.isMobilePlatform);
      _resizingDetails.value.monthRowCount = 0;
      if (!_isRTL) {
        if (xPosition < weekNumberPanelWidth) {
          xPosition = weekNumberPanelWidth;
        }
      } else {
        if (xPosition > widget.width - weekNumberPanelWidth) {
          xPosition = widget.width - weekNumberPanelWidth;
        }
      }
      yPosition -= viewHeaderHeight;
    } else if (isTimelineView) {
      if (xPosition < 0) {
        xPosition = 0;
      } else if (xPosition > widget.width - 1) {
        xPosition = widget.width - 1;
      }

      final double overAllWidth = _timeIntervalHeight *
          (_horizontalLinesCount! * widget.visibleDates.length);

      if (overAllWidth < widget.width && xPosition > overAllWidth) {
        xPosition = overAllWidth;
      }
    }

    DateTime resizingTime =
    _getDateFromPosition(xPosition, yPosition, timeLabelWidth)!;
    if (_resizingDetails.value.isAllDayPanel ||
        widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth) {
      resizingTime = DateTime(
          resizingTime.year, resizingTime.month, resizingTime.day, 0, 0, 0);
    } else if (isTimelineView) {
      final DateTime time = _timeFromPosition(
          resizingTime,
          widget.calendar.timeSlotViewSettings,
          xPosition,
          this,
          timeIntervalHeight,
          isTimelineView)!;

      resizingTime = DateTime(resizingTime.year, resizingTime.month,
          resizingTime.day, time.hour, time.minute, time.second);
    }

    CalendarResource? resource;
    int selectedResourceIndex = -1;
    if (isResourceEnabled) {
      selectedResourceIndex = _getSelectedResourceIndex(
          _resizingDetails.value.appointmentView!.appointmentRect!.top,
          viewHeaderHeight,
          timeLabelWidth);
      resource = widget.calendar.dataSource!.resources![selectedResourceIndex];
    }

    final bool isMonthView = widget.view == CalendarView.timelineMonth ||
        widget.view == CalendarView.month;

    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);

    DateTime updatedStartTime = appointment.actualStartTime,
        updatedEndTime = appointment.actualEndTime;
    if ((_isRTL && _mouseCursor == SystemMouseCursors.resizeLeft) ||
        (!_isRTL && _mouseCursor == SystemMouseCursors.resizeRight)) {
      if (isMonthView) {
        updatedEndTime = DateTime(resizingTime.year, resizingTime.month,
            resizingTime.day, updatedEndTime.hour, updatedEndTime.minute);
      } else {
        updatedEndTime = resizingTime;
      }
    } else if ((_isRTL && _mouseCursor == SystemMouseCursors.resizeRight) ||
        (!_isRTL && _mouseCursor == SystemMouseCursors.resizeLeft)) {
      if (isMonthView) {
        updatedStartTime = DateTime(resizingTime.year, resizingTime.month,
            resizingTime.day, updatedStartTime.hour, updatedStartTime.minute);
      } else {
        updatedStartTime = resizingTime;
      }
    }

    final DateTime callbackStartDate = updatedStartTime;
    final DateTime callbackEndDate = updatedEndTime;
    updatedStartTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
        updatedStartTime, widget.calendar.timeZone, appointment.startTimeZone);
    updatedEndTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
        updatedEndTime, widget.calendar.timeZone, appointment.endTimeZone);
    if (CalendarViewHelper.isDraggingAppointmentHasDisabledCell(
        widget.regions!,
        widget.blackoutDates!,
        updatedStartTime,
        updatedEndTime,
        isTimelineView,
        isMonthView,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        timeInterval,
        selectedResourceIndex,
        widget.resourceCollection)) {
      if (CalendarViewHelper.shouldRaiseAppointmentResizeEndCallback(
          widget.calendar.onAppointmentResizeEnd)) {
        CalendarViewHelper.raiseAppointmentResizeEndCallback(
            widget.calendar,
            appointment.data,
            resource,
            appointment.exactStartTime,
            appointment.exactEndTime);
      }

      _resetResizingPainter();
      return;
    }

    CalendarAppointment? parentAppointment;
    widget.getCalendarState(_updateCalendarStateDetails);
    if ((appointment.recurrenceRule != null &&
        appointment.recurrenceRule!.isNotEmpty) ||
        appointment.recurrenceId != null) {
      for (int i = 0;
      i < _updateCalendarStateDetails.appointments.length;
      i++) {
        final CalendarAppointment app =
        _updateCalendarStateDetails.appointments[i];
        if (app.id == appointment.id || app.id == appointment.recurrenceId) {
          parentAppointment = app;
          break;
        }
      }

      final List<DateTime> recurrenceDates =
      RecurrenceHelper.getRecurrenceDateTimeCollection(
          parentAppointment!.recurrenceRule ?? '',
          parentAppointment.exactStartTime,
          recurrenceDuration: AppointmentHelper.getDifference(
              parentAppointment.exactStartTime,
              parentAppointment.exactEndTime),
          specificStartDate: widget.visibleDates[0],
          specificEndDate:
          widget.visibleDates[widget.visibleDates.length - 1]);

      for (int i = 0;
      i < _updateCalendarStateDetails.appointments.length;
      i++) {
        final CalendarAppointment calendarApp =
        _updateCalendarStateDetails.appointments[i];
        if (calendarApp.recurrenceId != null &&
            calendarApp.recurrenceId == parentAppointment.id) {
          recurrenceDates.add(
              AppointmentHelper.convertTimeToAppointmentTimeZone(
                  calendarApp.startTime,
                  calendarApp.startTimeZone,
                  widget.calendar.timeZone));
        }
      }

      if (parentAppointment.recurrenceExceptionDates != null) {
        for (int i = 0;
        i < parentAppointment.recurrenceExceptionDates!.length;
        i++) {
          recurrenceDates.remove(
              AppointmentHelper.convertTimeToAppointmentTimeZone(
                  parentAppointment.recurrenceExceptionDates![i],
                  '',
                  widget.calendar.timeZone));
        }
      }

      recurrenceDates.sort();
      final int currentRecurrenceIndex =
      recurrenceDates.indexOf(appointment.exactStartTime);
      if (currentRecurrenceIndex != -1) {
        final DateTime? previousRecurrence = currentRecurrenceIndex <= 0
            ? null
            : recurrenceDates[currentRecurrenceIndex - 1];
        final DateTime? nextRecurrence =
        currentRecurrenceIndex >= recurrenceDates.length - 1
            ? null
            : recurrenceDates[currentRecurrenceIndex + 1];

        /// Check the resizing time is in between previous and next recurrence
        /// date. If previous recurrence is null(means resized appointment
        /// is first occurrence) then it does not have a limit for previous
        /// occurrence.
        if (!((nextRecurrence == null ||
            isSameOrBeforeDate(nextRecurrence, resizingTime)) &&
            (previousRecurrence == null ||
                isSameOrAfterDate(previousRecurrence, resizingTime)) &&
            !isSameDate(previousRecurrence, resizingTime) &&
            !isSameDate(nextRecurrence, resizingTime)) &&
            !isSameDate(appointment.exactStartTime, resizingTime)) {
          if (CalendarViewHelper.shouldRaiseAppointmentResizeEndCallback(
              widget.calendar.onAppointmentResizeEnd)) {
            CalendarViewHelper.raiseAppointmentResizeEndCallback(
                widget.calendar,
                appointment.data,
                resource,
                appointment.exactStartTime,
                appointment.exactEndTime);
          }

          _resetResizingPainter();
          return;
        }
      }

      if (appointment.recurrenceId != null &&
          (appointment.recurrenceRule == null ||
              appointment.recurrenceRule!.isEmpty)) {
        widget.calendar.dataSource!.appointments!.remove(appointment.data);
        widget.calendar.dataSource!.notifyListeners(
            CalendarDataSourceAction.remove, <dynamic>[appointment.data]);
      } else {
        widget.calendar.dataSource!.appointments!
            .remove(parentAppointment.data);
        widget.calendar.dataSource!.notifyListeners(
            CalendarDataSourceAction.remove, <dynamic>[parentAppointment.data]);

        final DateTime exceptionDate =
        AppointmentHelper.convertTimeToAppointmentTimeZone(
            appointment.exactStartTime, widget.calendar.timeZone, '');
        parentAppointment.recurrenceExceptionDates != null
            ? parentAppointment.recurrenceExceptionDates!.add(exceptionDate)
            : parentAppointment.recurrenceExceptionDates = <DateTime>[
          exceptionDate
        ];

        final dynamic newParentAppointment =
        _getCalendarAppointmentToObject(parentAppointment, widget.calendar);
        widget.calendar.dataSource!.appointments!.add(newParentAppointment);
        widget.calendar.dataSource!.notifyListeners(
            CalendarDataSourceAction.add, <dynamic>[newParentAppointment]);
      }
    } else {
      widget.calendar.dataSource!.appointments!.remove(appointment.data);
      widget.calendar.dataSource!.notifyListeners(
          CalendarDataSourceAction.remove, <dynamic>[appointment.data]);
    }

    appointment.startTime = updatedStartTime;
    appointment.endTime = updatedEndTime;
    appointment.recurrenceId = parentAppointment != null
        ? parentAppointment.id
        : appointment.recurrenceId;
    appointment.recurrenceRule =
    appointment.recurrenceId != null ? null : appointment.recurrenceRule;
    appointment.id = parentAppointment != null ? null : appointment.id;
    final dynamic newAppointment =
    _getCalendarAppointmentToObject(appointment, widget.calendar);

    widget.calendar.dataSource!.appointments!.add(newAppointment);
    widget.calendar.dataSource!.notifyListeners(
        CalendarDataSourceAction.add, <dynamic>[newAppointment]);

    if (CalendarViewHelper.shouldRaiseAppointmentResizeEndCallback(
        widget.calendar.onAppointmentResizeEnd)) {
      CalendarViewHelper.raiseAppointmentResizeEndCallback(widget.calendar,
          newAppointment, resource, callbackStartDate, callbackEndDate);
    }

    _resetResizingPainter();
  }

  Future<void> _updateAutoScrollDay(
      DragUpdateDetails details,
      double viewHeaderHeight,
      double allDayPanelHeight,
      bool isForwardResize,
      bool isBackwardResize,
      double? yPosition) async {
    double? newYPosition = yPosition;
    if (_resizingDetails.value.appointmentView == null) {
      return;
    }

    final double timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);

    if (newYPosition! <= viewHeaderHeight + allDayPanelHeight &&
        _scrollController!.position.pixels != 0) {
      if (_autoScrollTimer != null) {
        return;
      }
      _autoScrollTimer = Timer(const Duration(milliseconds: 200), () async {
        newYPosition = _resizingDetails.value.position.value?.dy;
        if (newYPosition != null &&
            newYPosition! <= viewHeaderHeight + allDayPanelHeight &&
            _scrollController!.offset != 0) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                _scrollController!.position.pixels - timeIntervalHeight;
            if (scrollPosition < 0) {
              scrollPosition = 0;
            }

            _resizingDetails.value.scrollPosition = scrollPosition;

            _resizingDetails.value.position.value = Offset(
                _resizingDetails.value.appointmentView!.appointmentRect!.left,
                newYPosition! - 0.1);

            await _scrollController!.position.animateTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
            if (_resizingDetails.value.appointmentView == null) {
              if (_autoScrollTimer != null) {
                _autoScrollTimer!.cancel();
                _autoScrollTimer = null;
              }

              return;
            }

            newYPosition = _resizingDetails.value.position.value?.dy;
            _updateMaximumResizingPosition(
                isForwardResize,
                isBackwardResize,
                _resizingDetails.value.appointmentView!,
                allDayPanelHeight,
                viewHeaderHeight);
            if ((isForwardResize &&
                newYPosition! < _maximumResizingPosition!) ||
                (isBackwardResize &&
                    newYPosition! > _maximumResizingPosition!)) {
              newYPosition = _maximumResizingPosition;
            }
            _updateAppointmentResizingUpdateCallback(
                isForwardResize,
                isBackwardResize,
                newYPosition!,
                viewHeaderHeight,
                allDayPanelHeight);

            _resizingDetails.value.position.value = Offset(
                _resizingDetails.value.appointmentView!.appointmentRect!.left,
                newYPosition!);

            if (newYPosition != null &&
                newYPosition! <= viewHeaderHeight + allDayPanelHeight &&
                _scrollController!.offset != 0) {
              _updateScrollPosition();
            } else if (_autoScrollTimer != null) {
              _autoScrollTimer!.cancel();
              _autoScrollTimer = null;
            }
          }

          _updateScrollPosition();
        } else if (_autoScrollTimer != null) {
          _autoScrollTimer!.cancel();
          _autoScrollTimer = null;
        }
      });
    } else if (newYPosition >= widget.height &&
        _scrollController!.position.pixels !=
            _scrollController!.position.maxScrollExtent) {
      if (_autoScrollTimer != null) {
        return;
      }
      _autoScrollTimer = Timer(const Duration(milliseconds: 200), () async {
        newYPosition = _resizingDetails.value.position.value?.dy;
        if (newYPosition != null &&
            newYPosition! >= widget.height &&
            _scrollController!.position.pixels !=
                _scrollController!.position.maxScrollExtent) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                _scrollController!.position.pixels + timeIntervalHeight;
            if (scrollPosition > _scrollController!.position.maxScrollExtent) {
              scrollPosition = _scrollController!.position.maxScrollExtent;
            }

            _resizingDetails.value.scrollPosition = scrollPosition;

            _resizingDetails.value.position.value = Offset(
                _resizingDetails.value.appointmentView!.appointmentRect!.left,
                newYPosition! - 0.1);

            await _scrollController!.position.moveTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
            if (_resizingDetails.value.appointmentView == null) {
              if (_autoScrollTimer != null) {
                _autoScrollTimer!.cancel();
                _autoScrollTimer = null;
              }

              return;
            }

            newYPosition = _resizingDetails.value.position.value?.dy;

            _updateMaximumResizingPosition(
                isForwardResize,
                isBackwardResize,
                _resizingDetails.value.appointmentView!,
                allDayPanelHeight,
                viewHeaderHeight);
            if ((isForwardResize &&
                newYPosition! < _maximumResizingPosition!) ||
                (isBackwardResize &&
                    newYPosition! > _maximumResizingPosition!)) {
              newYPosition = _maximumResizingPosition;
            }
            _updateAppointmentResizingUpdateCallback(
                isForwardResize,
                isBackwardResize,
                newYPosition!,
                viewHeaderHeight,
                allDayPanelHeight);

            _resizingDetails.value.position.value = Offset(
                _resizingDetails.value.appointmentView!.appointmentRect!.left,
                newYPosition!);

            if (newYPosition != null &&
                newYPosition! >= widget.height &&
                _scrollController!.position.pixels !=
                    _scrollController!.position.maxScrollExtent) {
              unawaited(_updateScrollPosition());
            } else if (_autoScrollTimer != null) {
              _autoScrollTimer!.cancel();
              _autoScrollTimer = null;
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_autoScrollTimer != null) {
          _autoScrollTimer!.cancel();
          _autoScrollTimer = null;
        }
      });
    }
  }

  Future<void> _updateAutoScrollTimeline(
      DragUpdateDetails details,
      double timeIntervalHeight,
      bool isForwardResize,
      bool isBackwardResize,
      double? xPosition,
      double yPosition,
      double timeLabelWidth,
      bool isResourceEnabled) async {
    double? newXPosition = xPosition;
    if (_resizingDetails.value.appointmentView == null) {
      return;
    }

    const int padding = 5;

    if (newXPosition! <= 0 &&
        ((_isRTL &&
            _scrollController!.position.pixels !=
                _scrollController!.position.maxScrollExtent) ||
            (!_isRTL && _scrollController!.position.pixels != 0))) {
      if (_autoScrollTimer != null) {
        return;
      }
      _autoScrollTimer = Timer(const Duration(milliseconds: 200), () async {
        newXPosition = _resizingDetails.value.position.value?.dx;
        if (newXPosition != null &&
            newXPosition! <= 0 &&
            ((_isRTL &&
                _scrollController!.position.pixels !=
                    _scrollController!.position.maxScrollExtent) ||
                (!_isRTL && _scrollController!.position.pixels != 0))) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                _scrollController!.position.pixels - timeIntervalHeight;
            if (_isRTL) {
              scrollPosition =
                  _scrollController!.position.pixels + timeIntervalHeight;
            }
            if (scrollPosition < 0 && !_isRTL) {
              scrollPosition = 0;
            } else if (_isRTL &&
                scrollPosition > _scrollController!.position.maxScrollExtent) {
              scrollPosition = _scrollController!.position.maxScrollExtent;
            }

            _resizingDetails.value.scrollPosition = scrollPosition;

            _resizingDetails.value.position.value = Offset(
                newXPosition! - 0.1, _resizingDetails.value.position.value!.dy);

            await _scrollController!.position.animateTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
            if (_resizingDetails.value.appointmentView == null) {
              if (_autoScrollTimer != null) {
                _autoScrollTimer!.cancel();
                _autoScrollTimer = null;
              }

              return;
            }

            newXPosition = _resizingDetails.value.position.value?.dx;
            _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
                _resizingDetails.value.appointmentView!, null, null);
            if ((isForwardResize &&
                newXPosition! < _maximumResizingPosition!) ||
                (isBackwardResize &&
                    newXPosition! > _maximumResizingPosition!)) {
              newXPosition = _maximumResizingPosition;
            }

            _updateAppointmentResizingUpdateCallback(
                isForwardResize, isBackwardResize, yPosition, null, null,
                xPosition: newXPosition,
                timeLabelWidth: timeLabelWidth,
                isResourceEnabled: isResourceEnabled,
                details: details);

            _resizingDetails.value.position.value = Offset(
                newXPosition!, _resizingDetails.value.position.value!.dy);

            if (newXPosition != null &&
                newXPosition! <= 0 &&
                ((_isRTL &&
                    _scrollController!.position.pixels !=
                        _scrollController!.position.maxScrollExtent) ||
                    (!_isRTL && _scrollController!.position.pixels != 0))) {
              unawaited(_updateScrollPosition());
            } else if (_autoScrollTimer != null) {
              _autoScrollTimer!.cancel();
              _autoScrollTimer = null;
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_autoScrollTimer != null) {
          _autoScrollTimer!.cancel();
          _autoScrollTimer = null;
        }
      });
    } else if (newXPosition + padding >= widget.width &&
        ((!_isRTL &&
            _scrollController!.position.pixels !=
                _scrollController!.position.maxScrollExtent) ||
            (_isRTL && _scrollController!.position.pixels != 0))) {
      if (_autoScrollTimer != null) {
        return;
      }
      _autoScrollTimer = Timer(const Duration(milliseconds: 200), () async {
        newXPosition = _resizingDetails.value.position.value?.dx;
        if (_resizingDetails.value.position.value != null &&
            newXPosition! + padding >= widget.width &&
            ((!_isRTL &&
                _scrollController!.position.pixels !=
                    _scrollController!.position.maxScrollExtent) ||
                (_isRTL && _scrollController!.position.pixels != 0))) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                _scrollController!.position.pixels + timeIntervalHeight;
            if (_isRTL) {
              scrollPosition =
                  _scrollController!.position.pixels - timeIntervalHeight;
            }
            if (scrollPosition > _scrollController!.position.maxScrollExtent &&
                !_isRTL) {
              scrollPosition = _scrollController!.position.maxScrollExtent;
            } else if (_isRTL && scrollPosition < 0) {
              scrollPosition = 0;
            }

            _resizingDetails.value.scrollPosition = scrollPosition;

            _resizingDetails.value.position.value = Offset(
                newXPosition! + 0.1, _resizingDetails.value.position.value!.dy);

            await _scrollController!.position.moveTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
            if (_resizingDetails.value.appointmentView == null) {
              if (_autoScrollTimer != null) {
                _autoScrollTimer!.cancel();
                _autoScrollTimer = null;
              }

              return;
            }

            newXPosition = _resizingDetails.value.position.value?.dx;
            _updateMaximumResizingPosition(isForwardResize, isBackwardResize,
                _resizingDetails.value.appointmentView!, null, null);
            if ((isForwardResize &&
                newXPosition! < _maximumResizingPosition!) ||
                (isBackwardResize &&
                    newXPosition! > _maximumResizingPosition!)) {
              newXPosition = _maximumResizingPosition;
            }

            _updateAppointmentResizingUpdateCallback(
                isForwardResize, isBackwardResize, yPosition, null, null,
                xPosition: newXPosition,
                timeLabelWidth: timeLabelWidth,
                isResourceEnabled: isResourceEnabled,
                details: details);

            _resizingDetails.value.position.value = Offset(
                newXPosition!, _resizingDetails.value.position.value!.dy);

            if (newXPosition != null &&
                newXPosition! + padding >= widget.width &&
                ((!_isRTL &&
                    _scrollController!.position.pixels !=
                        _scrollController!.position.maxScrollExtent) ||
                    (_isRTL && _scrollController!.position.pixels != 0))) {
              unawaited(_updateScrollPosition());
            } else if (_autoScrollTimer != null) {
              _autoScrollTimer!.cancel();
              _autoScrollTimer = null;
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_autoScrollTimer != null) {
          _autoScrollTimer!.cancel();
          _autoScrollTimer = null;
        }
      });
    }
  }

  void _updateMaximumResizingPosition(
      bool isForwardResize,
      bool isBackwardResize,
      AppointmentView appointmentView,
      double? allDayPanelHeight,
      double? viewHeaderHeight) {
    switch (widget.view) {
      case CalendarView.schedule:
        break;
      case CalendarView.day:
      case CalendarView.week:
      case CalendarView.workWeek:
        {
          if (_resizingDetails.value.isAllDayPanel) {
            final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
                widget.calendar.timeSlotViewSettings.timeRulerSize,
                widget.view);
            final double minimumCellWidth =
                ((widget.width - timeLabelWidth) / widget.visibleDates.length) /
                    2;
            if (isForwardResize) {
              _maximumResizingPosition = appointmentView.appointmentRect!.left +
                  (appointmentView.appointmentRect!.width > minimumCellWidth
                      ? minimumCellWidth
                      : appointmentView.appointmentRect!.width);
            } else if (isBackwardResize) {
              _maximumResizingPosition =
                  appointmentView.appointmentRect!.right -
                      (appointmentView.appointmentRect!.width > minimumCellWidth
                          ? minimumCellWidth
                          : appointmentView.appointmentRect!.width);
            }
          } else {
            final double timeIntervalSize = _getTimeIntervalHeight(
                widget.calendar,
                widget.view,
                widget.width,
                widget.height,
                widget.visibleDates.length,
                _allDayHeight,
                widget.isMobilePlatform);
            double minimumTimeIntervalSize = timeIntervalSize / 4;
            if (minimumTimeIntervalSize < 20) {
              minimumTimeIntervalSize = 20;
            }

            if (isForwardResize) {
              _maximumResizingPosition = (appointmentView.appointmentRect!.top -
                  _scrollController!.offset +
                  allDayPanelHeight! +
                  viewHeaderHeight!) +
                  (appointmentView.appointmentRect!.height / 2 >
                      minimumTimeIntervalSize
                      ? minimumTimeIntervalSize
                      : appointmentView.appointmentRect!.height / 2);
            } else if (isBackwardResize) {
              _maximumResizingPosition =
                  (appointmentView.appointmentRect!.bottom -
                      _scrollController!.offset +
                      allDayPanelHeight! +
                      viewHeaderHeight!) -
                      (appointmentView.appointmentRect!.height / 2 >
                          minimumTimeIntervalSize
                          ? minimumTimeIntervalSize
                          : appointmentView.appointmentRect!.height / 2);
            }
          }
        }
        break;
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
      case CalendarView.timelineMonth:
        {
          final double timeIntervalSize = _getTimeIntervalHeight(
              widget.calendar,
              widget.view,
              widget.width,
              widget.height,
              widget.visibleDates.length,
              _allDayHeight,
              widget.isMobilePlatform);
          double minimumTimeIntervalSize = timeIntervalSize /
              (widget.view == CalendarView.timelineMonth ? 2 : 4);
          if (minimumTimeIntervalSize < 20) {
            minimumTimeIntervalSize = 20;
          }
          if (isForwardResize) {
            _maximumResizingPosition = appointmentView.appointmentRect!.left -
                _scrollController!.offset;
            if (_isRTL) {
              _maximumResizingPosition = _scrollController!.offset -
                  _scrollController!.position.maxScrollExtent +
                  appointmentView.appointmentRect!.left;
            }
            _maximumResizingPosition = _maximumResizingPosition! +
                (appointmentView.appointmentRect!.width / 2 >
                    minimumTimeIntervalSize
                    ? minimumTimeIntervalSize
                    : appointmentView.appointmentRect!.width / 2);
          } else if (isBackwardResize) {
            _maximumResizingPosition = appointmentView.appointmentRect!.right -
                _scrollController!.offset;
            if (_isRTL) {
              _maximumResizingPosition = _scrollController!.offset -
                  _scrollController!.position.maxScrollExtent +
                  appointmentView.appointmentRect!.right;
            }
            _maximumResizingPosition = _maximumResizingPosition! -
                (appointmentView.appointmentRect!.width / 2 >
                    minimumTimeIntervalSize
                    ? minimumTimeIntervalSize
                    : appointmentView.appointmentRect!.width / 2);
          }
        }
        break;
      case CalendarView.month:
        {
          final double weekNumberPanelWidth =
          CalendarViewHelper.getWeekNumberPanelWidth(
              widget.calendar.showWeekNumber,
              widget.width,
              widget.isMobilePlatform);
          final double minimumCellWidth =
              ((widget.width - weekNumberPanelWidth) / DateTime.daysPerWeek) /
                  2;
          if (isForwardResize) {
            _maximumResizingPosition = appointmentView.appointmentRect!.left +
                (appointmentView.appointmentRect!.width / 2 > minimumCellWidth
                    ? minimumCellWidth
                    : appointmentView.appointmentRect!.width / 2);
          } else if (isBackwardResize) {
            _maximumResizingPosition = appointmentView.appointmentRect!.right -
                (appointmentView.appointmentRect!.width / 2 > minimumCellWidth
                    ? minimumCellWidth
                    : appointmentView.appointmentRect!.width / 2);
          }
        }
    }
  }

  void _updateAppointmentResizingUpdateCallback(
      bool isForwardResize,
      bool isBackwardResize,
      double yPosition,
      double? viewHeaderHeight,
      double? allDayPanelHeight,
      {bool isResourceEnabled = false,
        double? timeLabelWidth,
        double? xPosition,
        DragUpdateDetails? details}) {
    final double timeIntervalHeight = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);
    late DateTime resizingTime;
    CalendarResource? resource;
    int selectedResourceIndex = -1;
    if (isResourceEnabled) {
      final double viewHeaderHeight = widget.view == CalendarView.day
          ? 0
          : CalendarViewHelper.getViewHeaderHeight(
          widget.calendar.viewHeaderHeight, widget.view);
      selectedResourceIndex = _getSelectedResourceIndex(
          _resizingDetails.value.appointmentView!.appointmentRect!.top,
          viewHeaderHeight,
          timeLabelWidth!);
      resource = widget.calendar.dataSource!.resources![selectedResourceIndex];
    }

    if (CalendarViewHelper.isTimelineView(widget.view)) {
      final double overAllWidth = _timeIntervalHeight *
          (_horizontalLinesCount! * widget.visibleDates.length);
      double updatedXPosition = details!.localPosition.dx;
      if (updatedXPosition > widget.width - 1) {
        updatedXPosition = widget.width - 1;
      } else if (updatedXPosition < 0) {
        updatedXPosition = 0;
      }
      if (overAllWidth < widget.width && updatedXPosition > overAllWidth) {
        updatedXPosition = overAllWidth;
      }

      resizingTime = _getDateFromPosition(
          updatedXPosition, details.localPosition.dy, timeLabelWidth!)!;
      final DateTime time = _timeFromPosition(
          resizingTime,
          widget.calendar.timeSlotViewSettings,
          xPosition! > widget.width - 1
              ? widget.width - 1
              : (xPosition < 0 ? 0 : xPosition),
          this,
          timeIntervalHeight,
          true)!;

      if (widget.view == CalendarView.timelineMonth) {
        resizingTime = DateTime(
            resizingTime.year, resizingTime.month, resizingTime.day, 0, 0, 0);
      } else {
        resizingTime = DateTime(resizingTime.year, resizingTime.month,
            resizingTime.day, time.hour, time.minute, time.second);
      }
    } else {
      final double overAllHeight = _timeIntervalHeight * _horizontalLinesCount!;
      double updatedYPosition =
      yPosition > widget.height - 1 ? widget.height - 1 : yPosition;
      if (overAllHeight < widget.height && updatedYPosition > overAllHeight) {
        updatedYPosition = overAllHeight;
      }
      final double currentYPosition =
          updatedYPosition - viewHeaderHeight! - allDayPanelHeight!;
      resizingTime = _timeFromPosition(
          _resizingDetails.value.appointmentView!.appointment!.actualStartTime,
          widget.calendar.timeSlotViewSettings,
          currentYPosition > 0 ? currentYPosition : 0,
          this,
          timeIntervalHeight,
          false)!;
    }

    _resizingDetails.value.resizingTime = resizingTime;
    if (CalendarViewHelper.shouldRaiseAppointmentResizeUpdateCallback(
        widget.calendar.onAppointmentResizeUpdate)) {
      CalendarViewHelper.raiseAppointmentResizeUpdateCallback(
          widget.calendar,
          _getCalendarAppointmentToObject(
              _resizingDetails.value.appointmentView!.appointment,
              widget.calendar),
          resource,
          resizingTime,
          _resizingDetails.value.position.value!);
    }
  }

  void _resetResizingPainter() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _resizingDetails.value.position.value = null;
    });
    _resizingDetails.value.isAllDayPanel = false;
    _resizingDetails.value.scrollPosition = null;
    _resizingDetails.value.monthRowCount = 0;
    _resizingDetails.value.monthCellHeight = null;
    _resizingDetails.value.appointmentView = null;
    _resizingDetails.value.appointmentColor = Colors.transparent;
  }

  // Returns the month view  as a child for the calendar view.
  Widget _addMonthView(bool isRTL, String locale) {
    final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double height = widget.height - viewHeaderHeight;
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          height: viewHeaderHeight,
          child: Container(
            color: widget.calendar.viewHeaderStyle.backgroundColor ??
                widget.calendarTheme.viewHeaderBackgroundColor,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _ViewHeaderViewPainter(
                    widget.visibleDates,
                    widget.view,
                    widget.calendar.viewHeaderStyle,
                    widget.calendar.timeSlotViewSettings,
                    CalendarViewHelper.getTimeLabelWidth(
                        widget.calendar.timeSlotViewSettings.timeRulerSize,
                        widget.view),
                    CalendarViewHelper.getViewHeaderHeight(
                        widget.calendar.viewHeaderHeight, widget.view),
                    widget.calendar.monthViewSettings,
                    isRTL,
                    widget.locale,
                    widget.calendarTheme,
                    widget.calendar.todayHighlightColor ??
                        widget.calendarTheme.todayHighlightColor,
                    widget.calendar.todayTextStyle,
                    widget.calendar.cellBorderColor,
                    widget.calendar.minDate,
                    widget.calendar.maxDate,
                    _viewHeaderNotifier,
                    widget.textScaleFactor,
                    widget.calendar.showWeekNumber,
                    widget.isMobilePlatform,
                    widget.calendar.weekNumberStyle,
                    widget.localizations),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: viewHeaderHeight,
          right: 0,
          bottom: 0,
          child: RepaintBoundary(
              child: _CalendarMultiChildContainer(
                width: widget.width,
                height: height,
                children: <Widget>[
                  RepaintBoundary(child: _getMonthWidget(isRTL, height)),
                  RepaintBoundary(
                      child: _addAppointmentPainter(widget.width, height)),
                ],
              )),
        ),
        Positioned(
          left: 0,
          top: viewHeaderHeight,
          right: 0,
          bottom: 0,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _addSelectionView(),
              size: Size(widget.width, height),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getMonthWidget(bool isRTL, double height) {
    final List<CalendarAppointment>? visibleAppointments =
    widget.visibleDates ==
        _updateCalendarStateDetails.currentViewVisibleDates
        ? _updateCalendarStateDetails.visibleAppointments
        : null;
    _monthView = MonthViewWidget(
        widget.visibleDates,
        widget.calendar.monthViewSettings.numberOfWeeksInView,
        widget.calendar.monthViewSettings.monthCellStyle,
        isRTL,
        widget.calendar.todayHighlightColor ??
            widget.calendarTheme.todayHighlightColor,
        widget.calendar.todayTextStyle,
        widget.calendar.cellBorderColor,
        widget.calendarTheme,
        _calendarCellNotifier,
        widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        widget.calendar,
        widget.blackoutDates,
        widget.calendar.blackoutDatesTextStyle,
        widget.textScaleFactor,
        widget.calendar.monthCellBuilder,
        widget.width,
        height,
        widget.calendar.weekNumberStyle,
        widget.isMobilePlatform,
        ValueNotifier<List<CalendarAppointment>?>(visibleAppointments));
    return _monthView;
  }

  Widget _getResizeShadowView() {
    if (widget.isMobilePlatform || !widget.calendar.allowAppointmentResize) {
      return const SizedBox(width: 0, height: 0);
    }

    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double allDayPanelHeight = _isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : _allDayHeight;
    final bool isVerticalResize = _mouseCursor == SystemMouseCursors.resizeUp ||
        _mouseCursor == SystemMouseCursors.resizeDown;
    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    final bool isAllDayPanel = !isVerticalResize &&
        (!isTimelineView && widget.view != CalendarView.month);
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    final double weekNumberPanelWidth =
    CalendarViewHelper.getWeekNumberPanelWidth(
        widget.calendar.showWeekNumber,
        widget.width,
        widget.isMobilePlatform);

    final double overAllWidth = isTimelineView
        ? _timeIntervalHeight *
        (_horizontalLinesCount! * widget.visibleDates.length)
        : widget.width;
    final double overAllHeight =
    isTimelineView || widget.view == CalendarView.month
        ? widget.height
        : viewHeaderHeight +
        allDayPanelHeight +
        (_timeIntervalHeight * _horizontalLinesCount!);

    return Positioned(
        left: 0,
        width: overAllWidth,
        height: overAllHeight,
        top: 0,
        child: GestureDetector(
          child: IgnorePointer(
              ignoring: _mouseCursor == SystemMouseCursors.basic ||
                  _mouseCursor == SystemMouseCursors.move ||
                  isAllDayPanel,
              child: RepaintBoundary(
                  child: CustomPaint(
                    painter: _ResizingAppointmentPainter(
                        _resizingDetails,
                        _isRTL,
                        widget.textScaleFactor,
                        widget.isMobilePlatform,
                        widget.calendar.appointmentTextStyle,
                        allDayPanelHeight,
                        viewHeaderHeight,
                        timeLabelWidth,
                        _timeIntervalHeight,
                        _scrollController,
                        widget.calendar.dragAndDropSettings,
                        widget.view,
                        _mouseCursor,
                        weekNumberPanelWidth,
                        widget.calendarTheme),
                  ))),
          onVerticalDragStart: isVerticalResize ? _onVerticalStart : null,
          onVerticalDragUpdate: isVerticalResize ? _onVerticalUpdate : null,
          onVerticalDragEnd: isVerticalResize ? _onVerticalEnd : null,
          onHorizontalDragStart: isVerticalResize ? null : _onHorizontalStart,
          onHorizontalDragUpdate: isVerticalResize ? null : _onHorizontalUpdate,
          onHorizontalDragEnd: isVerticalResize ? null : _onHorizontalEnd,
        ));
  }

  // Returns the day view as a child for the calendar view.
  Widget _addDayView(double width, double height, bool isRTL, String locale,
      bool isCurrentView) {
    final double actualViewHeaderHeight =
    CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    double viewHeaderHeight = actualViewHeaderHeight;
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    if (widget.view == CalendarView.day) {
      viewHeaderHeight =
      _allDayHeight > viewHeaderHeight ? _allDayHeight : viewHeaderHeight;
    }

    double panelHeight = isCurrentView
        ? _updateCalendarStateDetails.allDayPanelHeight - _allDayHeight
        : 0;
    if (panelHeight < 0) {
      panelHeight = 0;
    }
    final Color borderColor = widget.calendar.cellBorderColor ??
        widget.calendarTheme.cellBorderColor!;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: actualViewHeaderHeight,
            color: widget.calendar.viewHeaderStyle.backgroundColor ??
                widget.calendarTheme.viewHeaderBackgroundColor,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: _ViewHeaderViewPainter(
                    widget.visibleDates,
                    widget.view,
                    widget.calendar.viewHeaderStyle,
                    widget.calendar.timeSlotViewSettings,
                    CalendarViewHelper.getTimeLabelWidth(
                        widget.calendar.timeSlotViewSettings.timeRulerSize,
                        widget.view),
                    actualViewHeaderHeight,
                    widget.calendar.monthViewSettings,
                    isRTL,
                    widget.locale,
                    widget.calendarTheme,
                    widget.calendar.todayHighlightColor ??
                        widget.calendarTheme.todayHighlightColor,
                    widget.calendar.todayTextStyle,
                    widget.calendar.cellBorderColor,
                    widget.calendar.minDate,
                    widget.calendar.maxDate,
                    _viewHeaderNotifier,
                    widget.textScaleFactor,
                    widget.calendar.showWeekNumber,
                    widget.isMobilePlatform,
                    widget.calendar.weekNumberStyle,
                    widget.localizations),
              ),
            ),
          ),
          spaceH12,
          _addAllDayAppointmentPanel(widget.calendarTheme, isCurrentView),
          Divider(
            height: 1,
            thickness: 1,
            color: borderColor.withOpacity(borderColor.opacity * 0.5),
          ),
          Scrollbar(
            controller: _scrollController,
            isAlwaysShown: !widget.isMobilePlatform,
            child: ListView(
              padding: EdgeInsets.zero,
              controller: _scrollController,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    RepaintBoundary(
                        child: _CalendarMultiChildContainer(
                            width: width,
                            height: height,
                            children: <Widget>[
                              RepaintBoundary(
                                child: TimeSlotWidget(
                                    widget.visibleDates,
                                    _horizontalLinesCount!,
                                    _timeIntervalHeight,
                                    timeLabelWidth,
                                    widget.calendar.cellBorderColor,
                                    widget.calendarTheme,
                                    widget.calendar.timeSlotViewSettings,
                                    isRTL,
                                    widget.regions,
                                    _calendarCellNotifier,
                                    widget.textScaleFactor,
                                    widget.calendar.timeRegionBuilder,
                                    width,
                                    height,
                                    widget.calendar.minDate,
                                    widget.calendar.maxDate),
                              ),
                              RepaintBoundary(
                                  child: _addAppointmentPainter(width, height)),
                            ])),
                    RepaintBoundary(
                      child: CustomPaint(
                        painter: _TimeRulerView(
                            _horizontalLinesCount!,
                            _timeIntervalHeight,
                            widget.calendar.timeSlotViewSettings,
                            widget.calendar.cellBorderColor,
                            isRTL,
                            widget.locale,
                            widget.calendarTheme,
                            CalendarViewHelper.isTimelineView(widget.view),
                            widget.visibleDates,
                            widget.textScaleFactor),
                        size: Size(timeLabelWidth, height),
                      ),
                    ),
                    RepaintBoundary(
                      child: CustomPaint(
                        painter: _addSelectionView(),
                        size: Size(width, height),
                      ),
                    ),
                    _getCurrentTimeIndicator(
                        timeLabelWidth, width, height, false),
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: borderColor.withOpacity(borderColor.opacity * 0.5),
                ),
                StreamBuilder<int>(
                    stream: totalAppRemove,
                    builder: (_, snapshot) {
                      final value = snapshot.data ?? 0;
                      if (value > 0) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: timeLabelWidth - 1),
                              child: Row(
                                children: List.generate(
                                  widget.visibleDates.length,
                                      (index) {
                                    return StreamBuilder<Map<DateTime, int>>(
                                      stream: removeDayCount,
                                      builder: (_, snapshot) {
                                        final mapValue = snapshot.data ?? {};
                                        final key =
                                        getKey(widget.visibleDates[index]);
                                        final count = mapValue[key] == null
                                            ? ''
                                            : '+${mapValue[key]}';
                                        return GestureDetector(
                                          onTap: () {
                                            widget.onMoreDayClick
                                                ?.call(key, mapValue[key] ?? 0);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color:
                                                  borderColor.withOpacity(
                                                    borderColor.opacity * 0.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            width:
                                            (width - timeLabelWidth + 1) /
                                                widget.visibleDates.length,
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                count,
                                                style: textNormalCustom(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: colorA2AEBD,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: borderColor
                                  .withOpacity(borderColor.opacity * 0.5),
                            ),
                            spaceH70,
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCurrentTimeIndicator(
      double timeLabelSize, double width, double height, bool isTimelineView) {
    if (!widget.calendar.showCurrentTimeIndicator ||
        widget.view == CalendarView.timelineMonth) {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }

    return RepaintBoundary(
      child: CustomPaint(
        painter: _CurrentTimeIndicator(
          _timeIntervalHeight,
          timeLabelSize,
          widget.calendar.timeSlotViewSettings,
          isTimelineView,
          widget.visibleDates,
          widget.calendar.todayHighlightColor ??
              widget.calendarTheme.todayHighlightColor,
          _isRTL,
          _currentTimeNotifier,
        ),
        size: Size(width, height),
      ),
    );
  }

  DateTime getKey(DateTime date) => DateTime(
    date.year,
    date.month,
    date.day,
  );

  /// Updates the cell selection when the initial display date property of
  /// calendar has value, on this scenario the first resource cell must be
  /// selected;
  void _updateProgrammaticSelectedResourceIndex() {
    if (_updateCalendarStateDetails.selectedDate != null &&
        _selectedResourceIndex == -1) {
      final bool isTimelineMonth = widget.view == CalendarView.timelineMonth;
      if ((isTimelineMonth &&
          (isSameDate(_updateCalendarStateDetails.selectedDate,
              widget.calendar.initialSelectedDate))) ||
          (!isTimelineMonth &&
              (CalendarViewHelper.isSameTimeSlot(
                  _updateCalendarStateDetails.selectedDate,
                  widget.calendar.initialSelectedDate)))) {
        _selectedResourceIndex = 0;
      }
    }
  }

  // Returns the timeline view  as a child for the calendar view.
  Widget _addTimelineView(double width, double height, String locale) {
    final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double timeLabelSize = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);
    double resourceItemHeight = 0;
    height -= viewHeaderHeight + timeLabelSize;
    if (isResourceEnabled) {
      _updateProgrammaticSelectedResourceIndex();
      final double resourceViewSize = widget.calendar.resourceViewSettings.size;
      resourceItemHeight = CalendarViewHelper.getResourceItemHeight(
          resourceViewSize,
          widget.height - viewHeaderHeight - timeLabelSize,
          widget.calendar.resourceViewSettings,
          widget.calendar.dataSource!.resources!.length);
      height = resourceItemHeight * widget.resourceCollection!.length;
    }
    return Stack(children: <Widget>[
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: viewHeaderHeight,
        child: Container(
          color: widget.calendar.viewHeaderStyle.backgroundColor ??
              widget.calendarTheme.viewHeaderBackgroundColor,
          child: _getTimelineViewHeader(width, viewHeaderHeight, widget.locale),
        ),
      ),
      Positioned(
          top: viewHeaderHeight,
          left: 0,
          right: 0,
          height: timeLabelSize,
          child: ListView(
            padding: EdgeInsets.zero,
            controller: _timelineRulerController,
            scrollDirection: Axis.horizontal,
            physics: const _CustomNeverScrollableScrollPhysics(),
            children: <Widget>[
              RepaintBoundary(
                  child: CustomPaint(
                    painter: _TimeRulerView(
                        _horizontalLinesCount!,
                        _timeIntervalHeight,
                        widget.calendar.timeSlotViewSettings,
                        widget.calendar.cellBorderColor,
                        _isRTL,
                        locale,
                        widget.calendarTheme,
                        CalendarViewHelper.isTimelineView(widget.view),
                        widget.visibleDates,
                        widget.textScaleFactor),
                    size: Size(width, timeLabelSize),
                  )),
            ],
          )),
      Positioned(
          top: viewHeaderHeight + timeLabelSize,
          left: 0,
          right: 0,
          bottom: 0,
          child: Scrollbar(
            controller: _scrollController,
            isAlwaysShown: !widget.isMobilePlatform,
            child: ListView(
                padding: EdgeInsets.zero,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const _CustomNeverScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                      width: width,
                      child: Stack(children: <Widget>[
                        Scrollbar(
                            controller: _timelineViewVerticalScrollController,
                            isAlwaysShown: !widget.isMobilePlatform,
                            child: ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                controller:
                                _timelineViewVerticalScrollController,
                                physics: isResourceEnabled
                                    ? const ClampingScrollPhysics()
                                    : const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  Stack(children: <Widget>[
                                    RepaintBoundary(
                                        child: _CalendarMultiChildContainer(
                                          width: width,
                                          height: height,
                                          children: <Widget>[
                                            RepaintBoundary(
                                                child: TimelineWidget(
                                                    _horizontalLinesCount!,
                                                    widget.visibleDates,
                                                    widget.calendar
                                                        .timeSlotViewSettings,
                                                    _timeIntervalHeight,
                                                    widget.calendar.cellBorderColor,
                                                    _isRTL,
                                                    widget.calendarTheme,
                                                    _calendarCellNotifier,
                                                    _scrollController!,
                                                    widget.regions,
                                                    resourceItemHeight,
                                                    widget.resourceCollection,
                                                    widget.textScaleFactor,
                                                    widget.isMobilePlatform,
                                                    widget
                                                        .calendar.timeRegionBuilder,
                                                    width,
                                                    height,
                                                    widget.minDate,
                                                    widget.maxDate,
                                                    widget.blackoutDates)),
                                            RepaintBoundary(
                                                child: _addAppointmentPainter(width,
                                                    height, resourceItemHeight)),
                                          ],
                                        )),
                                    RepaintBoundary(
                                      child: CustomPaint(
                                        painter: _addSelectionView(
                                            resourceItemHeight),
                                        size: Size(width, height),
                                      ),
                                    ),
                                    _getCurrentTimeIndicator(
                                        timeLabelSize, width, height, true),
                                  ]),
                                ])),
                      ])),
                ]),
          )),
    ]);
  }

  //// Get the calendar details for all calendar views.
  CalendarDetails? _getCalendarViewDetails(Offset position) {
    switch (widget.view) {
      case CalendarView.day:
      case CalendarView.week:
      case CalendarView.workWeek:
        return _getDetailsForDay(position);
      case CalendarView.month:
        return _getDetailsForMonth(position);
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
      case CalendarView.timelineMonth:
        return _getDetailsForTimeline(position);
      case CalendarView.schedule:
        return null;
    }
  }

  //// Get the calendar details for month cells and view header of month.
  CalendarDetails? _getDetailsForMonth(Offset position) {
    final double xPosition = position.dx;
    double yPosition = position.dy;
    final double weekNumberPanelWidth =
    CalendarViewHelper.getWeekNumberPanelWidth(
        widget.calendar.showWeekNumber,
        widget.width,
        widget.isMobilePlatform);
    if ((!_isRTL && xPosition < weekNumberPanelWidth) ||
        (_isRTL && xPosition > widget.width - weekNumberPanelWidth)) {
      /// Return null while the [getCalendarDetailsAtOffset] position placed on
      /// week number panel in month view.
      return null;
    }

    final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);

    if (yPosition < viewHeaderHeight) {
      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on view header in month view.
      return CalendarDetails(
          null,
          _getTappedViewHeaderDate(position, widget.width),
          CalendarElement.viewHeader,
          null);
    }

    yPosition = yPosition - viewHeaderHeight;
    AppointmentView? appointmentView;
    bool isMoreTapped = false;
    if (widget.calendar.monthViewSettings.appointmentDisplayMode ==
        MonthAppointmentDisplayMode.appointment) {
      appointmentView =
          _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);
      isMoreTapped = appointmentView != null &&
          appointmentView.startIndex == -1 &&
          appointmentView.endIndex == -1 &&
          appointmentView.position == -1 &&
          appointmentView.maxPositions == -1;
    }

    final DateTime getDate = _getDateFromPosition(xPosition, yPosition, 0)!;

    if (appointmentView == null) {
      final int currentMonth =
          widget.visibleDates[widget.visibleDates.length ~/ 2].month;

      /// Check the position of date as trailing or leading date when
      /// [SfCalendar] month not shown leading and trailing dates.
      if (!CalendarViewHelper.isCurrentMonthDate(
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
          currentMonth,
          getDate)) {
        /// Return null while the [getCalendarDetailsAtOffset] position placed
        /// on not shown leading and trailing dates.
        return null;
      }
    }

    final List<dynamic> selectedAppointments =
    appointmentView == null || isMoreTapped
        ? _getSelectedAppointments(getDate)
        : <dynamic>[
      CalendarViewHelper.getAppointmentDetail(
          appointmentView.appointment!, widget.calendar.dataSource)
    ];
    final CalendarElement selectedElement = appointmentView == null
        ? CalendarElement.calendarCell
        : isMoreTapped
        ? CalendarElement.moreAppointmentRegion
        : CalendarElement.appointment;

    /// Return calendar details while the [getCalendarDetailsAtOffset]
    /// position placed on month cells in month view.
    return CalendarDetails(
        selectedAppointments, getDate, selectedElement, null);
  }

  //// Handles the onTap callback for month cells, and view header of month
  void _handleOnTapForMonth(TapUpDetails details) {
    _handleTouchOnMonthView(details, null);
  }

  /// Handles the tap and long press related functions for month view.
  AppointmentView? _handleTouchOnMonthView(
      TapUpDetails? tapDetails, LongPressStartDetails? longPressDetails) {
    widget.removePicker();
    final DateTime? previousSelectedDate = _selectionPainter!.selectedDate;
    double xDetails = 0, yDetails = 0;
    bool isTapCallback = false;
    if (tapDetails != null) {
      isTapCallback = true;
      xDetails = tapDetails.localPosition.dx;
      yDetails = tapDetails.localPosition.dy;
    } else if (longPressDetails != null) {
      xDetails = longPressDetails.localPosition.dx;
      yDetails = longPressDetails.localPosition.dy;
    }

    final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double weekNumberPanelWidth =
    CalendarViewHelper.getWeekNumberPanelWidth(
        widget.calendar.showWeekNumber,
        widget.width,
        widget.isMobilePlatform);
    if ((!_isRTL && xDetails < weekNumberPanelWidth) ||
        (_isRTL && xDetails > widget.width - weekNumberPanelWidth)) {
      return null;
    }
    if (yDetails < viewHeaderHeight) {
      if (isTapCallback) {
        _handleOnTapForViewHeader(tapDetails!, widget.width);
      } else if (!isTapCallback) {
        _handleOnLongPressForViewHeader(longPressDetails!, widget.width);
      }
    } else if (yDetails > viewHeaderHeight) {
      if (!widget.focusNode.hasFocus) {
        widget.focusNode.requestFocus();
      }

      AppointmentView? appointmentView;
      bool isMoreTapped = false;
      if (!widget.isMobilePlatform &&
          widget.calendar.monthViewSettings.appointmentDisplayMode ==
              MonthAppointmentDisplayMode.appointment) {
        appointmentView = _appointmentLayout.getAppointmentViewOnPoint(
            xDetails, yDetails - viewHeaderHeight);
        isMoreTapped = appointmentView != null &&
            appointmentView.startIndex == -1 &&
            appointmentView.endIndex == -1 &&
            appointmentView.position == -1 &&
            appointmentView.maxPositions == -1;
      }

      if (appointmentView == null) {
        _drawSelection(xDetails, yDetails - viewHeaderHeight, 0);
      } else {
        _updateCalendarStateDetails.selectedDate = null;
        widget.agendaSelectedDate.value = null;
        _selectionPainter!.selectedDate = null;
        _selectionPainter!.appointmentView = appointmentView;
        _selectionNotifier.value = !_selectionNotifier.value;
      }

      widget.updateCalendarState(_updateCalendarStateDetails);
      final DateTime selectedDate =
      _getDateFromPosition(xDetails, yDetails - viewHeaderHeight, 0)!;
      if (appointmentView == null) {
        if (!isDateWithInDateRange(widget.calendar.minDate,
            widget.calendar.maxDate, selectedDate) ||
            CalendarViewHelper.isDateInDateCollection(
                widget.blackoutDates, selectedDate)) {
          return null;
        }

        final int currentMonth =
            widget.visibleDates[widget.visibleDates.length ~/ 2].month;

        /// Check the selected cell date as trailing or leading date when
        /// [SfCalendar] month not shown leading and trailing dates.
        if (!CalendarViewHelper.isCurrentMonthDate(
            widget.calendar.monthViewSettings.numberOfWeeksInView,
            widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
            currentMonth,
            selectedDate)) {
          return null;
        }

        _handleMonthCellTapNavigation(selectedDate);
      }

      final bool canRaiseTap =
          CalendarViewHelper.shouldRaiseCalendarTapCallback(
              widget.calendar.onTap) &&
              isTapCallback;
      final bool canRaiseLongPress =
          CalendarViewHelper.shouldRaiseCalendarLongPressCallback(
              widget.calendar.onLongPress) &&
              !isTapCallback;
      final bool canRaiseSelectionChanged =
      CalendarViewHelper.shouldRaiseCalendarSelectionChangedCallback(
          widget.calendar.onSelectionChanged);

      if (canRaiseLongPress || canRaiseTap || canRaiseSelectionChanged) {
        final List<dynamic> selectedAppointments = appointmentView == null ||
            isMoreTapped
            ? _getSelectedAppointments(selectedDate)
            : <dynamic>[
          CalendarViewHelper.getAppointmentDetail(
              appointmentView.appointment!, widget.calendar.dataSource)
        ];
        final CalendarElement selectedElement = appointmentView == null
            ? CalendarElement.calendarCell
            : isMoreTapped
            ? CalendarElement.moreAppointmentRegion
            : CalendarElement.appointment;
        if (canRaiseTap) {
          CalendarViewHelper.raiseCalendarTapCallback(widget.calendar,
              selectedDate, selectedAppointments, selectedElement, null);
        } else if (canRaiseLongPress) {
          CalendarViewHelper.raiseCalendarLongPressCallback(widget.calendar,
              selectedDate, selectedAppointments, selectedElement, null);
        }

        _updatedSelectionChangedCallback(
            canRaiseSelectionChanged, previousSelectedDate);
      }
      return appointmentView;
    }
    return null;
  }

  /// Raise selection changed callback based on the arguments passed.
  void _updatedSelectionChangedCallback(
      bool canRaiseSelectionChanged, DateTime? previousSelectedDate,
      [CalendarResource? selectedResource,
        int? previousSelectedResourceIndex]) {
    final bool isMonthView = widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth;
    if (canRaiseSelectionChanged &&
        ((isMonthView &&
            !isSameDate(
                previousSelectedDate, _selectionPainter!.selectedDate)) ||
            (!isMonthView &&
                !CalendarViewHelper.isSameTimeSlot(
                    previousSelectedDate, _selectionPainter!.selectedDate)) ||
            (CalendarViewHelper.isResourceEnabled(
                widget.calendar.dataSource, widget.view) &&
                _selectionPainter!.selectedResourceIndex !=
                    previousSelectedResourceIndex))) {
      CalendarViewHelper.raiseCalendarSelectionChangedCallback(
          widget.calendar, _selectionPainter!.selectedDate, selectedResource);
    }
  }

  void _handleMonthCellTapNavigation(DateTime date) {
    if (!widget.allowViewNavigation ||
        widget.view != CalendarView.month ||
        widget.calendar.monthViewSettings.showAgenda) {
      return;
    }

    widget.controller.view = CalendarView.day;
    widget.controller.displayDate = date;
  }

  //// Handles the onTap callback for timeline view cells, and view header of timeline.
  void _handleOnTapForTimeline(TapUpDetails details) {
    _handleTouchOnTimeline(details, null);
  }

  /// Returns the index of resource value associated with the selected calendar
  /// cell in timeline views.
  int _getSelectedResourceIndex(
      double yPosition, double viewHeaderHeight, double timeLabelSize) {
    final int resourceCount = widget.calendar.dataSource != null &&
        widget.calendar.dataSource!.resources != null
        ? widget.calendar.dataSource!.resources!.length
        : 0;
    final double resourceItemHeight = CalendarViewHelper.getResourceItemHeight(
        widget.calendar.resourceViewSettings.size,
        widget.height - viewHeaderHeight - timeLabelSize,
        widget.calendar.resourceViewSettings,
        resourceCount);
    return (yPosition / resourceItemHeight).truncate();
  }

  /// Get the calendar details for timeline view.
  CalendarDetails? _getDetailsForTimeline(Offset position) {
    final double xDetails = position.dx;
    final double yDetails = position.dy;

    final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);

    if (yDetails < viewHeaderHeight) {
      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on view header in timeline views.
      return CalendarDetails(
          null,
          _getTappedViewHeaderDate(position, widget.width),
          CalendarElement.viewHeader,
          null);
    }

    double xPosition = _scrollController!.offset + xDetails;
    double yPosition = yDetails - viewHeaderHeight;

    final double timeLabelHeight = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);

    if (yPosition < timeLabelHeight) {
      /// Return null while the [getCalendarDetailsAtOffset] position placed on
      /// above resource panel equal to view header in timeline views.
      return null;
    }

    yPosition -= timeLabelHeight;

    CalendarResource? calendarResource;

    if (CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view)) {
      yPosition += _timelineViewVerticalScrollController!.offset;
      _selectedResourceIndex = _getSelectedResourceIndex(
          yPosition, viewHeaderHeight, timeLabelHeight);
      calendarResource =
      widget.calendar.dataSource!.resources![_selectedResourceIndex];
    }

    if (_isRTL) {
      xPosition = _scrollController!.offset +
          (_scrollController!.position.viewportDimension - xDetails);
      xPosition = (_scrollController!.position.viewportDimension +
          _scrollController!.position.maxScrollExtent) -
          xPosition;
    }

    final AppointmentView? appointmentView =
    _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);

    final DateTime getDate =
    _getDateFromPosition(xDetails, yDetails - viewHeaderHeight, 0)!;

    if (appointmentView == null) {
      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on calendar cell in timeline views.
      return CalendarDetails(
          null, getDate, CalendarElement.calendarCell, calendarResource);
    } else {
      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on appointment in timeline views.
      return CalendarDetails(<dynamic>[
        CalendarViewHelper.getAppointmentDetail(
            appointmentView.appointment!, widget.calendar.dataSource)
      ], getDate, CalendarElement.appointment, calendarResource);
    }
  }

  /// Handles the tap and long press related functions for timeline view.
  AppointmentView? _handleTouchOnTimeline(
      TapUpDetails? tapDetails, LongPressStartDetails? longPressDetails) {
    widget.removePicker();
    final DateTime? previousSelectedDate = _selectionPainter!.selectedDate;
    double xDetails = 0, yDetails = 0;
    bool isTapCallback = false;
    if (tapDetails != null) {
      isTapCallback = true;
      xDetails = tapDetails.localPosition.dx;
      yDetails = tapDetails.localPosition.dy;
    } else if (longPressDetails != null) {
      xDetails = longPressDetails.localPosition.dx;
      yDetails = longPressDetails.localPosition.dy;
    }

    final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);

    if (yDetails < viewHeaderHeight) {
      if (isTapCallback) {
        _handleOnTapForViewHeader(tapDetails!, widget.width);
      } else if (!isTapCallback) {
        _handleOnLongPressForViewHeader(longPressDetails!, widget.width);
      }
    } else if (yDetails > viewHeaderHeight) {
      if (!widget.focusNode.hasFocus) {
        widget.focusNode.requestFocus();
      }

      widget.getCalendarState(_updateCalendarStateDetails);
      DateTime? selectedDate = _updateCalendarStateDetails.selectedDate;

      double xPosition = _scrollController!.offset + xDetails;
      double yPosition = yDetails - viewHeaderHeight;
      final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
          widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);

      if (yPosition < timeLabelWidth) {
        return null;
      }

      yPosition -= timeLabelWidth;

      CalendarResource? selectedResource;

      if (CalendarViewHelper.isResourceEnabled(
          widget.calendar.dataSource, widget.view)) {
        yPosition += _timelineViewVerticalScrollController!.offset;
        _selectedResourceIndex = _getSelectedResourceIndex(
            yPosition, viewHeaderHeight, timeLabelWidth);
        selectedResource =
        widget.calendar.dataSource!.resources![_selectedResourceIndex];
      }

      final int previousSelectedResourceIndex =
          _selectionPainter!.selectedResourceIndex;
      _selectionPainter!.selectedResourceIndex = _selectedResourceIndex;

      if (_isRTL) {
        xPosition = _scrollController!.offset +
            (_scrollController!.position.viewportDimension - xDetails);
        xPosition = (_scrollController!.position.viewportDimension +
            _scrollController!.position.maxScrollExtent) -
            xPosition;
      }

      final AppointmentView? appointmentView =
      _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);
      if (appointmentView == null) {
        _drawSelection(xDetails, yPosition, timeLabelWidth);
        selectedDate = _selectionPainter!.selectedDate;
      } else {
        if (selectedDate != null) {
          selectedDate = null;
          _selectionPainter!.selectedDate = selectedDate;
          _updateCalendarStateDetails.selectedDate = selectedDate;
        }

        _selectionPainter!.appointmentView = appointmentView;
        _selectionNotifier.value = !_selectionNotifier.value;
      }

      widget.updateCalendarState(_updateCalendarStateDetails);
      final bool canRaiseTap =
          CalendarViewHelper.shouldRaiseCalendarTapCallback(
              widget.calendar.onTap) &&
              isTapCallback;
      final bool canRaiseLongPress =
          CalendarViewHelper.shouldRaiseCalendarLongPressCallback(
              widget.calendar.onLongPress) &&
              !isTapCallback;
      final bool canRaiseSelectionChanged =
      CalendarViewHelper.shouldRaiseCalendarSelectionChangedCallback(
          widget.calendar.onSelectionChanged);

      if (canRaiseLongPress || canRaiseTap || canRaiseSelectionChanged) {
        final DateTime selectedDate =
        _getDateFromPosition(xDetails, yDetails - viewHeaderHeight, 0)!;
        final int timeInterval = CalendarViewHelper.getTimeInterval(
            widget.calendar.timeSlotViewSettings);
        if (appointmentView == null) {
          if (!CalendarViewHelper.isDateTimeWithInDateTimeRange(
              widget.calendar.minDate,
              widget.calendar.maxDate,
              selectedDate,
              timeInterval) ||
              (widget.view == CalendarView.timelineMonth &&
                  CalendarViewHelper.isDateInDateCollection(
                      widget.calendar.blackoutDates, selectedDate))) {
            return null;
          }

          /// Restrict the callback, while selected region as disabled
          /// [TimeRegion].
          if (!_isEnabledRegion(
              xDetails, selectedDate, _selectedResourceIndex)) {
            return null;
          }

          if (canRaiseTap) {
            CalendarViewHelper.raiseCalendarTapCallback(
                widget.calendar,
                selectedDate,
                null,
                CalendarElement.calendarCell,
                selectedResource);
          } else if (canRaiseLongPress) {
            CalendarViewHelper.raiseCalendarLongPressCallback(
                widget.calendar,
                selectedDate,
                null,
                CalendarElement.calendarCell,
                selectedResource);
          }
          _updatedSelectionChangedCallback(
              canRaiseSelectionChanged,
              previousSelectedDate,
              selectedResource,
              previousSelectedResourceIndex);
        } else {
          if (canRaiseTap) {
            CalendarViewHelper.raiseCalendarTapCallback(
                widget.calendar,
                selectedDate,
                <dynamic>[
                  CalendarViewHelper.getAppointmentDetail(
                      appointmentView.appointment!, widget.calendar.dataSource)
                ],
                CalendarElement.appointment,
                selectedResource);
          } else if (canRaiseLongPress) {
            CalendarViewHelper.raiseCalendarLongPressCallback(
                widget.calendar,
                selectedDate,
                <dynamic>[
                  CalendarViewHelper.getAppointmentDetail(
                      appointmentView.appointment!, widget.calendar.dataSource)
                ],
                CalendarElement.appointment,
                selectedResource);
          }
          _updatedSelectionChangedCallback(
              canRaiseSelectionChanged,
              previousSelectedDate,
              selectedResource,
              previousSelectedResourceIndex);
        }
      }

      return appointmentView;
    }
    return null;
  }

  void _updateAllDaySelection(AppointmentView? view, DateTime? date) {
    if (_allDaySelectionNotifier.value != null &&
        view == _allDaySelectionNotifier.value!.appointmentView &&
        isSameDate(date, _allDaySelectionNotifier.value!.selectedDate)) {
      return;
    }

    _allDaySelectionNotifier.value = SelectionDetails(view, date);
  }

  //// Handles the onTap callback for day view cells, all day panel, and view
  //// header of day.
  void _handleOnTapForDay(TapUpDetails details) {
    _handleTouchOnDayView(details, null);
  }

  /// Get the calendar details for day, week work week views.
  CalendarDetails? _getDetailsForDay(Offset position) {
    final double xDetails = position.dx;
    final double yDetails = position.dy;

    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);

    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double allDayHeight = _isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : _allDayHeight;
    // time ruler position on time slot scroll view.
    if (!_isRTL &&
        xDetails <= timeLabelWidth &&
        yDetails > viewHeaderHeight + allDayHeight) {
      /// Return null while the [getCalendarDetailsAtOffset] position placed
      /// on time ruler position.
      return null;
    }

    // In RTL, time ruler position on time slot scroll view.
    if (_isRTL &&
        xDetails >= widget.width - timeLabelWidth &&
        yDetails > viewHeaderHeight + allDayHeight) {
      /// Return null while the [getCalendarDetailsAtOffset] position placed
      /// on time ruler position in RTL.
      return null;
    }

    if (yDetails < viewHeaderHeight) {
      // week, workweek view header because view header height variable value is
      // 0 on day view.
      if ((!_isRTL && xDetails <= timeLabelWidth) ||
          (_isRTL && widget.width - xDetails <= timeLabelWidth)) {
        // Return null while the [getCalendarDetailsAtOffset] position placed on
        // week number in view header.
        return null;
      }

      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on view header in week and work week view.
      return CalendarDetails(
          null,
          _getTappedViewHeaderDate(position, widget.width),
          CalendarElement.viewHeader,
          null);
    } else if (yDetails < viewHeaderHeight + allDayHeight) {
      /// Check the position in view header when [CalendarView] is day
      /// If RTL, view header placed at right side,
      /// else view header placed at left side.
      if (widget.view == CalendarView.day &&
          ((!_isRTL && xDetails <= timeLabelWidth) ||
              (_isRTL && widget.width - xDetails <= timeLabelWidth)) &&
          yDetails <
              CalendarViewHelper.getViewHeaderHeight(
                  widget.calendar.viewHeaderHeight, widget.view)) {
        /// Return calendar details while the [getCalendarDetailsAtOffset]
        /// position placed on view header in day view.
        return CalendarDetails(
            null,
            _getTappedViewHeaderDate(position, widget.width),
            CalendarElement.viewHeader,
            null);
      } else if ((!_isRTL && timeLabelWidth >= xDetails) ||
          (_isRTL && xDetails > widget.width - timeLabelWidth)) {
        /// Return null while the [getCalendarDetailsAtOffset] position placed
        /// on expander icon in all day panel.
        return null;
      }

      final double yPosition = yDetails - viewHeaderHeight;
      final AppointmentView? appointmentView = _getAllDayAppointmentOnPoint(
          _updateCalendarStateDetails.allDayAppointmentViewCollection,
          xDetails,
          yPosition);

      /// Check the count position tapped or not
      bool isTappedOnCount = appointmentView != null &&
          _updateCalendarStateDetails.allDayPanelHeight > allDayHeight &&
          yPosition > allDayHeight - kAllDayAppointmentHeight;
      DateTime? selectedDate;
      if (appointmentView == null || isTappedOnCount) {
        selectedDate = _getTappedViewHeaderDate(position, widget.width);
      }

      List<CalendarAppointment>? _moreRegionAppointments;
      // Expand and collapsed the all day panel creates all the appointment
      // views including the hidden appointment. In that case, is tapped count
      // boolean property sets true.
      if (isTappedOnCount && selectedDate != null) {
        final int currentSelectedIndex = DateTimeHelper.getVisibleDateIndex(
            widget.visibleDates, selectedDate);
        if (currentSelectedIndex != -1) {
          _moreRegionAppointments = <CalendarAppointment>[];
          for (int i = 0;
          i <
              _updateCalendarStateDetails
                  .allDayAppointmentViewCollection.length;
          i++) {
            final AppointmentView currentView =
            _updateCalendarStateDetails.allDayAppointmentViewCollection[i];
            if (currentView.appointment == null) {
              continue;
            }

            if (currentView.startIndex <= currentSelectedIndex &&
                currentView.endIndex > currentSelectedIndex) {
              _moreRegionAppointments.add(currentView.appointment!);
            }
          }
        }
      }

      /// Check the tap position inside the last appointment rendering position
      /// when the panel as collapsed and it does not position does not have
      /// appointment.
      /// Eg., If July 8 have 3 all day appointments spanned to July 9 and
      /// July 9 have 1 all day appointment spanned to July 10 then July 10
      /// appointment view does not shown and it only have count label.
      /// If user tap on count label then the panel does not have appointment
      /// view, because the view rendered after the end position, so calculate
      /// the visible date cell appointment and it have appointments after
      /// end position then perform expand operation.
      if (appointmentView == null &&
          selectedDate != null &&
          _updateCalendarStateDetails.allDayPanelHeight > allDayHeight &&
          yPosition > allDayHeight - kAllDayAppointmentHeight) {
        final int currentSelectedIndex = DateTimeHelper.getVisibleDateIndex(
            widget.visibleDates, selectedDate);
        if (currentSelectedIndex != -1) {
          _moreRegionAppointments = <CalendarAppointment>[];
          final List<AppointmentView> selectedIndexAppointment =
          <AppointmentView>[];
          for (int i = 0;
          i <
              _updateCalendarStateDetails
                  .allDayAppointmentViewCollection.length;
          i++) {
            final AppointmentView currentView =
            _updateCalendarStateDetails.allDayAppointmentViewCollection[i];
            if (currentView.appointment == null) {
              continue;
            }

            if (currentView.startIndex <= currentSelectedIndex &&
                currentView.endIndex > currentSelectedIndex) {
              selectedIndexAppointment.add(currentView);
              _moreRegionAppointments.add(currentView.appointment!);
            }
          }

          int maxPosition = 0;
          if (selectedIndexAppointment.isNotEmpty) {
            maxPosition = selectedIndexAppointment
                .reduce((AppointmentView currentAppView,
                AppointmentView nextAppView) =>
            currentAppView.maxPositions > nextAppView.maxPositions
                ? currentAppView
                : nextAppView)
                .maxPositions;
          }
          final int endAppointmentPosition =
              allDayHeight ~/ kAllDayAppointmentHeight;
          if (endAppointmentPosition < maxPosition) {
            isTappedOnCount = true;
          }
        }
      }

      if (appointmentView != null &&
          (yPosition < allDayHeight - kAllDayAppointmentHeight ||
              _updateCalendarStateDetails.allDayPanelHeight <= allDayHeight ||
              appointmentView.position + 1 >= appointmentView.maxPositions)) {
        final List<dynamic> appointmentDetails = <dynamic>[
          CalendarViewHelper.getAppointmentDetail(
              appointmentView.appointment!, widget.calendar.dataSource)
        ];

        /// Return calendar details while the [getCalendarDetailsAtOffset]
        /// position placed on appointments in day, week and workweek view.
        return CalendarDetails(
            appointmentDetails, null, CalendarElement.appointment, null);
      } else if (isTappedOnCount) {
        /// Return calendar details while the [getCalendarDetailsAtOffset]
        /// position placed on more appointment region in day, week and workweek
        /// view.
        return CalendarDetails(
            widget.calendar.dataSource != null &&
                !AppointmentHelper.isCalendarAppointment(
                    widget.calendar.dataSource!)
                ? CalendarViewHelper.getCustomAppointments(
                _moreRegionAppointments, widget.calendar.dataSource)
                : _moreRegionAppointments,
            selectedDate,
            CalendarElement.moreAppointmentRegion,
            null);
      } else if (appointmentView == null) {
        /// Return calendar details while the [getCalendarDetailsAtOffset]
        /// position placed on all day panel in day, week and work week view.
        return CalendarDetails(
            null, selectedDate, CalendarElement.allDayPanel, null);
      }

      return null;
    }

    double yPosition =
        yDetails - viewHeaderHeight - allDayHeight + _scrollController!.offset;
    final AppointmentView? appointmentView =
    _appointmentLayout.getAppointmentViewOnPoint(xDetails, yPosition);

    if (appointmentView == null) {
      /// Remove the scroll position for internally handles the scroll position
      /// in _getDateFromPosition method
      yPosition = yPosition - _scrollController!.offset;
      final DateTime? selectedDate = _getDateFromPosition(
          !_isRTL ? xDetails - timeLabelWidth : xDetails,
          yPosition,
          timeLabelWidth);

      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on calendar cell in day, week and work week view.
      return CalendarDetails(
          null, selectedDate, CalendarElement.calendarCell, null);
    } else {
      final List<dynamic> appointmentDetails = <dynamic>[
        CalendarViewHelper.getAppointmentDetail(
            appointmentView.appointment!, widget.calendar.dataSource)
      ];

      /// Return calendar details while the [getCalendarDetailsAtOffset]
      /// position placed on appointments in day, week and work week view.
      return CalendarDetails(
          appointmentDetails, null, CalendarElement.appointment, null);
    }
  }

  /// Handles the tap and long press related functions for day, week
  /// work week views.
  AppointmentView? _handleTouchOnDayView(
      TapUpDetails? tapDetails, LongPressStartDetails? longPressDetails) {
    widget.removePicker();
    final DateTime? previousSelectedDate = _selectionPainter!.selectedDate;
    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);
    double xDetails = 0, yDetails = 0;
    bool isTappedCallback = false;
    if (tapDetails != null) {
      isTappedCallback = true;
      xDetails = tapDetails.localPosition.dx;
      yDetails = tapDetails.localPosition.dy;
    } else if (longPressDetails != null) {
      xDetails = longPressDetails.localPosition.dx;
      yDetails = longPressDetails.localPosition.dy;
    }
    if (!widget.focusNode.hasFocus) {
      widget.focusNode.requestFocus();
    }

    widget.getCalendarState(_updateCalendarStateDetails);
    AppointmentView? selectedAppointmentView;
    dynamic selectedAppointment;
    List<dynamic>? selectedAppointments;
    CalendarElement targetElement = CalendarElement.viewHeader;
    DateTime? selectedDate = _updateCalendarStateDetails.selectedDate;
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);

    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double allDayHeight = _isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : _allDayHeight;
    if (!_isRTL &&
        xDetails <= timeLabelWidth &&
        yDetails > viewHeaderHeight + allDayHeight) {
      return null;
    }

    if (_isRTL &&
        xDetails >= widget.width - timeLabelWidth &&
        yDetails > viewHeaderHeight + allDayHeight) {
      return null;
    }

    if (yDetails < viewHeaderHeight) {
      /// Check the touch position in time ruler view
      /// If RTL, time ruler placed at right side,
      /// else time ruler placed at left side.
      if ((!_isRTL && xDetails <= timeLabelWidth) ||
          (_isRTL && widget.width - xDetails <= timeLabelWidth)) {
        return null;
      }

      if (isTappedCallback) {
        _handleOnTapForViewHeader(tapDetails!, widget.width);
      } else if (!isTappedCallback) {
        _handleOnLongPressForViewHeader(longPressDetails!, widget.width);
      }

      return null;
    } else if (yDetails < viewHeaderHeight + allDayHeight) {
      /// Check the touch position in view header when [CalendarView] is day
      /// If RTL, view header placed at right side,
      /// else view header placed at left side.
      if (widget.view == CalendarView.day &&
          ((!_isRTL && xDetails <= timeLabelWidth) ||
              (_isRTL && widget.width - xDetails <= timeLabelWidth)) &&
          yDetails <
              CalendarViewHelper.getViewHeaderHeight(
                  widget.calendar.viewHeaderHeight, widget.view)) {
        if (isTappedCallback) {
          _handleOnTapForViewHeader(tapDetails!, widget.width);
        } else if (!isTappedCallback) {
          _handleOnLongPressForViewHeader(longPressDetails!, widget.width);
        }

        return null;
      } else if ((!_isRTL && timeLabelWidth >= xDetails) ||
          (_isRTL && xDetails > widget.width - timeLabelWidth)) {
        /// Perform expand or collapse when the touch position on
        /// expander icon in all day panel.
        _expandOrCollapseAllDay();
        return null;
      }

      final double yPosition = yDetails - viewHeaderHeight;
      final AppointmentView? appointmentView = _getAllDayAppointmentOnPoint(
          _updateCalendarStateDetails.allDayAppointmentViewCollection,
          xDetails,
          yPosition);

      if (appointmentView == null) {
        targetElement = CalendarElement.allDayPanel;
        if (isTappedCallback) {
          selectedDate =
              _getTappedViewHeaderDate(tapDetails!.localPosition, widget.width);
        } else {
          selectedDate = _getTappedViewHeaderDate(
              longPressDetails!.localPosition, widget.width);
        }
      }

      /// Check the count position tapped or not
      bool isTappedOnCount = appointmentView != null &&
          _updateCalendarStateDetails.allDayPanelHeight > allDayHeight &&
          yPosition > allDayHeight - kAllDayAppointmentHeight;

      /// Check the tap position inside the last appointment rendering position
      /// when the panel as collapsed and it does not position does not have
      /// appointment.
      /// Eg., If July 8 have 3 all day appointments spanned to July 9 and
      /// July 9 have 1 all day appointment spanned to July 10 then July 10
      /// appointment view does not shown and it only have count label.
      /// If user tap on count label then the panel does not have appointment
      /// view, because the view rendered after the end position, so calculate
      /// the visible date cell appointment and it have appointments after
      /// end position then perform expand operation.
      if (appointmentView == null &&
          selectedDate != null &&
          _updateCalendarStateDetails.allDayPanelHeight > allDayHeight &&
          yPosition > allDayHeight - kAllDayAppointmentHeight) {
        final int currentSelectedIndex = DateTimeHelper.getVisibleDateIndex(
            widget.visibleDates, selectedDate);
        if (currentSelectedIndex != -1) {
          final List<AppointmentView> selectedIndexAppointment =
          <AppointmentView>[];
          for (int i = 0;
          i <
              _updateCalendarStateDetails
                  .allDayAppointmentViewCollection.length;
          i++) {
            final AppointmentView currentView =
            _updateCalendarStateDetails.allDayAppointmentViewCollection[i];
            if (currentView.appointment == null) {
              continue;
            }
            if (currentView.startIndex <= currentSelectedIndex &&
                currentView.endIndex > currentSelectedIndex) {
              selectedIndexAppointment.add(currentView);
            }
          }

          int maxPosition = 0;
          if (selectedIndexAppointment.isNotEmpty) {
            maxPosition = selectedIndexAppointment
                .reduce((AppointmentView currentAppView,
                AppointmentView nextAppView) =>
            currentAppView.maxPositions > nextAppView.maxPositions
                ? currentAppView
                : nextAppView)
                .maxPositions;
          }
          final int endAppointmentPosition =
              allDayHeight ~/ kAllDayAppointmentHeight;
          if (endAppointmentPosition < maxPosition) {
            isTappedOnCount = true;
          }
        }
      }

      if (appointmentView != null &&
          (yPosition < allDayHeight - kAllDayAppointmentHeight ||
              _updateCalendarStateDetails.allDayPanelHeight <= allDayHeight ||
              appointmentView.position + 1 >= appointmentView.maxPositions)) {
        if (!CalendarViewHelper.isDateTimeWithInDateTimeRange(
            widget.calendar.minDate,
            widget.calendar.maxDate,
            appointmentView.appointment!.actualStartTime,
            timeInterval) ||
            !CalendarViewHelper.isDateTimeWithInDateTimeRange(
                widget.calendar.minDate,
                widget.calendar.maxDate,
                appointmentView.appointment!.actualEndTime,
                timeInterval)) {
          return null;
        }
        if (selectedDate != null) {
          selectedDate = null;
          _selectionPainter!.selectedDate = selectedDate;
          _updateCalendarStateDetails.selectedDate = selectedDate;
        }

        _selectionPainter!.appointmentView = null;
        _selectionNotifier.value = !_selectionNotifier.value;
        selectedAppointment = appointmentView.appointment;
        selectedAppointments = null;
        targetElement = CalendarElement.appointment;
        _updateAllDaySelection(appointmentView, null);
      } else if (isTappedOnCount) {
        _expandOrCollapseAllDay();
        return null;
      } else if (appointmentView == null) {
        _updateAllDaySelection(null, selectedDate);
        _selectionPainter!.selectedDate = null;
        _selectionPainter!.appointmentView = null;
        _selectionNotifier.value = !_selectionNotifier.value;
        _updateCalendarStateDetails.selectedDate = null;
      }

      selectedAppointmentView = appointmentView;
    } else {
      final double yPosition = yDetails -
          viewHeaderHeight -
          allDayHeight +
          _scrollController!.offset;
      final AppointmentView? appointmentView =
      _appointmentLayout.getAppointmentViewOnPoint(xDetails, yPosition);
      _allDaySelectionNotifier.value = null;
      if (appointmentView == null) {
        if (_isRTL) {
          _drawSelection(xDetails, yDetails - viewHeaderHeight - allDayHeight,
              timeLabelWidth);
        } else {
          _drawSelection(xDetails - timeLabelWidth,
              yDetails - viewHeaderHeight - allDayHeight, timeLabelWidth);
        }
        targetElement = CalendarElement.calendarCell;
      } else {
        if (selectedDate != null) {
          selectedDate = null;
          _selectionPainter!.selectedDate = selectedDate;
          _updateCalendarStateDetails.selectedDate = selectedDate;
        }

        _selectionPainter!.appointmentView = appointmentView;
        _selectionNotifier.value = !_selectionNotifier.value;
        selectedAppointmentView = appointmentView;
        selectedAppointment = appointmentView.appointment;
        targetElement = CalendarElement.appointment;
      }
    }

    widget.updateCalendarState(_updateCalendarStateDetails);
    final bool canRaiseTap = CalendarViewHelper.shouldRaiseCalendarTapCallback(
        widget.calendar.onTap) &&
        isTappedCallback;
    final bool canRaiseLongPress =
        CalendarViewHelper.shouldRaiseCalendarLongPressCallback(
            widget.calendar.onLongPress) &&
            !isTappedCallback;
    final bool canRaiseSelectionChanged =
    CalendarViewHelper.shouldRaiseCalendarSelectionChangedCallback(
        widget.calendar.onSelectionChanged);
    if (canRaiseLongPress || canRaiseTap || canRaiseSelectionChanged) {
      final double yPosition = yDetails - viewHeaderHeight - allDayHeight;
      if (_selectionPainter!.selectedDate != null &&
          targetElement != CalendarElement.allDayPanel) {
        selectedAppointments = null;

        /// In LTR, remove the time ruler width value from the
        /// touch x position while calculate the selected date value.
        selectedDate = _getDateFromPosition(
            !_isRTL ? xDetails - timeLabelWidth : xDetails,
            yPosition,
            timeLabelWidth);

        if (!CalendarViewHelper.isDateTimeWithInDateTimeRange(
            widget.calendar.minDate,
            widget.calendar.maxDate,
            selectedDate!,
            timeInterval)) {
          return null;
        }

        /// Restrict the callback, while selected region as disabled
        /// [TimeRegion].
        if (targetElement == CalendarElement.calendarCell &&
            !_isEnabledRegion(
                yPosition, selectedDate, _selectedResourceIndex)) {
          return null;
        }

        if (canRaiseTap) {
          CalendarViewHelper.raiseCalendarTapCallback(
              widget.calendar,
              _selectionPainter!.selectedDate,
              selectedAppointments,
              targetElement,
              null);
        } else if (canRaiseLongPress) {
          CalendarViewHelper.raiseCalendarLongPressCallback(
              widget.calendar,
              _selectionPainter!.selectedDate,
              selectedAppointments,
              targetElement,
              null);
        }
        _updatedSelectionChangedCallback(
            canRaiseSelectionChanged, previousSelectedDate);
      } else if (selectedAppointment != null) {
        selectedAppointments = <dynamic>[
          CalendarViewHelper.getAppointmentDetail(
              selectedAppointment, widget.calendar.dataSource)
        ];

        /// In LTR, remove the time ruler width value from the
        /// touch x position while calculate the selected date value.
        selectedDate = _getDateFromPosition(
            !_isRTL ? xDetails - timeLabelWidth : xDetails,
            yPosition,
            timeLabelWidth);

        if (canRaiseTap) {
          CalendarViewHelper.raiseCalendarTapCallback(
              widget.calendar,
              selectedDate,
              selectedAppointments,
              CalendarElement.appointment,
              null);
        } else if (canRaiseLongPress) {
          CalendarViewHelper.raiseCalendarLongPressCallback(
              widget.calendar,
              selectedDate,
              selectedAppointments,
              CalendarElement.appointment,
              null);
        }
        _updatedSelectionChangedCallback(
            canRaiseSelectionChanged, previousSelectedDate);
      } else if (selectedDate != null &&
          targetElement == CalendarElement.allDayPanel) {
        if (canRaiseTap) {
          CalendarViewHelper.raiseCalendarTapCallback(
              widget.calendar, selectedDate, null, targetElement, null);
        } else if (canRaiseLongPress) {
          CalendarViewHelper.raiseCalendarLongPressCallback(
              widget.calendar, selectedDate, null, targetElement, null);
        }
        _updatedSelectionChangedCallback(
            canRaiseSelectionChanged, previousSelectedDate);
      }
    }

    return selectedAppointmentView;
  }

  /// Check the selected date region as enabled time region or not.
  bool _isEnabledRegion(double y, DateTime? selectedDate, int resourceIndex) {
    if (widget.regions == null ||
        widget.regions!.isEmpty ||
        widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth ||
        selectedDate == null) {
      return true;
    }

    final double timeIntervalSize = _getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        widget.visibleDates.length,
        _allDayHeight,
        widget.isMobilePlatform);

    final double minuteHeight = timeIntervalSize /
        CalendarViewHelper.getTimeInterval(
            widget.calendar.timeSlotViewSettings);
    final Duration startDuration = Duration(
        hours: widget.calendar.timeSlotViewSettings.startHour.toInt(),
        minutes: ((widget.calendar.timeSlotViewSettings.startHour -
            widget.calendar.timeSlotViewSettings.startHour.toInt()) *
            60)
            .toInt());
    int minutes;
    if (CalendarViewHelper.isTimelineView(widget.view)) {
      final double viewWidth = _timeIntervalHeight * _horizontalLinesCount!;
      if (_isRTL) {
        minutes = ((_scrollController!.offset +
            (_scrollController!.position.viewportDimension - y)) %
            viewWidth) ~/
            minuteHeight;
      } else {
        minutes = ((_scrollController!.offset + y) % viewWidth) ~/ minuteHeight;
      }
    } else {
      minutes = (_scrollController!.offset + y) ~/ minuteHeight;
    }

    final DateTime date = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, 0, minutes + startDuration.inMinutes, 0);
    bool isValidRegion = true;
    final bool isResourcesEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);
    for (int i = 0; i < widget.regions!.length; i++) {
      final CalendarTimeRegion region = widget.regions![i];
      if (region.actualStartTime.isAfter(date) ||
          region.actualEndTime.isBefore(date)) {
        continue;
      }

      /// Condition added ensure that the region is disabled only on the
      /// specified resource slot, for other resources it must be enabled.
      if (isResourcesEnabled &&
          resourceIndex != -1 &&
          region.resourceIds != null &&
          region.resourceIds!.isNotEmpty &&
          !region.resourceIds!
              .contains(widget.resourceCollection![resourceIndex].id)) {
        continue;
      }

      isValidRegion = region.enablePointerInteraction;
    }

    return isValidRegion;
  }

  bool _isAutoTimeIntervalHeight(SfCalendar calendar, bool isTimelineView) {
    if (isTimelineView) {
      return calendar.timeSlotViewSettings.timeIntervalWidth == -1;
    }

    return calendar.timeSlotViewSettings.timeIntervalHeight == -1;
  }

  /// Returns the default time interval width for timeline views.
  double _getTimeIntervalWidth(double timeIntervalHeight, CalendarView view,
      double width, bool isMobilePlatform) {
    if (timeIntervalHeight >= 0) {
      return timeIntervalHeight;
    }

    if (view == CalendarView.timelineMonth &&
        !CalendarViewHelper.isMobileLayoutUI(width, isMobilePlatform)) {
      return 160;
    }

    return 60;
  }

  /// Returns the time interval width based on property value, also arrange the
  /// time slots into the view port size.
  double _getTimeIntervalHeight(
      SfCalendar calendar,
      CalendarView view,
      double width,
      double height,
      int visibleDatesCount,
      double allDayHeight,
      bool isMobilePlatform) {
    double newAllDayHeight = allDayHeight;
    final bool isTimelineView = CalendarViewHelper.isTimelineView(view);
    double timeIntervalHeight = isTimelineView
        ? _getTimeIntervalWidth(calendar.timeSlotViewSettings.timeIntervalWidth,
        view, width, isMobilePlatform)
        : calendar.timeSlotViewSettings.timeIntervalHeight;

    if (!_isAutoTimeIntervalHeight(calendar, isTimelineView)) {
      return timeIntervalHeight;
    }

    double viewHeaderHeight =
    CalendarViewHelper.getViewHeaderHeight(calendar.viewHeaderHeight, view);

    if (view == CalendarView.day) {
      newAllDayHeight = _kAllDayLayoutHeight;
      viewHeaderHeight = 0;
    } else {
      newAllDayHeight = newAllDayHeight > _kAllDayLayoutHeight
          ? _kAllDayLayoutHeight
          : newAllDayHeight;
    }

    switch (view) {
      case CalendarView.day:
      case CalendarView.week:
      case CalendarView.workWeek:
        timeIntervalHeight = (height - newAllDayHeight - viewHeaderHeight) /
            CalendarViewHelper.getHorizontalLinesCount(
                calendar.timeSlotViewSettings, view);
        break;
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
      case CalendarView.timelineMonth:
        {
          final double _horizontalLinesCount =
          CalendarViewHelper.getHorizontalLinesCount(
              calendar.timeSlotViewSettings, view);
          timeIntervalHeight =
              width / (_horizontalLinesCount * visibleDatesCount);
          if (!_isValidWidth(
              width, calendar, visibleDatesCount, _horizontalLinesCount)) {
            /// we have used 40 as a default time interval height for timeline
            /// view when the time interval height set for auto time
            /// interval height.
            timeIntervalHeight = 40;
          }
        }
        break;
      case CalendarView.schedule:
      case CalendarView.month:
        return 0;
    }

    return timeIntervalHeight;
  }

  /// checks whether the width can afford the line count or else creates a
  /// scrollable width
  bool _isValidWidth(double screenWidth, SfCalendar calendar,
      int visibleDatesCount, double horizontalLinesCount) {
    const int offSetValue = 10;
    final double tempWidth =
        visibleDatesCount * offSetValue * horizontalLinesCount;

    if (tempWidth < screenWidth) {
      return true;
    }

    return false;
  }

  //// Handles the on tap callback for view header
  void _handleOnTapForViewHeader(TapUpDetails details, double width) {
    final DateTime tappedDate =
    _getTappedViewHeaderDate(details.localPosition, width)!;
    _handleViewHeaderTapNavigation(tappedDate);
    if (!CalendarViewHelper.shouldRaiseCalendarTapCallback(
        widget.calendar.onTap)) {
      return;
    }

    CalendarViewHelper.raiseCalendarTapCallback(
        widget.calendar, tappedDate, null, CalendarElement.viewHeader, null);
  }

  //// Handles the on long press callback for view header
  void _handleOnLongPressForViewHeader(
      LongPressStartDetails details, double width) {
    final DateTime tappedDate =
    _getTappedViewHeaderDate(details.localPosition, width)!;
    _handleViewHeaderTapNavigation(tappedDate);
    if (!CalendarViewHelper.shouldRaiseCalendarLongPressCallback(
        widget.calendar.onLongPress)) {
      return;
    }

    CalendarViewHelper.raiseCalendarLongPressCallback(
        widget.calendar, tappedDate, null, CalendarElement.viewHeader, null);
  }

  void _handleViewHeaderTapNavigation(DateTime date) {
    if (!widget.allowViewNavigation ||
        widget.view == CalendarView.day ||
        widget.view == CalendarView.timelineDay ||
        widget.view == CalendarView.month) {
      return;
    }

    if (!isDateWithInDateRange(
        widget.calendar.minDate, widget.calendar.maxDate, date) ||
        (widget.controller.view == CalendarView.timelineMonth &&
            CalendarViewHelper.isDateInDateCollection(
                widget.blackoutDates, date))) {
      return;
    }

    if (widget.view == CalendarView.week ||
        widget.view == CalendarView.workWeek) {
      widget.controller.view = CalendarView.day;
    } else {
      widget.controller.view = CalendarView.timelineDay;
    }

    widget.controller.displayDate = date;
  }

  DateTime? _getTappedViewHeaderDate(Offset localPosition, double width) {
    int index = 0;
    final double timeLabelViewWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    final int visibleDatesLength = widget.visibleDates.length;
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      double cellWidth = 0;
      if (widget.view != CalendarView.month) {
        cellWidth = (width - timeLabelViewWidth) / visibleDatesLength;

        /// Set index value as 0 when calendar view as day because day view hold
        /// single visible date.
        if (widget.view == CalendarView.day) {
          index = 0;
        } else {
          index = ((localPosition.dx - (_isRTL ? 0 : timeLabelViewWidth)) /
              cellWidth)
              .truncate();
        }
      } else {
        cellWidth = width / DateTime.daysPerWeek;
        index = (localPosition.dx / cellWidth).truncate();
      }

      /// Calculate the RTL based value of index when the widget direction as
      /// RTL.
      if (_isRTL && widget.view != CalendarView.month) {
        index = visibleDatesLength - index - 1;
      } else if (_isRTL && widget.view == CalendarView.month) {
        index = DateTime.daysPerWeek - index - 1;
      }

      if (index < 0 || index >= visibleDatesLength) {
        return null;
      }

      return widget.visibleDates[index];
    } else {
      index = ((_scrollController!.offset +
          (_isRTL
              ? _scrollController!.position.viewportDimension -
              localPosition.dx
              : localPosition.dx)) /
          _getSingleViewWidthForTimeLineView(this))
          .truncate();

      if (index < 0 || index >= visibleDatesLength) {
        return null;
      }

      return widget.visibleDates[index];
    }
  }

  void _updateHoveringForAppointment(double xPosition, double yPosition) {
    if (_viewHeaderNotifier.value != null) {
      _viewHeaderNotifier.value = null;
    }

    if (_calendarCellNotifier.value != null) {
      _calendarCellNotifier.value = null;
    }

    if (_allDayNotifier.value != null) {
      _allDayNotifier.value = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    if (_hoveringDate != null) {
      _hoveringDate = null;
    }

    _appointmentHoverNotifier.value = Offset(xPosition, yPosition);
  }

  void _updateHoveringForAllDayPanel(double xPosition, double yPosition) {
    if (_viewHeaderNotifier.value != null) {
      _viewHeaderNotifier.value = null;
    }

    if (_calendarCellNotifier.value != null) {
      _hoveringDate = null;
      _calendarCellNotifier.value = null;
    }

    if (_appointmentHoverNotifier.value != null) {
      _appointmentHoverNotifier.value = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    if (_hoveringDate != null) {
      _hoveringDate = null;
    }

    _allDayNotifier.value = Offset(xPosition, yPosition);
  }

  /// Removes the view header hovering in multiple occasions, when the pointer
  /// hovering the disabled or blackout dates, and when the pointer moves out
  /// of the view header.
  void _removeViewHeaderHovering() {
    if (_hoveringDate != null) {
      _hoveringDate = null;
    }

    if (_viewHeaderNotifier.value != null) {
      _viewHeaderNotifier.value = null;
    }
  }

  void _removeAllWidgetHovering() {
    if (_hoveringDate != null) {
      _hoveringDate = null;
    }

    if (_viewHeaderNotifier.value != null) {
      _viewHeaderNotifier.value = null;
    }

    if (_calendarCellNotifier.value != null) {
      _hoveringDate = null;
      _calendarCellNotifier.value = null;
    }

    if (_allDayNotifier.value != null) {
      _allDayNotifier.value = null;
      _hoveringAppointmentView = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    if (_appointmentHoverNotifier.value != null) {
      _appointmentHoverNotifier.value = null;
      _hoveringAppointmentView = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }
  }

  void _updateHoveringForViewHeader(Offset localPosition, double xPosition,
      double yPosition, double viewHeaderHeight) {
    if (widget.calendar.onTap == null && widget.calendar.onLongPress == null) {
      final bool isViewNavigationEnabled =
          widget.calendar.allowViewNavigation &&
              widget.view != CalendarView.month &&
              widget.view != CalendarView.day &&
              widget.view != CalendarView.timelineDay;
      if (!isViewNavigationEnabled) {
        _removeAllWidgetHovering();
        return;
      }
    }

    if (yPosition < 0) {
      if (_hoveringDate != null) {
        _hoveringDate = null;
      }

      if (_viewHeaderNotifier.value != null) {
        _viewHeaderNotifier.value = null;
      }

      if (_calendarCellNotifier.value != null) {
        _calendarCellNotifier.value = null;
      }

      if (_allDayNotifier.value != null) {
        _allDayNotifier.value = null;
        _hoveringAppointmentView = null;
        if (_mouseCursor != SystemMouseCursors.basic) {
          setState(() {
            _mouseCursor = SystemMouseCursors.basic;
          });
        }
      }

      if (_appointmentHoverNotifier.value != null) {
        _appointmentHoverNotifier.value = null;
        _hoveringAppointmentView = null;
        if (_mouseCursor != SystemMouseCursors.basic) {
          setState(() {
            _mouseCursor = SystemMouseCursors.basic;
          });
        }
      }
    }

    final DateTime? hoverDate = _getTappedViewHeaderDate(
        Offset(
            CalendarViewHelper.isTimelineView(widget.view)
                ? localPosition.dx
                : xPosition,
            yPosition),
        widget.width);

    // Remove the hovering when the position not in cell regions.
    if (hoverDate == null) {
      _removeViewHeaderHovering();

      return;
    }

    if (!isDateWithInDateRange(
        widget.calendar.minDate, widget.calendar.maxDate, hoverDate)) {
      _removeViewHeaderHovering();

      return;
    }

    if (widget.view == CalendarView.timelineMonth &&
        CalendarViewHelper.isDateInDateCollection(
            widget.blackoutDates, hoverDate)) {
      _removeViewHeaderHovering();

      return;
    }

    _hoveringDate = hoverDate;

    if (_calendarCellNotifier.value != null) {
      _calendarCellNotifier.value = null;
    }

    if (_allDayNotifier.value != null) {
      _allDayNotifier.value = null;
      _hoveringAppointmentView = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    if (_appointmentHoverNotifier.value != null) {
      _appointmentHoverNotifier.value = null;
      _hoveringAppointmentView = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    _viewHeaderNotifier.value = Offset(xPosition, yPosition);
  }

  void _updateDraggingMouseCursor(bool isDragging) {
    if (_mouseCursor != SystemMouseCursors.move && isDragging) {
      setState(() {
        _mouseCursor = SystemMouseCursors.move;
      });
    } else if (!isDragging && _mouseCursor != SystemMouseCursors.basic) {
      setState(() {
        _mouseCursor = SystemMouseCursors.basic;
      });
    }
  }

  void _updateDisabledCellMouseCursor(bool isDisabled) {
    if (isDisabled && _mouseCursor != SystemMouseCursors.noDrop) {
      setState(() {
        _mouseCursor = SystemMouseCursors.noDrop;
      });
    } else if (!isDisabled && _mouseCursor == SystemMouseCursors.noDrop) {
      setState(() {
        _mouseCursor = SystemMouseCursors.move;
      });
    }
  }

  void _updateMouseCursorForAppointment(AppointmentView? appointmentView,
      double xPosition, double yPosition, bool isTimelineViews,
      {bool isAllDayPanel = false}) {
    _hoveringAppointmentView = appointmentView;
    if (!widget.calendar.allowAppointmentResize ||
        (widget.view == CalendarView.month &&
            widget.calendar.monthViewSettings.appointmentDisplayMode !=
                MonthAppointmentDisplayMode.appointment)) {
      return;
    }

    if (appointmentView == null || appointmentView.appointment == null) {
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }

      return;
    }

    const double padding = 5;

    if (isAllDayPanel ||
        (widget.view == CalendarView.month || isTimelineViews)) {
      final bool isMonthView = widget.view == CalendarView.month ||
          widget.view == CalendarView.timelineMonth;
      final DateTime viewStartDate =
      AppointmentHelper.convertToStartTime(widget.visibleDates[0]);
      final DateTime viewEndDate = AppointmentHelper.convertToEndTime(
          widget.visibleDates[widget.visibleDates.length - 1]);
      final DateTime appStartTime = appointmentView.appointment!.exactStartTime;
      final DateTime appEndTime = appointmentView.appointment!.exactEndTime;

      final bool canAddForwardSpanIcon =
      AppointmentHelper.canAddForwardSpanIcon(
          appStartTime, appEndTime, viewStartDate, viewEndDate);
      final bool canAddBackwardSpanIcon =
      AppointmentHelper.canAddBackwardSpanIcon(
          appStartTime, appEndTime, viewStartDate, viewEndDate);

      final DateTime appointmentStartTime =
      appointmentView.appointment!.isAllDay
          ? AppointmentHelper.convertToStartTime(
          appointmentView.appointment!.actualStartTime)
          : appointmentView.appointment!.actualStartTime;
      final DateTime appointmentEndTime = appointmentView.appointment!.isAllDay
          ? AppointmentHelper.convertToEndTime(
          appointmentView.appointment!.actualEndTime)
          : appointmentView.appointment!.actualEndTime;
      final DateTime appointmentExactStartTime =
      appointmentView.appointment!.isAllDay
          ? AppointmentHelper.convertToStartTime(
          appointmentView.appointment!.exactStartTime)
          : appointmentView.appointment!.exactStartTime;
      final DateTime appointmentExactEndTime =
      appointmentView.appointment!.isAllDay
          ? AppointmentHelper.convertToEndTime(
          appointmentView.appointment!.exactEndTime)
          : appointmentView.appointment!.exactEndTime;

      if (xPosition >= appointmentView.appointmentRect!.left &&
          xPosition <= appointmentView.appointmentRect!.left + padding &&
          ((isMonthView &&
              isSameDate(
                  _isRTL ? appointmentEndTime : appointmentStartTime,
                  _isRTL
                      ? appointmentExactEndTime
                      : appointmentExactStartTime)) ||
              (!isMonthView &&
                  CalendarViewHelper.isSameTimeSlot(
                      _isRTL ? appointmentEndTime : appointmentStartTime,
                      _isRTL
                          ? appointmentExactEndTime
                          : appointmentExactStartTime))) &&
          ((_isRTL && !canAddForwardSpanIcon) ||
              (!_isRTL && !canAddBackwardSpanIcon))) {
        setState(() {
          _mouseCursor = SystemMouseCursors.resizeLeft;
        });
      } else if (xPosition <= appointmentView.appointmentRect!.right &&
          xPosition >= appointmentView.appointmentRect!.right - padding &&
          ((isMonthView &&
              isSameDate(
                  _isRTL ? appointmentStartTime : appointmentEndTime,
                  _isRTL
                      ? appointmentExactStartTime
                      : appointmentExactEndTime)) ||
              (!isMonthView &&
                  CalendarViewHelper.isSameTimeSlot(
                      _isRTL ? appointmentStartTime : appointmentEndTime,
                      _isRTL
                          ? appointmentExactStartTime
                          : appointmentExactEndTime))) &&
          ((_isRTL && !canAddBackwardSpanIcon) ||
              (!_isRTL && !canAddForwardSpanIcon))) {
        setState(() {
          _mouseCursor = SystemMouseCursors.resizeRight;
        });
      } else if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    } else {
      if (yPosition >= appointmentView.appointmentRect!.top &&
          yPosition <= appointmentView.appointmentRect!.top + padding &&
          CalendarViewHelper.isSameTimeSlot(
              appointmentView.appointment!.actualStartTime,
              appointmentView.appointment!.exactStartTime)) {
        setState(() {
          _mouseCursor = SystemMouseCursors.resizeUp;
        });
      } else if (yPosition <= appointmentView.appointmentRect!.bottom &&
          yPosition >= appointmentView.appointmentRect!.bottom - padding &&
          CalendarViewHelper.isSameTimeSlot(
              appointmentView.appointment!.actualEndTime,
              appointmentView.appointment!.exactEndTime)) {
        setState(() {
          _mouseCursor = SystemMouseCursors.resizeDown;
        });
      } else if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }
  }

  void _updatePointerHover(Offset globalPosition) {
    if (widget.isMobilePlatform ||
        _resizingDetails.value.appointmentView != null ||
        widget.dragDetails.value.appointmentView != null &&
            widget.calendar.appointmentBuilder == null) {
      return;
    }

    // ignore: avoid_as
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset localPosition = box.globalToLocal(globalPosition);
    double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
        widget.calendar.viewHeaderHeight, widget.view);
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        widget.calendar.timeSlotViewSettings.timeRulerSize, widget.view);
    double allDayHeight = _isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : _allDayHeight;

    /// All day panel and view header are arranged horizontally,
    /// so get the maximum value from all day height and view header height and
    /// use the value instead of adding of view header height and all day
    /// height.
    if (widget.view == CalendarView.day) {
      if (allDayHeight > viewHeaderHeight) {
        viewHeaderHeight = allDayHeight;
      }

      allDayHeight = 0;
    }

    double xPosition;
    double yPosition;
    final bool isTimelineViews = CalendarViewHelper.isTimelineView(widget.view);
    if (widget.view != CalendarView.month && !isTimelineViews) {
      /// In LTR, remove the time ruler width value from the
      /// touch x position while calculate the selected date from position.
      xPosition = _isRTL ? localPosition.dx : localPosition.dx - timeLabelWidth;

      if (localPosition.dy < viewHeaderHeight) {
        if (widget.view == CalendarView.day) {
          if ((_isRTL && localPosition.dx < widget.width - timeLabelWidth) ||
              (!_isRTL && localPosition.dx > timeLabelWidth)) {
            _updateHoveringForAllDayPanel(localPosition.dx, localPosition.dy);

            final AppointmentView? appointment = _getAllDayAppointmentOnPoint(
                _updateCalendarStateDetails.allDayAppointmentViewCollection,
                localPosition.dx,
                localPosition.dy);
            _updateMouseCursorForAppointment(appointment, localPosition.dx,
                localPosition.dy, isTimelineViews,
                isAllDayPanel: true);
            return;
          }

          _updateHoveringForViewHeader(
              localPosition,
              _isRTL ? widget.width - localPosition.dx : localPosition.dx,
              localPosition.dy,
              viewHeaderHeight);
          return;
        }

        _updateHoveringForViewHeader(localPosition, localPosition.dx,
            localPosition.dy, viewHeaderHeight);
        return;
      }

      double panelHeight =
          _updateCalendarStateDetails.allDayPanelHeight - _allDayHeight;
      if (panelHeight < 0) {
        panelHeight = 0;
      }

      final double allDayExpanderHeight =
          panelHeight * _allDayExpanderAnimation!.value;
      final double allDayBottom = widget.view == CalendarView.day
          ? viewHeaderHeight
          : viewHeaderHeight + _allDayHeight + allDayExpanderHeight;
      if (localPosition.dy > viewHeaderHeight &&
          localPosition.dy < allDayBottom) {
        if ((_isRTL && localPosition.dx < widget.width - timeLabelWidth) ||
            (!_isRTL && localPosition.dx > timeLabelWidth)) {
          _updateHoveringForAllDayPanel(
              localPosition.dx, localPosition.dy - viewHeaderHeight);
          final AppointmentView? appointment = _getAllDayAppointmentOnPoint(
              _updateCalendarStateDetails.allDayAppointmentViewCollection,
              localPosition.dx,
              localPosition.dy - viewHeaderHeight);
          _updateMouseCursorForAppointment(appointment, localPosition.dx,
              localPosition.dy - viewHeaderHeight, isTimelineViews,
              isAllDayPanel: true);
        } else {
          _removeAllWidgetHovering();
        }

        return;
      }

      yPosition = localPosition.dy - (viewHeaderHeight + allDayHeight);

      final AppointmentView? appointment =
      _appointmentLayout.getAppointmentViewOnPoint(
          localPosition.dx, yPosition + _scrollController!.offset);
      _hoveringAppointmentView = appointment;
      if (appointment != null) {
        _updateHoveringForAppointment(
            localPosition.dx, yPosition + _scrollController!.offset);
        _updateMouseCursorForAppointment(appointment, localPosition.dx,
            yPosition + _scrollController!.offset, isTimelineViews);
        _hoveringDate = null;
        return;
      }
    } else {
      xPosition = localPosition.dx;

      /// Remove the hovering when the position not in week number panel.
      if (widget.calendar.showWeekNumber && widget.view == CalendarView.month) {
        final double weekNumberPanelWidth =
        CalendarViewHelper.getWeekNumberPanelWidth(
            widget.calendar.showWeekNumber,
            widget.width,
            widget.isMobilePlatform);
        if ((!_isRTL && xPosition < weekNumberPanelWidth) ||
            (_isRTL && xPosition > widget.width - weekNumberPanelWidth)) {
          _hoveringDate = null;
          _calendarCellNotifier.value = null;
          _viewHeaderNotifier.value = null;
          _appointmentHoverNotifier.value = null;
          if (_mouseCursor != SystemMouseCursors.basic) {
            setState(() {
              _mouseCursor = SystemMouseCursors.basic;
            });
          }
          _allDayNotifier.value = null;
          _hoveringAppointmentView = null;
          return;
        }
      }

      /// Update the x position value with scroller offset and the value
      /// assigned to mouse hover position.
      /// mouse hover position value used for highlight the position
      /// on all the calendar views.
      if (isTimelineViews) {
        if (_isRTL) {
          xPosition = (_getSingleViewWidthForTimeLineView(this) *
              widget.visibleDates.length) -
              (_scrollController!.offset +
                  (_scrollController!.position.viewportDimension -
                      localPosition.dx));
        } else {
          xPosition = localPosition.dx + _scrollController!.offset;
        }
      }

      if (localPosition.dy < viewHeaderHeight) {
        _updateHoveringForViewHeader(
            localPosition, xPosition, localPosition.dy, viewHeaderHeight);
        return;
      }

      yPosition = localPosition.dy - viewHeaderHeight - timeLabelWidth;
      if (CalendarViewHelper.isResourceEnabled(
          widget.calendar.dataSource, widget.view)) {
        yPosition += _timelineViewVerticalScrollController!.offset;
      }

      final AppointmentView? appointment =
      _appointmentLayout.getAppointmentViewOnPoint(xPosition, yPosition);
      _hoveringAppointmentView = appointment;
      if (appointment != null) {
        _updateHoveringForAppointment(xPosition, yPosition);
        _updateMouseCursorForAppointment(
            appointment, xPosition, yPosition, isTimelineViews);
        _hoveringDate = null;
        return;
      }
    }

    /// Remove the hovering when the position not in cell regions.
    if (yPosition < 0) {
      if (_hoveringDate != null) {
        _hoveringDate = null;
      }

      if (_calendarCellNotifier.value != null) {
        _calendarCellNotifier.value = null;
      }

      return;
    }

    final DateTime? hoverDate = _getDateFromPosition(
        isTimelineViews ? localPosition.dx : xPosition,
        yPosition,
        timeLabelWidth);

    /// Remove the hovering when the position not in cell regions or non active
    /// cell regions.
    final bool isMonthView = widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth;
    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);
    if (hoverDate == null ||
        (isMonthView &&
            !isDateWithInDateRange(
                widget.calendar.minDate, widget.calendar.maxDate, hoverDate)) ||
        (!isMonthView &&
            !CalendarViewHelper.isDateTimeWithInDateTimeRange(
                widget.calendar.minDate,
                widget.calendar.maxDate,
                hoverDate,
                timeInterval))) {
      if (_hoveringDate != null) {
        _hoveringDate = null;
      }

      if (_calendarCellNotifier.value != null) {
        _calendarCellNotifier.value = null;
      }

      return;
    }

    /// Check the hovering month cell date is blackout date.
    if (isMonthView &&
        CalendarViewHelper.isDateInDateCollection(
            widget.blackoutDates, hoverDate)) {
      if (_hoveringDate != null) {
        _hoveringDate = null;
      }

      /// Remove the existing cell hovering.
      if (_calendarCellNotifier.value != null) {
        _calendarCellNotifier.value = null;
      }

      /// Remove the existing appointment hovering.
      if (_appointmentHoverNotifier.value != null) {
        _appointmentHoverNotifier.value = null;
        _hoveringAppointmentView = null;
        if (_mouseCursor != SystemMouseCursors.basic) {
          setState(() {
            _mouseCursor = SystemMouseCursors.basic;
          });
        }
      }

      return;
    }

    final int hoveringResourceIndex =
    _getSelectedResourceIndex(yPosition, viewHeaderHeight, timeLabelWidth);

    /// Restrict the hovering, while selected region as disabled [TimeRegion].
    if (((widget.view == CalendarView.day ||
        widget.view == CalendarView.week ||
        widget.view == CalendarView.workWeek) &&
        !_isEnabledRegion(yPosition, hoverDate, hoveringResourceIndex)) ||
        (isTimelineViews &&
            !_isEnabledRegion(
                localPosition.dx, hoverDate, hoveringResourceIndex))) {
      if (_hoveringDate != null) {
        _hoveringDate = null;
      }

      if (_calendarCellNotifier.value != null) {
        _calendarCellNotifier.value = null;
      }
      return;
    }

    final int currentMonth =
        widget.visibleDates[widget.visibleDates.length ~/ 2].month;

    /// Check the selected cell date as trailing or leading date when
    /// [SfCalendar] month not shown leading and trailing dates.
    if (isMonthView &&
        !CalendarViewHelper.isCurrentMonthDate(
            widget.calendar.monthViewSettings.numberOfWeeksInView,
            widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
            currentMonth,
            hoverDate)) {
      if (_hoveringDate != null) {
        _hoveringDate = null;
      }

      /// Remove the existing cell hovering.
      if (_calendarCellNotifier.value != null) {
        _calendarCellNotifier.value = null;
      }

      /// Remove the existing appointment hovering.
      if (_appointmentHoverNotifier.value != null) {
        _appointmentHoverNotifier.value = null;
        _hoveringAppointmentView = null;
        if (_mouseCursor != SystemMouseCursors.basic) {
          setState(() {
            _mouseCursor = SystemMouseCursors.basic;
          });
        }
      }

      return;
    }

    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);

    /// If resource enabled the selected date or time slot can be same but the
    /// resource value differs hence to handle this scenario we are excluding
    /// the following conditions, if resource enabled.
    if (!isResourceEnabled) {
      if ((widget.view == CalendarView.month &&
          isSameDate(_hoveringDate, hoverDate) &&
          _viewHeaderNotifier.value == null) ||
          (widget.view != CalendarView.month &&
              CalendarViewHelper.isSameTimeSlot(_hoveringDate, hoverDate) &&
              _viewHeaderNotifier.value == null)) {
        return;
      }
    }

    _hoveringDate = hoverDate;

    if (widget.view == CalendarView.month &&
        isSameDate(_selectionPainter!.selectedDate, _hoveringDate)) {
      _calendarCellNotifier.value = null;
      return;
    } else if (widget.view != CalendarView.month &&
        CalendarViewHelper.isSameTimeSlot(
            _selectionPainter!.selectedDate, _hoveringDate) &&
        hoveringResourceIndex == _selectedResourceIndex) {
      _calendarCellNotifier.value = null;
      return;
    }

    if (widget.view != CalendarView.month && !isTimelineViews) {
      yPosition += _scrollController!.offset;
    }

    if (_viewHeaderNotifier.value != null) {
      _viewHeaderNotifier.value = null;
    }

    if (_allDayNotifier.value != null) {
      _allDayNotifier.value = null;
      _hoveringAppointmentView = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    if (_appointmentHoverNotifier.value != null) {
      _appointmentHoverNotifier.value = null;
      _hoveringAppointmentView = null;
      if (_mouseCursor != SystemMouseCursors.basic) {
        setState(() {
          _mouseCursor = SystemMouseCursors.basic;
        });
      }
    }

    _calendarCellNotifier.value = Offset(xPosition, yPosition);
  }

  void _pointerEnterEvent(PointerEnterEvent event) {
    _updatePointerHover(event.position);
  }

  void _pointerHoverEvent(PointerHoverEvent event) {
    _updatePointerHover(event.position);
  }

  void _pointerExitEvent(PointerExitEvent event) {
    _hoveringDate = null;
    _calendarCellNotifier.value = null;
    _viewHeaderNotifier.value = null;
    _appointmentHoverNotifier.value = null;
    if (_mouseCursor != SystemMouseCursors.basic &&
        _resizingDetails.value.appointmentView == null) {
      setState(() {
        _mouseCursor = SystemMouseCursors.basic;
      });
    }
    _allDayNotifier.value = null;
    _hoveringAppointmentView = null;
  }

  AppointmentView? _getAllDayAppointmentOnPoint(
      List<AppointmentView>? appointmentCollection, double x, double y) {
    if (appointmentCollection == null) {
      return null;
    }

    AppointmentView? selectedAppointmentView;
    for (int i = 0; i < appointmentCollection.length; i++) {
      final AppointmentView appointmentView = appointmentCollection[i];
      if (appointmentView.appointment != null &&
          appointmentView.appointmentRect != null &&
          appointmentView.appointmentRect!.left <= x &&
          appointmentView.appointmentRect!.right >= x &&
          appointmentView.appointmentRect!.top <= y &&
          appointmentView.appointmentRect!.bottom >= y) {
        selectedAppointmentView = appointmentView;
        break;
      }
    }

    return selectedAppointmentView;
  }

  List<dynamic> _getSelectedAppointments(DateTime selectedDate) {
    return (widget.calendar.dataSource != null &&
        !AppointmentHelper.isCalendarAppointment(
            widget.calendar.dataSource!))
        ? CalendarViewHelper.getCustomAppointments(
        AppointmentHelper.getSelectedDateAppointments(
            _updateCalendarStateDetails.appointments,
            widget.calendar.timeZone,
            selectedDate),
        widget.calendar.dataSource)
        : (AppointmentHelper.getSelectedDateAppointments(
        _updateCalendarStateDetails.appointments,
        widget.calendar.timeZone,
        selectedDate));
  }

  DateTime? _getDateFromPositionForMonth(
      double cellWidth, double cellHeight, double x, double y) {
    final int rowIndex = (x / cellWidth).truncate();
    final int columnIndex = (y / cellHeight).truncate();
    int index = 0;
    if (_isRTL) {
      index = (columnIndex * DateTime.daysPerWeek) +
          (DateTime.daysPerWeek - rowIndex) -
          1;
    } else {
      index = (columnIndex * DateTime.daysPerWeek) + rowIndex;
    }

    if (index < 0 || index >= widget.visibleDates.length) {
      return null;
    }

    return widget.visibleDates[index];
  }

  DateTime _getDateFromPositionForDay(
      double cellWidth, double cellHeight, double x, double y) {
    final int columnIndex =
    ((_scrollController!.offset + y) / cellHeight).truncate();
    final double time = columnIndex == -1
        ? 0
        : ((CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings) /
        60) *
        columnIndex) +
        widget.calendar.timeSlotViewSettings.startHour;
    final int hour = time.toInt();
    final int minute = ((time - hour) * 60).round();
    return DateTime(widget.visibleDates[0].year, widget.visibleDates[0].month,
        widget.visibleDates[0].day, hour, minute);
  }

  DateTime? _getDateFromPositionForWeek(
      double cellWidth, double cellHeight, double x, double y) {
    final int columnIndex =
    ((_scrollController!.offset + y) / cellHeight).truncate();
    final double time = columnIndex == -1
        ? 0
        : ((CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings) /
        60) *
        columnIndex) +
        widget.calendar.timeSlotViewSettings.startHour;
    final int hour = time.toInt();
    final int minute = ((time - hour) * 60).round();
    int rowIndex = (x / cellWidth).truncate();
    if (_isRTL) {
      rowIndex = (widget.visibleDates.length - rowIndex) - 1;
    }

    if (rowIndex < 0 || rowIndex >= widget.visibleDates.length) {
      return null;
    }

    final DateTime date = widget.visibleDates[rowIndex];

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  DateTime? _getDateFromPositionForTimeline(
      double cellWidth, double cellHeight, double x, double y) {
    int rowIndex, columnIndex;
    if (_isRTL) {
      rowIndex = (((_scrollController!.offset %
          _getSingleViewWidthForTimeLineView(this)) +
          (_scrollController!.position.viewportDimension - x)) /
          cellWidth)
          .truncate();
    } else {
      rowIndex = (((_scrollController!.offset %
          _getSingleViewWidthForTimeLineView(this)) +
          x) /
          cellWidth)
          .truncate();
    }
    columnIndex =
        (_scrollController!.offset / _getSingleViewWidthForTimeLineView(this))
            .truncate();
    if (rowIndex >= _horizontalLinesCount!) {
      columnIndex += rowIndex ~/ _horizontalLinesCount!;
      rowIndex = (rowIndex % _horizontalLinesCount!).toInt();
    }
    final double time = ((CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings) /
        60) *
        rowIndex) +
        widget.calendar.timeSlotViewSettings.startHour;
    final int hour = time.toInt();
    final int minute = ((time - hour) * 60).round();
    if (columnIndex < 0) {
      columnIndex = 0;
    } else if (columnIndex >= widget.visibleDates.length) {
      columnIndex = widget.visibleDates.length - 1;
    }

    if (columnIndex < 0 || columnIndex >= widget.visibleDates.length) {
      return null;
    }

    final DateTime date = widget.visibleDates[columnIndex];

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  DateTime? _getDateFromPosition(double x, double y, double timeLabelWidth) {
    double cellWidth = 0;
    double newX = x;
    double cellHeight = 0;
    final double width = widget.width - timeLabelWidth;
    switch (widget.view) {
      case CalendarView.schedule:
        return null;
      case CalendarView.month:
        {
          /// Remove the selection when the position is to week number panel.
          final double weekNumberPanelWidth =
          CalendarViewHelper.getWeekNumberPanelWidth(
              widget.calendar.showWeekNumber,
              widget.width,
              widget.isMobilePlatform);
          if (newX > widget.width ||
              (!_isRTL && newX < weekNumberPanelWidth) ||
              (_isRTL && newX > widget.width - weekNumberPanelWidth)) {
            return null;
          }

          /// In RTL the week number panel will render on the right side hence,
          /// we didn't consider the week number panel width in rtl.
          if (!_isRTL) {
            newX -= weekNumberPanelWidth;
          }

          cellWidth =
              (widget.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
          cellHeight = (widget.height -
              CalendarViewHelper.getViewHeaderHeight(
                  widget.calendar.viewHeaderHeight, widget.view)) /
              widget.calendar.monthViewSettings.numberOfWeeksInView;
          return _getDateFromPositionForMonth(cellWidth, cellHeight, newX, y);
        }
      case CalendarView.day:
        {
          if (y >= _timeIntervalHeight * _horizontalLinesCount! ||
              newX > width ||
              newX < 0) {
            return null;
          }
          cellWidth = width;
          cellHeight = _timeIntervalHeight;
          return _getDateFromPositionForDay(cellWidth, cellHeight, newX, y);
        }
      case CalendarView.week:
      case CalendarView.workWeek:
        {
          if (y >= _timeIntervalHeight * _horizontalLinesCount! ||
              newX > width ||
              newX < 0) {
            return null;
          }
          cellWidth = width / widget.visibleDates.length;
          cellHeight = _timeIntervalHeight;
          return _getDateFromPositionForWeek(cellWidth, cellHeight, newX, y);
        }
      case CalendarView.timelineDay:
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
      case CalendarView.timelineMonth:
        {
          final double viewWidth = _timeIntervalHeight *
              (_horizontalLinesCount! * widget.visibleDates.length);
          if ((!_isRTL && newX >= viewWidth) ||
              (_isRTL && newX < (widget.width - viewWidth))) {
            return null;
          }
          cellWidth = _timeIntervalHeight;
          cellHeight = widget.height;
          return _getDateFromPositionForTimeline(
              cellWidth, cellHeight, newX, y);
        }
    }
  }

  void _drawSelection(double x, double y, double timeLabelWidth) {
    final DateTime? selectedDate = _getDateFromPosition(x, y, timeLabelWidth);
    final bool isMonthView = widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth;
    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);
    if (selectedDate == null ||
        (isMonthView &&
            !isDateWithInDateRange(widget.calendar.minDate,
                widget.calendar.maxDate, selectedDate)) ||
        (!isMonthView &&
            !CalendarViewHelper.isDateTimeWithInDateTimeRange(
                widget.calendar.minDate,
                widget.calendar.maxDate,
                selectedDate,
                timeInterval))) {
      return;
    }

    /// Restrict the selection update, while selected region as disabled
    /// [TimeRegion].
    if (((widget.view == CalendarView.day ||
        widget.view == CalendarView.week ||
        widget.view == CalendarView.workWeek) &&
        !_isEnabledRegion(y, selectedDate, _selectedResourceIndex)) ||
        (CalendarViewHelper.isTimelineView(widget.view) &&
            !_isEnabledRegion(x, selectedDate, _selectedResourceIndex))) {
      return;
    }

    if (isMonthView &&
        CalendarViewHelper.isDateInDateCollection(
            widget.blackoutDates, selectedDate)) {
      return;
    }

    if (widget.view == CalendarView.month) {
      final int currentMonth =
          widget.visibleDates[widget.visibleDates.length ~/ 2].month;

      /// Check the selected cell date as trailing or leading date when
      /// [SfCalendar] month not shown leading and trailing dates.
      if (!CalendarViewHelper.isCurrentMonthDate(
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
          currentMonth,
          selectedDate)) {
        return;
      }

      widget.agendaSelectedDate.value = selectedDate;
    }

    _updateCalendarStateDetails.selectedDate = selectedDate;
    _selectionPainter!.selectedDate = selectedDate;
    _selectionPainter!.appointmentView = null;
    _selectionNotifier.value = !_selectionNotifier.value;
  }

  _SelectionPainter _addSelectionView([double? resourceItemHeight]) {
    AppointmentView? appointmentView;
    if (_selectionPainter?.appointmentView != null) {
      appointmentView = _selectionPainter!.appointmentView;
    }

    _selectionPainter = _SelectionPainter(
      widget.calendar,
      widget.view,
      widget.visibleDates,
      _updateCalendarStateDetails.selectedDate,
      widget.calendar.selectionDecoration,
      _timeIntervalHeight,
      widget.calendarTheme,
      _selectionNotifier,
      _isRTL,
      _selectedResourceIndex,
      resourceItemHeight,
      widget.calendar.showWeekNumber,
      widget.isMobilePlatform,
          (UpdateCalendarStateDetails details) {
        _getPainterProperties(details);
      },
    );

    if (appointmentView != null &&
        _updateCalendarStateDetails.visibleAppointments
            .contains(appointmentView.appointment)) {
      _selectionPainter!.appointmentView = appointmentView;
    }

    return _selectionPainter!;
  }

  Widget _getTimelineViewHeader(double width, double height, String locale) {
    _timelineViewHeader = TimelineViewHeaderView(
        widget.visibleDates,
        _timelineViewHeaderScrollController!,
        _timelineViewHeaderNotifier,
        widget.calendar.viewHeaderStyle,
        widget.calendar.timeSlotViewSettings,
        CalendarViewHelper.getViewHeaderHeight(
            widget.calendar.viewHeaderHeight, widget.view),
        _isRTL,
        widget.calendar.todayHighlightColor ??
            widget.calendarTheme.todayHighlightColor,
        widget.calendar.todayTextStyle,
        widget.locale,
        widget.calendarTheme,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        _viewHeaderNotifier,
        widget.calendar.cellBorderColor,
        widget.blackoutDates,
        widget.calendar.blackoutDatesTextStyle,
        widget.textScaleFactor);
    return ListView(
        padding: EdgeInsets.zero,
        controller: _timelineViewHeaderScrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          CustomPaint(
            painter: _timelineViewHeader,
            size: Size(width, height),
          )
        ]);
  }
}