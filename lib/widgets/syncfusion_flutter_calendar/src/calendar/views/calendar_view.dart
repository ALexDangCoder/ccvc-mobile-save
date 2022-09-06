import 'dart:async';
import 'dart:math' as math;

import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/core_internal.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../calendar.dart';
import '../appointment_engine/appointment_helper.dart';
import '../appointment_engine/recurrence_helper.dart';
import '../appointment_layout/allday_appointment_layout.dart';
import '../appointment_layout/appointment_layout.dart';
import '../common/calendar_view_helper.dart';
import '../common/date_time_engine.dart';
import '../views/day_view.dart';
import '../views/month_view.dart';
import '../views/timeline_view.dart';

part './calender_view_ext/view_calendar.dart';
part './calender_view_ext/view_header_painter.dart';
part './calender_view_ext/appoinment_render_object.dart';

/// All day appointment views default height
const double _kAllDayLayoutHeight = 60;

/// Holds the looping widget for calendar view(time slot, month, timeline and
/// appointment views) widgets of calendar widget.
@immutable
class CustomCalendarScrollView extends StatefulWidget {
  /// Constructor to create the calendar scroll view for holding calendar
  /// view(time slot, month, timeline and appointment views) widgets of
  /// calendar widget.
  const CustomCalendarScrollView(
      this.calendar,
      this.view,
      this.width,
      this.height,
      this.agendaSelectedDate,
      this.isRTL,
      this.locale,
      this.calendarTheme,
      this.specialRegions,
      this.blackoutDates,
      this.controller,
      this.removePicker,
      this.resourcePanelScrollController,
      this.resourceCollection,
      this.textScaleFactor,
      this.isMobilePlatform,
      this.fadeInController,
      this.minDate,
      this.maxDate,
      this.localizations,
      this.timelineMonthWeekNumberNotifier,
      this.updateCalendarState,
      this.getCalendarState,
      {Key? key,
      this.onMoreDayClick})
      : super(key: key);

  /// Holds the calendar instance used to get the calendar properties.
  final SfCalendar calendar;

  /// Holds the current calendar view of the calendar widget.
  final CalendarView view;

  /// Defines the width of the calendar scroll view widget.
  final double width;

  /// Defines the height of the calendar scroll view widget.
  final double height;

  /// Defines the direction of calendar widget is RTL or not.
  final bool isRTL;

  /// Defines the locale of the calendar.
  final String locale;

  /// Holds the theme data value for calendar.
  final SfCalendarThemeData calendarTheme;

  /// Holds the calendar controller for the calendar widget.
  final CalendarController controller;

  /// Used to update the calendar state details.
  final UpdateCalendarState updateCalendarState;

  /// Used to get the calendar state details.
  final UpdateCalendarState getCalendarState;

  /// Used to remove the calendar header picker.
  final VoidCallback removePicker;

  /// Holds the agenda selected date value and the value updated on month cell
  /// selection and it set to null on month appointment selection.
  final ValueNotifier<DateTime?> agendaSelectedDate;

  /// Notifier to update the weeknumber of timeline month view based on scroll
  /// changed.
  final ValueNotifier<DateTime?> timelineMonthWeekNumberNotifier;

  final void Function(DateTime day, int count)? onMoreDayClick;

  /// Holds the special time region of calendar widget.
  final List<TimeRegion>? specialRegions;

  /// Used to get the resource panel scroll position.
  final ScrollController? resourcePanelScrollController;

  /// Collection used to store the resource collection and check the collection
  /// manipulations(add, remove, reset).
  final List<CalendarResource>? resourceCollection;

  /// Defines the scale factor for the calendar widget.
  final double textScaleFactor;

  /// Defines the current platform is mobile platform or not.
  final bool isMobilePlatform;

  /// Holds the blackout dates collection of calendar.
  final List<DateTime>? blackoutDates;

  /// Used to animate the calendar views while navigation and view switching.
  final AnimationController? fadeInController;

  /// Defines the min date of the calendar.
  final DateTime minDate;

  /// Defines the max date of the calendar.
  final DateTime maxDate;

  /// Holds the localization data of the calendar widget.
  final SfLocalizations localizations;

  /// Updates the focus to the custom scroll view element.
  void updateFocus() {
    if (key == null) {
      return;
    }

    // ignore: avoid_as
    final GlobalKey scrollViewKey = key! as GlobalKey;
    final Object? currentState = scrollViewKey.currentState;
    if (currentState == null) {
      return;
    }

    final _CustomCalendarScrollViewState state =
        // ignore: avoid_as
        currentState as _CustomCalendarScrollViewState;
    if (!state._focusNode.hasFocus) {
      state._focusNode.requestFocus();
    }
  }

  /// Updates the calendar details in the calendar view
  CalendarDetails? getCalendarDetails(Offset position) {
    if (key == null) {
      return null;
    }

    // ignore: avoid_as
    final GlobalKey scrollViewKey = key! as GlobalKey;
    final Object? currentState = scrollViewKey.currentState;
    if (currentState == null) {
      return null;
    }

    final _CustomCalendarScrollViewState state =
        // ignore: avoid_as
        currentState as _CustomCalendarScrollViewState;
    return state._getCalendarDetails(position);
  }

  /// Update the scroll position when the display date time changes.
  void updateScrollPosition() {
    if (key == null) {
      return;
    }

    // ignore: avoid_as
    final GlobalKey scrollViewKey = key! as GlobalKey;
    final Object? currentState = scrollViewKey.currentState;
    if (currentState == null) {
      return;
    }

    final _CustomCalendarScrollViewState state =
        // ignore: avoid_as
        currentState as _CustomCalendarScrollViewState;
    state._updateMoveToDate();
  }

  @override
  // ignore: library_private_types_in_public_api
  _CustomCalendarScrollViewState createState() =>
      _CustomCalendarScrollViewState();
}

