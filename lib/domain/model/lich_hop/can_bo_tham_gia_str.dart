class CanBoThamGiaStr {
  String? createdAt;
  String? createdBy;
  bool? diemDanh;
  String? donViId;
  String? id;
  bool? isThamGiaBocBang;
  bool? isThuKy;
  String? lichHopId;
  String? tenCoQuan;
  int? trangThai;
  String? updateAt;
  String? updateBy;
  int? vaiTroThamGia;
  String? CanBoId;

  CanBoThamGiaStr({
    required this.CanBoId,
    required this.createdAt,
    required this.createdBy,
    required this.diemDanh,
    required this.donViId,
    required this.id,
    required this.isThamGiaBocBang,
    required this.isThuKy,
    required this.lichHopId,
    required this.tenCoQuan,
    required this.trangThai,
    required this.updateAt,
    required this.updateBy,
    required this.vaiTroThamGia,
  });

  CanBoThamGiaStr.empty();

  factory CanBoThamGiaStr.fromJson(Map<String, dynamic> json) {
    return CanBoThamGiaStr(
      CanBoId: json['CanBoId'],
      createdAt: json['CreatedAt'],
      createdBy: json['CreatedBy'],
      diemDanh: json['DiemDanh'],
      donViId: json['DonViId'],
      id: json['Id'],
      isThamGiaBocBang: json['IsThamGiaBocBang'],
      isThuKy: json['IsThuKy'],
      lichHopId: json['LichHopId'],
      tenCoQuan: json['TenCoQuan'],
      trangThai: json['TrangThai'],
      updateAt: json['UpdateAt'],
      updateBy: json['UpdateBy'],
      vaiTroThamGia: json['VaiTroThamGia'],
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
