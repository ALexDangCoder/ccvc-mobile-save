import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tin_tuc_thoi_su_screen.dart';

extension FunDropDown on dropDown {
  String getString() {
    switch (this) {
      case dropDown.tinRadio:
        return 'Tin radio';
      case dropDown.tinTrongNuoc:
        return 'Tin trong nước';
      case dropDown.tinQuocTe:
        return 'Tin quốc tế';
      default:
        return 'khong dung thong tin';
    }
  }
}
