class VanBanDiModel {
  String? iD;
  String? doKhan;
  String? loaiVanBan;
  String? ngayTao;
  String? nguoiSoanThao;

  VanBanDiModel({
    this.iD,
    this.doKhan,
    this.loaiVanBan,
    this.ngayTao,
    this.nguoiSoanThao,
  });
}

class DanhSachVanBanDiModel {
  List<VanBanDiModel>? pageData;

  DanhSachVanBanDiModel({
    this.pageData,
  });
}
