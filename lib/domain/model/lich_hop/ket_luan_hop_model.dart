enum TrangThai { DA_DUYET, CHO_DUYET, CHUA_GUI_DUYET, HUY_DUYET }
enum TinhTrang { TRUNG_BINH, DAT, CHUA_DAT }

class KetLuanHopModel {
  String id = '';
  String thoiGian = '';
  TrangThai trangThai = TrangThai.CHO_DUYET;
  TinhTrang tinhTrang = TinhTrang.CHUA_DAT;
  List<String>? file = [];
  String? title;

  KetLuanHopModel.empty();

  KetLuanHopModel({
    this.id = '',
    this.thoiGian = '',
    this.trangThai = TrangThai.CHO_DUYET,
    this.tinhTrang = TinhTrang.CHUA_DAT,
    this.file,
    this.title,
  });
}