class _CustomCalendarScrollViewState extends State<CustomCalendarScrollView>
    with TickerProviderStateMixin {
  // three views to arrange the view in vertical/horizontal direction and handle the swiping
  late _CalendarView _currentView;
  late _CalendarView _nextView;
  late _CalendarView _previousView;

  // the three children which to be added into the layout
  final List<_CalendarView> _children = <_CalendarView>[];

  // holds the index of the current displaying view
  int _currentChildIndex = 1;

  // _scrollStartPosition contains the touch movement starting position
  late double _scrollStartPosition;

  // _position contains distance that the view swiped
  double _position = 0;

  // animation controller to control the animation
  late AnimationController _animationController;

  // animation handled for the view swiping
  late Animation<double> _animation;

  // tween animation to handle the animation
  final Tween<double> _tween = Tween<double>(begin: 0.0, end: 0.1);

  // Three visible dates for the three views, the dates will updated based on
  // the swiping in the swipe end currentViewVisibleDates which stores the
  // visible dates of the current displaying view
  late List<DateTime> _visibleDates,
      _previousViewVisibleDates,
      _nextViewVisibleDates,
      _currentViewVisibleDates;

  /// keys maintained to access the data and methods from the calendar view
  /// class.
  final GlobalKey<_CalendarViewState> _previousViewKey =
          GlobalKey<_CalendarViewState>(),
      _currentViewKey = GlobalKey<_CalendarViewState>(),
      _nextViewKey = GlobalKey<_CalendarViewState>();

  final UpdateCalendarStateDetails _updateCalendarStateDetails =
      UpdateCalendarStateDetails();

  /// Collection used to store the special regions and
  /// check the special regions manipulations.
  List<TimeRegion>? _timeRegions;

  /// The variable stores the timeline view scroll start position used to
  /// decide the scroll as timeline scroll or scroll view on scroll update.
  double _timelineScrollStartPosition = 0;

  /// The variable used to store the scroll start position to calculate the
  /// scroll difference on scroll update.
  double _timelineStartPosition = 0;

  /// Boolean value used to trigger the horizontal end animation when user
  /// stops the scroll at middle.
  bool _isNeedTimelineScrollEnd = false;

  /// Used to perform the drag or scroll in timeline view.
  Drag? _drag;

  final FocusScopeNode _focusNode = FocusScopeNode();

  late ValueNotifier<_DragPaintDetails> _dragDetails;
  Offset? _dragDifferenceOffset;
  Timer? _timer;

  @override
  void initState() {
    _dragDetails = ValueNotifier<_DragPaintDetails>(
      _DragPaintDetails(
        position: ValueNotifier<Offset?>(null),
      ),
    );
    widget.controller.forward = widget.isRTL
        ? _moveToPreviousViewWithAnimation
        : _moveToNextViewWithAnimation;
    widget.controller.backward = widget.isRTL
        ? _moveToNextViewWithAnimation
        : _moveToPreviousViewWithAnimation;

    _currentChildIndex = 1;
    _updateVisibleDates();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = _tween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    )..addListener(animationListener);

    _timeRegions = CalendarViewHelper.cloneList(widget.specialRegions);

    super.initState();
  }

  @override
  void didUpdateWidget(CustomCalendarScrollView oldWidget) {
    if (oldWidget.controller != widget.controller) {
      widget.controller.forward = widget.isRTL
          ? _moveToPreviousViewWithAnimation
          : _moveToNextViewWithAnimation;
      widget.controller.backward = widget.isRTL
          ? _moveToNextViewWithAnimation
          : _moveToPreviousViewWithAnimation;

      if (!CalendarViewHelper.isSameTimeSlot(
            oldWidget.controller.selectedDate,
            widget.controller.selectedDate,
          ) ||
          !CalendarViewHelper.isSameTimeSlot(
            _updateCalendarStateDetails.selectedDate,
            widget.controller.selectedDate,
          )) {
        _selectResourceProgrammatically();
      }
    }

    if (oldWidget.view != widget.view) {
      _children.clear();

      /// Switching timeline view from non timeline view or non timeline view
      /// from timeline view creates the scroll layout as new because we handle
      /// the scrolling touch for timeline view in this widget, so current
      /// widget tree differ on timeline and non timeline views, so it creates
      /// new widget tree.
      if (CalendarViewHelper.isTimelineView(widget.view) !=
          CalendarViewHelper.isTimelineView(oldWidget.view)) {
        _currentChildIndex = 1;
      }

      _updateVisibleDates();
      _position = 0;
    }

    if ((widget.calendar.monthViewSettings.navigationDirection !=
            oldWidget.calendar.monthViewSettings.navigationDirection) ||
        widget.calendar.scheduleViewMonthHeaderBuilder !=
            oldWidget.calendar.scheduleViewMonthHeaderBuilder ||
        widget.calendar.monthCellBuilder !=
            oldWidget.calendar.monthCellBuilder ||
        widget.width != oldWidget.width ||
        widget.height != oldWidget.height ||
        widget.textScaleFactor != oldWidget.textScaleFactor) {
      _position = 0;
      _children.clear();
    }

    if (!_isTimeRegionsEquals(widget.specialRegions, _timeRegions)) {
      _timeRegions = CalendarViewHelper.cloneList(widget.specialRegions);
      _position = 0;
      _children.clear();
    }

    if ((widget.view == CalendarView.month ||
            widget.view == CalendarView.timelineMonth) &&
        widget.blackoutDates != oldWidget.blackoutDates) {
      _children.clear();
      if (!_animationController.isAnimating) {
        _position = 0;
      }
    }

    /// Check and re renders the views if the resource collection changed.
    if (CalendarViewHelper.isTimelineView(widget.view) &&
        !CalendarViewHelper.isCollectionEqual(
          oldWidget.resourceCollection,
          widget.resourceCollection,
        )) {
      _updateSelectedResourceIndex();
      _position = 0;
      _children.clear();
    }

    if (oldWidget.calendar.showCurrentTimeIndicator !=
        widget.calendar.showCurrentTimeIndicator) {
      _position = 0;
      _children.clear();
    }

    //// condition to check and update the view when the settings changed, it will check each and every property of settings
    //// to avoid unwanted repainting
    if (oldWidget.calendar.timeSlotViewSettings !=
            widget.calendar.timeSlotViewSettings ||
        oldWidget.calendar.monthViewSettings !=
            widget.calendar.monthViewSettings ||
        oldWidget.calendar.blackoutDatesTextStyle !=
            widget.calendar.blackoutDatesTextStyle ||
        oldWidget.calendar.resourceViewSettings !=
            widget.calendar.resourceViewSettings ||
        oldWidget.calendar.viewHeaderStyle != widget.calendar.viewHeaderStyle ||
        oldWidget.calendar.viewHeaderHeight !=
            widget.calendar.viewHeaderHeight ||
        oldWidget.calendar.todayHighlightColor !=
            widget.calendar.todayHighlightColor ||
        oldWidget.calendar.cellBorderColor != widget.calendar.cellBorderColor ||
        oldWidget.calendarTheme != widget.calendarTheme ||
        oldWidget.locale != widget.locale ||
        oldWidget.calendar.selectionDecoration !=
            widget.calendar.selectionDecoration ||
        oldWidget.calendar.weekNumberStyle != widget.calendar.weekNumberStyle) {
      final bool isTimelineView =
          CalendarViewHelper.isTimelineView(widget.view);
      if (widget.view != CalendarView.month &&
          (oldWidget.calendar.timeSlotViewSettings.timeInterval !=
                  widget.calendar.timeSlotViewSettings.timeInterval ||
              (!isTimelineView &&
                  oldWidget.calendar.timeSlotViewSettings.timeIntervalHeight !=
                      widget
                          .calendar.timeSlotViewSettings.timeIntervalHeight) ||
              (isTimelineView &&
                  oldWidget.calendar.timeSlotViewSettings.timeIntervalWidth !=
                      widget
                          .calendar.timeSlotViewSettings.timeIntervalWidth))) {
        if (_currentChildIndex == 0) {
          _previousViewKey.currentState!._retainScrolledDateTime();
        } else if (_currentChildIndex == 1) {
          _currentViewKey.currentState!._retainScrolledDateTime();
        } else if (_currentChildIndex == 2) {
          _nextViewKey.currentState!._retainScrolledDateTime();
        }
      }
      _children.clear();
      _position = 0;
    }

    if (widget.calendar.monthViewSettings.numberOfWeeksInView !=
            oldWidget.calendar.monthViewSettings.numberOfWeeksInView ||
        !CalendarViewHelper.isCollectionEqual(
          widget.calendar.timeSlotViewSettings.nonWorkingDays,
          oldWidget.calendar.timeSlotViewSettings.nonWorkingDays,
        ) ||
        widget.calendar.firstDayOfWeek != oldWidget.calendar.firstDayOfWeek ||
        widget.isRTL != oldWidget.isRTL) {
      _updateVisibleDates();
      _position = 0;
    }

    if (!isSameDate(widget.calendar.minDate, oldWidget.calendar.minDate) ||
        !isSameDate(widget.calendar.maxDate, oldWidget.calendar.maxDate)) {
      _updateVisibleDates();
      _position = 0;
    }

    if (CalendarViewHelper.isTimelineView(widget.view) !=
        CalendarViewHelper.isTimelineView(oldWidget.view)) {
      _children.clear();
    }

    /// position set as zero to maintain the existing scroll position in
    /// timeline view
    if (CalendarViewHelper.isTimelineView(widget.view) &&
        (oldWidget.calendar.backgroundColor !=
                widget.calendar.backgroundColor ||
            oldWidget.calendar.headerStyle != widget.calendar.headerStyle)) {
      _position = 0;
    }

    if (widget.controller == oldWidget.controller) {
      if (oldWidget.controller.displayDate != widget.controller.displayDate ||
          !isSameDate(
            _updateCalendarStateDetails.currentDate,
            widget.controller.displayDate,
          )) {
        widget.getCalendarState(_updateCalendarStateDetails);
        _updateCalendarStateDetails.currentDate = widget.controller.displayDate;
        widget.updateCalendarState(_updateCalendarStateDetails);
        if (widget.calendar.showWeekNumber &&
            widget.view == CalendarView.timelineMonth) {
          widget.timelineMonthWeekNumberNotifier.value =
              widget.controller.displayDate;
        }

        _updateVisibleDates();
        _updateMoveToDate();
        _position = 0;
      }

      if (!CalendarViewHelper.isSameTimeSlot(
            oldWidget.controller.selectedDate,
            widget.controller.selectedDate,
          ) ||
          !CalendarViewHelper.isSameTimeSlot(
            _updateCalendarStateDetails.selectedDate,
            widget.controller.selectedDate,
          )) {
        widget.getCalendarState(_updateCalendarStateDetails);
        _updateCalendarStateDetails.selectedDate =
            widget.controller.selectedDate;
        widget.updateCalendarState(_updateCalendarStateDetails);
        _selectResourceProgrammatically();
        _updateSelection();
        _position = 0;
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!CalendarViewHelper.isTimelineView(widget.view) &&
        widget.view != CalendarView.month) {
      _updateScrollPosition();
    }

    double leftPosition = 0,
        rightPosition = 0,
        topPosition = 0,
        bottomPosition = 0;
    final bool isHorizontalNavigation =
        widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.horizontal ||
            widget.view != CalendarView.month;
    if (isHorizontalNavigation) {
      leftPosition = -widget.width;
      rightPosition = -widget.width;
    } else {
      topPosition = -widget.height;
      bottomPosition = -widget.height;
    }

    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    final bool isNeedDragAndDrop = widget.calendar.allowDragAndDrop &&
        widget.view != CalendarView.schedule &&
        (!widget.isMobilePlatform ||
            (widget.view != CalendarView.month &&
                widget.view != CalendarView.timelineMonth));
    final double viewHeaderHeight = widget.view == CalendarView.day
        ? 0
        : CalendarViewHelper.getViewHeaderHeight(
            widget.calendar.viewHeaderHeight,
            widget.view,
          );
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
      widget.calendar.timeSlotViewSettings.timeRulerSize,
      widget.view,
    );
    final bool isResourceEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);
    final double resourceItemHeight = isResourceEnabled
        ? CalendarViewHelper.getResourceItemHeight(
            widget.calendar.resourceViewSettings.size,
            widget.height - viewHeaderHeight - timeLabelWidth,
            widget.calendar.resourceViewSettings,
            widget.calendar.dataSource!.resources!.length,
          )
        : 0;
    final double resourceViewSize =
        isResourceEnabled ? widget.calendar.resourceViewSettings.size : 0;
    final bool isMonthView = widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth;
    final double weekNumberPanelWidth =
        CalendarViewHelper.getWeekNumberPanelWidth(
      widget.calendar.showWeekNumber,
      widget.width,
      widget.isMobilePlatform,
    );

    final Widget customScrollWidget = GestureDetector(
      child: CustomScrollViewerLayout(
        _addViews(),
        isHorizontalNavigation
            ? CustomScrollDirection.horizontal
            : CustomScrollDirection.vertical,
        _position,
        _currentChildIndex,
      ),
      onTapDown: (TapDownDetails details) {
        if (!_focusNode.hasFocus) {
          _focusNode.requestFocus();
        }
      },
      onHorizontalDragStart: isTimelineView
          ? null
          : (DragStartDetails dragStartDetails) {
              _onHorizontalStart(
                  dragStartDetails,
                  isResourceEnabled,
                  isTimelineView,
                  viewHeaderHeight,
                  timeLabelWidth,
                  isNeedDragAndDrop);
            },
      onHorizontalDragUpdate: isTimelineView
          ? null
          : (DragUpdateDetails dragUpdateDetails) {
              _onHorizontalUpdate(
                  dragUpdateDetails,
                  isResourceEnabled,
                  isMonthView,
                  isTimelineView,
                  viewHeaderHeight,
                  timeLabelWidth,
                  resourceItemHeight,
                  weekNumberPanelWidth,
                  isNeedDragAndDrop);
            },
      onHorizontalDragEnd: isTimelineView
          ? null
          : (DragEndDetails dragEndDetails) {
              _onHorizontalEnd(
                dragEndDetails,
                isResourceEnabled,
                isTimelineView,
                isMonthView,
                viewHeaderHeight,
                timeLabelWidth,
                weekNumberPanelWidth,
                isNeedDragAndDrop,
              );
            },
      onVerticalDragStart: isHorizontalNavigation
          ? null
          : (DragStartDetails dragStartDetails) {
              _onVerticalStart(
                dragStartDetails,
                isResourceEnabled,
                isTimelineView,
                viewHeaderHeight,
                timeLabelWidth,
                isNeedDragAndDrop,
              );
            },
      onVerticalDragUpdate: isHorizontalNavigation
          ? null
          : (DragUpdateDetails dragUpdateDetails) {
              _onVerticalUpdate(
                dragUpdateDetails,
                isResourceEnabled,
                isMonthView,
                isTimelineView,
                viewHeaderHeight,
                timeLabelWidth,
                resourceItemHeight,
                weekNumberPanelWidth,
                isNeedDragAndDrop,
              );
            },
      onVerticalDragEnd: isHorizontalNavigation
          ? null
          : (DragEndDetails dragEndDetails) {
              _onVerticalEnd(
                dragEndDetails,
                isResourceEnabled,
                isTimelineView,
                isMonthView,
                viewHeaderHeight,
                timeLabelWidth,
                weekNumberPanelWidth,
                isNeedDragAndDrop,
              );
            },
    );

    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        _handleLongPressStart(
          details,
          isNeedDragAndDrop,
          isTimelineView,
          isResourceEnabled,
          viewHeaderHeight,
          timeLabelWidth,
        );
      },
      onLongPressMoveUpdate: isNeedDragAndDrop
          ? (LongPressMoveUpdateDetails details) {
              _handleLongPressMove(
                  details.localPosition,
                  isTimelineView,
                  isResourceEnabled,
                  isMonthView,
                  viewHeaderHeight,
                  timeLabelWidth,
                  resourceItemHeight,
                  weekNumberPanelWidth);
            }
          : null,
      onLongPressEnd: isNeedDragAndDrop
          ? (LongPressEndDetails details) {
              _handleLongPressEnd(
                details.localPosition,
                isTimelineView,
                isResourceEnabled,
                isMonthView,
                viewHeaderHeight,
                timeLabelWidth,
                weekNumberPanelWidth,
              );
            }
          : null,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: leftPosition,
            right: rightPosition,
            bottom: bottomPosition,
            top: topPosition,
            child: FocusScope(
              node: _focusNode,
              onKey: _onKeyDown,
              child: isTimelineView
                  ? Listener(
                      onPointerSignal: _handlePointerSignal,
                      child: RawGestureDetector(
                        gestures: <Type, GestureRecognizerFactory>{
                          HorizontalDragGestureRecognizer:
                              GestureRecognizerFactoryWithHandlers<
                                  HorizontalDragGestureRecognizer>(
                            () => HorizontalDragGestureRecognizer(),
                            (HorizontalDragGestureRecognizer instance) {
                              instance.onUpdate = (DragUpdateDetails details) {
                                _handleDragUpdate(
                                    details,
                                    isTimelineView,
                                    isResourceEnabled,
                                    isMonthView,
                                    viewHeaderHeight,
                                    timeLabelWidth,
                                    resourceItemHeight,
                                    weekNumberPanelWidth,
                                    isNeedDragAndDrop,
                                    resourceViewSize);
                              };
                              instance.onStart = (DragStartDetails details) {
                                _handleDragStart(
                                    details,
                                    isNeedDragAndDrop,
                                    isTimelineView,
                                    isResourceEnabled,
                                    viewHeaderHeight,
                                    timeLabelWidth,
                                    resourceViewSize);
                              };
                              instance.onEnd = (DragEndDetails details) {
                                _handleDragEnd(
                                  details,
                                  isTimelineView,
                                  isResourceEnabled,
                                  isMonthView,
                                  viewHeaderHeight,
                                  timeLabelWidth,
                                  weekNumberPanelWidth,
                                  isNeedDragAndDrop,
                                );
                              };
                              instance.onCancel = _handleDragCancel;
                            },
                          )
                        },
                        behavior: HitTestBehavior.opaque,
                        child: customScrollWidget,
                      ),
                    )
                  : customScrollWidget,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: IgnorePointer(
              child: RepaintBoundary(
                child: _DraggingAppointmentWidget(
                    _dragDetails,
                    widget.isRTL,
                    widget.textScaleFactor,
                    widget.isMobilePlatform,
                    widget.calendar.appointmentTextStyle,
                    widget.calendar.dragAndDropSettings,
                    widget.view,
                    _updateCalendarStateDetails.allDayPanelHeight,
                    viewHeaderHeight,
                    timeLabelWidth,
                    resourceItemHeight,
                    widget.calendarTheme,
                    widget.calendar,
                    widget.width,
                    widget.height),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.removeListener(animationListener);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleAppointmentDragStart(
      AppointmentView appointmentView,
      bool isTimelineView,
      Offset details,
      bool isResourceEnabled,
      double viewHeaderHeight,
      double timeLabelWidth) {
    final _CalendarViewState currentState = _getCurrentViewByVisibleDates()!;
    currentState._updateDraggingMouseCursor(true);
    _dragDetails.value.timeIntervalHeight = currentState._getTimeIntervalHeight(
      widget.calendar,
      widget.view,
      widget.width,
      widget.height,
      currentState.widget.visibleDates.length,
      currentState._allDayHeight,
      widget.isMobilePlatform,
    );
    _dragDetails.value.appointmentView = appointmentView;
    _dragDifferenceOffset = null;
    final Offset appointmentPosition = Offset(
        widget.isRTL
            ? appointmentView.appointmentRect!.right
            : appointmentView.appointmentRect!.left,
        appointmentView.appointmentRect!.top);
    double xPosition;
    double yPosition;
    if (isTimelineView) {
      xPosition = (appointmentPosition.dx -
              currentState._scrollController!.position.pixels) -
          details.dx;
      if (widget.isRTL) {
        xPosition = currentState._scrollController!.offset +
            currentState._scrollController!.position.viewportDimension;
        xPosition = xPosition -
            ((currentState._scrollController!.position.viewportDimension +
                    currentState._scrollController!.position.maxScrollExtent) -
                appointmentPosition.dx);
        xPosition -= details.dx;
      }
      yPosition = appointmentPosition.dy +
          viewHeaderHeight +
          timeLabelWidth -
          details.dy;
      if (isResourceEnabled) {
        yPosition -= currentState._timelineViewVerticalScrollController!.offset;
      }
      _dragDifferenceOffset = Offset(xPosition, yPosition);
    } else if (widget.view == CalendarView.month) {
      xPosition = appointmentPosition.dx - details.dx;
      yPosition = appointmentPosition.dy + viewHeaderHeight;
      yPosition = yPosition - details.dy;
      _dragDifferenceOffset = Offset(xPosition, yPosition);
    } else {
      final double allDayHeight = currentState._isExpanded
          ? _updateCalendarStateDetails.allDayPanelHeight
          : currentState._allDayHeight;
      xPosition = appointmentPosition.dx - details.dx;
      yPosition = appointmentPosition.dy +
          viewHeaderHeight +
          allDayHeight -
          currentState._scrollController!.position.pixels;
      if (appointmentView.appointment!.isAllDay ||
          appointmentView.appointment!.isSpanned) {
        yPosition = appointmentPosition.dy + viewHeaderHeight;
      }
      yPosition = yPosition - details.dy;
      _dragDifferenceOffset = Offset(xPosition, yPosition);
    }

    CalendarResource? selectedResource;
    int _selectedResourceIndex = -1;

    if (isResourceEnabled) {
      yPosition = details.dy - viewHeaderHeight - timeLabelWidth;
      yPosition += currentState._timelineViewVerticalScrollController!.offset;
      _selectedResourceIndex = currentState._getSelectedResourceIndex(
          yPosition, viewHeaderHeight, timeLabelWidth);
      selectedResource =
          widget.calendar.dataSource!.resources![_selectedResourceIndex];
    }
    _dragDetails.value.position.value = details + _dragDifferenceOffset!;
    _dragDetails.value.draggingTime =
        yPosition <= 0 && widget.view != CalendarView.month && !isTimelineView
            ? null
            : _dragDetails.value.appointmentView!.appointment!.actualStartTime;
    final dynamic dragStartAppointment = _getCalendarAppointmentToObject(
        appointmentView.appointment, widget.calendar);
    if (widget.calendar.onDragStart != null) {
      widget.calendar.onDragStart!(
          AppointmentDragStartDetails(dragStartAppointment, selectedResource));
    }
  }

  void _handleLongPressStart(
    LongPressStartDetails details,
    bool isNeedDragAndDrop,
    bool isTimelineView,
    bool isResourceEnabled,
    double viewHeaderHeight,
    double timeLabelWidth,
  ) {
    final _CalendarViewState currentState = _getCurrentViewByVisibleDates()!;
    AppointmentView? appointmentView =
        _getDragAppointment(details, currentState);
    if (!isNeedDragAndDrop || appointmentView == null) {
      _dragDetails.value.position.value = null;
      return;
    }
    currentState._removeAllWidgetHovering();
    appointmentView = appointmentView.clone();
    _handleAppointmentDragStart(
        appointmentView,
        isTimelineView,
        details.localPosition,
        isResourceEnabled,
        viewHeaderHeight,
        timeLabelWidth);
  }

  AppointmentView? _getDragAppointment(
    LongPressStartDetails details,
    _CalendarViewState currentState,
  ) {
    if (CalendarViewHelper.isTimelineView(widget.view)) {
      return currentState._handleTouchOnTimeline(null, details);
    } else if (widget.view == CalendarView.month) {
      return currentState._handleTouchOnMonthView(null, details);
    }

    return currentState._handleTouchOnDayView(null, details);
  }

  void _handleLongPressMove(
      Offset details,
      bool isTimelineView,
      bool isResourceEnabled,
      bool isMonthView,
      double viewHeaderHeight,
      double timeLabelWidth,
      double resourceItemHeight,
      double weekNumberPanelWidth) {
    if (_dragDetails.value.appointmentView == null) {
      return;
    }

    final Offset appointmentPosition = details + _dragDifferenceOffset!;
    final _CalendarViewState currentState = _getCurrentViewByVisibleDates()!;
    final double allDayHeight = currentState._isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : currentState._allDayHeight;

    final double timeIntervalHeight = currentState._getTimeIntervalHeight(
      widget.calendar,
      widget.view,
      widget.width,
      widget.height,
      currentState.widget.visibleDates.length,
      currentState._allDayHeight,
      widget.isMobilePlatform,
    );
    if (isTimelineView) {
      _updateAutoScrollDragTimelineView(
          currentState,
          appointmentPosition,
          viewHeaderHeight,
          timeIntervalHeight,
          resourceItemHeight,
          isResourceEnabled,
          details,
          isMonthView,
          allDayHeight,
          isTimelineView,
          timeLabelWidth,
          weekNumberPanelWidth);
    } else {
      _updateNavigationDayView(
        currentState,
        appointmentPosition,
        viewHeaderHeight,
        allDayHeight,
        timeIntervalHeight,
        timeLabelWidth,
        isResourceEnabled,
        isTimelineView,
        isMonthView,
        details,
        weekNumberPanelWidth,
      );
    }

    _dragDetails.value.position.value = appointmentPosition;
    _updateAppointmentDragUpdateCallback(
        isTimelineView,
        viewHeaderHeight,
        timeLabelWidth,
        allDayHeight,
        appointmentPosition,
        isMonthView,
        timeIntervalHeight,
        currentState,
        details,
        isResourceEnabled,
        weekNumberPanelWidth);
  }

  Future<void> _updateNavigationDayView(
      _CalendarViewState currentState,
      Offset appointmentPosition,
      double viewHeaderHeight,
      double allDayHeight,
      double timeIntervalHeight,
      double timeLabelWidth,
      bool isResourceEnabled,
      bool isTimelineView,
      bool isMonthView,
      Offset details,
      double weekNumberPanelWidth) async {
    _CalendarViewState newCurrentState = currentState;
    if (_dragDetails.value.appointmentView == null) {
      return;
    }

    double navigationThresholdValue = 0;
    if (widget.view == CalendarView.day) {
      navigationThresholdValue =
          _dragDetails.value.appointmentView!.appointmentRect!.width * 0.1;
    }

    double rtlValue = 0;
    if (widget.isRTL) {
      rtlValue = _dragDetails.value.appointmentView!.appointmentRect!.width;
    }

    final bool isHorizontalNavigation =
        widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.horizontal ||
            widget.view != CalendarView.month;

    if (widget.calendar.dragAndDropSettings.allowScroll &&
        widget.view != CalendarView.month &&
        appointmentPosition.dy <= viewHeaderHeight + allDayHeight &&
        newCurrentState._scrollController!.position.pixels != 0) {
      if (_timer != null) {
        return;
      }
      _timer = Timer(const Duration(milliseconds: 200), () async {
        if (_dragDetails.value.position.value != null &&
            _dragDetails.value.position.value!.dy <=
                viewHeaderHeight + allDayHeight &&
            newCurrentState._scrollController!.position.pixels != 0) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                newCurrentState._scrollController!.position.pixels -
                    timeIntervalHeight;
            if (scrollPosition < 0) {
              scrollPosition = 0;
            }
            await newCurrentState._scrollController!.position.moveTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );

            _updateAppointmentDragUpdateCallback(
                isTimelineView,
                viewHeaderHeight,
                timeLabelWidth,
                allDayHeight,
                appointmentPosition,
                isMonthView,
                timeIntervalHeight,
                newCurrentState,
                details,
                isResourceEnabled,
                weekNumberPanelWidth,);

            if (_dragDetails.value.position.value != null &&
                _dragDetails.value.position.value!.dy <=
                    viewHeaderHeight + allDayHeight &&
                newCurrentState._scrollController!.position.pixels != 0) {
              unawaited(_updateScrollPosition());
            } else if (_timer != null) {
              _timer!.cancel();
              _timer = null;
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
      });
    } else if (widget.calendar.dragAndDropSettings.allowScroll &&
        widget.view != CalendarView.month &&
        appointmentPosition.dy +
                _dragDetails.value.appointmentView!.appointmentRect!.height >=
            widget.height &&
        newCurrentState._scrollController!.position.pixels !=
            newCurrentState._scrollController!.position.maxScrollExtent) {
      if (_timer != null) {
        return;
      }
      _timer = Timer(const Duration(milliseconds: 200), () async {
        if (_dragDetails.value.position.value != null &&
            _dragDetails.value.position.value!.dy +
                    _dragDetails
                        .value.appointmentView!.appointmentRect!.height >=
                widget.height &&
            newCurrentState._scrollController!.position.pixels !=
                newCurrentState._scrollController!.position.maxScrollExtent) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                newCurrentState._scrollController!.position.pixels +
                    timeIntervalHeight;
            if (scrollPosition >
                newCurrentState._scrollController!.position.maxScrollExtent) {
              scrollPosition =
                  newCurrentState._scrollController!.position.maxScrollExtent;
            }

            await newCurrentState._scrollController!.position.moveTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );

            _updateAppointmentDragUpdateCallback(
                isTimelineView,
                viewHeaderHeight,
                timeLabelWidth,
                allDayHeight,
                appointmentPosition,
                isMonthView,
                timeIntervalHeight,
                newCurrentState,
                details,
                isResourceEnabled,
                weekNumberPanelWidth);

            if (_dragDetails.value.position.value != null &&
                _dragDetails.value.position.value!.dy +
                        _dragDetails
                            .value.appointmentView!.appointmentRect!.height >=
                    widget.height &&
                newCurrentState._scrollController!.position.pixels !=
                    newCurrentState
                        ._scrollController!.position.maxScrollExtent) {
              unawaited(_updateScrollPosition());
            } else if (_timer != null) {
              _timer!.cancel();
              _timer = null;
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
      });
    } else if (widget.calendar.dragAndDropSettings.allowNavigation &&
        ((isHorizontalNavigation &&
                (appointmentPosition.dx +
                            _dragDetails.value.appointmentView!.appointmentRect!
                                .width) -
                        rtlValue >=
                    widget.width) ||
            (!isHorizontalNavigation &&
                (appointmentPosition.dy +
                        _dragDetails
                            .value.appointmentView!.appointmentRect!.height >=
                    widget.height)))) {
      if (_timer != null) {
        return;
      }
      _timer =
          Timer.periodic(widget.calendar.dragAndDropSettings.autoNavigateDelay,
              (Timer timer) async {
        if (_dragDetails.value.position.value != null &&
            ((isHorizontalNavigation &&
                    (_dragDetails.value.position.value!.dx +
                                _dragDetails.value.appointmentView!
                                    .appointmentRect!.width) -
                            rtlValue >=
                        widget.width + navigationThresholdValue) ||
                (!isHorizontalNavigation &&
                    _dragDetails.value.position.value!.dy +
                            _dragDetails.value.appointmentView!.appointmentRect!
                                .height >=
                        widget.height))) {
          if (widget.isRTL) {
            _moveToPreviousViewWithAnimation();
          } else {
            _moveToNextViewWithAnimation();
          }
          newCurrentState = _getCurrentViewByVisibleDates()!;
          newCurrentState._updateDraggingMouseCursor(true);
          _updateAppointmentDragUpdateCallback(
              isTimelineView,
              viewHeaderHeight,
              timeLabelWidth,
              allDayHeight,
              appointmentPosition,
              isMonthView,
              timeIntervalHeight,
              newCurrentState,
              details,
              isResourceEnabled,
              weekNumberPanelWidth,);
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
      });
    } else if (widget.calendar.dragAndDropSettings.allowNavigation &&
        ((isHorizontalNavigation &&
                (appointmentPosition.dx + navigationThresholdValue) -
                        rtlValue <=
                    0) ||
            (!isHorizontalNavigation &&
                appointmentPosition.dy <= viewHeaderHeight))) {
      if (_timer != null) {
        return;
      }
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
        if (_dragDetails.value.position.value != null &&
            ((isHorizontalNavigation &&
                    (_dragDetails.value.position.value!.dx +
                                navigationThresholdValue) -
                            rtlValue <=
                        0) ||
                (!isHorizontalNavigation &&
                    _dragDetails.value.position.value!.dy <=
                        viewHeaderHeight))) {
          if (widget.isRTL) {
            _moveToNextViewWithAnimation();
          } else {
            _moveToPreviousViewWithAnimation();
          }
          newCurrentState = _getCurrentViewByVisibleDates()!;
          newCurrentState._updateDraggingMouseCursor(true);
          _updateAppointmentDragUpdateCallback(
              isTimelineView,
              viewHeaderHeight,
              timeLabelWidth,
              allDayHeight,
              appointmentPosition,
              isMonthView,
              timeIntervalHeight,
              newCurrentState,
              details,
              isResourceEnabled,
              weekNumberPanelWidth,);
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
      });
    }
  }

  Future<void> _updateAutoScrollDragTimelineView(
      _CalendarViewState currentState,
      Offset appointmentPosition,
      double viewHeaderHeight,
      double timeIntervalHeight,
      double resourceItemHeight,
      bool isResourceEnabled,
      Offset details,
      bool isMonthView,
      double allDayHeight,
      bool isTimelineView,
      double timeLabelWidth,
      double weekNumberPanelWidth,) async {
    if (_dragDetails.value.appointmentView == null) {
      return;
    }

    double rtlValue = 0;
    if (widget.isRTL) {
      rtlValue = _dragDetails.value.appointmentView!.appointmentRect!.width;
    }
    if (widget.calendar.dragAndDropSettings.allowScroll &&
        appointmentPosition.dx - rtlValue <= 0 &&
        ((widget.isRTL &&
                currentState._scrollController!.position.pixels !=
                    currentState._scrollController!.position.maxScrollExtent) ||
            (!widget.isRTL &&
                currentState._scrollController!.position.pixels != 0))) {
      if (_timer != null) {
        return;
      }
      _timer = Timer(const Duration(milliseconds: 200), () async {
        if (_dragDetails.value.position.value != null &&
            _dragDetails.value.position.value!.dx - rtlValue <= 0 &&
            ((widget.isRTL &&
                    currentState._scrollController!.position.pixels !=
                        currentState
                            ._scrollController!.position.maxScrollExtent) ||
                (!widget.isRTL &&
                    currentState._scrollController!.position.pixels != 0))) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                currentState._scrollController!.position.pixels -
                    timeIntervalHeight;
            if (widget.isRTL) {
              scrollPosition = currentState._scrollController!.position.pixels +
                  timeIntervalHeight;
            }
            if (!widget.isRTL && scrollPosition < 0) {
              scrollPosition = 0;
            } else if (widget.isRTL &&
                scrollPosition >
                    currentState._scrollController!.position.maxScrollExtent) {
              scrollPosition =
                  currentState._scrollController!.position.maxScrollExtent;
            }
            await currentState._scrollController!.position.moveTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );

            _updateAppointmentDragUpdateCallback(
                isTimelineView,
                viewHeaderHeight,
                timeLabelWidth,
                allDayHeight,
                appointmentPosition,
                isMonthView,
                timeIntervalHeight,
                currentState,
                details,
                isResourceEnabled,
                weekNumberPanelWidth);

            if (_dragDetails.value.position.value != null &&
                _dragDetails.value.position.value!.dx - rtlValue <= 0 &&
                ((widget.isRTL &&
                        currentState._scrollController!.position.pixels !=
                            currentState
                                ._scrollController!.position.maxScrollExtent) ||
                    (!widget.isRTL &&
                        currentState._scrollController!.position.pixels !=
                            0))) {
              unawaited(_updateScrollPosition());
            } else if (_timer != null) {
              _timer!.cancel();
              _timer = null;
              _updateAutoViewNavigationTimelineView(
                  currentState,
                  appointmentPosition,
                  viewHeaderHeight,
                  timeIntervalHeight,
                  resourceItemHeight,
                  isResourceEnabled,
                  details,
                  isMonthView,
                  allDayHeight,
                  isTimelineView,
                  timeLabelWidth,
                  weekNumberPanelWidth,
                  rtlValue,);
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
          _updateAutoViewNavigationTimelineView(
              currentState,
              appointmentPosition,
              viewHeaderHeight,
              timeIntervalHeight,
              resourceItemHeight,
              isResourceEnabled,
              details,
              isMonthView,
              allDayHeight,
              isTimelineView,
              timeLabelWidth,
              weekNumberPanelWidth,
              rtlValue,);
        }
      });
    } else if (widget.calendar.dragAndDropSettings.allowScroll &&
        (appointmentPosition.dx +
                    _dragDetails
                        .value.appointmentView!.appointmentRect!.width) -
                rtlValue >=
            widget.width &&
        ((widget.isRTL &&
                currentState._scrollController!.position.pixels != 0) ||
            (!widget.isRTL &&
                currentState._scrollController!.position.pixels !=
                    currentState
                        ._scrollController!.position.maxScrollExtent))) {
      if (_timer != null) {
        return;
      }
      _timer = Timer(const Duration(milliseconds: 200), () async {
        if (_dragDetails.value.position.value != null &&
            (_dragDetails.value.position.value!.dx +
                        _dragDetails
                            .value.appointmentView!.appointmentRect!.width) -
                    rtlValue >=
                widget.width &&
            ((widget.isRTL &&
                    currentState._scrollController!.position.pixels != 0) ||
                (!widget.isRTL &&
                    currentState._scrollController!.position.pixels !=
                        currentState
                            ._scrollController!.position.maxScrollExtent))) {
          Future<void> _updateScrollPosition() async {
            double scrollPosition =
                currentState._scrollController!.position.pixels +
                    timeIntervalHeight;
            if (widget.isRTL) {
              scrollPosition = currentState._scrollController!.position.pixels -
                  timeIntervalHeight;
            }
            if (!widget.isRTL &&
                scrollPosition >
                    currentState._scrollController!.position.maxScrollExtent) {
              scrollPosition =
                  currentState._scrollController!.position.maxScrollExtent;
            } else if (widget.isRTL && scrollPosition < 0) {
              scrollPosition = 0;
            }

            await currentState._scrollController!.position.moveTo(
              scrollPosition,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );

            _updateAppointmentDragUpdateCallback(
                isTimelineView,
                viewHeaderHeight,
                timeLabelWidth,
                allDayHeight,
                appointmentPosition,
                isMonthView,
                timeIntervalHeight,
                currentState,
                details,
                isResourceEnabled,
                weekNumberPanelWidth,);

            if (_dragDetails.value.position.value != null &&
                (_dragDetails.value.position.value!.dx +
                            _dragDetails.value.appointmentView!.appointmentRect!
                                .width) -
                        rtlValue >=
                    widget.width &&
                ((widget.isRTL &&
                        currentState._scrollController!.position.pixels != 0) ||
                    (!widget.isRTL &&
                        currentState._scrollController!.position.pixels !=
                            currentState._scrollController!.position
                                .maxScrollExtent))) {
              unawaited(_updateScrollPosition());
            } else if (_timer != null) {
              _timer!.cancel();
              _timer = null;
              _updateAutoViewNavigationTimelineView(
                  currentState,
                  appointmentPosition,
                  viewHeaderHeight,
                  timeIntervalHeight,
                  resourceItemHeight,
                  isResourceEnabled,
                  details,
                  isMonthView,
                  allDayHeight,
                  isTimelineView,
                  timeLabelWidth,
                  weekNumberPanelWidth,
                  rtlValue);
            }
          }

          unawaited(_updateScrollPosition());
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
          _updateAutoViewNavigationTimelineView(
              currentState,
              appointmentPosition,
              viewHeaderHeight,
              timeIntervalHeight,
              resourceItemHeight,
              isResourceEnabled,
              details,
              isMonthView,
              allDayHeight,
              isTimelineView,
              timeLabelWidth,
              weekNumberPanelWidth,
              rtlValue);
        }
      });
    }

    _updateAutoViewNavigationTimelineView(
        currentState,
        appointmentPosition,
        viewHeaderHeight,
        timeIntervalHeight,
        resourceItemHeight,
        isResourceEnabled,
        details,
        isMonthView,
        allDayHeight,
        isTimelineView,
        timeLabelWidth,
        weekNumberPanelWidth,
        rtlValue);

    if (_dragDetails.value.appointmentView == null) {
      return;
    }

    if (isResourceEnabled) {
      if (widget.calendar.dragAndDropSettings.allowScroll &&
          appointmentPosition.dy - viewHeaderHeight - timeIntervalHeight <= 0 &&
          currentState._timelineViewVerticalScrollController!.position.pixels !=
              0) {
        if (_timer != null) {
          return;
        }
        _timer = Timer(const Duration(milliseconds: 200), () async {
          if (_dragDetails.value.position.value != null &&
              _dragDetails.value.position.value!.dy -
                      viewHeaderHeight -
                      timeIntervalHeight <=
                  0 &&
              currentState
                      ._timelineViewVerticalScrollController!.position.pixels !=
                  0) {
            Future<void> _updateScrollPosition() async {
              double scrollPosition = currentState
                      ._timelineViewVerticalScrollController!.position.pixels -
                  resourceItemHeight;
              if (scrollPosition < 0) {
                scrollPosition = 0;
              }
              await currentState._timelineViewVerticalScrollController!.position
                  .moveTo(
                scrollPosition,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );

              if (_dragDetails.value.position.value != null &&
                  _dragDetails.value.position.value!.dy -
                          viewHeaderHeight -
                          timeIntervalHeight <=
                      0 &&
                  currentState._timelineViewVerticalScrollController!.position
                          .pixels !=
                      0) {
                unawaited(_updateScrollPosition());
              } else if (_timer != null) {
                _timer!.cancel();
                _timer = null;
              }
            }

            unawaited(_updateScrollPosition());
          } else if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
        });
      } else if (widget.calendar.dragAndDropSettings.allowScroll &&
          appointmentPosition.dy +
                  _dragDetails.value.appointmentView!.appointmentRect!.height >=
              widget.height &&
          currentState._timelineViewVerticalScrollController!.position.pixels !=
              currentState._timelineViewVerticalScrollController!.position
                  .maxScrollExtent) {
        if (_timer != null) {
          return;
        }
        _timer = Timer(const Duration(milliseconds: 200), () async {
          if (_dragDetails.value.position.value != null &&
              _dragDetails.value.position.value!.dy +
                      _dragDetails
                          .value.appointmentView!.appointmentRect!.height >=
                  widget.height &&
              currentState
                      ._timelineViewVerticalScrollController!.position.pixels !=
                  currentState._timelineViewVerticalScrollController!.position
                      .maxScrollExtent) {
            Future<void> _updateScrollPosition() async {
              double scrollPosition = currentState
                      ._timelineViewVerticalScrollController!.position.pixels +
                  resourceItemHeight;
              if (scrollPosition >
                  currentState._timelineViewVerticalScrollController!.position
                      .maxScrollExtent) {
                scrollPosition = currentState
                    ._timelineViewVerticalScrollController!
                    .position
                    .maxScrollExtent;
              }

              await currentState._timelineViewVerticalScrollController!.position
                  .moveTo(
                scrollPosition,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );

              if (_dragDetails.value.position.value != null &&
                  _dragDetails.value.position.value!.dy +
                          _dragDetails
                              .value.appointmentView!.appointmentRect!.height >=
                      widget.height &&
                  currentState._timelineViewVerticalScrollController!.position
                          .pixels !=
                      currentState._timelineViewVerticalScrollController!
                          .position.maxScrollExtent) {
                unawaited(_updateScrollPosition());
              } else if (_timer != null) {
                _timer!.cancel();
                _timer = null;
              }
            }

            unawaited(_updateScrollPosition());
          } else if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
        });
      }
    }
  }

  void _updateAutoViewNavigationTimelineView(
      _CalendarViewState currentState,
      Offset appointmentPosition,
      double viewHeaderHeight,
      double timeIntervalHeight,
      double resourceItemHeight,
      bool isResourceEnabled,
      dynamic details,
      bool isMonthView,
      double allDayHeight,
      bool isTimelineView,
      double timeLabelWidth,
      double weekNumberPanelWidth,
      double rtlValue) {
    _CalendarViewState newCurrentState = currentState;
    if (widget.calendar.dragAndDropSettings.allowNavigation &&
        (appointmentPosition.dx +
                    _dragDetails
                        .value.appointmentView!.appointmentRect!.width) -
                rtlValue >=
            widget.width &&
        ((!widget.isRTL &&
                newCurrentState._scrollController!.offset ==
                    newCurrentState
                        ._scrollController!.position.maxScrollExtent) ||
            (widget.isRTL && newCurrentState._scrollController!.offset == 0))) {
      if (_timer != null) {
        return;
      }
      _timer =
          Timer.periodic(widget.calendar.dragAndDropSettings.autoNavigateDelay,
              (Timer timer) async {
        if (_dragDetails.value.position.value != null &&
            (_dragDetails.value.position.value!.dx +
                        _dragDetails
                            .value.appointmentView!.appointmentRect!.width) -
                    rtlValue >=
                widget.width &&
            ((!widget.isRTL &&
                    newCurrentState._scrollController!.offset ==
                        newCurrentState
                            ._scrollController!.position.maxScrollExtent) ||
                (widget.isRTL &&
                    newCurrentState._scrollController!.offset == 0))) {
          if (widget.isRTL) {
            _moveToPreviousViewWithAnimation(isScrollToEnd: true);
          } else {
            _moveToNextViewWithAnimation();
          }
          newCurrentState = _getCurrentViewByVisibleDates()!;
          newCurrentState._updateDraggingMouseCursor(true);
          _updateAppointmentDragUpdateCallback(
              isTimelineView,
              viewHeaderHeight,
              timeLabelWidth,
              allDayHeight,
              appointmentPosition,
              isMonthView,
              timeIntervalHeight,
              newCurrentState,
              details,
              isResourceEnabled,
              weekNumberPanelWidth,);
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
      });
    } else if (widget.calendar.dragAndDropSettings.allowNavigation &&
        ((appointmentPosition.dx) - rtlValue).truncate() <= 0 &&
        ((widget.isRTL &&
                newCurrentState._scrollController!.position.pixels ==
                    newCurrentState
                        ._scrollController!.position.maxScrollExtent) ||
            (!widget.isRTL &&
                newCurrentState._scrollController!.offset == 0))) {
      if (_timer != null) {
        return;
      }
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
        if (_dragDetails.value.position.value != null &&
            (_dragDetails.value.position.value!.dx - rtlValue).truncate() <=
                0 &&
            ((widget.isRTL &&
                    newCurrentState._scrollController!.position.pixels ==
                        newCurrentState
                            ._scrollController!.position.maxScrollExtent) ||
                (!widget.isRTL &&
                    newCurrentState._scrollController!.offset == 0))) {
          if (widget.isRTL) {
            _moveToNextViewWithAnimation();
          } else {
            _moveToPreviousViewWithAnimation(isScrollToEnd: true);
          }
          newCurrentState = _getCurrentViewByVisibleDates()!;
          newCurrentState._updateDraggingMouseCursor(true);
          _updateAppointmentDragUpdateCallback(
              isTimelineView,
              viewHeaderHeight,
              timeLabelWidth,
              allDayHeight,
              appointmentPosition,
              isMonthView,
              timeIntervalHeight,
              newCurrentState,
              details,
              isResourceEnabled,
              weekNumberPanelWidth,);
        } else if (_timer != null) {
          _timer!.cancel();
          _timer = null;
        }
      });
    }
  }

  void _updateAppointmentDragUpdateCallback(
      bool isTimelineView,
      double viewHeaderHeight,
      double timeLabelWidth,
      double allDayHeight,
      Offset appointmentPosition,
      bool isMonthView,
      double timeIntervalHeight,
      _CalendarViewState currentState,
      Offset details,
      bool isResourceEnabled,
      double weekNumberPanelWidth,) {
    if (_dragDetails.value.appointmentView == null) {
      return;
    }

    late DateTime draggingTime;
    double xPosition = details.dx;
    double yPosition = appointmentPosition.dy;
    if (isTimelineView) {
      xPosition = appointmentPosition.dx;
      yPosition -= viewHeaderHeight + timeLabelWidth;
    } else {
      if (widget.view == CalendarView.month) {
        if (yPosition < viewHeaderHeight) {
          yPosition = viewHeaderHeight;
        } else if (yPosition > widget.height - 1) {
          yPosition = widget.height - 1;
        }

        yPosition -= viewHeaderHeight;
        if (!widget.isRTL && xPosition <= weekNumberPanelWidth) {
          xPosition = weekNumberPanelWidth;
        } else if (widget.isRTL &&
            xPosition >= (widget.width - weekNumberPanelWidth)) {
          xPosition = widget.width - weekNumberPanelWidth;
        }
      } else {
        if (yPosition < viewHeaderHeight + allDayHeight) {
          yPosition = viewHeaderHeight + allDayHeight;
        } else if (yPosition > widget.height - 1) {
          yPosition = widget.height - 1;
        }

        yPosition -= viewHeaderHeight + allDayHeight;
        if (!widget.isRTL) {
          xPosition -= timeLabelWidth;
        }
      }
    }

    if (xPosition < 0) {
      xPosition = 0;
    } else if (xPosition > widget.width) {
      xPosition = widget.width;
    }

    final double overAllWidth = isTimelineView
        ? currentState._timeIntervalHeight *
            (currentState._horizontalLinesCount! *
                currentState.widget.visibleDates.length)
        : widget.width;
    final double overAllHeight = isTimelineView || isMonthView
        ? widget.height
        : currentState._timeIntervalHeight *
            currentState._horizontalLinesCount!;

    if (isTimelineView &&
        overAllWidth < widget.width &&
        xPosition + _dragDetails.value.appointmentView!.appointmentRect!.width >
            overAllWidth) {
      xPosition = overAllWidth -
          _dragDetails.value.appointmentView!.appointmentRect!.width;
    } else if (!isTimelineView &&
        !isMonthView &&
        overAllHeight < widget.height &&
        yPosition +
                _dragDetails.value.appointmentView!.appointmentRect!.height >
            overAllHeight) {
      yPosition = overAllHeight -
          _dragDetails.value.appointmentView!.appointmentRect!.height;
    }

    draggingTime = currentState._getDateFromPosition(
        xPosition, yPosition, timeLabelWidth,)!;
    if (!isMonthView) {
      if (isTimelineView) {
        final DateTime time = _timeFromPosition(
            draggingTime,
            widget.calendar.timeSlotViewSettings,
            xPosition,
            currentState,
            timeIntervalHeight,
            isTimelineView,)!;

        draggingTime = DateTime(draggingTime.year, draggingTime.month,
            draggingTime.day, time.hour, time.minute,);
      } else {
        if (yPosition < 0) {
          draggingTime = DateTime(
              draggingTime.year, draggingTime.month, draggingTime.day, 0, 0, 0,);
        } else {
          draggingTime = _timeFromPosition(
              draggingTime,
              widget.calendar.timeSlotViewSettings,
              yPosition,
              currentState,
              timeIntervalHeight,
              isTimelineView,)!;
        }
      }
    }

    _dragDetails.value.position.value = Offset(
        _dragDetails.value.position.value!.dx,
        _dragDetails.value.position.value!.dy - 0.1,);
    _dragDetails.value.draggingTime =
        yPosition <= 0 && widget.view != CalendarView.month && !isTimelineView
            ? null
            : draggingTime;
    _dragDetails.value.position.value = Offset(
        _dragDetails.value.position.value!.dx,
        _dragDetails.value.position.value!.dy + 0.1,);

    final dynamic draggingAppointment = _getCalendarAppointmentToObject(
        _dragDetails.value.appointmentView!.appointment, widget.calendar);

    CalendarResource? selectedResource, previousResource;
    int targetResourceIndex = -1;
    int sourceSelectedResourceIndex = -1;
    if (isResourceEnabled) {
      targetResourceIndex = currentState._getSelectedResourceIndex(
          appointmentPosition.dy +
              currentState._timelineViewVerticalScrollController!.offset,
          viewHeaderHeight,
          timeLabelWidth,);
      if (targetResourceIndex >
          widget.calendar.dataSource!.resources!.length - 1) {
        targetResourceIndex = widget.calendar.dataSource!.resources!.length - 1;
      }
      selectedResource =
          widget.calendar.dataSource!.resources![targetResourceIndex];
      sourceSelectedResourceIndex = currentState._getSelectedResourceIndex(
          _dragDetails.value.appointmentView!.appointmentRect!.top,
          viewHeaderHeight,
          timeLabelWidth,);
      previousResource =
          widget.calendar.dataSource!.resources![sourceSelectedResourceIndex];
    }

    final int currentMonth = currentState.widget
        .visibleDates[currentState.widget.visibleDates.length ~/ 2].month;

    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings,);

    final DateTime updateStartTime = draggingTime;

    final Duration appointmentDuration = _dragDetails
                .value.appointmentView!.appointment!.isAllDay &&
            widget.view != CalendarView.month &&
            !isTimelineView
        ? const Duration(hours: 1)
        : _dragDetails.value.appointmentView!.appointment!.endTime.difference(
            _dragDetails.value.appointmentView!.appointment!.startTime,);
    final DateTime updatedEndTime = updateStartTime.add(appointmentDuration);

    if (CalendarViewHelper.isDraggingAppointmentHasDisabledCell(
            _getTimeRegions(),
            _getBlackoutDates(),
            updateStartTime,
            updatedEndTime,
            isTimelineView,
            isMonthView,
            widget.calendar.minDate,
            widget.calendar.maxDate,
            timeInterval,
            targetResourceIndex,
            widget.resourceCollection,) ||
        (widget.view == CalendarView.month &&
            !CalendarViewHelper.isCurrentMonthDate(
                widget.calendar.monthViewSettings.numberOfWeeksInView,
                widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
                currentMonth,
                draggingTime))) {
      currentState._updateDisabledCellMouseCursor(true);
    } else {
      currentState._updateDisabledCellMouseCursor(false);
    }

    if (widget.calendar.onDragUpdate == null) {
      return;
    }

    if (widget.calendar.onDragUpdate != null) {
      widget.calendar.onDragUpdate!(AppointmentDragUpdateDetails(
          draggingAppointment,
          previousResource,
          selectedResource,
          appointmentPosition,
          _dragDetails.value.draggingTime),);
    }
  }

  void _handleLongPressEnd(
      Offset details,
      bool isTimelineView,
      bool isResourceEnabled,
      bool isMonthView,
      double viewHeaderHeight,
      double timeLabelWidth,
      double weekNumberPanelWidth) {
    if (_dragDetails.value.appointmentView == null) {
      return;
    }

    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    final Offset appointmentPosition = details + _dragDifferenceOffset!;
    final _CalendarViewState currentState = _getCurrentViewByVisibleDates()!;
    final double allDayHeight = currentState._isExpanded
        ? _updateCalendarStateDetails.allDayPanelHeight
        : currentState._allDayHeight;
    final double timeIntervalHeight = currentState._getTimeIntervalHeight(
        widget.calendar,
        widget.view,
        widget.width,
        widget.height,
        currentState.widget.visibleDates.length,
        currentState._allDayHeight,
        widget.isMobilePlatform,);
    double xPosition = details.dx;
    double yPosition = appointmentPosition.dy;
    if (isTimelineView) {
      xPosition = !isMonthView ? appointmentPosition.dx : xPosition;
      yPosition -= viewHeaderHeight + timeLabelWidth;
    } else {
      if (widget.view == CalendarView.month) {
        if (yPosition < viewHeaderHeight) {
          yPosition = viewHeaderHeight;
        } else if (yPosition > widget.height - 1) {
          yPosition = widget.height - 1;
        }

        yPosition -= viewHeaderHeight;
        if (!widget.isRTL && xPosition <= weekNumberPanelWidth) {
          xPosition = weekNumberPanelWidth;
        } else if (widget.isRTL &&
            xPosition >= (widget.width - weekNumberPanelWidth)) {
          xPosition = widget.width - weekNumberPanelWidth;
        }
      } else {
        yPosition -= viewHeaderHeight + allDayHeight;
        if (!widget.isRTL) {
          xPosition -= timeLabelWidth;
        }
      }
    }

    if (xPosition < 0) {
      xPosition = 0;
    } else if (xPosition > widget.width) {
      xPosition = widget.width;
    }

    final double overAllWidth = isTimelineView
        ? currentState._timeIntervalHeight *
            (currentState._horizontalLinesCount! *
                currentState.widget.visibleDates.length)
        : widget.width;
    final double overAllHeight = isTimelineView || isMonthView
        ? widget.height
        : currentState._timeIntervalHeight *
            currentState._horizontalLinesCount!;

    if (isTimelineView &&
        overAllWidth < widget.width &&
        xPosition + _dragDetails.value.appointmentView!.appointmentRect!.width >
            overAllWidth) {
      xPosition = overAllWidth -
          _dragDetails.value.appointmentView!.appointmentRect!.width;
    } else if (!isTimelineView &&
        !isMonthView &&
        overAllHeight < widget.height &&
        yPosition +
                _dragDetails.value.appointmentView!.appointmentRect!.height >
            overAllHeight) {
      yPosition = overAllHeight -
          _dragDetails.value.appointmentView!.appointmentRect!.height;
    }

    final CalendarAppointment? appointment =
        _dragDetails.value.appointmentView!.appointment;
    DateTime? dropTime =
        currentState._getDateFromPosition(xPosition, yPosition, timeLabelWidth);
    if (!isMonthView) {
      if (isTimelineView) {
        final DateTime time = _timeFromPosition(
            dropTime!,
            widget.calendar.timeSlotViewSettings,
            xPosition,
            currentState,
            timeIntervalHeight,
            isTimelineView)!;
        dropTime = DateTime(dropTime.year, dropTime.month, dropTime.day,
            time.hour, time.minute,);
      } else {
        dropTime = _timeFromPosition(
            dropTime!,
            widget.calendar.timeSlotViewSettings,
            yPosition,
            currentState,
            timeIntervalHeight,
            isTimelineView,);
      }
    }

    CalendarResource? selectedResource, previousResource;
    int targetResourceIndex = -1;
    int sourceSelectedResourceIndex = -1;
    if (isResourceEnabled) {
      targetResourceIndex = currentState._getSelectedResourceIndex(
          (details.dy - viewHeaderHeight - timeLabelWidth) +
              currentState._timelineViewVerticalScrollController!.offset,
          viewHeaderHeight,
          timeLabelWidth);
      if (targetResourceIndex >
          widget.calendar.dataSource!.resources!.length - 1) {
        targetResourceIndex = widget.calendar.dataSource!.resources!.length - 1;
      }
      selectedResource =
          widget.calendar.dataSource!.resources![targetResourceIndex];
      sourceSelectedResourceIndex = currentState._getSelectedResourceIndex(
          _dragDetails.value.appointmentView!.appointmentRect!.top,
          viewHeaderHeight,
          timeLabelWidth,);
      previousResource =
          widget.calendar.dataSource!.resources![sourceSelectedResourceIndex];
    }

    final int currentMonth = currentState.widget
        .visibleDates[currentState.widget.visibleDates.length ~/ 2].month;

    bool _isAllDay = appointment!.isAllDay;
    if (!isTimelineView && widget.view != CalendarView.month) {
      _isAllDay = yPosition < 0;
      if (_dragDetails.value.appointmentView!.appointment!.isSpanned &&
          !appointment.isAllDay) {
        _isAllDay = appointment.isAllDay;
      }
    } else {
      _isAllDay = appointment.isAllDay;
    }

    DateTime updateStartTime = _isAllDay
        ? DateTime(dropTime!.year, dropTime.month, dropTime.day, 0, 0, 0)
        : dropTime!;

    final Duration appointmentDuration = appointment.isAllDay &&
            widget.view != CalendarView.month &&
            !isTimelineView
        ? const Duration(hours: 1)
        : appointment.endTime.difference(appointment.startTime);
    DateTime updatedEndTime =
        _isAllDay ? updateStartTime : updateStartTime.add(appointmentDuration);

    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);

    final DateTime callbackStartDate = updateStartTime;
    updateStartTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
        updateStartTime, widget.calendar.timeZone, appointment.startTimeZone,);
    updatedEndTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
        updatedEndTime, widget.calendar.timeZone, appointment.endTimeZone);

    if (CalendarViewHelper.isDraggingAppointmentHasDisabledCell(
            _getTimeRegions(),
            _getBlackoutDates(),
            updateStartTime,
            updatedEndTime,
            isTimelineView,
            isMonthView,
            widget.calendar.minDate,
            widget.calendar.maxDate,
            timeInterval,
            targetResourceIndex,
            widget.resourceCollection,) ||
        (widget.view == CalendarView.month &&
            !CalendarViewHelper.isCurrentMonthDate(
                widget.calendar.monthViewSettings.numberOfWeeksInView,
                widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
                currentMonth,
                dropTime))) {
      if (widget.calendar.onDragEnd != null) {
        widget.calendar.onDragEnd!(AppointmentDragEndDetails(
            _getCalendarAppointmentToObject(appointment, widget.calendar),
            previousResource,
            previousResource,
            appointment.exactStartTime));
      }
      _resetDraggingDetails(currentState);
      return;
    }

    CalendarAppointment? parentAppointment;
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
              specificStartDate: currentState.widget.visibleDates[0],
              specificEndDate: currentState.widget
                  .visibleDates[currentState.widget.visibleDates.length - 1]);

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
      bool canAddRecurrence =
          isSameDate(appointment.exactStartTime, callbackStartDate);
      if (!CalendarViewHelper.isDateInDateCollection(
          recurrenceDates, callbackStartDate)) {
        final int currentRecurrenceIndex =
            recurrenceDates.indexOf(appointment.exactStartTime);
        if (currentRecurrenceIndex == 0 ||
            currentRecurrenceIndex == recurrenceDates.length - 1) {
          canAddRecurrence = true;
        } else if (currentRecurrenceIndex < 0) {
          canAddRecurrence = false;
        } else {
          final DateTime previousRecurrence =
              recurrenceDates[currentRecurrenceIndex - 1];
          final DateTime nextRecurrence =
              recurrenceDates[currentRecurrenceIndex + 1];
          canAddRecurrence = (isDateWithInDateRange(
                      previousRecurrence, nextRecurrence, callbackStartDate) &&
                  !isSameDate(previousRecurrence, callbackStartDate) &&
                  !isSameDate(nextRecurrence, callbackStartDate)) ||
              canAddRecurrence;
        }
      }

      if (!canAddRecurrence) {
        if (widget.calendar.onDragEnd != null) {
          widget.calendar.onDragEnd!(AppointmentDragEndDetails(
              _getCalendarAppointmentToObject(appointment, widget.calendar),
              previousResource,
              previousResource,
              appointment.exactStartTime));
        }
        _resetDraggingDetails(currentState);
        return;
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

        appointment.id =
            appointment.recurrenceId != null ? appointment.id : null;
        appointment.recurrenceId =
            appointment.recurrenceId ?? parentAppointment.id;
        appointment.recurrenceRule = null;
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

    appointment.startTime = updateStartTime;
    appointment.endTime = updatedEndTime;
    appointment.isAllDay = _isAllDay;
    if (isResourceEnabled) {
      if (appointment.resourceIds != null &&
          appointment.resourceIds!.isNotEmpty) {
        if (previousResource!.id != selectedResource!.id &&
            !appointment.resourceIds!.contains(selectedResource.id)) {
          appointment.resourceIds!.remove(previousResource.id);
          appointment.resourceIds!.add(selectedResource.id);
        }
      } else {
        appointment.resourceIds = <Object>[selectedResource!.id];
      }
    }

    final dynamic newAppointment =
        _getCalendarAppointmentToObject(appointment, widget.calendar);

    widget.calendar.dataSource!.appointments!.add(newAppointment);
    widget.calendar.dataSource!.notifyListeners(
        CalendarDataSourceAction.add, <dynamic>[newAppointment]);

    _resetDraggingDetails(currentState);
    if (widget.calendar.onDragEnd != null) {
      widget.calendar.onDragEnd!(AppointmentDragEndDetails(newAppointment,
          previousResource, selectedResource, callbackStartDate));
    }
  }

  void _resetDraggingDetails(_CalendarViewState currentState) {
    _dragDetails.value.appointmentView = null;
    _dragDetails.value.position.value = null;
    _dragDifferenceOffset = null;
    _dragDetails.value.timeIntervalHeight = null;
    currentState._hoveringAppointmentView = null;
    currentState._updateDraggingMouseCursor(false);
  }

  /// Method added to get the blackout dates in the current visible views of the
  /// calendar, we have filtered the blackoutdates based on visible dates, and
  /// pass them into the child.
  List<DateTime> _getBlackoutDates() {
    final List<DateTime> blackoutDates = <DateTime>[];
    if (_currentView.blackoutDates != null) {
      blackoutDates.addAll(_currentView.blackoutDates!);
    }
    if (_previousView.blackoutDates != null) {
      blackoutDates.addAll(_previousView.blackoutDates!);
    }
    if (_nextView.blackoutDates != null) {
      blackoutDates.addAll(_nextView.blackoutDates!);
    }

    return blackoutDates;
  }

  /// Method added to get the special time regions from the current visible
  /// views of the calendar, we have filtered the special time regions based on
  /// visible dates, and pass them into the child.
  List<CalendarTimeRegion> _getTimeRegions() {
    final List<CalendarTimeRegion> regions = <CalendarTimeRegion>[];
    if (_currentView.regions != null) {
      regions.addAll(_currentView.regions!);
    }
    if (_previousView.regions != null) {
      regions.addAll(_previousView.regions!);
    }
    if (_nextView.regions != null) {
      regions.addAll(_nextView.regions!);
    }

    return regions;
  }

  /// Get the scroll layout current child view state based on its visible dates.
  _CalendarViewState? _getCurrentViewByVisibleDates() {
    _CalendarView? view;
    for (int i = 0; i < _children.length; i++) {
      final _CalendarView currentView = _children[i];
      if (currentView.visibleDates == _currentViewVisibleDates) {
        view = currentView;
        break;
      }
    }

    if (view == null) {
      return null;
    }

    return (view.key! as GlobalKey<_CalendarViewState>).currentState;
  }

  /// Handle start of the scroll, set the scroll start position and check
  /// the start position as start or end of timeline scroll controller.
  /// If the timeline view scroll starts at min or max scroll position then
  /// move the previous view to end of the scroll or move the next view to
  /// start of the scroll and set the drag as timeline scroll controller drag.
  void _handleDragStart(
      DragStartDetails details,
      bool isNeedDragAndDrop,
      bool isTimelineView,
      bool isResourceEnabled,
      double viewHeaderHeight,
      double timeLabelWidth,
      double resourceViewSize) {
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      return;
    }
    final _CalendarViewState viewKey = _getCurrentViewByVisibleDates()!;
    if (viewKey._hoveringAppointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleAppointmentDragStart(
          viewKey._hoveringAppointmentView!.clone(),
          isTimelineView,
          Offset(details.localPosition.dx - widget.width,
              details.localPosition.dy),
          isResourceEnabled,
          viewHeaderHeight,
          timeLabelWidth);
      return;
    }
    _timelineScrollStartPosition = viewKey._scrollController!.position.pixels;
    _timelineStartPosition = details.globalPosition.dx;
    _isNeedTimelineScrollEnd = false;

    /// If the timeline view scroll starts at min or max scroll position then
    /// move the previous view to end of the scroll or move the next view to
    /// start of the scroll
    if (_timelineScrollStartPosition >=
        viewKey._scrollController!.position.maxScrollExtent) {
      _positionTimelineView();
    } else if (_timelineScrollStartPosition <=
        viewKey._scrollController!.position.minScrollExtent) {
      _positionTimelineView();
    }

    /// Set the drag as timeline scroll controller drag.
    if (viewKey._scrollController!.hasClients) {
      _drag = viewKey._scrollController!.position.drag(details, _disposeDrag);
    }
  }

  /// Handles the scroll update, if the scroll moves after the timeline max
  /// scroll position or before the timeline min scroll position then check the
  /// scroll start position if it is start or end of the timeline scroll view
  /// then pass the touch to custom scroll view and set the timeline view
  /// drag as null;
  void _handleDragUpdate(
      DragUpdateDetails details,
      bool isTimelineView,
      bool isResourceEnabled,
      bool isMonthView,
      double viewHeaderHeight,
      double timeLabelWidth,
      double resourceItemHeight,
      double weekNumberPanelWidth,
      bool isNeedDragAndDrop,
      double resourceViewSize) {
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      return;
    }
    final _CalendarViewState viewKey = _getCurrentViewByVisibleDates()!;

    if (_dragDetails.value.appointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleLongPressMove(
          Offset(details.localPosition.dx - widget.width,
              details.localPosition.dy),
          isTimelineView,
          isResourceEnabled,
          isMonthView,
          viewHeaderHeight,
          timeLabelWidth,
          resourceItemHeight,
          weekNumberPanelWidth);
      return;
    }

    /// Calculate the scroll difference by current scroll position and start
    /// scroll position.
    final double difference =
        details.globalPosition.dx - _timelineStartPosition;
    if (_timelineScrollStartPosition >=
            viewKey._scrollController!.position.maxScrollExtent &&
        ((difference < 0 && !widget.isRTL) ||
            (difference > 0 && widget.isRTL))) {
      /// Set the scroll position as timeline scroll start position and the
      /// value used on horizontal update method.
      _scrollStartPosition = _timelineStartPosition;
      _drag?.cancel();

      /// Move the touch(drag) to custom scroll view.
      _onHorizontalUpdate(details);

      /// Enable boolean value used to trigger the horizontal end animation on
      /// drag end.
      _isNeedTimelineScrollEnd = true;

      /// Remove the timeline view drag or scroll.
      _disposeDrag();
      return;
    } else if (_timelineScrollStartPosition <=
            viewKey._scrollController!.position.minScrollExtent &&
        ((difference > 0 && !widget.isRTL) ||
            (difference < 0 && widget.isRTL))) {
      /// Set the scroll position as timeline scroll start position and the
      /// value used on horizontal update method.
      _scrollStartPosition = _timelineStartPosition;
      _drag?.cancel();

      /// Move the touch(drag) to custom scroll view.
      _onHorizontalUpdate(details);

      /// Enable boolean value used to trigger the horizontal end animation on
      /// drag end.
      _isNeedTimelineScrollEnd = true;

      /// Remove the timeline view drag or scroll.
      _disposeDrag();
      return;
    }

    _drag?.update(details);
  }

  /// Handle the scroll end to update the timeline view scroll or custom scroll
  /// view scroll based on [_isNeedTimelineScrollEnd] value
  void _handleDragEnd(
      DragEndDetails details,
      bool isTimelineView,
      bool isResourceEnabled,
      bool isMonthView,
      double viewHeaderHeight,
      double timeLabelWidth,
      double weekNumberPanelWidth,
      bool isNeedDragAndDrop) {
    if (_dragDetails.value.appointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleLongPressEnd(
          _dragDetails.value.position.value! - _dragDifferenceOffset!,
          isTimelineView,
          isResourceEnabled,
          isMonthView,
          viewHeaderHeight,
          timeLabelWidth,
          weekNumberPanelWidth);
      return;
    }

    if (_isNeedTimelineScrollEnd) {
      _isNeedTimelineScrollEnd = false;
      _onHorizontalEnd(details);
      return;
    }

    _isNeedTimelineScrollEnd = false;
    _drag?.end(details);
  }

  /// Handle drag cancel related operations.
  void _handleDragCancel() {
    _isNeedTimelineScrollEnd = false;
    _drag?.cancel();
  }

  /// Remove the drag when the touch(drag) passed to custom scroll view.
  void _disposeDrag() {
    _drag = null;
  }

  /// Handle the pointer scroll when a pointer signal occurs over this object.
  /// eg., track pad scroll.
  void _handlePointerSignal(PointerSignalEvent event) {
    final _CalendarViewState? viewKey = _getCurrentViewByVisibleDates();
    if (event is PointerScrollEvent && viewKey != null) {
      final double scrolledPosition =
          widget.isRTL ? -event.scrollDelta.dy : event.scrollDelta.dy;
      final double targetScrollOffset = math.min(
          math.max(
              viewKey._scrollController!.position.pixels + scrolledPosition,
              viewKey._scrollController!.position.minScrollExtent),
          viewKey._scrollController!.position.maxScrollExtent);
      if (targetScrollOffset != viewKey._scrollController!.position.pixels) {
        viewKey._scrollController!.position.jumpTo(targetScrollOffset);
      }
    }
  }

  void _updateVisibleDates() {
    widget.getCalendarState(_updateCalendarStateDetails);
    final DateTime currentDate = DateTime(
        _updateCalendarStateDetails.currentDate!.year,
        _updateCalendarStateDetails.currentDate!.month,
        _updateCalendarStateDetails.currentDate!.day);
    final DateTime prevDate = DateTimeHelper.getPreviousViewStartDate(
        widget.view,
        widget.calendar.monthViewSettings.numberOfWeeksInView,
        currentDate);
    final DateTime nextDate = DateTimeHelper.getNextViewStartDate(widget.view,
        widget.calendar.monthViewSettings.numberOfWeeksInView, currentDate);
    final List<int>? nonWorkingDays = (widget.view == CalendarView.workWeek ||
            widget.view == CalendarView.timelineWorkWeek)
        ? widget.calendar.timeSlotViewSettings.nonWorkingDays
        : null;
    final int visibleDatesCount = DateTimeHelper.getViewDatesCount(
        widget.view, widget.calendar.monthViewSettings.numberOfWeeksInView);

    _visibleDates = getVisibleDates(currentDate, nonWorkingDays,
            widget.calendar.firstDayOfWeek, visibleDatesCount)
        .cast();
    _previousViewVisibleDates = getVisibleDates(
            widget.isRTL ? nextDate : prevDate,
            nonWorkingDays,
            widget.calendar.firstDayOfWeek,
            visibleDatesCount)
        .cast();
    _nextViewVisibleDates = getVisibleDates(widget.isRTL ? prevDate : nextDate,
            nonWorkingDays, widget.calendar.firstDayOfWeek, visibleDatesCount)
        .cast();
    if (widget.view == CalendarView.timelineMonth) {
      _visibleDates = DateTimeHelper.getCurrentMonthDates(_visibleDates);
      _previousViewVisibleDates =
          DateTimeHelper.getCurrentMonthDates(_previousViewVisibleDates);
      _nextViewVisibleDates =
          DateTimeHelper.getCurrentMonthDates(_nextViewVisibleDates);
    }

    _currentViewVisibleDates = _visibleDates;
    _updateCalendarStateDetails.currentViewVisibleDates =
        _currentViewVisibleDates;
    widget.updateCalendarState(_updateCalendarStateDetails);

    if (_currentChildIndex == 0) {
      _visibleDates = _nextViewVisibleDates;
      _nextViewVisibleDates = _previousViewVisibleDates;
      _previousViewVisibleDates = _currentViewVisibleDates;
    } else if (_currentChildIndex == 1) {
      _visibleDates = _currentViewVisibleDates;
    } else if (_currentChildIndex == 2) {
      _visibleDates = _previousViewVisibleDates;
      _previousViewVisibleDates = _nextViewVisibleDates;
      _nextViewVisibleDates = _currentViewVisibleDates;
    }
  }

  void _updateNextViewVisibleDates() {
    DateTime currentViewDate = _currentViewVisibleDates[0];
    if (widget.view == CalendarView.month &&
        widget.calendar.monthViewSettings.numberOfWeeksInView == 6) {
      currentViewDate = _currentViewVisibleDates[
          (_currentViewVisibleDates.length / 2).truncate()];
    }

    if (widget.isRTL) {
      currentViewDate = DateTimeHelper.getPreviousViewStartDate(
          widget.view,
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          currentViewDate);
    } else {
      currentViewDate = DateTimeHelper.getNextViewStartDate(
          widget.view,
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          currentViewDate);
    }

    List<DateTime> dates = getVisibleDates(
            currentViewDate,
            widget.view == CalendarView.workWeek ||
                    widget.view == CalendarView.timelineWorkWeek
                ? widget.calendar.timeSlotViewSettings.nonWorkingDays
                : null,
            widget.calendar.firstDayOfWeek,
            DateTimeHelper.getViewDatesCount(widget.view,
                widget.calendar.monthViewSettings.numberOfWeeksInView,),)
        .cast();

    if (widget.view == CalendarView.timelineMonth) {
      dates = DateTimeHelper.getCurrentMonthDates(dates);
    }

    if (_currentChildIndex == 0) {
      _nextViewVisibleDates = dates;
    } else if (_currentChildIndex == 1) {
      _previousViewVisibleDates = dates;
    } else {
      _visibleDates = dates;
    }
  }

  void _updatePreviousViewVisibleDates() {
    DateTime currentViewDate = _currentViewVisibleDates[0];
    if (widget.view == CalendarView.month &&
        widget.calendar.monthViewSettings.numberOfWeeksInView == 6) {
      currentViewDate = _currentViewVisibleDates[
          (_currentViewVisibleDates.length / 2).truncate()];
    }

    if (widget.isRTL) {
      currentViewDate = DateTimeHelper.getNextViewStartDate(
          widget.view,
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          currentViewDate);
    } else {
      currentViewDate = DateTimeHelper.getPreviousViewStartDate(
          widget.view,
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          currentViewDate);
    }

    List<DateTime> dates = getVisibleDates(
            currentViewDate,
            widget.view == CalendarView.workWeek ||
                    widget.view == CalendarView.timelineWorkWeek
                ? widget.calendar.timeSlotViewSettings.nonWorkingDays
                : null,
            widget.calendar.firstDayOfWeek,
            DateTimeHelper.getViewDatesCount(widget.view,
                widget.calendar.monthViewSettings.numberOfWeeksInView))
        .cast();

    if (widget.view == CalendarView.timelineMonth) {
      dates = DateTimeHelper.getCurrentMonthDates(dates);
    }

    if (_currentChildIndex == 0) {
      _visibleDates = dates;
    } else if (_currentChildIndex == 1) {
      _nextViewVisibleDates = dates;
    } else {
      _previousViewVisibleDates = dates;
    }
  }

  void _getCalendarViewStateDetails(UpdateCalendarStateDetails details) {
    widget.getCalendarState(_updateCalendarStateDetails);
    details.currentDate = _updateCalendarStateDetails.currentDate;
    details.currentViewVisibleDates =
        _updateCalendarStateDetails.currentViewVisibleDates;
    details.selectedDate = _updateCalendarStateDetails.selectedDate;
    details.allDayPanelHeight = _updateCalendarStateDetails.allDayPanelHeight;
    details.allDayAppointmentViewCollection =
        _updateCalendarStateDetails.allDayAppointmentViewCollection;
    details.appointments = _updateCalendarStateDetails.appointments;
    details.visibleAppointments =
        _updateCalendarStateDetails.visibleAppointments;
  }

  void _updateCalendarViewStateDetails(UpdateCalendarStateDetails details) {
    _updateCalendarStateDetails.selectedDate = details.selectedDate;
    widget.updateCalendarState(_updateCalendarStateDetails);
  }

  CalendarTimeRegion _getCalendarTimeRegionFromTimeRegion(TimeRegion region) {
    return CalendarTimeRegion(
      startTime: region.startTime,
      endTime: region.endTime,
      color: region.color,
      text: region.text,
      textStyle: region.textStyle,
      recurrenceExceptionDates: region.recurrenceExceptionDates,
      recurrenceRule: region.recurrenceRule,
      resourceIds: region.resourceIds,
      timeZone: region.timeZone,
      enablePointerInteraction: region.enablePointerInteraction,
      iconData: region.iconData,
    );
  }

  /// Return collection of time region, in between the visible dates.
  List<CalendarTimeRegion> _getRegions(List<DateTime> visibleDates) {
    final DateTime visibleStartDate = visibleDates[0];
    final DateTime visibleEndDate = visibleDates[visibleDates.length - 1];
    final List<CalendarTimeRegion> regionCollection = <CalendarTimeRegion>[];
    if (_timeRegions == null) {
      return regionCollection;
    }

    final DateTime startDate =
        AppointmentHelper.convertToStartTime(visibleStartDate);
    final DateTime endDate = AppointmentHelper.convertToEndTime(visibleEndDate);
    for (int j = 0; j < _timeRegions!.length; j++) {
      final TimeRegion timeRegion = _timeRegions![j];
      final CalendarTimeRegion region =
          _getCalendarTimeRegionFromTimeRegion(timeRegion);
      region.actualStartTime =
          AppointmentHelper.convertTimeToAppointmentTimeZone(
              region.startTime, region.timeZone, widget.calendar.timeZone,);
      region.actualEndTime = AppointmentHelper.convertTimeToAppointmentTimeZone(
          region.endTime, region.timeZone, widget.calendar.timeZone);
      region.data = timeRegion;

      if (region.recurrenceRule == null || region.recurrenceRule == '') {
        if (AppointmentHelper.isDateRangeWithinVisibleDateRange(
            region.actualStartTime, region.actualEndTime, startDate, endDate)) {
          regionCollection.add(region);
        }

        continue;
      }

      getRecurrenceRegions(region, regionCollection, startDate, endDate,
          widget.calendar.timeZone,);
    }

    return regionCollection;
  }

  /// Get the recurrence time regions in between the visible date range.
  void getRecurrenceRegions(
      CalendarTimeRegion region,
      List<CalendarTimeRegion> regions,
      DateTime visibleStartDate,
      DateTime visibleEndDate,
      String? calendarTimeZone,) {
    final DateTime regionStartDate = region.actualStartTime;
    if (regionStartDate.isAfter(visibleEndDate)) {
      return;
    }

    String rule = region.recurrenceRule!;
    if (!rule.contains('COUNT') && !rule.contains('UNTIL')) {
      final DateFormat formatter = DateFormat('yyyyMMdd');
      final String newSubString = ';UNTIL=${formatter.format(visibleEndDate)}';
      rule = rule + newSubString;
    }

    final List<DateTime> recursiveDates =
        RecurrenceHelper.getRecurrenceDateTimeCollection(
            rule, region.actualStartTime,
            recurrenceDuration: AppointmentHelper.getDifference(
                region.actualStartTime, region.actualEndTime,),
            specificStartDate: visibleStartDate,
            specificEndDate: visibleEndDate,);

    for (int j = 0; j < recursiveDates.length; j++) {
      final DateTime recursiveDate = recursiveDates[j];
      if (region.recurrenceExceptionDates != null) {
        bool isDateContains = false;
        for (int i = 0; i < region.recurrenceExceptionDates!.length; i++) {
          final DateTime date =
              AppointmentHelper.convertTimeToAppointmentTimeZone(
                  region.recurrenceExceptionDates![i], '', calendarTimeZone);
          if (isSameDate(date, recursiveDate)) {
            isDateContains = true;
            break;
          }
        }
        if (isDateContains) {
          continue;
        }
      }

      final CalendarTimeRegion occurrenceRegion =
          cloneRecurrenceRegion(region, recursiveDate, calendarTimeZone);
      regions.add(occurrenceRegion);
    }
  }

  /// Used to clone the time region with new values.
  CalendarTimeRegion cloneRecurrenceRegion(CalendarTimeRegion region,
      DateTime recursiveDate, String? calendarTimeZone) {
    final int minutes = AppointmentHelper.getDifference(
            region.actualStartTime, region.actualEndTime)
        .inMinutes;
    final DateTime actualEndTime = DateTimeHelper.getDateTimeValue(
        addDuration(recursiveDate, Duration(minutes: minutes)));
    final DateTime startDate =
        AppointmentHelper.convertTimeToAppointmentTimeZone(
            recursiveDate, calendarTimeZone, region.timeZone,);

    final DateTime endDate = AppointmentHelper.convertTimeToAppointmentTimeZone(
        actualEndTime, calendarTimeZone, region.timeZone,);

    final TimeRegion occurrenceTimeRegion =
        region.data.copyWith(startTime: startDate, endTime: endDate);
    final CalendarTimeRegion occurrenceRegion =
        _getCalendarTimeRegionFromTimeRegion(occurrenceTimeRegion);
    occurrenceRegion.actualStartTime = recursiveDate;
    occurrenceRegion.actualEndTime = actualEndTime;
    occurrenceRegion.data = occurrenceTimeRegion;
    return occurrenceRegion;
  }

  /// Return date collection which falls between the visible date range.
  List<DateTime> _getDatesWithInVisibleDateRange(
      List<DateTime>? dates, List<DateTime> visibleDates) {
    final List<DateTime> visibleMonthDates = <DateTime>[];
    if (dates == null) {
      return visibleMonthDates;
    }

    final DateTime visibleStartDate = visibleDates[0];
    final DateTime visibleEndDate = visibleDates[visibleDates.length - 1];
    final int datesCount = dates.length;
    final Map<String, DateTime> dateCollection = <String, DateTime>{};
    for (int i = 0; i < datesCount; i++) {
      final DateTime currentDate = dates[i];
      if (!isDateWithInDateRange(
          visibleStartDate, visibleEndDate, currentDate)) {
        continue;
      }

      if (dateCollection.keys.contains(
          currentDate.day.toString() + currentDate.month.toString())) {
        continue;
      }

      dateCollection[currentDate.day.toString() +
          currentDate.month.toString()] = currentDate;
      visibleMonthDates.add(currentDate);
    }

    return visibleMonthDates;
  }

  List<Widget> _addViews() {
    if (_children.isEmpty) {
      _previousView = _CalendarView(
        widget.calendar,
        widget.view,
        _previousViewVisibleDates,
        widget.width,
        widget.height,
        widget.agendaSelectedDate,
        widget.locale,
        widget.calendarTheme,
        _getRegions(_previousViewVisibleDates),
        _getDatesWithInVisibleDateRange(
            widget.blackoutDates, _previousViewVisibleDates),
        _focusNode,
        widget.removePicker,
        widget.calendar.allowViewNavigation,
        widget.controller,
        widget.resourcePanelScrollController,
        widget.resourceCollection,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.minDate,
        widget.maxDate,
        widget.localizations,
        widget.timelineMonthWeekNumberNotifier,
        _dragDetails,
        (UpdateCalendarStateDetails details) {
          _updateCalendarViewStateDetails(details);
        },
        (UpdateCalendarStateDetails details) {
          _getCalendarViewStateDetails(details);
        },
        key: _previousViewKey,
        onMoreDayClick: widget.onMoreDayClick,
      );
      _currentView = _CalendarView(
        widget.calendar,
        widget.view,
        _visibleDates,
        widget.width,
        widget.height,
        widget.agendaSelectedDate,
        widget.locale,
        widget.calendarTheme,
        _getRegions(_visibleDates),
        _getDatesWithInVisibleDateRange(widget.blackoutDates, _visibleDates),
        _focusNode,
        widget.removePicker,
        widget.calendar.allowViewNavigation,
        widget.controller,
        widget.resourcePanelScrollController,
        widget.resourceCollection,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.minDate,
        widget.maxDate,
        widget.localizations,
        widget.timelineMonthWeekNumberNotifier,
        _dragDetails,
        (UpdateCalendarStateDetails details) {
          _updateCalendarViewStateDetails(details);
        },
        (UpdateCalendarStateDetails details) {
          _getCalendarViewStateDetails(details);
        },
        key: _currentViewKey,
        onMoreDayClick: widget.onMoreDayClick,
      );
      _nextView = _CalendarView(
        widget.calendar,
        widget.view,
        _nextViewVisibleDates,
        widget.width,
        widget.height,
        widget.agendaSelectedDate,
        widget.locale,
        widget.calendarTheme,
        _getRegions(_nextViewVisibleDates),
        _getDatesWithInVisibleDateRange(
            widget.blackoutDates, _nextViewVisibleDates),
        _focusNode,
        widget.removePicker,
        widget.calendar.allowViewNavigation,
        widget.controller,
        widget.resourcePanelScrollController,
        widget.resourceCollection,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.minDate,
        widget.maxDate,
        widget.localizations,
        widget.timelineMonthWeekNumberNotifier,
        _dragDetails,
        (UpdateCalendarStateDetails details) {
          _updateCalendarViewStateDetails(details);
        },
        (UpdateCalendarStateDetails details) {
          _getCalendarViewStateDetails(details);
        },
        key: _nextViewKey,
        onMoreDayClick: widget.onMoreDayClick,
      );

      _children.add(_previousView);
      _children.add(_currentView);
      _children.add(_nextView);
      return _children;
    }

    widget.getCalendarState(_updateCalendarStateDetails);
    final _CalendarView previousView = _updateViews(
        _previousView, _previousViewKey, _previousViewVisibleDates);
    final _CalendarView currentView =
        _updateViews(_currentView, _currentViewKey, _visibleDates);
    final _CalendarView nextView =
        _updateViews(_nextView, _nextViewKey, _nextViewVisibleDates);

    //// Update views while the all day view height differ from original height,
    //// else repaint the appointment painter while current child visible appointment not equals calendar visible appointment
    if (_previousView != previousView) {
      _previousView = previousView;
    }
    if (_currentView != currentView) {
      _currentView = currentView;
    }
    if (_nextView != nextView) {
      _nextView = nextView;
    }

    return _children;
  }

  // method to check and update the views and appointments on the swiping end
  _CalendarView _updateViews(_CalendarView view,
      GlobalKey<_CalendarViewState> viewKey, List<DateTime> visibleDates) {
    _CalendarView newView = view;
    final int index = _children.indexOf(newView);

    final AppointmentLayout appointmentLayout =
        viewKey.currentState!._appointmentLayout;
    // update the view with the visible dates on swiping end.
    if (newView.visibleDates != visibleDates) {
      newView = _CalendarView(
        widget.calendar,
        widget.view,
        visibleDates,
        widget.width,
        widget.height,
        widget.agendaSelectedDate,
        widget.locale,
        widget.calendarTheme,
        _getRegions(visibleDates),
        _getDatesWithInVisibleDateRange(widget.blackoutDates, visibleDates),
        _focusNode,
        widget.removePicker,
        widget.calendar.allowViewNavigation,
        widget.controller,
        widget.resourcePanelScrollController,
        widget.resourceCollection,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.minDate,
        widget.maxDate,
        widget.localizations,
        widget.timelineMonthWeekNumberNotifier,
        _dragDetails,
        (UpdateCalendarStateDetails details) {
          _updateCalendarViewStateDetails(details);
        },
        (UpdateCalendarStateDetails details) {
          _getCalendarViewStateDetails(details);
        },
        key: viewKey,
        onMoreDayClick: widget.onMoreDayClick,
      );

      _children[index] = newView;
    } // check and update the visible appointments in the view
    else if (!CalendarViewHelper.isCollectionEqual(
        appointmentLayout.visibleAppointments.value,
        _updateCalendarStateDetails.visibleAppointments)) {
      if (widget.view != CalendarView.month &&
          !CalendarViewHelper.isTimelineView(widget.view)) {
        newView = _CalendarView(
          widget.calendar,
          widget.view,
          visibleDates,
          widget.width,
          widget.height,
          widget.agendaSelectedDate,
          widget.locale,
          widget.calendarTheme,
          newView.regions,
          newView.blackoutDates,
          _focusNode,
          widget.removePicker,
          widget.calendar.allowViewNavigation,
          widget.controller,
          widget.resourcePanelScrollController,
          widget.resourceCollection,
          widget.textScaleFactor,
          widget.isMobilePlatform,
          widget.minDate,
          widget.maxDate,
          widget.localizations,
          widget.timelineMonthWeekNumberNotifier,
          _dragDetails,
          (UpdateCalendarStateDetails details) {
            _updateCalendarViewStateDetails(details);
          },
          (UpdateCalendarStateDetails details) {
            _getCalendarViewStateDetails(details);
          },
          key: viewKey,
          onMoreDayClick: widget.onMoreDayClick,
        );
        _children[index] = newView;
      } else if (newView.visibleDates == _currentViewVisibleDates) {
        /// Remove the appointment selection when the selected
        /// appointment removed.
        if (viewKey.currentState!._selectionPainter != null &&
            viewKey.currentState!._selectionPainter!.appointmentView != null &&
            (!_updateCalendarStateDetails.visibleAppointments.contains(viewKey
                .currentState!
                ._selectionPainter!
                .appointmentView!
                .appointment))) {
          viewKey.currentState!._selectionPainter!.appointmentView = null;
          viewKey.currentState!._selectionPainter!.repaintNotifier.value =
              !viewKey.currentState!._selectionPainter!.repaintNotifier.value;
        }

        appointmentLayout.visibleAppointments.value =
            _updateCalendarStateDetails.visibleAppointments;
        if (widget.view == CalendarView.month &&
            widget.calendar.monthCellBuilder != null) {
          viewKey.currentState!._monthView.visibleAppointmentNotifier.value =
              _updateCalendarStateDetails.visibleAppointments;
        }
      }
    }
    // When calendar state changed the state doesn't pass to the child of
    // custom scroll view, hence to update the calendar state to the child we
    // have added this.
    else if (newView.calendar != widget.calendar) {
      /// Update the calendar view when calendar properties like blackout dates
      /// dynamically changed.
      newView = _CalendarView(
        widget.calendar,
        widget.view,
        visibleDates,
        widget.width,
        widget.height,
        widget.agendaSelectedDate,
        widget.locale,
        widget.calendarTheme,
        newView.regions,
        newView.blackoutDates,
        _focusNode,
        widget.removePicker,
        widget.calendar.allowViewNavigation,
        widget.controller,
        widget.resourcePanelScrollController,
        widget.resourceCollection,
        widget.textScaleFactor,
        widget.isMobilePlatform,
        widget.minDate,
        widget.maxDate,
        widget.localizations,
        widget.timelineMonthWeekNumberNotifier,
        _dragDetails,
        (UpdateCalendarStateDetails details) {
          _updateCalendarViewStateDetails(details);
        },
        (UpdateCalendarStateDetails details) {
          _getCalendarViewStateDetails(details);
        },
        key: viewKey,
        onMoreDayClick: widget.onMoreDayClick,
      );

      _children[index] = newView;
    }

    return newView;
  }

  void animationListener() {
    setState(() {
      _position = _animation.value;
    });
  }

  /// Check both the region collection as equal or not.
  bool _isTimeRegionsEquals(
      List<TimeRegion>? regions1, List<TimeRegion>? regions2) {
    /// Check both instance as equal
    /// eg., if both are null then its equal.
    if (regions1 == regions2) {
      return true;
    }

    /// Check the collections are not equal based on its length
    if (regions2 == null ||
        regions1 == null ||
        regions1.length != regions2.length) {
      return false;
    }

    /// Check each of the region is equal to another or not.
    for (int i = 0; i < regions1.length; i++) {
      if (regions1[i] != regions2[i]) {
        return false;
      }
    }

    return true;
  }

  /// Updates the selected date programmatically, when resource enables, in
  /// this scenario the first resource cell will be selected
  void _selectResourceProgrammatically() {
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      return;
    }

    for (int i = 0; i < _children.length; i++) {
      final GlobalKey<_CalendarViewState> viewKey =
          // ignore: avoid_as
          _children[i].key! as GlobalKey<_CalendarViewState>;
      if (CalendarViewHelper.isResourceEnabled(
          widget.calendar.dataSource, widget.view)) {
        viewKey.currentState!._selectedResourceIndex = 0;
        viewKey.currentState!._selectionPainter!.selectedResourceIndex = 0;
      } else {
        viewKey.currentState!._selectedResourceIndex = -1;
        viewKey.currentState!._selectionPainter!.selectedResourceIndex = -1;
      }
    }
  }

  /// Updates the selection, when the resource enabled and the resource
  /// collection modified, moves or removes the selection based on the action
  /// performed.
  void _updateSelectedResourceIndex() {
    for (int i = 0; i < _children.length; i++) {
      final GlobalKey<_CalendarViewState> viewKey =
          // ignore: avoid_as
          _children[i].key! as GlobalKey<_CalendarViewState>;
      final int selectedResourceIndex =
          viewKey.currentState!._selectedResourceIndex;
      if (selectedResourceIndex != -1) {
        final Object selectedResourceId =
            widget.resourceCollection![selectedResourceIndex].id;
        final int newIndex = CalendarViewHelper.getResourceIndex(
            widget.calendar.dataSource?.resources, selectedResourceId);
        viewKey.currentState!._selectedResourceIndex = newIndex;
      }
    }
  }

  void _updateSelection() {
    widget.getCalendarState(_updateCalendarStateDetails);
    final _CalendarViewState previousViewState = _previousViewKey.currentState!;
    final _CalendarViewState currentViewState = _currentViewKey.currentState!;
    final _CalendarViewState nextViewState = _nextViewKey.currentState!;
    previousViewState._allDaySelectionNotifier.value = null;
    currentViewState._allDaySelectionNotifier.value = null;
    nextViewState._allDaySelectionNotifier.value = null;
    previousViewState._selectionPainter!.selectedDate =
        _updateCalendarStateDetails.selectedDate;
    nextViewState._selectionPainter!.selectedDate =
        _updateCalendarStateDetails.selectedDate;
    currentViewState._selectionPainter!.selectedDate =
        _updateCalendarStateDetails.selectedDate;
    previousViewState._selectionPainter!.appointmentView = null;
    nextViewState._selectionPainter!.appointmentView = null;
    currentViewState._selectionPainter!.appointmentView = null;
    previousViewState._selectionNotifier.value =
        !previousViewState._selectionNotifier.value;
    currentViewState._selectionNotifier.value =
        !currentViewState._selectionNotifier.value;
    nextViewState._selectionNotifier.value =
        !nextViewState._selectionNotifier.value;
  }

  void _updateMoveToDate() {
    if (widget.view == CalendarView.month) {
      return;
    }

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (_currentChildIndex == 0) {
        _previousViewKey.currentState?._scrollToPosition();
      } else if (_currentChildIndex == 1) {
        _currentViewKey.currentState?._scrollToPosition();
      } else if (_currentChildIndex == 2) {
        _nextViewKey.currentState?._scrollToPosition();
      }
    });
  }

  CalendarDetails? _getCalendarDetails(Offset position) {
    if (_currentChildIndex == 0) {
      return _previousViewKey.currentState?._getCalendarViewDetails(position);
    } else if (_currentChildIndex == 1) {
      return _currentViewKey.currentState?._getCalendarViewDetails(position);
    } else if (_currentChildIndex == 2) {
      return _nextViewKey.currentState?._getCalendarViewDetails(position);
    } else {
      return null;
    }
  }

  /// Updates the current view visible dates for calendar in the swiping end
  void _updateCurrentViewVisibleDates({bool isNextView = false}) {
    if (isNextView) {
      if (_currentChildIndex == 0) {
        _currentViewVisibleDates = _visibleDates;
      } else if (_currentChildIndex == 1) {
        _currentViewVisibleDates = _nextViewVisibleDates;
      } else {
        _currentViewVisibleDates = _previousViewVisibleDates;
      }
    } else {
      if (_currentChildIndex == 0) {
        _currentViewVisibleDates = _nextViewVisibleDates;
      } else if (_currentChildIndex == 1) {
        _currentViewVisibleDates = _previousViewVisibleDates;
      } else {
        _currentViewVisibleDates = _visibleDates;
      }
    }

    _updateCalendarStateDetails.currentViewVisibleDates =
        _currentViewVisibleDates;
    if (widget.view == CalendarView.month &&
        widget.calendar.monthViewSettings.numberOfWeeksInView == 6) {
      final DateTime currentMonthDate =
          _currentViewVisibleDates[_currentViewVisibleDates.length ~/ 2];
      _updateCalendarStateDetails.currentDate =
          DateTime(currentMonthDate.year, currentMonthDate.month, 01);
    } else {
      _updateCalendarStateDetails.currentDate = _currentViewVisibleDates[0];
    }

    widget.updateCalendarState(_updateCalendarStateDetails);
  }

  void _updateNextView() {
    if (!_animationController.isCompleted) {
      return;
    }

    _updateSelection();
    _updateNextViewVisibleDates();

    /// Updates the all day panel of the view, when the all day panel expanded
    /// and the view swiped with the expanded all day panel, and when we swipe
    /// back to the view or swipes three times will render the all day panel as
    /// expanded, to collapse the all day panel in day, week and work week view,
    /// we have added this condition and called the method.
    if (widget.view != CalendarView.month &&
        !CalendarViewHelper.isTimelineView(widget.view)) {
      _updateAllDayPanel();
    }

    setState(() {
      /// Update the custom scroll layout current child index when the
      /// animation ends.
      if (_currentChildIndex == 0) {
        _currentChildIndex = 1;
      } else if (_currentChildIndex == 1) {
        _currentChildIndex = 2;
      } else if (_currentChildIndex == 2) {
        _currentChildIndex = 0;
      }
    });

    _resetPosition();
    _updateAppointmentPainter();
  }

  void _updatePreviousView() {
    if (!_animationController.isCompleted) {
      return;
    }

    _updateSelection();
    _updatePreviousViewVisibleDates();

    /// Updates the all day panel of the view, when the all day panel expanded
    /// and the view swiped with the expanded all day panel, and when we swipe
    /// back to the view or swipes three times will render the all day panel as
    /// expanded, to collapse the all day panel in day, week and work week view,
    /// we have added this condition and called the method.
    if (widget.view != CalendarView.month &&
        !CalendarViewHelper.isTimelineView(widget.view)) {
      _updateAllDayPanel();
    }

    setState(() {
      /// Update the custom scroll layout current child index when the
      /// animation ends.
      if (_currentChildIndex == 0) {
        _currentChildIndex = 2;
      } else if (_currentChildIndex == 1) {
        _currentChildIndex = 0;
      } else if (_currentChildIndex == 2) {
        _currentChildIndex = 1;
      }
    });

    _resetPosition();
    _updateAppointmentPainter();
  }

  void _moveToNextViewWithAnimation() {
    if (!widget.isMobilePlatform) {
      _moveToNextWebViewWithAnimation();
      return;
    }

    if (!DateTimeHelper.canMoveToNextView(
        widget.view,
        widget.calendar.monthViewSettings.numberOfWeeksInView,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        _currentViewVisibleDates,
        widget.calendar.timeSlotViewSettings.nonWorkingDays,
        widget.isRTL)) {
      return;
    }

    // Resets the controller to forward it again, the animation will forward
    // only from the dismissed state
    if (_animationController.isCompleted || _animationController.isDismissed) {
      _animationController.reset();
    } else {
      return;
    }

    // Handled for time line view, to move the previous and next view to it's
    // start and end position accordingly
    if (CalendarViewHelper.isTimelineView(widget.view)) {
      _positionTimelineView(isScrolledToEnd: false);
    }

    if (widget.calendar.monthViewSettings.navigationDirection ==
            MonthNavigationDirection.vertical &&
        widget.view == CalendarView.month) {
      // update the bottom to top swiping
      _tween.begin = 0;
      _tween.end = -widget.height;
    } else {
      // update the right to left swiping
      _tween.begin = 0;
      _tween.end = -widget.width;
    }

    _animationController.duration = const Duration(milliseconds: 250);
    _animationController
        .forward()
        .then<dynamic>((dynamic value) => _updateNextView());

    /// updates the current view visible dates when the view swiped
    _updateCurrentViewVisibleDates(isNextView: true);
  }

  void _moveToPreviousViewWithAnimation({bool isScrollToEnd = false}) {
    if (!widget.isMobilePlatform) {
      _moveToPreviousWebViewWithAnimation(isScrollToEnd: isScrollToEnd);
      return;
    }

    if (!DateTimeHelper.canMoveToPreviousView(
        widget.view,
        widget.calendar.monthViewSettings.numberOfWeeksInView,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        _currentViewVisibleDates,
        widget.calendar.timeSlotViewSettings.nonWorkingDays,
        widget.isRTL)) {
      return;
    }

    // Resets the controller to backward it again, the animation will backward
    // only from the dismissed state
    if (_animationController.isCompleted || _animationController.isDismissed) {
      _animationController.reset();
    } else {
      return;
    }

    // Handled for time line view, to move the previous and next view to it's
    // start and end position accordingly
    if (CalendarViewHelper.isTimelineView(widget.view)) {
      _positionTimelineView(isScrolledToEnd: isScrollToEnd);
    }

    if (widget.calendar.monthViewSettings.navigationDirection ==
            MonthNavigationDirection.vertical &&
        widget.view == CalendarView.month) {
      // update the top to bottom swiping
      _tween.begin = 0;
      _tween.end = widget.height;
    } else {
      // update the left to right swiping
      _tween.begin = 0;
      _tween.end = widget.width;
    }

    _animationController.duration = const Duration(milliseconds: 250);
    _animationController
        .forward()
        .then<dynamic>((dynamic value) => _updatePreviousView());

    /// updates the current view visible dates when the view swiped.
    _updateCurrentViewVisibleDates();
  }

  void _moveToPreviousWebViewWithAnimation({bool isScrollToEnd = false}) {
    if (!DateTimeHelper.canMoveToPreviousView(
        widget.view,
        widget.calendar.monthViewSettings.numberOfWeeksInView,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        _currentViewVisibleDates,
        widget.calendar.timeSlotViewSettings.nonWorkingDays,
        widget.isRTL)) {
      return;
    }

    /// Resets the animation from, we have added this without condition so that
    /// the selection updates, when the cells selected through keyboard right
    /// arrows with fast finger.
    widget.fadeInController!.reset();

    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    // Handled for time line view, to move the previous and next view to it's
    // start and end position accordingly
    if (isTimelineView) {
      _positionTimelineView(isScrolledToEnd: isScrollToEnd);
    } else if (!isTimelineView && widget.view != CalendarView.month) {
      _updateDayViewScrollPosition();
    }

    /// updates the current view visible dates when the view swiped.
    _updateCurrentViewVisibleDates();
    _position = 0;
    widget.fadeInController!.forward();
    _updateSelection();
    _updatePreviousViewVisibleDates();

    /// Updates the all day panel of the view, when the all day panel expanded
    /// and the view swiped with the expanded all day panel, and when we swipe
    /// back to the view or swipes three times will render the all day panel as
    /// expanded, to collapse the all day panel in day, week and work week view,
    /// we have added this condition and called the method.
    if (widget.view != CalendarView.month && !isTimelineView) {
      _updateAllDayPanel();
    }

    if (_currentChildIndex == 0) {
      _currentChildIndex = 2;
    } else if (_currentChildIndex == 1) {
      _currentChildIndex = 0;
    } else if (_currentChildIndex == 2) {
      _currentChildIndex = 1;
    }

    _updateAppointmentPainter();
  }

  void _moveToNextWebViewWithAnimation() {
    if (!DateTimeHelper.canMoveToNextView(
        widget.view,
        widget.calendar.monthViewSettings.numberOfWeeksInView,
        widget.calendar.minDate,
        widget.calendar.maxDate,
        _currentViewVisibleDates,
        widget.calendar.timeSlotViewSettings.nonWorkingDays,
        widget.isRTL)) {
      return;
    }

    /// Resets the animation from, we have added this without condition so that
    /// the selection updates, when the cells selected through keyboard right
    /// arrows with fast finger.
    widget.fadeInController!.reset();

    final bool isTimelineView = CalendarViewHelper.isTimelineView(widget.view);
    // Handled for time line view, to move the previous and next view to it's
    // start and end position accordingly
    if (isTimelineView) {
      _positionTimelineView(isScrolledToEnd: false);
    } else if (!isTimelineView && widget.view != CalendarView.month) {
      _updateDayViewScrollPosition();
    }

    /// updates the current view visible dates when the view swiped
    _updateCurrentViewVisibleDates(isNextView: true);

    _position = 0;
    widget.fadeInController!.forward();
    _updateSelection();
    _updateNextViewVisibleDates();

    /// Updates the all day panel of the view, when the all day panel expanded
    /// and the view swiped with the expanded all day panel, and when we swipe
    /// back to the view or swipes three times will render the all day panel as
    /// expanded, to collapse the all day panel in day, week and work week view,
    /// we have added this condition and called the method.
    if (widget.view != CalendarView.month && !isTimelineView) {
      _updateAllDayPanel();
    }

    if (_currentChildIndex == 0) {
      _currentChildIndex = 1;
    } else if (_currentChildIndex == 1) {
      _currentChildIndex = 2;
    } else if (_currentChildIndex == 2) {
      _currentChildIndex = 0;
    }

    _updateAppointmentPainter();
  }

  // resets position to zero on the swipe end to avoid the unwanted date updates
  void _resetPosition() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (_position.abs() == widget.width || _position.abs() == widget.height) {
        _position = 0;
      }
    });
  }

  void _updateScrollPosition() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (_previousViewKey.currentState == null ||
          _currentViewKey.currentState == null ||
          _nextViewKey.currentState == null ||
          _previousViewKey.currentState!._scrollController == null ||
          _currentViewKey.currentState!._scrollController == null ||
          _nextViewKey.currentState!._scrollController == null ||
          !_previousViewKey.currentState!._scrollController!.hasClients ||
          !_currentViewKey.currentState!._scrollController!.hasClients ||
          !_nextViewKey.currentState!._scrollController!.hasClients) {
        return;
      }

      _updateDayViewScrollPosition();
    });
  }

  /// Update the current day view view scroll position to other views.
  void _updateDayViewScrollPosition() {
    double scrolledPosition = 0;
    if (_currentChildIndex == 0) {
      scrolledPosition =
          _previousViewKey.currentState!._scrollController!.offset;
    } else if (_currentChildIndex == 1) {
      scrolledPosition =
          _currentViewKey.currentState!._scrollController!.offset;
    } else if (_currentChildIndex == 2) {
      scrolledPosition = _nextViewKey.currentState!._scrollController!.offset;
    }

    if (_previousViewKey.currentState!._scrollController!.offset !=
            scrolledPosition &&
        _previousViewKey
                .currentState!._scrollController!.position.maxScrollExtent >=
            scrolledPosition) {
      _previousViewKey.currentState!._scrollController!
          .jumpTo(scrolledPosition);
    }

    if (_currentViewKey.currentState!._scrollController!.offset !=
            scrolledPosition &&
        _currentViewKey
                .currentState!._scrollController!.position.maxScrollExtent >=
            scrolledPosition) {
      _currentViewKey.currentState!._scrollController!.jumpTo(scrolledPosition);
    }

    if (_nextViewKey.currentState!._scrollController!.offset !=
            scrolledPosition &&
        _nextViewKey
                .currentState!._scrollController!.position.maxScrollExtent >=
            scrolledPosition) {
      _nextViewKey.currentState!._scrollController!.jumpTo(scrolledPosition);
    }
  }

  int _getRowOfDate(List<DateTime> visibleDates, DateTime selectedDate) {
    for (int i = 0; i < visibleDates.length; i++) {
      if (isSameDate(selectedDate, visibleDates[i])) {
        switch (widget.view) {
          case CalendarView.day:
          case CalendarView.week:
          case CalendarView.workWeek:
          case CalendarView.schedule:
            return -1;
          case CalendarView.month:
            return i ~/ DateTime.daysPerWeek;
          case CalendarView.timelineDay:
          case CalendarView.timelineWeek:
          case CalendarView.timelineWorkWeek:
          case CalendarView.timelineMonth:
            return i;
        }
      }
    }

    return -1;
  }

  DateTime _updateSelectedDateForRightArrow(_CalendarView currentView,
      _CalendarViewState currentViewState, DateTime? selectedDate) {
    /// Condition added to move the view to next view when the selection reaches
    /// the last horizontal cell of the view in day, week, workweek, month and
    /// timeline month.
    DateTime? newSelectedDate = selectedDate;
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      final int visibleDatesCount = currentView.visibleDates.length;
      if (isSameDate(
          currentView.visibleDates[visibleDatesCount - 1], newSelectedDate)) {
        _moveToNextViewWithAnimation();
      }

      newSelectedDate = AppointmentHelper.addDaysWithTime(newSelectedDate!, 1,
          newSelectedDate.hour, newSelectedDate.minute, newSelectedDate.second);

      /// Move to next view when the new selected date as next month date.
      if (widget.view == CalendarView.month &&
          !CalendarViewHelper.isCurrentMonthDate(
              widget.calendar.monthViewSettings.numberOfWeeksInView,
              widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
              currentView.visibleDates[visibleDatesCount ~/ 2].month,
              newSelectedDate)) {
        _moveToNextViewWithAnimation();
      } else if (widget.view == CalendarView.workWeek) {
        for (int i = 0;
            i <
                DateTime.daysPerWeek -
                    widget.calendar.timeSlotViewSettings.nonWorkingDays.length;
            i++) {
          if (widget.calendar.timeSlotViewSettings.nonWorkingDays
              .contains(newSelectedDate!.weekday)) {
            newSelectedDate = AppointmentHelper.addDaysWithTime(
                newSelectedDate,
                1,
                newSelectedDate.hour,
                newSelectedDate.minute,
                newSelectedDate.second);
          } else {
            break;
          }
        }
      }
    } else {
      final double xPosition = widget.view == CalendarView.timelineMonth
          ? 0
          : AppointmentHelper.timeToPosition(widget.calendar, newSelectedDate!,
              currentViewState._timeIntervalHeight);
      final int rowIndex =
          _getRowOfDate(currentView.visibleDates, newSelectedDate!);
      final double singleChildWidth =
          _getSingleViewWidthForTimeLineView(currentViewState);
      if ((rowIndex * singleChildWidth) +
              xPosition +
              currentViewState._timeIntervalHeight >=
          currentViewState._scrollController!.offset + widget.width) {
        currentViewState._scrollController!.jumpTo(
            currentViewState._scrollController!.offset +
                currentViewState._timeIntervalHeight);
      }
      if (widget.view == CalendarView.timelineDay &&
          newSelectedDate
                  .add(widget.calendar.timeSlotViewSettings.timeInterval)
                  .day !=
              currentView
                  .visibleDates[currentView.visibleDates.length - 1].day) {
        _moveToNextViewWithAnimation();
      }

      if ((rowIndex * singleChildWidth) +
              xPosition +
              currentViewState._timeIntervalHeight ==
          currentViewState._scrollController!.position.maxScrollExtent +
              currentViewState._scrollController!.position.viewportDimension) {
        _moveToNextViewWithAnimation();
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _moveToSelectedTimeSlot();
        });
      }

      /// For timeline month view each column represents a single day, and for
      /// other timeline views each column represents a given time interval,
      /// hence to update the selected date for timeline month we must add a day
      /// and for other timeline views we must add the given time interval.
      if (widget.view == CalendarView.timelineMonth) {
        newSelectedDate = AppointmentHelper.addDaysWithTime(
            newSelectedDate,
            1,
            newSelectedDate.hour,
            newSelectedDate.minute,
            newSelectedDate.second);
      } else {
        newSelectedDate = newSelectedDate
            .add(widget.calendar.timeSlotViewSettings.timeInterval);
      }
      if (widget.view == CalendarView.timelineWorkWeek) {
        for (int i = 0;
            i <
                DateTime.daysPerWeek -
                    widget.calendar.timeSlotViewSettings.nonWorkingDays.length;
            i++) {
          if (widget.calendar.timeSlotViewSettings.nonWorkingDays
              .contains(newSelectedDate!.weekday)) {
            newSelectedDate = AppointmentHelper.addDaysWithTime(
                newSelectedDate,
                1,
                newSelectedDate.hour,
                newSelectedDate.minute,
                newSelectedDate.second);
          } else {
            break;
          }
        }
      }
    }

    return newSelectedDate!;
  }

  DateTime _updateSelectedDateForLeftArrow(_CalendarView currentView,
      _CalendarViewState currentViewState, DateTime? selectedDate) {
    DateTime? newSelectedDate = selectedDate;
    if (!CalendarViewHelper.isTimelineView(widget.view)) {
      if (isSameDate(
          currentViewState.widget.visibleDates[0], newSelectedDate)) {
        _moveToPreviousViewWithAnimation();
      }

      newSelectedDate = AppointmentHelper.addDaysWithTime(newSelectedDate!, -1,
          newSelectedDate.hour, newSelectedDate.minute, newSelectedDate.second);

      /// Move to previous view when the selected date as previous month date.
      if (widget.view == CalendarView.month &&
          !CalendarViewHelper.isCurrentMonthDate(
              widget.calendar.monthViewSettings.numberOfWeeksInView,
              widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
              currentView
                  .visibleDates[currentView.visibleDates.length ~/ 2].month,
              newSelectedDate)) {
        _moveToPreviousViewWithAnimation();
      } else if (widget.view == CalendarView.workWeek) {
        for (int i = 0;
            i <
                DateTime.daysPerWeek -
                    widget.calendar.timeSlotViewSettings.nonWorkingDays.length;
            i++) {
          if (widget.calendar.timeSlotViewSettings.nonWorkingDays
              .contains(newSelectedDate!.weekday)) {
            newSelectedDate = AppointmentHelper.addDaysWithTime(
                newSelectedDate,
                -1,
                newSelectedDate.hour,
                newSelectedDate.minute,
                newSelectedDate.second);
          } else {
            break;
          }
        }
      }
    } else {
      final double xPosition = widget.view == CalendarView.timelineMonth
          ? 0
          : AppointmentHelper.timeToPosition(widget.calendar, newSelectedDate!,
              currentViewState._timeIntervalHeight);
      final int rowIndex =
          _getRowOfDate(currentView.visibleDates, newSelectedDate!);
      final double singleChildWidth =
          _getSingleViewWidthForTimeLineView(currentViewState);

      if ((rowIndex * singleChildWidth) + xPosition == 0) {
        _moveToPreviousViewWithAnimation(isScrollToEnd: true);
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _moveToSelectedTimeSlot();
        });
      }

      if ((rowIndex * singleChildWidth) + xPosition <=
          currentViewState._scrollController!.offset) {
        currentViewState._scrollController!.jumpTo(
            currentViewState._scrollController!.offset -
                currentViewState._timeIntervalHeight);
      }

      /// For timeline month view each column represents a single day, and for
      /// other timeline views each column represents a given time interval,
      /// hence to update the selected date for timeline month we must subtract
      /// a day and for other timeline views we must subtract the given time
      /// interval.
      if (widget.view == CalendarView.timelineMonth) {
        newSelectedDate = AppointmentHelper.addDaysWithTime(
            newSelectedDate,
            -1,
            newSelectedDate.hour,
            newSelectedDate.minute,
            newSelectedDate.second);
      } else {
        newSelectedDate = newSelectedDate
            .subtract(widget.calendar.timeSlotViewSettings.timeInterval);
      }
      if (widget.view == CalendarView.timelineWorkWeek) {
        for (int i = 0;
            i <
                DateTime.daysPerWeek -
                    widget.calendar.timeSlotViewSettings.nonWorkingDays.length;
            i++) {
          if (widget.calendar.timeSlotViewSettings.nonWorkingDays
              .contains(newSelectedDate!.weekday)) {
            newSelectedDate = AppointmentHelper.addDaysWithTime(
                newSelectedDate,
                -1,
                newSelectedDate.hour,
                newSelectedDate.minute,
                newSelectedDate.second);
          } else {
            break;
          }
        }
      }
    }

    return newSelectedDate!;
  }

  DateTime? _updateSelectedDateForUpArrow(
      _CalendarView currentView,
      _CalendarViewState currentViewState,
      DateTime? selectedDate,
      DateTime? appointmentSelectedDate) {
    DateTime? newSelectedDate = selectedDate;
    if (widget.view == CalendarView.month) {
      final int rowIndex =
          _getRowOfDate(currentView.visibleDates, newSelectedDate!);
      if (rowIndex == 0) {
        return newSelectedDate;
      }
      newSelectedDate = AppointmentHelper.addDaysWithTime(
          newSelectedDate,
          -DateTime.daysPerWeek,
          newSelectedDate.hour,
          newSelectedDate.minute,
          newSelectedDate.second);

      /// Move to month start date when the new selected date as
      /// previous month date.
      if (!CalendarViewHelper.isCurrentMonthDate(
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
          currentView.visibleDates[currentView.visibleDates.length ~/ 2].month,
          newSelectedDate)) {
        newSelectedDate = AppointmentHelper.getMonthStartDate(
            currentViewState._selectionPainter!.selectedDate ??
                appointmentSelectedDate!);

        if (CalendarViewHelper.isDateInDateCollection(
            currentView.blackoutDates, newSelectedDate)) {
          do {
            newSelectedDate = AppointmentHelper.addDaysWithTime(
                newSelectedDate!,
                1,
                newSelectedDate.hour,
                newSelectedDate.minute,
                newSelectedDate.second);
          } while (CalendarViewHelper.isDateInDateCollection(
              currentView.blackoutDates, newSelectedDate));
        }
      }

      return newSelectedDate;
    } else if (!CalendarViewHelper.isTimelineView(widget.view)) {
      final double yPosition = AppointmentHelper.timeToPosition(widget.calendar,
          newSelectedDate!, currentViewState._timeIntervalHeight);
      if (yPosition < 1) {
        return newSelectedDate;
      }
      if (yPosition - 1 <= currentViewState._scrollController!.offset) {
        currentViewState._scrollController!
            .jumpTo(yPosition - currentViewState._timeIntervalHeight);
      }
      return newSelectedDate
          .subtract(widget.calendar.timeSlotViewSettings.timeInterval);
    } else if (CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view)) {
      final double resourceItemHeight =
          CalendarViewHelper.getResourceItemHeight(
              widget.calendar.resourceViewSettings.size,
              widget.height,
              widget.calendar.resourceViewSettings,
              widget.calendar.dataSource!.resources!.length);

      currentViewState._selectedResourceIndex -= 1;

      if (currentViewState._selectedResourceIndex == -1) {
        currentViewState._selectedResourceIndex = 0;
        return newSelectedDate;
      }

      if (currentViewState._selectedResourceIndex * resourceItemHeight <
          currentViewState._timelineViewVerticalScrollController!.offset) {
        double scrollPosition =
            currentViewState._timelineViewVerticalScrollController!.offset -
                resourceItemHeight;
        scrollPosition = scrollPosition > 0 ? scrollPosition : 0;
        currentViewState._timelineViewVerticalScrollController!
            .jumpTo(scrollPosition);
      }

      return newSelectedDate;
    }

    return null;
  }

  DateTime? _updateSelectedDateForDownArrow(
      _CalendarView currentView,
      _CalendarViewState currentViewState,
      DateTime? selectedDate,
      DateTime? selectedAppointmentDate) {
    DateTime? newSelectedDate = selectedDate;
    if (widget.view == CalendarView.month) {
      final int rowIndex =
          _getRowOfDate(currentView.visibleDates, newSelectedDate!);
      if (rowIndex ==
          widget.calendar.monthViewSettings.numberOfWeeksInView - 1) {
        return newSelectedDate;
      }

      newSelectedDate = AppointmentHelper.addDaysWithTime(
          newSelectedDate,
          DateTime.daysPerWeek,
          newSelectedDate.hour,
          newSelectedDate.minute,
          newSelectedDate.second);

      /// Move to month end date when the new selected date as next month date.
      if (!CalendarViewHelper.isCurrentMonthDate(
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          widget.calendar.monthViewSettings.showTrailingAndLeadingDates,
          currentView.visibleDates[currentView.visibleDates.length ~/ 2].month,
          newSelectedDate)) {
        newSelectedDate = AppointmentHelper.getMonthEndDate(
            currentViewState._selectionPainter!.selectedDate ??
                selectedAppointmentDate!);

        if (CalendarViewHelper.isDateInDateCollection(
            currentView.blackoutDates, newSelectedDate)) {
          do {
            newSelectedDate = AppointmentHelper.addDaysWithTime(
                newSelectedDate!,
                -1,
                newSelectedDate.hour,
                newSelectedDate.minute,
                newSelectedDate.second);
          } while (CalendarViewHelper.isDateInDateCollection(
              currentView.blackoutDates, newSelectedDate));
        }
      }
      return newSelectedDate;
    } else if (!CalendarViewHelper.isTimelineView(widget.view)) {
      final double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
          widget.calendar.viewHeaderHeight, widget.view);
      final double yPosition = AppointmentHelper.timeToPosition(widget.calendar,
          newSelectedDate!, currentViewState._timeIntervalHeight);

      if (newSelectedDate
              .add(widget.calendar.timeSlotViewSettings.timeInterval)
              .day !=
          newSelectedDate.day) {
        return newSelectedDate;
      }

      if (currentViewState._scrollController!.offset +
                  (widget.height - viewHeaderHeight) <
              currentViewState._scrollController!.position.viewportDimension +
                  currentViewState
                      ._scrollController!.position.maxScrollExtent &&
          yPosition +
                  currentViewState._timeIntervalHeight +
                  widget.calendar.headerHeight +
                  viewHeaderHeight >=
              currentViewState._scrollController!.offset + widget.height &&
          currentViewState._scrollController!.offset +
                  currentViewState
                      ._scrollController!.position.viewportDimension !=
              currentViewState._scrollController!.position.maxScrollExtent) {
        currentViewState._scrollController!.jumpTo(
            currentViewState._scrollController!.offset +
                currentViewState._timeIntervalHeight);
      }
      return newSelectedDate
          .add(widget.calendar.timeSlotViewSettings.timeInterval);
    } else if (CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view)) {
      final double resourceItemHeight =
          CalendarViewHelper.getResourceItemHeight(
              widget.calendar.resourceViewSettings.size,
              widget.height,
              widget.calendar.resourceViewSettings,
              widget.calendar.dataSource!.resources!.length);
      if (currentViewState._selectedResourceIndex ==
              widget.calendar.dataSource!.resources!.length - 1 ||
          currentViewState._selectedResourceIndex == -1) {
        return newSelectedDate;
      }

      currentViewState._selectedResourceIndex += 1;

      if (currentViewState._selectedResourceIndex * resourceItemHeight >=
          currentViewState._timelineViewVerticalScrollController!.offset +
              currentViewState._timelineViewVerticalScrollController!.position
                  .viewportDimension) {
        double scrollPosition =
            currentViewState._timelineViewVerticalScrollController!.offset +
                resourceItemHeight;
        scrollPosition = scrollPosition >
                currentViewState._timelineViewVerticalScrollController!.position
                    .maxScrollExtent
            ? currentViewState
                ._timelineViewVerticalScrollController!.position.maxScrollExtent
            : scrollPosition;
        currentViewState._timelineViewVerticalScrollController!
            .jumpTo(scrollPosition);
      }

      return newSelectedDate!;
    }

    return null;
  }

  /// Moves the view to the selected time slot.
  void _moveToSelectedTimeSlot() {
    _CalendarViewState currentViewState;
    if (_currentChildIndex == 0) {
      currentViewState = _previousViewKey.currentState!;
    } else if (_currentChildIndex == 1) {
      currentViewState = _currentViewKey.currentState!;
    } else {
      currentViewState = _nextViewKey.currentState!;
    }

    final double scrollPosition =
        currentViewState._getScrollPositionForCurrentDate(
            currentViewState._selectionPainter!.selectedDate!);
    if (scrollPosition == -1 ||
        currentViewState._scrollController!.position.pixels == scrollPosition) {
      return;
    }

    currentViewState._scrollController!.jumpTo(
        currentViewState._scrollController!.position.maxScrollExtent >
                scrollPosition
            ? scrollPosition
            : currentViewState._scrollController!.position.maxScrollExtent);
  }

  DateTime? _updateSelectedDate(
      RawKeyEvent event,
      _CalendarViewState currentViewState,
      _CalendarView currentView,
      int resourceIndex,
      DateTime? selectedAppointmentDate,
      bool isAllDayAppointment) {
    int newResourceIndex = resourceIndex;
    DateTime? selectedDate = currentViewState._selectionPainter!.selectedDate ??
        selectedAppointmentDate;
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      do {
        selectedDate = _updateSelectedDateForRightArrow(
            currentView, currentViewState, selectedDate);
      } while (!_isSelectedDateEnabled(selectedDate, newResourceIndex, true));

      return selectedDate;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      do {
        selectedDate = _updateSelectedDateForLeftArrow(
            currentView, currentViewState, selectedDate);
      } while (!_isSelectedDateEnabled(selectedDate, newResourceIndex, true));

      return selectedDate;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      do {
        selectedDate = _updateSelectedDateForUpArrow(currentView,
            currentViewState, selectedDate, selectedAppointmentDate);
        if (newResourceIndex != -1 &&
            currentView.regions != null &&
            currentView.regions!.isNotEmpty) {
          newResourceIndex -= 1;
        }

        if (widget.controller.view != CalendarView.month &&
            !CalendarViewHelper.isTimelineView(widget.calendar.view)) {
          double yPosition = AppointmentHelper.timeToPosition(widget.calendar,
              selectedDate!, currentViewState._timeIntervalHeight);
          if (yPosition < 1 &&
              !_isSelectedDateEnabled(selectedDate, newResourceIndex, true)) {
            yPosition = AppointmentHelper.timeToPosition(
                widget.calendar,
                currentViewState._selectionPainter!.selectedDate!,
                currentViewState._timeIntervalHeight);
            currentViewState._scrollController!.jumpTo(yPosition);
            break;
          }
        }
      } while (!_isSelectedDateEnabled(selectedDate!, newResourceIndex, true) &&
          _getRowOfDate(currentView.visibleDates, selectedDate) != 0);
      return selectedDate;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (isAllDayAppointment) {
        return selectedDate;
      }

      do {
        selectedDate = _updateSelectedDateForDownArrow(currentView,
            currentViewState, selectedDate, selectedAppointmentDate);
        if (newResourceIndex != -1 &&
            currentView.regions != null &&
            currentView.regions!.isNotEmpty) {
          newResourceIndex += 1;
        }

        if (widget.controller.view != CalendarView.month &&
            !CalendarViewHelper.isTimelineView(widget.calendar.view)) {
          if (selectedDate!
                  .add(widget.calendar.timeSlotViewSettings.timeInterval)
                  .day !=
              selectedDate.day) {
            final double yPosition = AppointmentHelper.timeToPosition(
                widget.calendar,
                currentViewState._selectionPainter!.selectedDate!,
                currentViewState._timeIntervalHeight);
            if (yPosition <= currentViewState._scrollController!.offset) {
              currentViewState._scrollController!.jumpTo(yPosition);
            }
            break;
          }
        }
      } while (!_isSelectedDateEnabled(selectedDate!, newResourceIndex, true) &&
          _getRowOfDate(currentView.visibleDates, selectedDate) !=
              widget.calendar.monthViewSettings.numberOfWeeksInView - 1);
      return selectedDate;
    }

    return null;
  }

  /// Checks the selected date is enabled or not.
  bool _isSelectedDateEnabled(DateTime date, int resourceIndex,
      [bool isMinMaxDate = false]) {
    final bool isMonthView = widget.view == CalendarView.month ||
        widget.view == CalendarView.timelineMonth;
    final int timeInterval = CalendarViewHelper.getTimeInterval(
        widget.calendar.timeSlotViewSettings);
    if ((isMonthView &&
            !isDateWithInDateRange(
                widget.calendar.minDate, widget.calendar.maxDate, date)) ||
        (!isMonthView &&
            !CalendarViewHelper.isDateTimeWithInDateTimeRange(
                widget.calendar.minDate,
                widget.calendar.maxDate,
                date,
                timeInterval))) {
      return isMinMaxDate;
    }

    if (isMonthView &&
        CalendarViewHelper.isDateInDateCollection(_getBlackoutDates(), date)) {
      return false;
    } else if (!isMonthView) {
      final List<CalendarTimeRegion> regions = _getTimeRegions();

      for (int i = 0; i < regions.length; i++) {
        final CalendarTimeRegion region = regions[i];
        if (region.enablePointerInteraction ||
            (region.actualStartTime.isAfter(date) &&
                !CalendarViewHelper.isSameTimeSlot(
                    region.actualStartTime, date)) ||
            region.actualEndTime.isBefore(date) ||
            CalendarViewHelper.isSameTimeSlot(region.actualEndTime, date)) {
          continue;
        }

        /// Condition added ensure that the region is disabled only on the
        /// specified resource slot, for other resources it must be enabled.
        if (resourceIndex != -1 &&
            region.resourceIds != null &&
            region.resourceIds!.isNotEmpty &&
            !region.resourceIds!
                .contains(widget.resourceCollection![resourceIndex].id)) {
          continue;
        }

        return false;
      }
    }

    return true;
  }

  /// Method to handle the page up/down key for timeslot views in calendar.
  KeyEventResult _updatePageUpAndDown(RawKeyEvent event,
      _CalendarViewState currentViewState, bool isResourceEnabled) {
    if (widget.controller.view != CalendarView.day &&
        widget.controller.view != CalendarView.week &&
        widget.controller.view != CalendarView.workWeek &&
        !isResourceEnabled) {
      return KeyEventResult.ignored;
    }

    final ScrollController scrollController = isResourceEnabled
        ? widget.resourcePanelScrollController!
        : currentViewState._scrollController!;
    final TargetPlatform platform = Theme.of(context).platform;

    double difference = 0;
    final double scrollViewHeight = scrollController.position.maxScrollExtent +
        scrollController.position.viewportDimension;
    double divideValue = 0.25;
    if (scrollController.position.pixels > scrollViewHeight / 2) {
      divideValue = 0.5;
    }
    if (event.logicalKey == LogicalKeyboardKey.pageUp ||
        (platform == TargetPlatform.windows &&
            event.logicalKey.keyId == 0x10700000021)) {
      if (scrollController.position.pixels == 0) {
        return KeyEventResult.ignored;
      }
      difference = scrollController.position.pixels * divideValue;
      scrollController.jumpTo(difference);
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.pageDown ||
        (platform == TargetPlatform.windows &&
            event.logicalKey.keyId == 0x10700000022)) {
      double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
          widget.calendar.viewHeaderHeight, widget.controller.view!);
      double allDayHeight = 0;

      if (widget.controller.view == CalendarView.day) {
        allDayHeight = _kAllDayLayoutHeight;
        viewHeaderHeight = 0;
      } else {
        allDayHeight = allDayHeight > _kAllDayLayoutHeight
            ? _kAllDayLayoutHeight
            : allDayHeight;
      }

      final double timeRulerSize = CalendarViewHelper.getTimeLabelWidth(
          widget.calendar.timeSlotViewSettings.timeRulerSize,
          widget.controller.view!);

      final double viewPortHeight = isResourceEnabled
          ? widget.height - viewHeaderHeight - timeRulerSize
          : widget.height - allDayHeight - viewHeaderHeight;

      final double viewPortEndPosition =
          scrollController.position.pixels + viewPortHeight;
      if (viewPortEndPosition == scrollViewHeight) {
        return KeyEventResult.ignored;
      }
      difference =
          (scrollViewHeight - scrollController.position.pixels) * divideValue;
      difference += scrollController.position.pixels;
      if (difference + viewPortHeight >= scrollViewHeight) {
        difference = scrollViewHeight - viewPortHeight;
      }
      scrollController.jumpTo(difference);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  /// Updates the appointment selection based on keyboard navigation in calendar
  KeyEventResult _updateAppointmentSelection(
      RawKeyEvent event,
      _CalendarViewState currentVisibleViewState,
      bool isResourceEnabled,
      AppointmentView? currentSelectedAppointment,
      AppointmentView? currentAllDayAppointment) {
    if (widget.controller.view == CalendarView.schedule) {
      return KeyEventResult.ignored;
    }

    AppointmentView? selectedAppointment;
    bool isAllDay = currentAllDayAppointment != null;
    final List<AppointmentView> appointmentCollection = currentVisibleViewState
        ._appointmentLayout
        .getAppointmentViewCollection();
    final List<AppointmentView> allDayAppointmentCollection =
        _updateCalendarStateDetails.allDayAppointmentViewCollection;
    final List<AppointmentView> tempAppColl =
        isAllDay ? allDayAppointmentCollection : appointmentCollection;
    if (event.isShiftPressed) {
      if (event.logicalKey == LogicalKeyboardKey.tab) {
        if (currentAllDayAppointment != null ||
            currentSelectedAppointment != null) {
          int index = tempAppColl.indexOf(isAllDay
              ? currentAllDayAppointment
              : currentSelectedAppointment!);
          index -= 1;
          if (tempAppColl.length > index && !index.isNegative) {
            selectedAppointment = tempAppColl[index].appointment != null
                ? tempAppColl[index]
                : null;
          }
        }

        if (currentSelectedAppointment != null && selectedAppointment == null) {
          isAllDay = allDayAppointmentCollection.isNotEmpty;
          selectedAppointment = isAllDay
              ? allDayAppointmentCollection[
                  allDayAppointmentCollection.length - 1]
              : null;
        } else if (currentSelectedAppointment == null &&
            currentAllDayAppointment == null &&
            selectedAppointment == null) {
          if (currentVisibleViewState._selectionPainter!.selectedDate != null &&
              appointmentCollection.isNotEmpty) {
            for (int i = 0; i < appointmentCollection.length; i++) {
              if (AppointmentHelper.getDifference(
                      currentVisibleViewState._selectionPainter!.selectedDate!,
                      appointmentCollection[i].appointment!.actualStartTime)
                  .isNegative) {
                continue;
              }

              if (i != 0) {
                selectedAppointment = appointmentCollection[i - 1];
              }
              break;
            }
          } else {
            selectedAppointment = appointmentCollection.isNotEmpty
                ? appointmentCollection[appointmentCollection.length - 1]
                : null;
          }
        }

        return _updateAppointmentSelectionOnView(
            selectedAppointment,
            currentVisibleViewState,
            isAllDay,
            isResourceEnabled,
            !event.isShiftPressed);
      }
    } else if (event.logicalKey == LogicalKeyboardKey.tab) {
      if (currentAllDayAppointment != null ||
          currentSelectedAppointment != null) {
        int index = tempAppColl.indexOf(
            isAllDay ? currentAllDayAppointment : currentSelectedAppointment!);
        index += 1;
        if (tempAppColl.length > index) {
          selectedAppointment = tempAppColl[index].appointment != null
              ? tempAppColl[index]
              : null;
        }
      }

      if (currentAllDayAppointment != null && selectedAppointment == null) {
        isAllDay = false;
        selectedAppointment = appointmentCollection[0];
      } else if (currentAllDayAppointment == null &&
          currentSelectedAppointment == null) {
        if (currentVisibleViewState._selectionPainter!.selectedDate != null &&
            appointmentCollection.isNotEmpty) {
          for (int i = 0; i < appointmentCollection.length; i++) {
            if (AppointmentHelper.getDifference(
                    currentVisibleViewState._selectionPainter!.selectedDate!,
                    appointmentCollection[i].appointment!.actualStartTime)
                .isNegative) {
              continue;
            }

            selectedAppointment = appointmentCollection[i];
            break;
          }
        } else {
          isAllDay = allDayAppointmentCollection.isNotEmpty;
          selectedAppointment = isAllDay
              ? allDayAppointmentCollection[0]
              : appointmentCollection.isNotEmpty
                  ? appointmentCollection[0]
                  : null;
        }
      }

      return _updateAppointmentSelectionOnView(
          selectedAppointment,
          currentVisibleViewState,
          isAllDay,
          isResourceEnabled,
          !event.isShiftPressed);
    }

    return KeyEventResult.ignored;
  }

  /// Updates the selection for appointment view based on keyboard navigation
  /// in Calendar.
  KeyEventResult _updateAppointmentSelectionOnView(
      AppointmentView? selectedAppointment,
      _CalendarViewState currentVisibleViewState,
      bool isAllDay,
      bool isResourceEnabled,
      bool isForward) {
    final DateTime visibleStartDate = AppointmentHelper.convertToStartTime(
        currentVisibleViewState.widget.visibleDates[0]);
    final DateTime visibleEndDate = AppointmentHelper.convertToEndTime(
        currentVisibleViewState.widget.visibleDates[
            currentVisibleViewState.widget.visibleDates.length - 1]);

    if (isAllDay && selectedAppointment != null) {
      currentVisibleViewState._updateAllDaySelection(selectedAppointment, null);
      currentVisibleViewState._selectionPainter!.appointmentView = null;
      currentVisibleViewState._selectionPainter!.selectedDate = null;
      currentVisibleViewState._selectionNotifier.value =
          !currentVisibleViewState._selectionNotifier.value;
      _updateCalendarStateDetails.selectedDate = null;
      widget.updateCalendarState(_updateCalendarStateDetails);
      return KeyEventResult.handled;
    }

    if (selectedAppointment != null &&
        AppointmentHelper.isAppointmentWithinVisibleDateRange(
            selectedAppointment.appointment!,
            visibleStartDate,
            visibleEndDate)) {
      currentVisibleViewState._allDaySelectionNotifier.value = null;
      currentVisibleViewState._selectionPainter!.appointmentView =
          selectedAppointment;
      currentVisibleViewState._selectionPainter!.selectedDate = null;
      currentVisibleViewState._selectionNotifier.value =
          !currentVisibleViewState._selectionNotifier.value;

      if (widget.controller.view != CalendarView.month) {
        late double offset;
        late double viewPortSize;
        final double scrollViewHeight = currentVisibleViewState
                ._scrollController!.position.maxScrollExtent +
            currentVisibleViewState
                ._scrollController!.position.viewportDimension;
        final double resourceViewSize =
            isResourceEnabled ? widget.calendar.resourceViewSettings.size : 0;
        final bool isTimeline =
            CalendarViewHelper.isTimelineView(widget.controller.view!);
        double viewHeaderHeight = CalendarViewHelper.getViewHeaderHeight(
            widget.calendar.viewHeaderHeight, widget.controller.view!);

        if (isTimeline) {
          viewPortSize = widget.width - resourceViewSize;
          offset = selectedAppointment.appointmentRect!.left;
        } else {
          double allDayHeight = 0;

          if (widget.controller.view == CalendarView.day) {
            allDayHeight = _kAllDayLayoutHeight;
            viewHeaderHeight = 0;
          } else {
            allDayHeight = allDayHeight > _kAllDayLayoutHeight
                ? _kAllDayLayoutHeight
                : allDayHeight;
          }
          viewPortSize = widget.height - allDayHeight - viewHeaderHeight;
          offset = selectedAppointment.appointmentRect!.top;
        }

        _updateScrollViewToAppointment(
            offset,
            currentVisibleViewState._scrollController!,
            viewPortSize,
            scrollViewHeight);

        if (isResourceEnabled) {
          final double resourcePanelHeight = widget
                  .resourcePanelScrollController!.position.viewportDimension +
              widget.resourcePanelScrollController!.position.maxScrollExtent;
          final double timeRulerSize = CalendarViewHelper.getTimeLabelWidth(
                  widget.calendar.timeSlotViewSettings.timeRulerSize,
                  widget.controller.view!),
              viewPortSize = widget.height - viewHeaderHeight - timeRulerSize;
          _updateScrollViewToAppointment(
              selectedAppointment.appointmentRect!.top,
              widget.resourcePanelScrollController!,
              viewPortSize,
              resourcePanelHeight);
        }
      } else if (widget.controller.view == CalendarView.month) {
        widget.agendaSelectedDate.value = null;
      }

      _updateCalendarStateDetails.selectedDate = null;
      widget.updateCalendarState(_updateCalendarStateDetails);
      return KeyEventResult.handled;
    } else {
      currentVisibleViewState._allDaySelectionNotifier.value = null;
      currentVisibleViewState._selectionPainter!.appointmentView = null;
      currentVisibleViewState._selectionPainter!.selectedDate = null;
      currentVisibleViewState._selectionNotifier.value =
          !currentVisibleViewState._selectionNotifier.value;
      _updateCalendarStateDetails.selectedDate = null;
      widget.updateCalendarState(_updateCalendarStateDetails);
      isForward
          ? FocusScope.of(context).nextFocus()
          : FocusScope.of(context).previousFocus();
      return KeyEventResult.handled;
    }
  }

  /// Moves the scroll panel to the selected appointments position, if the
  /// selected appointment doesn't falls on the view port.
  void _updateScrollViewToAppointment(
      double offset,
      ScrollController scrollController,
      double viewPortSize,
      double panelHeight) {
    if (offset < scrollController.position.pixels ||
        offset > (scrollController.position.pixels + viewPortSize)) {
      if (offset + viewPortSize > panelHeight) {
        offset = panelHeight - viewPortSize;
      }
      scrollController.jumpTo(offset);
    }
  }

  KeyEventResult _onKeyDown(FocusNode node, RawKeyEvent event) {
    KeyEventResult result = KeyEventResult.ignored;
    if (event.runtimeType != RawKeyDownEvent) {
      return result;
    }

    widget.removePicker();

    if (event.isControlPressed && widget.view != CalendarView.schedule) {
      final bool canMoveToNextView = DateTimeHelper.canMoveToNextView(
          widget.view,
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          widget.calendar.minDate,
          widget.calendar.maxDate,
          _currentViewVisibleDates,
          widget.calendar.timeSlotViewSettings.nonWorkingDays,
          widget.isRTL);
      final bool canMoveToPreviousView = DateTimeHelper.canMoveToPreviousView(
          widget.view,
          widget.calendar.monthViewSettings.numberOfWeeksInView,
          widget.calendar.minDate,
          widget.calendar.maxDate,
          _currentViewVisibleDates,
          widget.calendar.timeSlotViewSettings.nonWorkingDays,
          widget.isRTL);
      if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
          canMoveToNextView) {
        widget.isRTL
            ? _moveToPreviousViewWithAnimation()
            : _moveToNextViewWithAnimation();
        result = KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
          canMoveToPreviousView) {
        widget.isRTL
            ? _moveToNextViewWithAnimation()
            : _moveToPreviousViewWithAnimation();
        result = KeyEventResult.handled;
      }
      result = KeyEventResult.ignored;
    }

    CalendarViewHelper.handleViewSwitchKeyBoardEvent(
        event, widget.controller, widget.calendar.allowedViews);

    _CalendarViewState currentVisibleViewState;
    _CalendarView currentVisibleView;
    final bool isResourcesEnabled = CalendarViewHelper.isResourceEnabled(
        widget.calendar.dataSource, widget.view);
    if (_currentChildIndex == 0) {
      currentVisibleViewState = _previousViewKey.currentState!;
      currentVisibleView = _previousView;
    } else if (_currentChildIndex == 1) {
      currentVisibleViewState = _currentViewKey.currentState!;
      currentVisibleView = _currentView;
    } else {
      currentVisibleViewState = _nextViewKey.currentState!;
      currentVisibleView = _nextView;
    }

    result = _updatePageUpAndDown(
        event, currentVisibleViewState, isResourcesEnabled);

    AppointmentView? currentSelectedAppointment =
        currentVisibleViewState._selectionPainter!.appointmentView;
    AppointmentView? currentAllDayAppointment =
        currentVisibleViewState._allDaySelectionNotifier.value?.appointmentView;

    result = _updateAppointmentSelection(
        event,
        currentVisibleViewState,
        isResourcesEnabled,
        currentSelectedAppointment,
        currentAllDayAppointment);

    currentSelectedAppointment =
        currentVisibleViewState._selectionPainter!.appointmentView;
    currentAllDayAppointment =
        currentVisibleViewState._allDaySelectionNotifier.value?.appointmentView;

    if (event.logicalKey == LogicalKeyboardKey.enter &&
        CalendarViewHelper.shouldRaiseCalendarTapCallback(
            widget.calendar.onTap)) {
      final AppointmentView? selectedAppointment = currentVisibleViewState
              ._allDaySelectionNotifier.value?.appointmentView ??
          currentVisibleViewState._selectionPainter!.appointmentView;
      final List<CalendarAppointment>? selectedAppointments =
          widget.controller.view == CalendarView.month &&
                  selectedAppointment == null
              ? AppointmentHelper.getSelectedDateAppointments(
                  _updateCalendarStateDetails.appointments,
                  widget.calendar.timeZone,
                  _updateCalendarStateDetails.selectedDate)
              : selectedAppointment != null
                  ? <CalendarAppointment>[selectedAppointment.appointment!]
                  : null;
      final CalendarElement tappedElement =
          _updateCalendarStateDetails.selectedDate != null
              ? CalendarElement.calendarCell
              : CalendarElement.appointment;

      CalendarViewHelper.raiseCalendarTapCallback(
          widget.calendar,
          tappedElement == CalendarElement.appointment
              ? selectedAppointments![0].startTime
              : _updateCalendarStateDetails.selectedDate,
          CalendarViewHelper.getCustomAppointments(
              selectedAppointments, widget.calendar.dataSource),
          tappedElement,
          isResourcesEnabled
              ? widget.calendar.dataSource!
                  .resources![currentVisibleViewState._selectedResourceIndex]
              : null);
    }

    final int previousResourceIndex = isResourcesEnabled
        ? currentVisibleViewState._selectedResourceIndex
        : -1;

    if ((currentVisibleViewState._selectionPainter!.selectedDate != null &&
            isDateWithInDateRange(
                currentVisibleViewState.widget.visibleDates[0],
                currentVisibleViewState.widget.visibleDates[
                    currentVisibleViewState.widget.visibleDates.length - 1],
                currentVisibleViewState._selectionPainter!.selectedDate)) ||
        (currentSelectedAppointment != null ||
            currentAllDayAppointment != null)) {
      final int resourceIndex = isResourcesEnabled
          ? currentVisibleViewState._selectedResourceIndex
          : -1;

      final DateTime? selectedAppointmentDate = currentAllDayAppointment != null
          ? AppointmentHelper.convertToStartTime(
              currentAllDayAppointment.appointment!.actualStartTime)
          : currentSelectedAppointment?.appointment!.actualStartTime;

      final bool isAllDayAppointment = currentAllDayAppointment != null;

      final DateTime? selectedDate = _updateSelectedDate(
          event,
          currentVisibleViewState,
          currentVisibleView,
          resourceIndex,
          selectedAppointmentDate,
          isAllDayAppointment);

      if (selectedDate == null) {
        result = KeyEventResult.ignored;
        return result;
      }

      if (!_isSelectedDateEnabled(selectedDate, resourceIndex)) {
        currentVisibleViewState._selectedResourceIndex = previousResourceIndex;
        return KeyEventResult.ignored;
      }

      if (widget.view == CalendarView.month) {
        widget.agendaSelectedDate.value = selectedDate;
      }

      _updateCalendarStateDetails.selectedDate = selectedDate;
      if (widget.calendar.onSelectionChanged != null &&
          (!CalendarViewHelper.isSameTimeSlot(
                  currentVisibleViewState._selectionPainter!.selectedDate,
                  selectedDate) ||
              (isResourcesEnabled &&
                  currentVisibleViewState
                          ._selectionPainter!.selectedResourceIndex !=
                      currentVisibleViewState._selectedResourceIndex))) {
        CalendarViewHelper.raiseCalendarSelectionChangedCallback(
            widget.calendar,
            selectedDate,
            isResourcesEnabled
                ? widget.resourceCollection![
                    currentVisibleViewState._selectedResourceIndex]
                : null);
      }
      currentVisibleViewState._selectionPainter!.selectedDate = selectedDate;
      currentVisibleViewState._updateAllDaySelection(null, null);
      currentVisibleViewState._selectionPainter!.appointmentView = null;
      currentVisibleViewState._selectionPainter!.selectedResourceIndex =
          currentVisibleViewState._selectedResourceIndex;
      currentVisibleViewState._selectionNotifier.value =
          !currentVisibleViewState._selectionNotifier.value;

      widget.updateCalendarState(_updateCalendarStateDetails);
      result = KeyEventResult.handled;
    }

    return result;
  }

  void _positionTimelineView({bool isScrolledToEnd = true}) {
    final _CalendarViewState previousViewState = _previousViewKey.currentState!;
    final _CalendarViewState currentViewState = _currentViewKey.currentState!;
    final _CalendarViewState nextViewState = _nextViewKey.currentState!;
    if (widget.isRTL) {
      if (_currentChildIndex == 0) {
        currentViewState._scrollController!.jumpTo(isScrolledToEnd
            ? currentViewState._scrollController!.position.maxScrollExtent
            : 0);
        nextViewState._scrollController!.jumpTo(0);
      } else if (_currentChildIndex == 1) {
        nextViewState._scrollController!.jumpTo(isScrolledToEnd
            ? nextViewState._scrollController!.position.maxScrollExtent
            : 0);
        previousViewState._scrollController!.jumpTo(0);
      } else if (_currentChildIndex == 2) {
        previousViewState._scrollController!.jumpTo(isScrolledToEnd
            ? previousViewState._scrollController!.position.maxScrollExtent
            : 0);
        currentViewState._scrollController!.jumpTo(0);
      }
    } else {
      if (_currentChildIndex == 0) {
        nextViewState._scrollController!.jumpTo(isScrolledToEnd
            ? nextViewState._scrollController!.position.maxScrollExtent
            : 0);
        currentViewState._scrollController!.jumpTo(0);
      } else if (_currentChildIndex == 1) {
        previousViewState._scrollController!.jumpTo(isScrolledToEnd
            ? previousViewState._scrollController!.position.maxScrollExtent
            : 0);
        nextViewState._scrollController!.jumpTo(0);
      } else if (_currentChildIndex == 2) {
        currentViewState._scrollController!.jumpTo(isScrolledToEnd
            ? currentViewState._scrollController!.position.maxScrollExtent
            : 0);
        previousViewState._scrollController!.jumpTo(0);
      }
    }
  }

  void _onHorizontalStart(
      DragStartDetails dragStartDetails,
      bool isResourceEnabled,
      bool isTimelineView,
      double viewHeaderHeight,
      double timeLabelWidth,
      bool isNeedDragAndDrop) {
    final _CalendarViewState currentState = _getCurrentViewByVisibleDates()!;
    if (currentState._hoveringAppointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleAppointmentDragStart(
          currentState._hoveringAppointmentView!.clone(),
          isTimelineView,
          Offset(dragStartDetails.localPosition.dx - widget.width,
              dragStartDetails.localPosition.dy),
          isResourceEnabled,
          viewHeaderHeight,
          timeLabelWidth);
      return;
    }
    switch (widget.calendar.viewNavigationMode) {
      case ViewNavigationMode.none:
        return;
      case ViewNavigationMode.snap:
        widget.removePicker();
        if (widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.horizontal ||
            widget.view != CalendarView.month) {
          _scrollStartPosition = dragStartDetails.globalPosition.dx;
        }

        // Handled for time line view, to move the previous and
        // next view to it's start and end position accordingly
        if (CalendarViewHelper.isTimelineView(widget.view)) {
          _positionTimelineView();
        }
    }
  }

  void _onHorizontalUpdate(DragUpdateDetails dragUpdateDetails,
      [bool isResourceEnabled = false,
      bool isMonthView = false,
      bool isTimelineView = false,
      double viewHeaderHeight = 0,
      double timeLabelWidth = 0,
      double resourceItemHeight = 0,
      double weekNumberPanelWidth = 0,
      bool isNeedDragAndDrop = false]) {
    if (_dragDetails.value.appointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleLongPressMove(
          Offset(dragUpdateDetails.localPosition.dx - widget.width,
              dragUpdateDetails.localPosition.dy),
          isTimelineView,
          isResourceEnabled,
          isMonthView,
          viewHeaderHeight,
          timeLabelWidth,
          resourceItemHeight,
          weekNumberPanelWidth);
      return;
    }
    switch (widget.calendar.viewNavigationMode) {
      case ViewNavigationMode.none:
        return;
      case ViewNavigationMode.snap:
        widget.removePicker();
        if (widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.horizontal ||
            widget.view != CalendarView.month) {
          final double difference =
              dragUpdateDetails.globalPosition.dx - _scrollStartPosition;
          if (difference < 0 &&
              !DateTimeHelper.canMoveToNextView(
                  widget.view,
                  widget.calendar.monthViewSettings.numberOfWeeksInView,
                  widget.calendar.minDate,
                  widget.calendar.maxDate,
                  _currentViewVisibleDates,
                  widget.calendar.timeSlotViewSettings.nonWorkingDays,
                  widget.isRTL)) {
            _position = 0;
            return;
          } else if (difference > 0 &&
              !DateTimeHelper.canMoveToPreviousView(
                  widget.view,
                  widget.calendar.monthViewSettings.numberOfWeeksInView,
                  widget.calendar.minDate,
                  widget.calendar.maxDate,
                  _currentViewVisibleDates,
                  widget.calendar.timeSlotViewSettings.nonWorkingDays,
                  widget.isRTL)) {
            _position = 0;
            return;
          }
          _position = difference;
          _clearSelection();
          setState(() {
            /* Updates the widget navigated distance and moves the widget
       in the custom scroll view */
          });
        }
    }
  }

  void _onHorizontalEnd(DragEndDetails dragEndDetails,
      [bool isResourceEnabled = false,
      bool isTimelineView = false,
      bool isMonthView = false,
      double viewHeaderHeight = 0,
      double timeLabelWidth = 0,
      double weekNumberPanelWidth = 0,
      bool isNeedDragAndDrop = false]) {
    if (_dragDetails.value.appointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleLongPressEnd(
          _dragDetails.value.position.value! - _dragDifferenceOffset!,
          isTimelineView,
          isResourceEnabled,
          isMonthView,
          viewHeaderHeight,
          timeLabelWidth,
          weekNumberPanelWidth);
      return;
    }
    switch (widget.calendar.viewNavigationMode) {
      case ViewNavigationMode.none:
        return;
      case ViewNavigationMode.snap:
        widget.removePicker();
        if (widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.horizontal ||
            widget.view != CalendarView.month) {
          // condition to check and update the right to left swiping
          if (-_position >= widget.width / 2) {
            _tween.begin = _position;
            _tween.end = -widget.width;

            // Resets the controller to forward it again,
            // the animation will forward only from the dismissed state
            if (_animationController.isCompleted && _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .forward()
                .then<dynamic>((dynamic value) => _updateNextView());

            /// updates the current view visible dates when the view swiped in
            /// right to left direction
            _updateCurrentViewVisibleDates(isNextView: true);
          }
          // fling the view from right to left
          else if (-dragEndDetails.velocity.pixelsPerSecond.dx > widget.width) {
            if (!DateTimeHelper.canMoveToNextView(
                widget.view,
                widget.calendar.monthViewSettings.numberOfWeeksInView,
                widget.calendar.minDate,
                widget.calendar.maxDate,
                _currentViewVisibleDates,
                widget.calendar.timeSlotViewSettings.nonWorkingDays,
                widget.isRTL)) {
              _position = 0;
              setState(() {
                /* Completes the swiping and rearrange the children position
                in the custom scroll view */
              });
              return;
            }

            _tween.begin = _position;
            _tween.end = -widget.width;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted && _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .fling(
                    velocity: 5.0, animationBehavior: AnimationBehavior.normal)
                .then<dynamic>((dynamic value) => _updateNextView());

            /// updates the current view visible dates when fling the view in
            /// right to left direction
            _updateCurrentViewVisibleDates(isNextView: true);
          }
          // condition to check and update the left to right swiping
          else if (_position >= widget.width / 2) {
            _tween.begin = _position;
            _tween.end = widget.width;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted || _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .forward()
                .then<dynamic>((dynamic value) => _updatePreviousView());

            /// updates the current view visible dates when the view swiped in
            /// left to right direction
            _updateCurrentViewVisibleDates();
          }
          // fling the view from left to right
          else if (dragEndDetails.velocity.pixelsPerSecond.dx > widget.width) {
            if (!DateTimeHelper.canMoveToPreviousView(
                widget.view,
                widget.calendar.monthViewSettings.numberOfWeeksInView,
                widget.calendar.minDate,
                widget.calendar.maxDate,
                _currentViewVisibleDates,
                widget.calendar.timeSlotViewSettings.nonWorkingDays,
                widget.isRTL)) {
              _position = 0;
              setState(() {
                /* Completes the swiping and rearrange the children position
            in the custom scroll view */
              });
              return;
            }

            _tween.begin = _position;
            _tween.end = widget.width;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted && _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .fling(
                    velocity: 5.0, animationBehavior: AnimationBehavior.normal)
                .then<dynamic>((dynamic value) => _updatePreviousView());

            /// updates the current view visible dates when fling the view in
            /// left to right direction
            _updateCurrentViewVisibleDates();
          }
          // condition to check and revert the right to left swiping
          else if (_position.abs() <= widget.width / 2) {
            _tween.begin = _position;
            _tween.end = 0.0;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted && _position != _tween.end) {
              _animationController.reset();
            }

            _animationController.forward();
          }
        }
    }
  }

  void _onVerticalStart(
      DragStartDetails dragStartDetails,
      bool isResourceEnabled,
      bool isTimelineView,
      double viewHeaderHeight,
      double timeLabelWidth,
      bool isNeedDragAndDrop) {
    final _CalendarViewState currentState = _getCurrentViewByVisibleDates()!;
    if (currentState._hoveringAppointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleAppointmentDragStart(
          currentState._hoveringAppointmentView!.clone(),
          isTimelineView,
          Offset(dragStartDetails.localPosition.dx,
              dragStartDetails.localPosition.dy - widget.height),
          isResourceEnabled,
          viewHeaderHeight,
          timeLabelWidth);
      return;
    }
    switch (widget.calendar.viewNavigationMode) {
      case ViewNavigationMode.none:
        return;
      case ViewNavigationMode.snap:
        widget.removePicker();
        if (widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.vertical &&
            !CalendarViewHelper.isTimelineView(widget.view)) {
          _scrollStartPosition = dragStartDetails.globalPosition.dy;
        }
    }
  }

  void _onVerticalUpdate(DragUpdateDetails dragUpdateDetails,
      [bool isResourceEnabled = false,
      bool isMonthView = false,
      bool isTimelineView = false,
      double viewHeaderHeight = 0,
      double timeLabelWidth = 0,
      double resourceItemHeight = 0,
      double weekNumberPanelWidth = 0,
      bool isNeedDragAndDrop = false]) {
    if (_dragDetails.value.appointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleLongPressMove(
          Offset(dragUpdateDetails.localPosition.dx,
              dragUpdateDetails.localPosition.dy - widget.height),
          isTimelineView,
          isResourceEnabled,
          isMonthView,
          viewHeaderHeight,
          timeLabelWidth,
          resourceItemHeight,
          weekNumberPanelWidth);
      return;
    }
    switch (widget.calendar.viewNavigationMode) {
      case ViewNavigationMode.none:
        return;
      case ViewNavigationMode.snap:
        widget.removePicker();
        if (widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.vertical &&
            !CalendarViewHelper.isTimelineView(widget.view)) {
          final double difference =
              dragUpdateDetails.globalPosition.dy - _scrollStartPosition;
          if (difference < 0 &&
              !DateTimeHelper.canMoveToNextView(
                  widget.view,
                  widget.calendar.monthViewSettings.numberOfWeeksInView,
                  widget.calendar.minDate,
                  widget.calendar.maxDate,
                  _currentViewVisibleDates,
                  widget.calendar.timeSlotViewSettings.nonWorkingDays)) {
            _position = 0;
            return;
          } else if (difference > 0 &&
              !DateTimeHelper.canMoveToPreviousView(
                  widget.view,
                  widget.calendar.monthViewSettings.numberOfWeeksInView,
                  widget.calendar.minDate,
                  widget.calendar.maxDate,
                  _currentViewVisibleDates,
                  widget.calendar.timeSlotViewSettings.nonWorkingDays)) {
            _position = 0;
            return;
          }
          _position = difference;
          setState(() {
            /* Updates the widget navigated distance and moves the widget
       in the custom scroll view */
          });
        }
    }
  }

  void _onVerticalEnd(DragEndDetails dragEndDetails,
      [bool isResourceEnabled = false,
      bool isTimelineView = false,
      bool isMonthView = false,
      double viewHeaderHeight = 0,
      double timeLabelWidth = 0,
      double weekNumberPanelWidth = 0,
      bool isNeedDragAndDrop = false]) {
    if (_dragDetails.value.appointmentView != null &&
        !widget.isMobilePlatform &&
        isNeedDragAndDrop) {
      _handleLongPressEnd(
          _dragDetails.value.position.value! - _dragDifferenceOffset!,
          isTimelineView,
          isResourceEnabled,
          isMonthView,
          viewHeaderHeight,
          timeLabelWidth,
          weekNumberPanelWidth);
      return;
    }
    switch (widget.calendar.viewNavigationMode) {
      case ViewNavigationMode.none:
        return;
      case ViewNavigationMode.snap:
        widget.removePicker();
        if (widget.calendar.monthViewSettings.navigationDirection ==
                MonthNavigationDirection.vertical &&
            !CalendarViewHelper.isTimelineView(widget.view)) {
          // condition to check and update the bottom to top swiping
          if (-_position >= widget.height / 2) {
            _tween.begin = _position;
            _tween.end = -widget.height;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted || _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .forward()
                .then<dynamic>((dynamic value) => _updateNextView());

            /// updates the current view visible dates when the view swiped in
            /// bottom to top direction
            _updateCurrentViewVisibleDates(isNextView: true);
          }
          // fling the view to bottom to top
          else if (-dragEndDetails.velocity.pixelsPerSecond.dy >
              widget.height) {
            if (!DateTimeHelper.canMoveToNextView(
                widget.view,
                widget.calendar.monthViewSettings.numberOfWeeksInView,
                widget.calendar.minDate,
                widget.calendar.maxDate,
                _currentViewVisibleDates,
                widget.calendar.timeSlotViewSettings.nonWorkingDays)) {
              _position = 0;
              setState(() {
                /* Completes the swiping and rearrange the children position in
            the custom scroll view */
              });
              return;
            }

            _tween.begin = _position;
            _tween.end = -widget.height;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted || _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .fling(
                    velocity: 5.0, animationBehavior: AnimationBehavior.normal)
                .then<dynamic>((dynamic value) => _updateNextView());

            /// updates the current view visible dates when fling the view in
            /// bottom to top direction
            _updateCurrentViewVisibleDates(isNextView: true);
          }
          // condition to check and update the top to bottom swiping
          else if (_position >= widget.height / 2) {
            _tween.begin = _position;
            _tween.end = widget.height;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted || _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .forward()
                .then<dynamic>((dynamic value) => _updatePreviousView());

            /// updates the current view visible dates when the view swiped in
            /// top to bottom direction
            _updateCurrentViewVisibleDates();
          }
          // fling the view to top to bottom
          else if (dragEndDetails.velocity.pixelsPerSecond.dy > widget.height) {
            if (!DateTimeHelper.canMoveToPreviousView(
                widget.view,
                widget.calendar.monthViewSettings.numberOfWeeksInView,
                widget.calendar.minDate,
                widget.calendar.maxDate,
                _currentViewVisibleDates,
                widget.calendar.timeSlotViewSettings.nonWorkingDays)) {
              _position = 0;
              setState(() {
                /* Completes the swiping and rearrange the children position in
            the custom scroll view */
              });
              return;
            }

            _tween.begin = _position;
            _tween.end = widget.height;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted || _position != _tween.end) {
              _animationController.reset();
            }

            _animationController
                .fling(
                    velocity: 5.0, animationBehavior: AnimationBehavior.normal)
                .then<dynamic>((dynamic value) => _updatePreviousView());

            /// updates the current view visible dates when fling the view in
            /// top to bottom direction
            _updateCurrentViewVisibleDates();
          }
          // condition to check and revert the bottom to top swiping
          else if (_position.abs() <= widget.height / 2) {
            _tween.begin = _position;
            _tween.end = 0.0;

            // Resets the controller to forward it again, the animation will
            // forward only from the dismissed state
            if (_animationController.isCompleted || _position != _tween.end) {
              _animationController.reset();
            }

            _animationController.forward();
          }
        }
    }
  }

  void _clearSelection() {
    widget.getCalendarState(_updateCalendarStateDetails);
    for (int i = 0; i < _children.length; i++) {
      final GlobalKey<_CalendarViewState> viewKey =
          // ignore: avoid_as
          _children[i].key! as GlobalKey<_CalendarViewState>;
      if (viewKey.currentState!._selectionPainter!.selectedDate !=
          _updateCalendarStateDetails.selectedDate) {
        viewKey.currentState!._selectionPainter!.selectedDate =
            _updateCalendarStateDetails.selectedDate;
        viewKey.currentState!._selectionNotifier.value =
            !viewKey.currentState!._selectionNotifier.value;
      }
    }
  }

  /// Updates the all day panel of the view, when the all day panel expanded and
  /// the view swiped to next or previous view with the expanded all day panel,
  /// it will be collapsed.
  void _updateAllDayPanel() {
    GlobalKey<_CalendarViewState> viewKey;
    if (_currentChildIndex == 0) {
      viewKey = _previousViewKey;
    } else if (_currentChildIndex == 1) {
      viewKey = _currentViewKey;
    } else {
      viewKey = _nextViewKey;
    }
    if (viewKey.currentState!._expanderAnimationController?.status ==
        AnimationStatus.completed) {
      viewKey.currentState!._expanderAnimationController?.reset();
    }
    viewKey.currentState!._isExpanded = false;
  }

  /// Method to clear the appointments in the previous/next view
  void _updateAppointmentPainter() {
    for (int i = 0; i < _children.length; i++) {
      final _CalendarView view = _children[i];
      final GlobalKey<_CalendarViewState> viewKey =
          // ignore: avoid_as
          view.key! as GlobalKey<_CalendarViewState>;
      if (widget.view == CalendarView.month &&
          widget.calendar.monthCellBuilder != null) {
        if (view.visibleDates == _currentViewVisibleDates) {
          widget.getCalendarState(_updateCalendarStateDetails);
          if (!CalendarViewHelper.isCollectionEqual(
              viewKey.currentState!._monthView.visibleAppointmentNotifier.value,
              _updateCalendarStateDetails.visibleAppointments)) {
            viewKey.currentState!._monthView.visibleAppointmentNotifier.value =
                _updateCalendarStateDetails.visibleAppointments;
          }
        } else {
          if (!CalendarViewHelper.isEmptyList(viewKey
              .currentState!._monthView.visibleAppointmentNotifier.value)) {
            viewKey.currentState!._monthView.visibleAppointmentNotifier.value =
                null;
          }
        }
      } else {
        final AppointmentLayout appointmentLayout =
            viewKey.currentState!._appointmentLayout;
        if (view.visibleDates == _currentViewVisibleDates) {
          widget.getCalendarState(_updateCalendarStateDetails);
          if (!CalendarViewHelper.isCollectionEqual(
              appointmentLayout.visibleAppointments.value,
              _updateCalendarStateDetails.visibleAppointments)) {
            appointmentLayout.visibleAppointments.value =
                _updateCalendarStateDetails.visibleAppointments;
          }
        } else {
          if (!CalendarViewHelper.isEmptyList(
              appointmentLayout.visibleAppointments.value)) {
            appointmentLayout.visibleAppointments.value = null;
          }
        }
      }
    }
  }
}

