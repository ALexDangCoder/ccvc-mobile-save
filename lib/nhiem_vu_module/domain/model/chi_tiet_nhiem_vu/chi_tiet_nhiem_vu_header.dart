import 'package:ccvc_mobile/generated/l10n.dart';

class ChiTietNhiemVuHeader {
  String id = '';
  String loaiNV = '';
  String soNhiemVu = '';
  String tinhHinhTH = '';
  String hanXuLy = '';
  String nguoiGiao = '';
  String noiDung = '';

  ChiTietNhiemVuHeader.empty();

  ChiTietNhiemVuHeader({
    required this.id,
    required this.loaiNV,
    required this.soNhiemVu,
    required this.tinhHinhTH,
    required this.hanXuLy,
    required this.nguoiGiao,
    required this.noiDung,
  });

  List<ChiTietHeaderRow> listRow() {
    List<ChiTietHeaderRow> list = [
      ChiTietHeaderRow(
        key: S.current.loai_nhiem_vu,
        value: loaiNV,
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.so_nhiem_vu,
        value: soNhiemVu,
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.tinh_hinh_thuc_hien,
        value: tinhHinhTH,
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.han_xu_ly,
        value: hanXuLy,
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.nguoi_giao,
        value: nguoiGiao,
        isNote: false,
      ),
      ChiTietHeaderRow(
        key: S.current.just_noi_dung,
        value: noiDung,
        isNote: false,
      ),
    ];
    return list;
  }
}

class ChiTietHeaderRow {
  String key;
  String value;
  bool isNote;

  ChiTietHeaderRow({
    required this.key,
    required this.value,
    required this.isNote,
  });
}
