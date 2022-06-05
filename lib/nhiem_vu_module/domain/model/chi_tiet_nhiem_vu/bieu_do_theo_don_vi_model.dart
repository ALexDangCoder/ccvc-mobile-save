class BieuDoTheoDonViModel {
  int? tongSoNhiemVu;
  TinhTrangXuLyModel? tinhTrangXuLy;
  List<NhiemVuDonViModel>? nhiemVuDonVi;

  BieuDoTheoDonViModel({
     this.tongSoNhiemVu,
     this.tinhTrangXuLy,
     this.nhiemVuDonVi,
  });
}

class NhiemVuDonViModel {
  String? donViId;
  String? tenDonVi;
  TinhTrangXuLyModel? tinhTrangXuLy;

  NhiemVuDonViModel({
     this.donViId,
     this.tenDonVi,
     this.tinhTrangXuLy,
  });
}

class TinhTrangXuLyModel {
  int? choPhanXuLy;
  int? chuaThucHien;
  int? dangThucHien;
  int? daThucHien;

  TinhTrangXuLyModel({
     this.choPhanXuLy,
     this.chuaThucHien,
     this.dangThucHien,
     this.daThucHien,
  });
}
