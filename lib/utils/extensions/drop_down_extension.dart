import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tin_tuc_thoi_su_screen.dart';

extension funDropDown on dropDown {
  String getString() {
    switch(this) {
      case dropDown.tinRadio : return 'Tin radio';
      case dropDown.tinTrongNuoc : return 'Tin trong nước';
      default: return 'khong dung thong tin';
    }
  }
}