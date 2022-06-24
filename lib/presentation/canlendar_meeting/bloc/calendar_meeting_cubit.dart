
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/controller/choose_time_calendar_controller.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalendarMeetingCubit extends BaseCubit<CalendarMeetingState> {
  CalendarMeetingCubit() : super(const CalendarViewState()){
    showContent();
  }

  final BehaviorSubject<String> _titleSubject = BehaviorSubject();

  Stream<String> get titleStream => _titleSubject.stream;

  final controller = ChooseTimeController();


  final CalendarController fCalendarControllerDay = CalendarController();

  final CalendarController fCalendarControllerWeek = CalendarController();

  final CalendarController fCalendarControllerMonth = CalendarController();

}