import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWorkCubit extends BaseCubit<CalendarWorkState> {
  CalendarWorkCubit() : super(const CalendarViewState());

  late final CalendarController calendarControllerDay = CalendarController();
  late final CalendarController calendarControllerWeek = CalendarController();
  late final CalendarController calendarControllerMonth = CalendarController();

  final BehaviorSubject<DataLichLvModel> _listCalendarWorkSubject =
      BehaviorSubject();

  Stream<DataLichLvModel> get listCalendarWorkStream =>
      _listCalendarWorkSubject.stream;
}

class DataSourceFCalendar extends CalendarDataSource {
  DataSourceFCalendar(List<Appointment> source) {
    appointments = source;
  }
}