class _SelectionPainter extends CustomPainter {
  _SelectionPainter(
      this.calendar,
      this.view,
      this.visibleDates,
      this.selectedDate,
      this.selectionDecoration,
      this.timeIntervalHeight,
      this.calendarTheme,
      this.repaintNotifier,
      this.isRTL,
      this.selectedResourceIndex,
      this.resourceItemHeight,
      this.showWeekNumber,
      this.isMobilePlatform,
      this.getCalendarState)
      : super(repaint: repaintNotifier);

  final SfCalendar calendar;
  final CalendarView view;
  final SfCalendarThemeData calendarTheme;
  final List<DateTime> visibleDates;
  Decoration? selectionDecoration;
  DateTime? selectedDate;
  final double timeIntervalHeight;
  final bool isRTL;
  final UpdateCalendarState getCalendarState;
  int selectedResourceIndex;
  final double? resourceItemHeight;

  late BoxPainter _boxPainter;
  AppointmentView? appointmentView;
  double _cellWidth = 0, _cellHeight = 0, _xPosition = 0, _yPosition = 0;
  final ValueNotifier<bool> repaintNotifier;
  final UpdateCalendarStateDetails _updateCalendarStateDetails =
      UpdateCalendarStateDetails();
  final bool showWeekNumber;
  final bool isMobilePlatform;

