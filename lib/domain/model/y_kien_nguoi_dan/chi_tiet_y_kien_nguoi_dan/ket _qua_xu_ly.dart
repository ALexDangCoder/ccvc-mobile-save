class KetQuaXuLyModel {
  String iD;
  int depth;
  String location;
  String donViId;
  String canBoId;
  String soVanBanDi;
  String ngayKyVanBanDi;
  String coQuanBanHanh;
  String nguoiKyDuyet;
  String trichYeu;
  String tenDonVi;
  String tenCanBo;
  String dSFile;
  String taskContent;
  int trangThai;
  bool isChuTri;

  KetQuaXuLyModel(
      {required this.iD,
      required this.depth,
      required this.location,
      required this.donViId,
      required this.canBoId,
      required this.soVanBanDi,
      required this.ngayKyVanBanDi,
      required this.coQuanBanHanh,
      required this.nguoiKyDuyet,
      required this.trichYeu,
      required this.tenDonVi,
      required this.tenCanBo,
      required this.dSFile,
      required this.taskContent,
      required this.trangThai,
      required this.isChuTri,});
}
