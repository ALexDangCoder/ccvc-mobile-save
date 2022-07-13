enum TrangThai { DA_DUYET, CHO_DUYET, NHAP, TU_CHOI }
enum TinhTrang { TRUNG_BINH, DAT, KHONG_DAT }

class KetLuanHopModel {
  String id = '';
  String thoiGian = '';
  TrangThai trangThai = TrangThai.CHO_DUYET;
  TinhTrang tinhTrang = TinhTrang.KHONG_DAT;
  List<String>? file = [];
  String? title;

  KetLuanHopModel.empty();

  KetLuanHopModel({
    this.id = '',
    this.thoiGian = '',
    this.trangThai = TrangThai.CHO_DUYET,
    this.tinhTrang = TinhTrang.KHONG_DAT,
    this.file,
    this.title,
  });
}