  @override
  void paint(Canvas canvas, Size size) {
    selectionDecoration ??= BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: calendarTheme.selectionBorderColor!, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(2)),
      shape: BoxShape.rectangle,
    );

    getCalendarState(_updateCalendarStateDetails);
    selectedDate = _updateCalendarStateDetails.selectedDate;
    final bool isMonthView =
        view == CalendarView.month || view == CalendarView.timelineMonth;
    final int timeInterval =
        CalendarViewHelper.getTimeInterval(calendar.timeSlotViewSettings);
    if (selectedDate != null &&
        ((isMonthView &&
                !isDateWithInDateRange(
                    calendar.minDate, calendar.maxDate, selectedDate)) ||
            (!isMonthView &&
                !CalendarViewHelper.isDateTimeWithInDateTimeRange(
                    calendar.minDate,
                    calendar.maxDate,
                    selectedDate!,
                    timeInterval)))) {
      return;
    }
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final double timeLabelWidth = CalendarViewHelper.getTimeLabelWidth(
        calendar.timeSlotViewSettings.timeRulerSize, view);
    double width = size.width;
    final bool isTimeline = CalendarViewHelper.isTimelineView(view);
    if (view != CalendarView.month && !isTimeline) {
      width -= timeLabelWidth;
    }

    final bool isResourceEnabled = isTimeline &&
        CalendarViewHelper.isResourceEnabled(calendar.dataSource, view);
    if ((selectedDate == null && appointmentView == null) ||
        visibleDates != _updateCalendarStateDetails.currentViewVisibleDates ||
        (isResourceEnabled && selectedResourceIndex == -1)) {
      return;
    }

    if (!isTimeline) {
      if (view == CalendarView.month) {
        _cellWidth = width / DateTime.daysPerWeek;
        _cellHeight =
            size.height / calendar.monthViewSettings.numberOfWeeksInView;
      } else {
        _cellWidth = width / visibleDates.length;
        _cellHeight = timeIntervalHeight;
      }
    } else {
      _cellWidth = timeIntervalHeight;
      _cellHeight = size.height;

      /// The selection view must render on the resource area alone, when the
      /// resource enabled.
      if (isResourceEnabled && selectedResourceIndex >= 0) {
        _cellHeight = resourceItemHeight!;
      }
    }

    if (appointmentView != null && appointmentView!.appointment != null) {
      _drawAppointmentSelection(canvas);
    }

    switch (view) {
      case CalendarView.schedule:
        return;
      case CalendarView.month:
        {
          if (selectedDate != null) {
            _drawMonthSelection(canvas, size, width);
          }
        }
        break;
      case CalendarView.day:
        {
          if (selectedDate != null) {
            _drawDaySelection(canvas, size, width, timeLabelWidth);
          }
        }
        break;
      case CalendarView.week:
      case CalendarView.workWeek:
        {
          if (selectedDate != null) {
            _drawWeekSelection(canvas, size, timeLabelWidth, width);
          }
        }
        break;
      case CalendarView.timelineDay:
        {
          if (selectedDate != null) {
            _drawTimelineDaySelection(canvas, size, width);
          }
        }
        break;
      case CalendarView.timelineWeek:
      case CalendarView.timelineWorkWeek:
        {
          if (selectedDate != null) {
            _drawTimelineWeekSelection(canvas, size, width);
          }
        }
        break;
      case CalendarView.timelineMonth:
        {
          if (selectedDate != null) {
            _drawTimelineMonthSelection(canvas, size, width);
          }
        }
    }
  }

  @override
  bool? hitTest(Offset position) {
    return false;
  }

  void _drawMonthSelection(Canvas canvas, Size size, double width) {
    final int visibleDatesLength = visibleDates.length;
    if (!isDateWithInDateRange(
        visibleDates[0], visibleDates[visibleDatesLength - 1], selectedDate)) {
      return;
    }

    final int currentMonth = visibleDates[visibleDatesLength ~/ 2].month;

    /// Check the selected cell date as trailing or leading date when
    /// [SfCalendar] month not shown leading and trailing dates.
    if (!CalendarViewHelper.isCurrentMonthDate(
        calendar.monthViewSettings.numberOfWeeksInView,
        calendar.monthViewSettings.showTrailingAndLeadingDates,
        currentMonth,
        selectedDate!)) {
      return;
    }

    if (CalendarViewHelper.isDateInDateCollection(
        calendar.blackoutDates, selectedDate!)) {
      return;
    }

    for (int i = 0; i < visibleDatesLength; i++) {
      if (isSameDate(visibleDates[i], selectedDate)) {
        final double weekNumberPanelWidth =
            CalendarViewHelper.getWeekNumberPanelWidth(
                showWeekNumber, width, isMobilePlatform);
        _cellWidth = (size.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
        final int columnIndex = (i / DateTime.daysPerWeek).truncate();
        _yPosition = columnIndex * _cellHeight;
        final int rowIndex = i % DateTime.daysPerWeek;
        if (isRTL) {
          _xPosition = (DateTime.daysPerWeek - 1 - rowIndex) * _cellWidth;
        } else {
          _xPosition = rowIndex * _cellWidth + weekNumberPanelWidth;
        }
        _drawSlotSelection(width, size.height, canvas);
        break;
      }
    }
  }

  void _drawDaySelection(
      Canvas canvas, Size size, double width, double timeLabelWidth) {
    if (isSameDate(visibleDates[0], selectedDate)) {
      if (isRTL) {
        _xPosition = 0;
      } else {
        _xPosition = timeLabelWidth;
      }

      selectedDate = _updateSelectedDate();

      _yPosition = AppointmentHelper.timeToPosition(
          calendar, selectedDate!, timeIntervalHeight);
      _drawSlotSelection(width + timeLabelWidth, size.height, canvas);
    }
  }

  /// Method to update the selected date, when the selected date not fill the
  /// exact time slot, and render the mid of time slot, on this scenario we
  /// have updated the selected date to update the exact time slot.
  ///
  /// Eg: If the time interval is 60min, and the selected date is 12.45 PM the
  /// selection renders on the center of 12 to 1 PM slot, to avoid this we have
  /// modified the selected date to 1 PM so that the selection will render the
  /// exact time slot.
  DateTime _updateSelectedDate() {
    final int timeInterval =
        CalendarViewHelper.getTimeInterval(calendar.timeSlotViewSettings);
    final int startHour = calendar.timeSlotViewSettings.startHour.toInt();
    final double startMinute = (calendar.timeSlotViewSettings.startHour -
            calendar.timeSlotViewSettings.startHour.toInt()) *
        60;
    final int selectedMinutes = ((selectedDate!.hour - startHour) * 60) +
        (selectedDate!.minute - startMinute.toInt());
    if (selectedMinutes % timeInterval != 0) {
      final int diff = selectedMinutes % timeInterval;
      if (diff < (timeInterval / 2)) {
        return selectedDate!.subtract(Duration(minutes: diff));
      } else {
        return selectedDate!.add(Duration(minutes: timeInterval - diff));
      }
    }

    return selectedDate!;
  }

  void _drawWeekSelection(
      Canvas canvas, Size size, double timeLabelWidth, double width) {
    final int visibleDatesLength = visibleDates.length;
    if (isDateWithInDateRange(
        visibleDates[0], visibleDates[visibleDatesLength - 1], selectedDate)) {
      for (int i = 0; i < visibleDatesLength; i++) {
        if (isSameDate(selectedDate, visibleDates[i])) {
          final int rowIndex = i;
          if (isRTL) {
            _xPosition = _cellWidth * (visibleDatesLength - 1 - rowIndex);
          } else {
            _xPosition = timeLabelWidth + _cellWidth * rowIndex;
          }

          selectedDate = _updateSelectedDate();
          _yPosition = AppointmentHelper.timeToPosition(
              calendar, selectedDate!, timeIntervalHeight);
          _drawSlotSelection(width + timeLabelWidth, size.height, canvas);
          break;
        }
      }
    }
  }

  /// Returns the yPosition for selection view based on resource associated with
  /// the selected cell in  timeline views when resource enabled.
  double _getTimelineYPosition() {
    if (selectedResourceIndex == -1) {
      return 0;
    }

    return selectedResourceIndex * resourceItemHeight!;
  }

  void _drawTimelineDaySelection(Canvas canvas, Size size, double width) {
    if (isSameDate(visibleDates[0], selectedDate)) {
      selectedDate = _updateSelectedDate();
      _xPosition = AppointmentHelper.timeToPosition(
          calendar, selectedDate!, timeIntervalHeight);
      _yPosition = _getTimelineYPosition();
      final double height = selectedResourceIndex == -1
          ? size.height
          : _yPosition + resourceItemHeight!;
      if (isRTL) {
        _xPosition = size.width - _xPosition - _cellWidth;
      }
      _drawSlotSelection(width, height, canvas);
    }
  }

  void _drawTimelineMonthSelection(Canvas canvas, Size size, double width) {
    if (!isDateWithInDateRange(
        visibleDates[0], visibleDates[visibleDates.length - 1], selectedDate)) {
      return;
    }

    if (CalendarViewHelper.isDateInDateCollection(
        calendar.blackoutDates, selectedDate!)) {
      return;
    }

    for (int i = 0; i < visibleDates.length; i++) {
      if (isSameDate(visibleDates[i], selectedDate)) {
        _yPosition = _getTimelineYPosition();
        _xPosition =
            isRTL ? size.width - ((i + 1) * _cellWidth) : i * _cellWidth;
        final double height = selectedResourceIndex == -1
            ? size.height
            : _yPosition + resourceItemHeight!;
        _drawSlotSelection(width, height, canvas);
        break;
      }
    }
  }

  void _drawTimelineWeekSelection(Canvas canvas, Size size, double width) {
    if (isDateWithInDateRange(
        visibleDates[0], visibleDates[visibleDates.length - 1], selectedDate)) {
      selectedDate = _updateSelectedDate();
      for (int i = 0; i < visibleDates.length; i++) {
        if (isSameDate(selectedDate, visibleDates[i])) {
          final double singleViewWidth = width / visibleDates.length;
          _xPosition = (i * singleViewWidth) +
              AppointmentHelper.timeToPosition(
                  calendar, selectedDate!, timeIntervalHeight);
          if (isRTL) {
            _xPosition = size.width - _xPosition - _cellWidth;
          }
          _yPosition = _getTimelineYPosition();
          final double height = selectedResourceIndex == -1
              ? size.height
              : _yPosition + resourceItemHeight!;
          _drawSlotSelection(width, height, canvas);
          break;
        }
      }
    }
  }

  void _drawAppointmentSelection(Canvas canvas) {
    Rect rect = appointmentView!.appointmentRect!.outerRect;
    rect = Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom);
    _boxPainter = selectionDecoration!
        .createBoxPainter(_updateSelectionDecorationPainter);
    _boxPainter.paint(canvas, Offset(rect.left, rect.top),
        ImageConfiguration(size: rect.size));
  }

  /// Used to pass the argument of create box painter and it is called when
  /// decoration have asynchronous data like image.
  void _updateSelectionDecorationPainter() {
    repaintNotifier.value = !repaintNotifier.value;
  }

  void _drawSlotSelection(double width, double height, Canvas canvas) {
    //// padding used to avoid first, last row and column selection clipping.
    const double padding = 0.5;
    final Rect rect = Rect.fromLTRB(
        _xPosition == 0 ? _xPosition + padding : _xPosition,
        _yPosition == 0 ? _yPosition + padding : _yPosition,
        _xPosition + _cellWidth == width
            ? _xPosition + _cellWidth - padding
            : _xPosition + _cellWidth,
        _yPosition + _cellHeight == height
            ? _yPosition + _cellHeight - padding
            : _yPosition + _cellHeight);

    _boxPainter = selectionDecoration!
        .createBoxPainter(_updateSelectionDecorationPainter);
    _boxPainter.paint(canvas, Offset(rect.left, rect.top),
        ImageConfiguration(size: rect.size, textDirection: TextDirection.ltr));
  }

  @override
  bool shouldRepaint(_SelectionPainter oldDelegate) {
    final _SelectionPainter oldWidget = oldDelegate;
    return oldWidget.selectionDecoration != selectionDecoration ||
        oldWidget.selectedDate != selectedDate ||
        oldWidget.view != view ||
        oldWidget.visibleDates != visibleDates ||
        oldWidget.selectedResourceIndex != selectedResourceIndex ||
        oldWidget.isRTL != isRTL;
  }
}

