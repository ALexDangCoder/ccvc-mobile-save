import 'package:json_annotation/json_annotation.dart';

part 'edit_person_information_request.g.dart';

@JsonSerializable()
class EditPersonInformationRequest {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'maCanBo')
  String? maCanBo;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'cA_Number')
  String? cANumber;
  @JsonKey(name: 'phone_DiDong')
  String? phoneDiDong;
  @JsonKey(name: 'phone_CoQuan')
  String? phoneCoQuan;
  @JsonKey(name: 'phone_NhaRieng')
  String? phoneNhaRieng;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'gioiTinh')
  bool? gioiTinh;
  @JsonKey(name: 'ngaySinh')
  String? ngaySinh;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'iD_DonVi_HoatDong')
  String? iDDonViHoatDong;
  @JsonKey(name: 'cmtnd')
  String? cmtnd;
  @JsonKey(name: 'anhDaiDien_FilePath')
  String? anhDaiDienFilePath;
  @JsonKey(name: 'anhChuKy_FilePath')
  String? anhChuKyFilePath;
  @JsonKey(name: 'anhChuKyNhay_FilePath')
  String? anhChuKyNhayFilePath;
  @JsonKey(name: 'bit_ChuyenCongTac')
  bool? bitChuyenCongTac;
  @JsonKey(name: 'thoiGian_CapNhat')
  String? thoiGianCapNhat;
  @JsonKey(name: 'bit_NhanTinBuon_Email')
  bool? bitNhanTinBuonEmail;
  @JsonKey(name: 'bit_NhanTinBuon_SMS')
  bool? bitNhanTinBuonSMS;
  @JsonKey(name: 'bit_DanhBa')
  bool? bitDanhBa;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'donVi')
  String? donVi;
  @JsonKey(name: 'bit_ThuTruongDonVi')
  bool? bitThuTruongDonVi;
  @JsonKey(name: 'bitDauMoiPAKN')
  bool? bitDauMoiPAKN;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'duongDanIdDonViCha')
  String? duongDanIdDonViCha;
  @JsonKey(name: 'duongDanIdDonViBietPhaiCha')
  String? duongDanIdDonViBietPhaiCha;
  @JsonKey(name: 'donViDetail')
  DonViDetail? donViDetail;
  @JsonKey(name: 'chucVuDetail')
  String? chucVuDetail;
  @JsonKey(name: 'nhomChucVuDetail')
  String? nhomChucVuDetail;
  @JsonKey(name: 'thuTu')
  String? thuTu;
  @JsonKey(name: '_ThuTu')
  int? iThuTu;
  @JsonKey(name: 'tinh')
  String? tinh;
  @JsonKey(name: 'huyen')
  String? huyen;
  @JsonKey(name: 'xa')
  String? xa;
  @JsonKey(name: 'tinhId')
  String? tinhId;
  @JsonKey(name: 'huyenId')
  String? huyenId;
  @JsonKey(name: 'xaId')
  String? xaId;
  @JsonKey(name: 'departments')
  List<Departments>? departments;
  @JsonKey(name: 'userAccounts')
  List<UserAccounts>? userAccounts;
  @JsonKey(name: 'lsCanBoKiemNhiemResponse')
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
