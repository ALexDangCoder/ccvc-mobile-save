import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_item.dart';


abstract class CalendarWorkState extends BaseState {
  final CalendarType typeView;
  const CalendarWorkState( this.typeView);
}

class ListViewState extends CalendarWorkState {

  const ListViewState({typeView = CalendarType.DAY}) : super(typeView);

  @override
  // TODO: implement props
  List<Object?> get props => [typeView];
}

class CalendarViewState extends CalendarWorkState {

  const CalendarViewState({typeView = CalendarType.DAY}) : super(typeView);

  @override
  // TODO: implement props
  List<Object?> get props => [typeView];
}
