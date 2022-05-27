import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'date_time_cupertino_custom_state.dart';

class DateTimeCupertinoCustomCubit extends Cubit<DateTimeCupertinoCustomState> {
  DateTimeCupertinoCustomCubit() : super(DateTimeCupertinoCustomInitial());

  BehaviorSubject<bool> isSwitchBtnCheckedSubject = BehaviorSubject();
  BehaviorSubject<String> timeSubject = BehaviorSubject();
  BehaviorSubject<String> dateSubject = BehaviorSubject();

  void handleSwitchButtonPressed({required bool isChecked}){
    isSwitchBtnCheckedSubject.sink.add(isChecked);
  }
}
