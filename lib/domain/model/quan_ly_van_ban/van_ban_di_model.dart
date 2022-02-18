
class VanBanDiModel {
  String? doKhan;
  String? loaiVanBan;
  String? ngayTao;
  String? nguoiSoanThao;

  VanBanDiModel({
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
