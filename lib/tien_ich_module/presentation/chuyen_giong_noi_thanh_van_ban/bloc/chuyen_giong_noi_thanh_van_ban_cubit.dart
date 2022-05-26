import 'package:rxdart/rxdart.dart';

class ChuyenGiongNoiThanhVanBanCubit {
  BehaviorSubject<bool> isVoiceSubject = BehaviorSubject.seeded(false);

  Stream<bool> get isVoiceStream => isVoiceSubject.stream;
}
