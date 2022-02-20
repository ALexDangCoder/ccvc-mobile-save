
class VanBanModel {
  String? doKhan;
  String? loaiVanBan;
  String? ngayDen;
  String? nguoiSoanThao;

  VanBanModel({
    this.doKhan,
    this.loaiVanBan,
    this.ngayDen,
    this.nguoiSoanThao,
  });
}

class DanhSachVanBanModel {
  List<VanBanModel>? pageData;

  DanhSachVanBanModel({
    this.pageData,
  });
}