class _TimeRulerView extends CustomPainter {
  _TimeRulerView(
      this.horizontalLinesCount,
      this.timeIntervalHeight,
      this.timeSlotViewSettings,
      this.cellBorderColor,
      this.isRTL,
      this.locale,
      this.calendarTheme,
      this.isTimelineView,
      this.visibleDates,
      this.textScaleFactor);

  final double horizontalLinesCount;
  final double timeIntervalHeight;
  final TimeSlotViewSettings timeSlotViewSettings;
  final bool isRTL;
  final String locale;
  final SfCalendarThemeData calendarTheme;
  final Color? cellBorderColor;
  final bool isTimelineView;
  final List<DateTime> visibleDates;
  final double textScaleFactor;
  final Paint _linePainter = Paint();
  final TextPainter _textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    const double offset = 0.5;
    double xPosition, yPosition;
    DateTime date = visibleDates[0];

    xPosition = isRTL && isTimelineView ? size.width : 0;
    yPosition = timeIntervalHeight;
    _linePainter.strokeWidth = offset;
    _linePainter.color = cellBorderColor ?? calendarTheme.cellBorderColor!;

    if (!isTimelineView) {
      final double lineXPosition = isRTL ? offset : size.width - offset;
      // Draw vertical time label line
      canvas.drawLine(Offset(lineXPosition, 0),
          Offset(lineXPosition, size.height), _linePainter);
    }

    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;
    _textPainter.textScaleFactor = textScaleFactor;

