class CanBoThamGiaStr {
  String? CanBoId;
  String? CanBo_TenChucVu;
  String? CanBo_TenDonVi;
  String? CreatedAt;
  String? CreatedBy;
  bool? DiemDanh;
  String? DonViId;
  String? HoTen;
  String? Id;
  bool? IsThamGiaBocBang;
  bool? IsThuKy;
  String? LichHopId;
  String? TenCanBo;
  String? TenCoQuan;
  int? TrangThai;
  String? UpdateAt;
  String? UpdateBy;
  int? VaiTroThamGia;
  String? ParentId;

  CanBoThamGiaStr({
    required this.CanBoId,
    required this.CanBo_TenChucVu,
    required this.CanBo_TenDonVi,
    required this.CreatedAt,
    required this.CreatedBy,
    required this.DiemDanh,
    required this.DonViId,
    required this.HoTen,
    required this.Id,
    required this.IsThamGiaBocBang,
    required this.IsThuKy,
    required this.LichHopId,
    required this.TenCanBo,
    required this.TenCoQuan,
    required this.TrangThai,
    required this.UpdateAt,
    required this.UpdateBy,
    required this.VaiTroThamGia,
    required this.ParentId,
  });

  CanBoThamGiaStr.empty();

  factory CanBoThamGiaStr.fromJson(Map<String, dynamic> json) {
    return CanBoThamGiaStr(
      CanBoId: json['CanBoId'],
      CanBo_TenChucVu: json['CanBo_TenChucVu'],
      CanBo_TenDonVi: json['CanBo_TenDonVi'],
      CreatedAt: json['CreatedAt'],
      CreatedBy: json['CreatedBy'],
      DiemDanh: json['DiemDanh'],
      DonViId: json['DonViId'],
      HoTen: json['HoTen'],
      Id: json['Id'],
      IsThamGiaBocBang: json['IsThamGiaBocBang'],
      IsThuKy: json['IsThuKy'],
      LichHopId: json['LichHopId'],
      TenCanBo: json['TenCanBo'],
      TenCoQuan: json['TenCoQuan'],
      TrangThai: json['TrangThai'],
      UpdateAt: json['UpdateAt'],
      UpdateBy: json['UpdateBy'],
      VaiTroThamGia: json['VaiTroThamGia'],
      ParentId: json['ParentId'],
    );
  }
}

class NguoiTaoStr {
  String? chucVuId;
  String? DonViId;
  String? HoTen;
  String? TenChucVu;
  String? TenDonVi;
  String? UserId;

  NguoiTaoStr({
    this.chucVuId,
    this.DonViId,
    this.HoTen,
    this.TenChucVu,
    this.TenDonVi,
    this.UserId,
  });

  NguoiTaoStr.empty();

  factory NguoiTaoStr.fromJson(Map<String, dynamic> json) {
    return NguoiTaoStr(
      chucVuId: json['chucVuId'],
      DonViId: json['DonViId'],
      HoTen: json['HoTen'],
      TenChucVu: json['TenChucVu'],
      TenDonVi: json['TenDonVi'],
      UserId: json['UserId'],
    );
  }
}
