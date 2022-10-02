class ThongKeDiemDanhCaNhanModel {
  int? soLanDiMuon;
  int? soLanVeSom;
  double? soNgayLamViec;
  int? soLanChamCongThuCong;
  int? soNgayVangMatKhongLyDo;
  int? soNgayNghiCoLyDo;

  ThongKeDiemDanhCaNhanModel({
    this.soLanDiMuon,
    this.soLanVeSom,
    this.soNgayLamViec,
    this.soLanChamCongThuCong,
    this.soNgayVangMatKhongLyDo,
    this.soNgayNghiCoLyDo,
  });

  int get soNgayNghi => (soNgayNghiCoLyDo ?? 0) + (soNgayVangMatKhongLyDo ?? 0);
}
