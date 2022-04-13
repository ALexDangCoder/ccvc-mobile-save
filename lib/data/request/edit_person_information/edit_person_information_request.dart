import 'package:json_annotation/json_annotation.dart';

part 'edit_person_information_request.g.dart';

@JsonSerializable()
class EditPersonInformationRequest {
  String? id;
  String? maCanBo;
  String? hoTen;
  String? phoneDiDong;
  String? phoneCoQuan;
  String? phoneNhaRieng;
  String? email;
  bool? gioiTinh;
  String? ngaySinh;
  String? userName;
  String? userId;
  String? iDDonViHoatDong;
  String? cmtnd;
  String? anhDaiDienFilePath;
  String? anhChuKyFilePath;
  String? anhChuKyNhayFilePath;
  bool? bitChuyenCongTac;
  String? thoiGianCapNhat;
  bool? bitNhanTinBuonEmail;
  bool? bitNhanTinBuonSMS;
  bool? bitDanhBa;
  String? chucVu;
  String? donVi;
  bool? bitThuTruongDonVi;
  bool? bitDauMoiPAKN;
  String? diaChi;
  String? duongDanIdDonViCha;
  String? duongDanIdDonViBietPhaiCha;
  DonViDetail? donViDetail;
  String? chucVuDetail;
  String? nhomChucVuDetail;
  int? thuTu;
  int? iThuTu;
  String? tinh;
  String? huyen;
  String? xa;
  String? tinhId;
  String? huyenId;
  String? xaId;
  List<Departments>? departments;
  List<UserAccounts>? userAccounts;
  List<String>? lsCanBoKiemNhiemResponse;

  EditPersonInformationRequest({
    this.id,
    this.maCanBo,
    this.hoTen,
    this.phoneDiDong,
    this.phoneCoQuan,
    this.phoneNhaRieng,
    this.email,
    this.gioiTinh,
    this.ngaySinh,
    this.userName,
    this.userId,
    this.iDDonViHoatDong,
    this.cmtnd,
    this.anhDaiDienFilePath,
    this.anhChuKyFilePath,
    this.anhChuKyNhayFilePath,
    this.bitChuyenCongTac,
    this.thoiGianCapNhat,
    this.bitNhanTinBuonEmail,
    this.bitNhanTinBuonSMS,
    this.bitDanhBa,
    this.chucVu,
    this.donVi,
    this.bitThuTruongDonVi,
    this.bitDauMoiPAKN,
    this.diaChi,
    this.duongDanIdDonViCha,
    this.duongDanIdDonViBietPhaiCha,
    this.donViDetail,
    this.chucVuDetail,
    this.nhomChucVuDetail,
    this.thuTu,
    this.iThuTu,
    this.tinh,
    this.huyen,
    this.xa,
    this.tinhId,
    this.huyenId,
    this.xaId,
    this.departments,
    this.userAccounts,
    this.lsCanBoKiemNhiemResponse,
  });

  factory EditPersonInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$EditPersonInformationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditPersonInformationRequestToJson(this);
}

@JsonSerializable()
class Departments {
  String? id;
  String? chucVuId;
  String? tenChucVu;
  String? tenChucVuKhongDau;
  String? donViId;
  String? tenDonVi;
  bool? isDefault;
  String? tenDonViKhongDau;
  int? trangThai;
  String? updatedAt;

  Departments({
    this.id,
    this.chucVuId,
    this.tenChucVu,
    this.tenChucVuKhongDau,
    this.donViId,
    this.tenDonVi,
    this.isDefault,
    this.tenDonViKhongDau,
    this.trangThai,
    this.updatedAt,
  });

  factory Departments.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentsToJson(this);
}

@JsonSerializable()
class UserAccounts {
  String? id;
  String? userName;
  String? userId;
  String? password;
  List<Applications>? applications;
  int? trangThai;

  UserAccounts({
    this.id,
    this.userName,
    this.userId,
    this.password,
    this.applications,
    this.trangThai,
  });

  factory UserAccounts.fromJson(Map<String, dynamic> json) =>
      _$UserAccountsFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountsToJson(this);
}

@JsonSerializable()
class Applications {
  String? applicationName;
  String? applicationId;
  String? userId;

  Applications({
    this.applicationName,
    this.applicationId,
    this.userId,
  });

  factory Applications.fromJson(Map<String, dynamic> json) =>
      _$ApplicationsFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationsToJson(this);
}

@JsonSerializable()
class DonViDetail {
  String? cayDonVi;
  String? cayDonViBietPhai;

  DonViDetail({this.cayDonVi, this.cayDonViBietPhai});

  factory DonViDetail.fromJson(Map<String, dynamic> json) =>
      _$DonViDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DonViDetailToJson(this);
}
