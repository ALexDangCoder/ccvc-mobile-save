class VanBanModel {
  String? iD;
  String? doKhan;
  String? loaiVanBan;
  String? ngayDen;
  String? nguoiSoanThao;
  String? donViSoanThao;
  String? taskId;
  String? number;
  int? statusCode;
  String? sender;
  String? priorityCode;
  String? trichYeu;
  String? chucVuNguoiSoanThao;

  VanBanModel({
    this.iD,
    this.doKhan,
    this.loaiVanBan,
    this.ngayDen,
    this.nguoiSoanThao,
    this.taskId,
    this.statusCode,
    this.number,
    this.sender,
    this.donViSoanThao,
    this.priorityCode,
    this.trichYeu,
    this.chucVuNguoiSoanThao,
  });

  VanBanModel.empty();
}

class DanhSachVanBanModel {
  List<VanBanModel>? pageData;
  int? currentPage;
  int? pageSize;
  int? totalPage;
  int? totalRows;

  DanhSachVanBanModel(
      {this.pageData,
      this.currentPage,
      this.pageSize,
      this.totalPage,
      this.totalRows});
}
