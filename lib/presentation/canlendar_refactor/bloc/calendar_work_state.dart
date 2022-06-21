import 'package:equatable/equatable.dart';

enum TypeCalendarList { DAY, WEEK, MONTH }

abstract class CalendarWorkState extends Equatable {
  final TypeCalendarList typeView;
  const CalendarWorkState( this.typeView);
}

class ListViewState extends CalendarWorkState {

  const ListViewState({typeView = TypeCalendarList.DAY}) : super(typeView);

  @override
  // TODO: implement props
  List<Object?> get props => [typeView];
}

class CalendarViewState extends CalendarWorkState {

  const CalendarViewState({typeView = TypeCalendarList.DAY}) : super(typeView);

  @override
  // TODO: implement props
  List<Object?> get props => [typeView];
}
