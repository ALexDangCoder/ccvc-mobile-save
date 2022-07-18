class ChartSuCoModel {
  String? khuVucId;
  String? tenKhuVuc;
  String? codeKhuVuc;
  List<DanhSachSuCo>? danhSachSuCo;

  ChartSuCoModel({
    this.khuVucId,
    this.tenKhuVuc,
    this.codeKhuVuc,
    this.danhSachSuCo,
  });
}

class DanhSachSuCo {
  String? tenSuCo;
  int? soLuong;

  DanhSachSuCo({
    this.tenSuCo,
    this.soLuong,
  });
}