    final TextStyle timeTextStyle =
        timeSlotViewSettings.timeTextStyle ?? calendarTheme.timeTextStyle!;

    final double hour = (timeSlotViewSettings.startHour -
            timeSlotViewSettings.startHour.toInt()) *
        60;
    if (isTimelineView) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _linePainter);
      final double timelineViewWidth =
          timeIntervalHeight * horizontalLinesCount;
      for (int i = 0; i < visibleDates.length; i++) {
        date = visibleDates[i];
        _drawTimeLabels(
            canvas, size, date, hour, xPosition, yPosition, timeTextStyle);
        if (isRTL) {
          xPosition -= timelineViewWidth;
        } else {
          xPosition += timelineViewWidth;
        }
      }
    } else {
      _drawTimeLabels(
          canvas, size, date, hour, xPosition, yPosition, timeTextStyle);
    }
  }

  /// Draws the time labels in the time label view for timeslot views in
  /// calendar.
  void _drawTimeLabels(Canvas canvas, Size size, DateTime date, double hour,
      double xPosition, double yPosition, TextStyle timeTextStyle) {
    double newYPosition = yPosition;
    double newXPosition = xPosition;
    DateTime newDate = date;
    const int padding = 5;
    final int timeInterval =
        CalendarViewHelper.getTimeInterval(timeSlotViewSettings);

    /// For timeline view we will draw 24 lines where as in day, week and work
    /// week view we will draw 23 lines excluding the 12 AM, hence to rectify
    /// this the i value handled accordingly.
    for (int i = isTimelineView ? 0 : 1;
        i <= (isTimelineView ? horizontalLinesCount - 1 : horizontalLinesCount);
        i++) {
      if (isTimelineView) {
        canvas.save();
        canvas.clipRect(
            Rect.fromLTWH(newXPosition, 0, timeIntervalHeight, size.height));
        canvas.restore();
        canvas.drawLine(Offset(newXPosition, 0),
            Offset(newXPosition, size.height), _linePainter);
      }

      final double minute = (i * timeInterval) + hour;
      newDate = DateTime(newDate.year, newDate.month, newDate.day,
          timeSlotViewSettings.startHour.toInt(), minute.toInt());
      final String time =
          DateFormat(timeSlotViewSettings.timeFormat, locale).format(newDate);
      final TextSpan span = TextSpan(
        text: time,
        style: timeTextStyle,
      );

      final double cellWidth = isTimelineView ? timeIntervalHeight : size.width;

      _textPainter.text = span;
      _textPainter.layout(minWidth: 0, maxWidth: cellWidth);
      if (isTimelineView && _textPainter.height > size.height) {
        return;
      }

      double startXPosition = (cellWidth - _textPainter.width) / 2;
      if (startXPosition < 0) {
        startXPosition = 0;
      }

      if (isTimelineView) {
        startXPosition =
            isRTL ? newXPosition - _textPainter.width : newXPosition;
      }

      double startYPosition = newYPosition - (_textPainter.height / 2);

      if (isTimelineView) {
        startYPosition = (size.height - _textPainter.height) / 2;
        startXPosition =
            isRTL ? startXPosition - padding : startXPosition + padding;
      }

      _textPainter.paint(canvas, Offset(startXPosition, startYPosition));

      if (!isTimelineView) {
        final Offset start =
            Offset(isRTL ? 0 : size.width - (startXPosition / 2), newYPosition);
        final Offset end =
            Offset(isRTL ? startXPosition / 2 : size.width, newYPosition);
        canvas.drawLine(start, end, _linePainter);
        newYPosition += timeIntervalHeight;
        if (newYPosition.round() == size.height.round()) {
          break;
        }
      } else {
        if (isRTL) {
          newXPosition -= timeIntervalHeight;
        } else {
          newXPosition += timeIntervalHeight;
        }
      }
    }
  }

  @override
  bool shouldRepaint(_TimeRulerView oldDelegate) {
    final _TimeRulerView oldWidget = oldDelegate;
    return oldWidget.timeSlotViewSettings != timeSlotViewSettings ||
        oldWidget.cellBorderColor != cellBorderColor ||
        oldWidget.calendarTheme != calendarTheme ||
        oldWidget.isRTL != isRTL ||
        oldWidget.locale != locale ||
        oldWidget.visibleDates != visibleDates ||
        oldWidget.isTimelineView != isTimelineView ||
        oldWidget.textScaleFactor != textScaleFactor;
  }
}

