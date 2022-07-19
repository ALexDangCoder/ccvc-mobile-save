import '/generated/l10n.dart';
import '/home_module/utils/extensions/string_extension.dart';

enum GioiTinh { Nam, Nu }

class SinhNhatUserModel {
  final String canBoId;
  final String ngaySinh;
  final String tenCanBo;
  final String gioiTinh;
  final String email;
  GioiTinh gioiTinhEnum = GioiTinh.Nam;

  SinhNhatUserModel(
      {this.canBoId = '',
      this.ngaySinh = '',
      this.tenCanBo = '',
      this.gioiTinh = '',
      this.email = ''}) {
    gioiTinhEnum = fromEnum();
  }

  String title() {
    String title = '';
    if (gioiTinhEnum == GioiTinh.Nam) {
      title = '${S.current.birthday} ${S.current.ong}';
    } else {
      title = '${S.current.birthday} ${S.current.ba}';
    }
    return '$title $tenCanBo';
  }

  GioiTinh fromEnum() {
    switch (gioiTinh.toLowerCase().vietNameseParse()) {
      case 'nam':
        return GioiTinh.Nam;
      case 'nu':
        return GioiTinh.Nu;
    }
    return GioiTinh.Nam;
  }
}
