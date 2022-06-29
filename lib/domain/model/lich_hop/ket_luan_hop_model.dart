enum TrangThai { DaDuyet, ChoDuyet, ChuaGuiDuyet, HuyDuyet }
enum TinhTrang { TrungBinh, Dat, ChuaDat }

class KetLuanHopModel {
  String id = '';
  String thoiGian = '';
  TrangThai trangThai = TrangThai.ChoDuyet;
  TinhTrang tinhTrang = TinhTrang.ChuaDat;
  List<String>? file = [];
  String? title;

  KetLuanHopModel.empty();

  KetLuanHopModel({
    this.id = '',
    this.thoiGian = '',
    this.trangThai = TrangThai.ChoDuyet,
    this.tinhTrang = TinhTrang.ChuaDat,
    this.file,
    this.title,
  });
}
