import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:rxdart/rxdart.dart';

class CaiDatGiaoDienCubit {
  final BehaviorSubject<AppTheme> _selectAppThem = BehaviorSubject<AppTheme>();

  Stream<AppTheme> get selectAppThem => _selectAppThem.stream;

  void dispose() {
    _selectAppThem.close();
  }
}
