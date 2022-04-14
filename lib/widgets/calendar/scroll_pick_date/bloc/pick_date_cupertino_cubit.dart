import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/bloc/pick_date_cupertino_state.dart';
import 'package:rxdart/rxdart.dart';

class PicKDateCupertinoCubit extends BaseCubit<PickDateCupertinoState> {
  PicKDateCupertinoCubit() : super(PickDateCupertinoInitial());

  BehaviorSubject<bool> isDateTimeSubject = BehaviorSubject.seeded(true);

  BehaviorSubject<DateTime> startDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );

  BehaviorSubject<DateTime> endDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );

  BehaviorSubject<DateTime> taoLichHopSubject =
  BehaviorSubject.seeded(DateTime.now());

  Stream<DateTime> get taoLichHopStream => taoLichHopSubject.stream;

  Stream<bool> get isDateTimeStream => isDateTimeSubject.stream;

  Stream<DateTime> get startDateStream => startDateSubject.stream;

  Stream<DateTime> get endDateStream => endDateSubject.stream;

  void listeningStartDataTime(DateTime dateAndTime) {
    startDateSubject.add(dateAndTime);
    endDateSubject.add(dateAndTime);
  }

  void listeningEndDataTime(DateTime dateAndTime) {
    endDateSubject.add(dateAndTime);
  }

  void listeningTaoLichHop(DateTime dateAndTime) {
    taoLichHopSubject.add(dateAndTime);
  }
}