class _CalendarMultiChildContainer extends Stack {
  _CalendarMultiChildContainer(
      {this.painter,
      List<Widget> children = const <Widget>[],
      required this.width,
      required this.height})
      : super(children: children);
  final CustomPainter? painter;
  final double width;
  final double height;

  @override
  RenderStack createRenderObject(BuildContext context) {
    final Directionality? widget =
        context.dependOnInheritedWidgetOfExactType<Directionality>();
    return _MultiChildContainerRenderObject(width, height,
        painter: painter, direction: widget?.textDirection);
  }

  @override
  void updateRenderObject(BuildContext context, RenderStack renderObject) {
    super.updateRenderObject(context, renderObject);
    if (renderObject is _MultiChildContainerRenderObject) {
      final Directionality? widget =
          context.dependOnInheritedWidgetOfExactType<Directionality>();
      renderObject
        ..width = width
        ..height = height
        ..painter = painter
        ..textDirection = widget?.textDirection;
    }
  }
}

class _MultiChildContainerRenderObject extends RenderStack {
  _MultiChildContainerRenderObject(this._width, this._height,
      {CustomPainter? painter, TextDirection? direction})
      : _painter = painter,
        super(textDirection: direction);

  CustomPainter? get painter => _painter;
  CustomPainter? _painter;

  set painter(CustomPainter? value) {
    if (_painter == value) {
      return;
    }

    final CustomPainter? oldPainter = _painter;
    _painter = value;
    _updatePainter(_painter, oldPainter);
    if (attached) {
      oldPainter?.removeListener(markNeedsPaint);
      _painter?.addListener(markNeedsPaint);
    }
  }

  double get width => _width;

  set width(double value) {
    if (_width == value) {
      return;
    }

    _width = value;
    markNeedsLayout();
  }

  double _width;
  double _height;

  double get height => _height;

  set height(double value) {
    if (_height == value) {
      return;
    }

    _height = value;
    markNeedsLayout();
  }

  /// Caches [SemanticsNode]s created during [assembleSemanticsNode] so they
  /// can be re-used when [assembleSemanticsNode] is called again. This ensures
  /// stable ids for the [SemanticsNode]s of children across
  /// [assembleSemanticsNode] invocations.
  /// Ref: assembleSemanticsNode method in RenderParagraph class
  /// (https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/rendering/paragraph.dart)
  List<SemanticsNode>? _cacheNodes;

