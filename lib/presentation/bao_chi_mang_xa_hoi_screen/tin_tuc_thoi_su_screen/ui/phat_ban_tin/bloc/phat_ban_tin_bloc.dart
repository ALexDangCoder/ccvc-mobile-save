import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/phat_ban_tin/bloc/phat_ban_tin_state.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class PhatBanTinBloc extends BaseCubit<PhatBanTinState> {
  PhatBanTinBloc() : super(PhatBanTinStateInitial());
  final BehaviorSubject<bool> _isPlay = BehaviorSubject.seeded(true);
  final BehaviorSubject<int> _indexRadio = BehaviorSubject.seeded(0);

  final BehaviorSubject<bool> _isLoopMode = BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> _isRePlay = BehaviorSubject.seeded(false);


  Stream<bool> get isLoopMode => _isLoopMode.stream;
  Stream<bool> get isRePlay => _isRePlay.stream;

  Stream<bool> get streamPlay => _isPlay.stream;

  Stream<int> get indexRadio => _indexRadio.stream;

  void changePlay() {
    _isPlay.sink.add(!_isPlay.value);
  }

  void setLoopMode() {
    _isLoopMode.sink.add(!_isLoopMode.value);
  }
  void setRePlayMode() {
    _isRePlay.sink.add(!_isRePlay.value);
  }

  void setIndexRadio(int index, int maxSize) {
    if (0 <= index && index <= maxSize) {
      _indexRadio.sink.add(index);
    } else {
      if (index < 0) {
        _indexRadio.sink.add(0);
      } else if(index >maxSize){
        _indexRadio.sink.add(maxSize);
      }
    }
  }

  int getIndexRadio() {
    return _indexRadio.value;
  }
  String intToDate(int time ){
    final date = DateTime.fromMillisecondsSinceEpoch(time*1000);
    final result = DateFormat( 'mm:ss').format(date);
    return result;
  }
}

