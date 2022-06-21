import 'package:equatable/equatable.dart';

enum TypeCalendarList { DAY, WEEK, MONTH }

abstract class CalendarWorkState extends Equatable {
  const CalendarWorkState();
}

class ListViewState extends CalendarWorkState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CalendarViewState extends CalendarWorkState {
  final TypeCalendarList typeView;

  const CalendarViewState({this.typeView = TypeCalendarList.DAY});

  @override
  // TODO: implement props
  List<Object?> get props => [typeView];
}