  void _updatePainter(CustomPainter? newPainter, CustomPainter? oldPainter) {
    if (newPainter == null) {
      markNeedsPaint();
    } else if (oldPainter == null ||
        newPainter.runtimeType != oldPainter.runtimeType ||
        newPainter.shouldRepaint(oldPainter)) {
      markNeedsPaint();
    }

    if (newPainter == null) {
      if (attached) {
        markNeedsSemanticsUpdate();
      }
    } else if (oldPainter == null ||
        newPainter.runtimeType != oldPainter.runtimeType ||
        newPainter.shouldRebuildSemantics(oldPainter)) {
      markNeedsSemanticsUpdate();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _painter?.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _painter?.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void performLayout() {
    final Size widgetSize = constraints.biggest;
    size = Size(widgetSize.width.isInfinite ? width : widgetSize.width,
        widgetSize.height.isInfinite ? height : widgetSize.height);
    for (dynamic child = firstChild; child != null; child = childAfter(child)) {
      child.layout(constraints);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_painter != null) {
      _painter!.paint(context.canvas, size);
    }

    paintStack(context, offset);
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
  }

  @override
  void assembleSemanticsNode(
    SemanticsNode node,
    SemanticsConfiguration config,
    Iterable<SemanticsNode> children,
  ) {
    _cacheNodes ??= <SemanticsNode>[];
    final List<CustomPainterSemantics> semantics = _semanticsBuilder(size);
    final List<SemanticsNode> semanticsNodes = <SemanticsNode>[];
    for (int i = 0; i < semantics.length; i++) {
      final CustomPainterSemantics currentSemantics = semantics[i];
      final SemanticsNode newChild = _cacheNodes!.isNotEmpty
          ? _cacheNodes!.removeAt(0)
          : SemanticsNode(key: currentSemantics.key);

      final SemanticsProperties properties = currentSemantics.properties;
      final SemanticsConfiguration config = SemanticsConfiguration();
      if (properties.label != null) {
        config.label = properties.label!;
      }
      if (properties.textDirection != null) {
        config.textDirection = properties.textDirection;
      }

      newChild.updateWith(
        config: config,
        // As of now CustomPainter does not support multiple tree levels.
        childrenInInversePaintOrder: const <SemanticsNode>[],
      );

      newChild
        ..rect = currentSemantics.rect
        ..transform = currentSemantics.transform
        ..tags = currentSemantics.tags;

      semanticsNodes.add(newChild);
    }

    final List<SemanticsNode> finalChildren = <SemanticsNode>[];
    finalChildren.addAll(semanticsNodes);
    finalChildren.addAll(children);
    _cacheNodes = semanticsNodes;
    super.assembleSemanticsNode(node, config, finalChildren);
  }

  @override
  void clearSemantics() {
    super.clearSemantics();
    _cacheNodes = null;
  }

  SemanticsBuilderCallback get _semanticsBuilder {
    final List<CustomPainterSemantics> semantics = <CustomPainterSemantics>[];
    if (painter != null) {
      semantics.addAll(painter!.semanticsBuilder!(size));
    }
    // ignore: avoid_as
    for (RenderRepaintBoundary? child = firstChild! as RenderRepaintBoundary;
        child != null;
        // ignore: avoid_as
        child = childAfter(child) as RenderRepaintBoundary?) {
      if (child.child is! CustomCalendarRenderObject) {
        continue;
      }

      final CustomCalendarRenderObject appointmentRenderObject =
          // ignore: avoid_as
          child.child! as CustomCalendarRenderObject;
      semantics.addAll(appointmentRenderObject.semanticsBuilder!(size));
    }

    return (Size size) {
      return semantics;
    };
  }
}

class _CustomNeverScrollableScrollPhysics extends NeverScrollableScrollPhysics {
  /// Creates scroll physics that does not let the user scroll.
  const _CustomNeverScrollableScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  _CustomNeverScrollableScrollPhysics applyTo(ScrollPhysics? ancestor) {
    /// Set the clamping scroll physics as default parent for never scroll
    /// physics, because flutter framework set different parent physics
    /// based on platform(iOS, Android, etc.,)
    return _CustomNeverScrollableScrollPhysics(
        parent: buildParent(const ClampingScrollPhysics(
            parent: RangeMaintainingScrollPhysics())));
  }
}

class _CurrentTimeIndicator extends CustomPainter {
  _CurrentTimeIndicator(
      this.timeIntervalSize,
      this.timeRulerSize,
      this.timeSlotViewSettings,
      this.isTimelineView,
      this.visibleDates,
      this.todayHighlightColor,
      this.isRTL,
      ValueNotifier<int> repaintNotifier)
      : super(repaint: repaintNotifier);
  final double timeIntervalSize;
  final TimeSlotViewSettings timeSlotViewSettings;
  final bool isTimelineView;
  final List<DateTime> visibleDates;
  final double timeRulerSize;
  final Color? todayHighlightColor;
  final bool isRTL;

  @override
  void paint(Canvas canvas, Size size) {
    final DateTime now = DateTime.now();
    final int hours = now.hour;
    final int minutes = now.minute;
    final int totalMinutes = (hours * 60) + minutes;
    final int viewStartMinutes = (timeSlotViewSettings.startHour * 60).toInt();
    final int viewEndMinutes = (timeSlotViewSettings.endHour * 60).toInt();
    if (totalMinutes < viewStartMinutes || totalMinutes > viewEndMinutes) {
      return;
    }

    int index = -1;
    for (int i = 0; i < visibleDates.length; i++) {
      final DateTime date = visibleDates[i];
      if (isSameDate(date, now)) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      return;
    }

    final double minuteHeight = timeIntervalSize /
        CalendarViewHelper.getTimeInterval(timeSlotViewSettings);
    final double currentTimePosition = CalendarViewHelper.getTimeToPosition(
        Duration(hours: hours, minutes: minutes),
        timeSlotViewSettings,
        minuteHeight);
    final Paint painter = Paint()
      ..color = todayHighlightColor!
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    if (isTimelineView) {
      final double viewSize = size.width / visibleDates.length;
      double startXPosition = (index * viewSize) + currentTimePosition;
      if (isRTL) {
        startXPosition = size.width - startXPosition;
      }
      canvas.drawCircle(Offset(startXPosition, 5), 5, painter);
      canvas.drawLine(Offset(startXPosition, 0),
          Offset(startXPosition, size.height), painter);
    } else {
      final double viewSize =
          (size.width - timeRulerSize) / visibleDates.length;
      final double startYPosition = currentTimePosition;
      double viewStartPosition = (index * viewSize) + timeRulerSize;
      double viewEndPosition = viewStartPosition + viewSize;
      double startXPosition = viewStartPosition < 5 ? 5 : viewStartPosition;
      if (isRTL) {
        viewStartPosition = size.width - viewStartPosition;
        viewEndPosition = size.width - viewEndPosition;
        startXPosition = size.width - startXPosition;
      }
      canvas.drawCircle(Offset(startXPosition, startYPosition), 5, painter);
      canvas.drawLine(Offset(viewStartPosition, startYPosition),
          Offset(viewEndPosition, startYPosition), painter);
    }
  }

  @override
  bool? hitTest(Offset position) {
    return false;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// Returns the date time value from the position.
DateTime? _timeFromPosition(
    DateTime date,
    TimeSlotViewSettings timeSlotViewSettings,
    double positionY,
    _CalendarViewState? currentState,
    double timeIntervalHeight,
    bool isTimelineView) {
  double newPositionY = positionY;
  final double topPosition =
      currentState == null ? 0 : currentState._scrollController!.offset;

  final double singleIntervalHeightForAnHour =
      (60 / CalendarViewHelper.getTimeInterval(timeSlotViewSettings)) *
          timeIntervalHeight;
  final double startHour = timeSlotViewSettings.startHour;
  final double endHour = timeSlotViewSettings.endHour;
  if (isTimelineView) {
    if (currentState!._isRTL) {
      newPositionY = (currentState._scrollController!.offset %
              _getSingleViewWidthForTimeLineView(currentState)) +
          (currentState._scrollController!.position.viewportDimension -
              newPositionY);
    } else {
      newPositionY += currentState._scrollController!.offset %
          _getSingleViewWidthForTimeLineView(currentState);
    }
  } else {
    newPositionY += topPosition;
  }
  if (newPositionY >= 0) {
    double totalHour = newPositionY / singleIntervalHeightForAnHour;
    totalHour += startHour;
    int hour = totalHour.toInt();
    final int minute = ((totalHour - hour) * 60).round();
    if (isTimelineView) {
      while (hour >= endHour) {
        hour = ((hour - endHour) + startHour).toInt();
      }
    }
    return DateTime(date.year, date.month, date.day, hour, minute, 0);
  }

  return DateTime(date.year, date.month, date.day, 0, 0, 0);
}

/// Returns the single view width from the time line view for time line
double _getSingleViewWidthForTimeLineView(_CalendarViewState viewState) {
  return (viewState._scrollController!.position.maxScrollExtent +
          viewState._scrollController!.position.viewportDimension) /
      viewState.widget.visibleDates.length;
}

class _ResizingPaintDetails {
  _ResizingPaintDetails(
      {this.appointmentView,
      required this.position,
      this.isAllDayPanel = false,
      this.scrollPosition,
      this.monthRowCount = 0,
      this.monthCellHeight,
      this.appointmentColor = Colors.transparent,
      this.resizingTime});

  AppointmentView? appointmentView;
  final ValueNotifier<Offset?> position;
  bool isAllDayPanel;
  double? scrollPosition;
  int monthRowCount;
  double? monthCellHeight;
  Color appointmentColor;
  DateTime? resizingTime;
}

class _ResizingAppointmentPainter extends CustomPainter {
  _ResizingAppointmentPainter(
      this.resizingDetails,
      this.isRTL,
      this.textScaleFactor,
      this.isMobilePlatform,
      this.appointmentTextStyle,
      this.allDayHeight,
      this.viewHeaderHeight,
      this.timeLabelWidth,
      this.timeIntervalHeight,
      this.scrollController,
      this.dragAndDropSettings,
      this.view,
      this.mouseCursor,
      this.weekNumberPanelWidth,
      this.calendarTheme)
      : super(repaint: resizingDetails.value.position);

  final ValueNotifier<_ResizingPaintDetails> resizingDetails;

  final bool isRTL;

  final double textScaleFactor;

  final bool isMobilePlatform;

  final TextStyle appointmentTextStyle;

  final double allDayHeight;

  final double viewHeaderHeight;

  final ScrollController? scrollController;

  final CalendarView view;

  final double weekNumberPanelWidth;

  final SystemMouseCursor mouseCursor;

  final SfCalendarThemeData calendarTheme;

  final DragAndDropSettings dragAndDropSettings;

  final double timeLabelWidth;

  final double timeIntervalHeight;

  final Paint _shadowPainter = Paint();
  final TextPainter _textPainter = TextPainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (resizingDetails.value.appointmentView == null ||
        resizingDetails.value.appointmentView!.appointmentRect == null) {
      return;
    }
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final double scrollOffset =
        view == CalendarView.month || resizingDetails.value.isAllDayPanel
            ? 0
            : resizingDetails.value.scrollPosition ?? scrollController!.offset;

    final bool isForwardResize = mouseCursor == SystemMouseCursors.resizeDown ||
        mouseCursor == SystemMouseCursors.resizeRight;
    final bool isBackwardResize = mouseCursor == SystemMouseCursors.resizeUp ||
        mouseCursor == SystemMouseCursors.resizeLeft;

    const int textStartPadding = 3;
    double xPosition = resizingDetails.value.position.value!.dx;
    double yPosition = resizingDetails.value.position.value!.dy;

    _shadowPainter.color = resizingDetails.value.appointmentColor;
    final bool isTimelineView = CalendarViewHelper.isTimelineView(view);

    final bool isHorizontalResize = resizingDetails.value.isAllDayPanel ||
        isTimelineView ||
        view == CalendarView.month;
    double left = resizingDetails.value.position.value!.dx,
        top = resizingDetails.value.appointmentView!.appointmentRect!.top,
        right = resizingDetails.value.appointmentView!.appointmentRect!.right,
        bottom = resizingDetails.value.appointmentView!.appointmentRect!.bottom;

    bool canUpdateSubjectPosition = true;
    late Rect rect;
    if (resizingDetails.value.monthRowCount != 0 &&
        view == CalendarView.month) {
      final int lastRow = resizingDetails.value.monthRowCount;
      for (int i = lastRow; i >= 0; i--) {
        if (i == 0) {
          if (isBackwardResize) {
            left = isRTL ? 0 : weekNumberPanelWidth;
            right =
                resizingDetails.value.appointmentView!.appointmentRect!.right;
            if (isRTL) {
              top -= resizingDetails.value.monthCellHeight!;
              xPosition = right;
              yPosition = top;
            } else {
              top += resizingDetails.value.monthCellHeight!;
            }
          } else {
            left = resizingDetails.value.appointmentView!.appointmentRect!.left;
            right = isRTL ? size.width - weekNumberPanelWidth : size.width;
            if (isRTL) {
              top += resizingDetails.value.monthCellHeight!;
            } else {
              top -= resizingDetails.value.monthCellHeight!;
            }

            if (!isRTL) {
              xPosition = left;
              yPosition = top;
            }
          }
        } else if (i == lastRow) {
          if (isBackwardResize) {
            left = resizingDetails.value.position.value!.dx;
            right = isRTL ? size.width - weekNumberPanelWidth : size.width;
            xPosition = left;
            yPosition = resizingDetails.value.position.value!.dy;
          } else {
            right = resizingDetails.value.position.value!.dx;
            left = isRTL ? 0 : weekNumberPanelWidth;
            if (!isRTL) {
              xPosition = right;
              yPosition = top;
            }
          }
          top = resizingDetails.value.position.value!.dy;
        } else {
          left = isRTL ? 0 : weekNumberPanelWidth;
          if (isForwardResize) {
            if (isRTL) {
              top += resizingDetails.value.monthCellHeight!;
            } else {
              top -= resizingDetails.value.monthCellHeight!;
            }
          } else {
            if (isRTL) {
              top -= resizingDetails.value.monthCellHeight!;
            } else {
              top += resizingDetails.value.monthCellHeight!;
            }
          }
          right = isRTL ? size.width : size.width - weekNumberPanelWidth;
        }

        bottom = top +
            resizingDetails.value.appointmentView!.appointmentRect!.height;
        rect = Rect.fromLTRB(left, top, right, bottom);
        canvas.drawRect(rect, _shadowPainter);
        paintBorder(canvas, rect,
            left: BorderSide(
                color: calendarTheme.selectionBorderColor!, width: 2),
            right: BorderSide(
                color: calendarTheme.selectionBorderColor!, width: 2),
            bottom: BorderSide(
                color: calendarTheme.selectionBorderColor!, width: 2),
            top: BorderSide(
                color: calendarTheme.selectionBorderColor!, width: 2));
      }
    } else {
      if (isForwardResize) {
        if (isHorizontalResize) {
          if (resizingDetails.value.isAllDayPanel ||
              view == CalendarView.month) {
            left = resizingDetails.value.appointmentView!.appointmentRect!.left;
          } else if (isTimelineView) {
            left =
                resizingDetails.value.appointmentView!.appointmentRect!.left -
                    scrollOffset;
            if (isRTL) {
              left =
                  scrollOffset + scrollController!.position.viewportDimension;
              left = left -
                  ((scrollController!.position.viewportDimension +
                          scrollController!.position.maxScrollExtent) -
                      resizingDetails
                          .value.appointmentView!.appointmentRect!.left);
            }
          }
          right = resizingDetails.value.position.value!.dx;
          top = resizingDetails.value.position.value!.dy;
          bottom = top +
              resizingDetails.value.appointmentView!.appointmentRect!.height;
        } else {
          top = resizingDetails.value.appointmentView!.appointmentRect!.top -
              scrollOffset +
              allDayHeight +
              viewHeaderHeight;
          bottom = resizingDetails.value.position.value!.dy;
          if (top < viewHeaderHeight + allDayHeight) {
            top = viewHeaderHeight + allDayHeight;
            canUpdateSubjectPosition = false;
          }
          bottom = bottom > size.height ? size.height : bottom;
        }

        xPosition = isRTL ? right : left;
      } else {
        if (isHorizontalResize) {
          if (resizingDetails.value.isAllDayPanel ||
              view == CalendarView.month) {
            right =
                resizingDetails.value.appointmentView!.appointmentRect!.right;
          } else if (isTimelineView) {
            right =
                resizingDetails.value.appointmentView!.appointmentRect!.right -
                    scrollOffset;
            if (isRTL) {
              right =
                  scrollOffset + scrollController!.position.viewportDimension;
              right = right -
                  ((scrollController!.position.viewportDimension +
                          scrollController!.position.maxScrollExtent) -
                      resizingDetails
                          .value.appointmentView!.appointmentRect!.right);
            }
          }

          left = resizingDetails.value.position.value!.dx;
          top = resizingDetails.value.position.value!.dy;
          bottom = top +
              resizingDetails.value.appointmentView!.appointmentRect!.height;
        } else {
          top = resizingDetails.value.position.value!.dy;
          bottom =
              resizingDetails.value.appointmentView!.appointmentRect!.bottom -
                  scrollOffset +
                  allDayHeight +
                  viewHeaderHeight;
          if (top < viewHeaderHeight + allDayHeight) {
            top = viewHeaderHeight + allDayHeight;
          }
          bottom = bottom > size.height ? size.height : bottom;
        }

        xPosition = isRTL ? right : left;
        if (!isHorizontalResize) {
          if (top < viewHeaderHeight + allDayHeight) {
            top = viewHeaderHeight + allDayHeight;
            canUpdateSubjectPosition = false;
          }
          bottom = bottom > size.height ? size.height : bottom;
        }
      }
      rect = Rect.fromLTRB(left, top, right, bottom);
      canvas.drawRect(rect, _shadowPainter);
      yPosition = top;
    }
    if (dragAndDropSettings.showTimeIndicator &&
        resizingDetails.value.resizingTime != null) {
      _drawTimeIndicator(canvas, isTimelineView, size, isBackwardResize);
    }

    if (!canUpdateSubjectPosition) {
      return;
    }

    final TextSpan span = TextSpan(
      text: resizingDetails.value.appointmentView!.appointment!.subject,
      style: appointmentTextStyle,
    );

    final bool isRecurrenceAppointment =
        resizingDetails.value.appointmentView!.appointment!.recurrenceRule !=
                null &&
            resizingDetails
                .value.appointmentView!.appointment!.recurrenceRule!.isNotEmpty;

    _updateTextPainter(span);

    if (view != CalendarView.month) {
      _addSubjectTextForTimeslotViews(canvas, textStartPadding, xPosition,
          yPosition, isRecurrenceAppointment, rect);
    } else {
      _addSubjectTextForMonthView(
          canvas,
          resizingDetails.value.appointmentView!.appointmentRect!,
          appointmentTextStyle,
          span,
          isRecurrenceAppointment,
          xPosition,
          rect,
          yPosition);
    }

    paintBorder(canvas, rect,
        left: BorderSide(color: calendarTheme.selectionBorderColor!, width: 2),
        right: BorderSide(color: calendarTheme.selectionBorderColor!, width: 2),
        bottom:
            BorderSide(color: calendarTheme.selectionBorderColor!, width: 2),
        top: BorderSide(color: calendarTheme.selectionBorderColor!, width: 2));
  }

  /// Draw the time indicator when resizing the appointment on all calendar
  /// views except month and timelineMonth views.
  void _drawTimeIndicator(
      Canvas canvas, bool isTimelineView, Size size, bool isBackwardResize) {
    if (view == CalendarView.month || view == CalendarView.timelineMonth) {
      return;
    }

    if (!isTimelineView &&
        resizingDetails.value.position.value!.dy <
            viewHeaderHeight + allDayHeight) {
      return;
    }

    final TextSpan span = TextSpan(
      text: DateFormat(dragAndDropSettings.indicatorTimeFormat)
          .format(resizingDetails.value.resizingTime!),
      style: dragAndDropSettings.timeIndicatorStyle ??
          calendarTheme.timeIndicatorTextStyle,
    );
    _updateTextPainter(span);
    _textPainter.layout(
        minWidth: 0,
        maxWidth: isTimelineView ? timeIntervalHeight : timeLabelWidth);
    double xPosition;
    double yPosition;
    if (isTimelineView) {
      yPosition = viewHeaderHeight + (timeLabelWidth - _textPainter.height);
      xPosition = resizingDetails.value.position.value!.dx;
      if (isRTL) {
        xPosition -= _textPainter.width;
        if (isBackwardResize) {
          xPosition += _textPainter.width;
        }
      }
      if (!isBackwardResize && !isRTL) {
        xPosition -= _textPainter.width;
      }
    } else {
      yPosition = resizingDetails.value.position.value!.dy;
      xPosition = (timeLabelWidth - _textPainter.width) / 2;
      if (isRTL) {
        xPosition = (size.width - timeLabelWidth) + xPosition;
      }
    }
    _textPainter.paint(canvas, Offset(xPosition, yPosition));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addSubjectTextForTimeslotViews(
      Canvas canvas,
      int textStartPadding,
      double xPosition,
      double yPosition,
      bool isRecurrenceAppointment,
      Rect rect) {
    double newXPosition = xPosition;
    final double totalHeight =
        resizingDetails.value.appointmentView!.appointmentRect!.height -
            textStartPadding;
    _updatePainterMaxLines(totalHeight);

    double maxTextWidth =
        resizingDetails.value.appointmentView!.appointmentRect!.width -
            textStartPadding;
    maxTextWidth = maxTextWidth > 0 ? maxTextWidth : 0;
    _textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);
    if (isRTL) {
      newXPosition -= textStartPadding + _textPainter.width;
    }
    _textPainter.paint(
        canvas,
        Offset(newXPosition + (isRTL ? 0 : textStartPadding),
            yPosition + textStartPadding));
    if (isRecurrenceAppointment ||
        resizingDetails.value.appointmentView!.appointment!.recurrenceId !=
            null) {
      double textSize = appointmentTextStyle.fontSize!;
      if (rect.width < textSize || rect.height < textSize) {
        textSize = rect.width > rect.height ? rect.height : rect.width;
      }
      _addRecurrenceIcon(
          rect, canvas, textStartPadding, isRecurrenceAppointment, textSize);
    }
  }

  void _addSubjectTextForMonthView(
      Canvas canvas,
      RRect appointmentRect,
      TextStyle style,
      TextSpan span,
      bool isRecurrenceAppointment,
      double xPosition,
      Rect rect,
      double yPosition) {
    double newXPosition = xPosition;
    double newYPosition = yPosition;
    TextStyle newStyle = style;
    TextSpan newSpan = span;
    double textSize = -1;
    if (textSize == -1) {
      //// left and right side padding value 2 subtracted in appointment width
      double maxTextWidth = appointmentRect.width - 2;
      maxTextWidth = maxTextWidth > 0 ? maxTextWidth : 0;
      for (double j = newStyle.fontSize! - 1; j > 0; j--) {
        _textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);
        if (_textPainter.height >= appointmentRect.height) {
          newStyle = newStyle.copyWith(fontSize: j);
          newSpan = TextSpan(
              text: resizingDetails.value.appointmentView!.appointment!.subject,
              style: newStyle);
          _updateTextPainter(newSpan);
        } else {
          textSize = j + 1;
          break;
        }
      }
    } else {
      newSpan = TextSpan(
          text: resizingDetails.value.appointmentView!.appointment!.subject,
          style: newStyle.copyWith(fontSize: textSize));
      _updateTextPainter(newSpan);
    }
    final double textWidth =
        appointmentRect.width - (isRecurrenceAppointment ? textSize : 1);
    _textPainter.layout(minWidth: 0, maxWidth: textWidth > 0 ? textWidth : 0);
    if (isRTL) {
      newXPosition -= (isRTL ? 0 : 2) + _textPainter.width;
    }
    newYPosition =
        newYPosition + ((appointmentRect.height - _textPainter.height) / 2);
    _textPainter.paint(
        canvas, Offset(newXPosition + (isRTL ? 0 : 2), newYPosition));

    if (isRecurrenceAppointment ||
        resizingDetails.value.appointmentView!.appointment!.recurrenceId !=
            null) {
      _addRecurrenceIcon(rect, canvas, null, isRecurrenceAppointment, textSize);
    }
  }

  void _updateTextPainter(TextSpan span) {
    _textPainter.text = span;
    _textPainter.maxLines = 1;
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textAlign = isRTL ? TextAlign.right : TextAlign.left;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;
    _textPainter.textScaleFactor = textScaleFactor;
  }

  void _addRecurrenceIcon(Rect rect, Canvas canvas, int? textPadding,
      bool isRecurrenceAppointment, double textSize) {
    const double xPadding = 2;
    const double bottomPadding = 2;

    final TextSpan icon = AppointmentHelper.getRecurrenceIcon(
        appointmentTextStyle.color!, textSize, isRecurrenceAppointment);
    _textPainter.text = icon;

    if (view == CalendarView.month) {
      _textPainter.layout(
          minWidth: 0, maxWidth: rect.width + 1 > 0 ? rect.width + 1 : 0);
      final double yPosition =
          rect.top + ((rect.height - _textPainter.height) / 2);
      const double rightPadding = 0;
      final double recurrenceStartPosition = isRTL
          ? rect.left + rightPadding
          : rect.right - _textPainter.width - rightPadding;
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTRB(recurrenceStartPosition, yPosition,
                  recurrenceStartPosition + _textPainter.width, rect.bottom),
              resizingDetails.value.appointmentView!.appointmentRect!.tlRadius),
          _shadowPainter);
      _textPainter.paint(canvas, Offset(recurrenceStartPosition, yPosition));
    } else {
      double maxTextWidth =
          resizingDetails.value.appointmentView!.appointmentRect!.width -
              textPadding! -
              2;
      maxTextWidth = maxTextWidth > 0 ? maxTextWidth : 0;
      _textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTRB(
                  isRTL
                      ? rect.left + textSize + xPadding
                      : rect.right - textSize - xPadding,
                  rect.bottom - bottomPadding - textSize,
                  isRTL ? rect.left : rect.right,
                  rect.bottom),
              resizingDetails.value.appointmentView!.appointmentRect!.tlRadius),
          _shadowPainter);
      _textPainter.paint(
          canvas,
          Offset(
              isRTL ? rect.left + xPadding : rect.right - textSize - xPadding,
              rect.bottom - bottomPadding - textSize));
    }
  }

  void _updatePainterMaxLines(double height) {
    /// [preferredLineHeight] is used to get the line height based on text
    /// style and text. floor the calculated value to set the minimum line
    /// count to painter max lines property.
    final int maxLines = (height / _textPainter.preferredLineHeight).floor();
    if (maxLines <= 0) {
      return;
    }

    _textPainter.maxLines = maxLines;
  }
}

dynamic _getCalendarAppointmentToObject(
    CalendarAppointment? calendarAppointment, SfCalendar calendar) {
  if (calendarAppointment == null) {
    return null;
  }

  final Appointment appointment =
      calendarAppointment.convertToCalendarAppointment();

  if (calendarAppointment.data is Appointment) {
    return appointment;
  }
  final dynamic customObject = calendar.dataSource!
      .convertAppointmentToObject(calendarAppointment.data, appointment);
  assert(customObject != null,
      'Implement convertToCalendarAppointment method from CalendarDataSource');
  return customObject;
}

class _DragPaintDetails {
  _DragPaintDetails(
      {this.appointmentView,
      required this.position,
      this.draggingTime,
      this.timeIntervalHeight});

  AppointmentView? appointmentView;
  final ValueNotifier<Offset?> position;
  DateTime? draggingTime;
  double? timeIntervalHeight;
}

@immutable
class _DraggingAppointmentWidget extends StatefulWidget {
  const _DraggingAppointmentWidget(
      this.dragDetails,
      this.isRTL,
      this.textScaleFactor,
      this.isMobilePlatform,
      this.appointmentTextStyle,
      this.dragAndDropSettings,
      this.calendarView,
      this.allDayPanelHeight,
      this.viewHeaderHeight,
      this.timeLabelWidth,
      this.resourceItemHeight,
      this.calendarTheme,
      this.calendar,
      this.width,
      this.height);

  final ValueNotifier<_DragPaintDetails> dragDetails;

  final bool isRTL;

  final double textScaleFactor;

  final bool isMobilePlatform;

  final TextStyle appointmentTextStyle;

  final DragAndDropSettings dragAndDropSettings;

  final CalendarView calendarView;

  final double allDayPanelHeight;

  final double viewHeaderHeight;

  final double timeLabelWidth;

  final double resourceItemHeight;

  final SfCalendarThemeData calendarTheme;

  final SfCalendar calendar;

  final double width;

  final double height;

  @override
  _DraggingAppointmentState createState() => _DraggingAppointmentState();
}

class _DraggingAppointmentState extends State<_DraggingAppointmentWidget> {
  AppointmentView? _draggingAppointmentView;

  @override
  void initState() {
    _draggingAppointmentView = widget.dragDetails.value.appointmentView;
    widget.dragDetails.value.position.addListener(_updateDraggingAppointment);
    super.initState();
  }

  @override
  void dispose() {
    widget.dragDetails.value.position
        .removeListener(_updateDraggingAppointment);
    super.dispose();
  }

  void _updateDraggingAppointment() {
    if (_draggingAppointmentView != widget.dragDetails.value.appointmentView) {
      _draggingAppointmentView = widget.dragDetails.value.appointmentView;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (widget.dragDetails.value.appointmentView != null &&
        widget.calendar.appointmentBuilder != null) {
      final DateTime date = DateTime(
          _draggingAppointmentView!.appointment!.actualStartTime.year,
          _draggingAppointmentView!.appointment!.actualStartTime.month,
          _draggingAppointmentView!.appointment!.actualStartTime.day);

      child = widget.calendar.appointmentBuilder!(
          context,
          CalendarAppointmentDetails(
              date,
              List<dynamic>.unmodifiable(<dynamic>[
                CalendarViewHelper.getAppointmentDetail(
                    _draggingAppointmentView!.appointment!,
                    widget.calendar.dataSource)
              ]),
              Rect.fromLTWH(
                  widget.dragDetails.value.position.value!.dx,
                  widget.dragDetails.value.position.value!.dy,
                  widget.isRTL
                      ? -_draggingAppointmentView!.appointmentRect!.width
                      : _draggingAppointmentView!.appointmentRect!.width,
                  _draggingAppointmentView!.appointmentRect!.height),
              isMoreAppointmentRegion: false));
    }

    return _DraggingAppointmentRenderObjectWidget(
      widget.dragDetails.value,
      widget.isRTL,
      widget.textScaleFactor,
      widget.isMobilePlatform,
      widget.appointmentTextStyle,
      widget.dragAndDropSettings,
      widget.calendarView,
      widget.allDayPanelHeight,
      widget.viewHeaderHeight,
      widget.timeLabelWidth,
      widget.resourceItemHeight,
      widget.calendarTheme,
      widget.width,
      widget.height,
      child: child,
    );
  }
}

