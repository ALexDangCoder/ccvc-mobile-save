class NhomCungHeThong {
  String? tenNhom;
  String? idNhom;
  List<ThanhVien>? listThanhVien;

  NhomCungHeThong({
    this.tenNhom,
    this.idNhom,
    this.listThanhVien,
  });
}

class DonViCungHeThong {
  String? tenDonVi;
  String? idDonVi;
  List<ThanhVien>? listThanhVien;

  DonViCungHeThong({
    this.tenDonVi,
    this.idDonVi,
    this.listThanhVien,
  });
}

class ThanhVien {
  String? tenThanhVien;
  String? idThanhVien;
  String? chucVu;

  ThanhVien({
    this.tenThanhVien,
    this.idThanhVien,
    this.chucVu,
  });
}