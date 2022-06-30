import 'dart:async';

import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:meta/meta.dart';

part 'chi_tiet_ho_tro_state.dart';

class ChiTietHoTroCubit extends BaseCubit<ChiTietHoTroState> {
  ChiTietHoTroCubit() : super(ChiTietHoTroInitial());
  
  void callApi(){
    int counter = 4;
    Timer.periodic(const Duration(seconds: 2), (timer) {
      showLoading();
      counter--;
      if (counter == 0) {
        showContent();
        timer.cancel();
      }
    });
  }
}
