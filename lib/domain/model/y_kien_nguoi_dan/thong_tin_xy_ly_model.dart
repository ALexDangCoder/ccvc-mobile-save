class LuongXuLyPAKNModel {
  final String id;
  final String kienNghiId;
  final String donViTaoId;
  final String nguoiTaoId;
  final String ngayTao;
  final String tenDonVi;
  final String donViId;
  final String ten;

  LuongXuLyPAKNModel({
    required this.id,
    required this.kienNghiId,
    required this.donViTaoId,
    required this.nguoiTaoId,
    required this.ngayTao,
    required this.tenDonVi,
    required this.donViId,
    required this.ten,
  });
}

class ThongTinXuLyPAKNModel {
  final bool isDuyet;
  final int linhVucId;
  final String phanLoaiPAKN;
  final String soPAKN;
  final String tieuDe;
  final String noiDung;
  final int nguonPAKNID;
  final int luatId;
  final int noiDungPAKNId;
  final int linhVucPAKNId;
  final int doiTuongId;
  final String tenNguoiPhanAnh;
  final List<LuongXuLyPAKNModel>? listLuongPAKN;

  ThongTinXuLyPAKNModel({
    required this.isDuyet,
    required this.linhVucId,
    required this.phanLoaiPAKN,
    required this.soPAKN,
    required this.tieuDe,
    required this.noiDung,
    required this.nguonPAKNID,
    required this.luatId,
    required this.noiDungPAKNId,
    required this.linhVucPAKNId,
    required this.doiTuongId,
    required this.tenNguoiPhanAnh,
    this.listLuongPAKN,
  });

  ThongTinXuLyPAKNModel.seeded({
    this.isDuyet = false,
    this.linhVucId = -1,
    this.phanLoaiPAKN = '',
    this.soPAKN = '',
    this.tieuDe = '',
    this.noiDung = '',
    this.nguonPAKNID = -1,
    this.luatId = -1,
    this.noiDungPAKNId = -1,
    this.linhVucPAKNId = -1,
    this.doiTuongId = -1,
    this.tenNguoiPhanAnh = '',
    this.listLuongPAKN,
  });
}
