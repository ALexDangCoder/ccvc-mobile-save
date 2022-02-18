import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manager_personal_information_response.g.dart';

@JsonSerializable()
class ManagerPersonalInformationResponse {
  @JsonKey(name: 'data')
  PersonalInformationResponse data;

  ManagerPersonalInformationResponse(this.data);

  factory ManagerPersonalInformationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ManagerPersonalInformationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ManagerPersonalInformationResponseToJson(this);
}

@JsonSerializable()
class PersonalInformationResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'maCanBo')
  String? maCanBo;
  @JsonKey(name: 'hoTen')
  String? hoTen;
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
  @JsonKey(name: 'thoiGian_CapNhat')
  String? thoiGianCapNhat;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'donVi')
  String? donVi;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'thuTu')
  int? thuTu;
  @JsonKey(name: '_ThuTu')
  int? iThuTu;
  @JsonKey(name: 'tinh')
  String? tinh;
  @JsonKey(name: 'huyen')
  String? huyen;
  @JsonKey(name: 'xa')
  String? xa;
  @JsonKey(name: 'departments')
  List<DepartmentsResponse>? departments;
  @JsonKey(name: 'userAccounts')
  List<UserAccountsResponse>? userAccounts;

//

  PersonalInformationResponse();

  factory PersonalInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonalInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInformationResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  ManagerPersonalInformationModel toModel() => ManagerPersonalInformationModel(
        id: id,
        maCanBo: maCanBo,
        hoTen: hoTen,
        phoneDiDong: phoneDiDong,
        phoneCoQuan: phoneCoQuan,
        phoneNhaRieng: phoneNhaRieng,
        email: email,
        gioiTinh: gioiTinh,
        ngaySinh: ngaySinh,
        iDDonViHoatDong: iDDonViHoatDong,
        cmtnd: cmtnd,
        anhDaiDienFilePath: anhDaiDienFilePath,
        anhChuKyFilePath: anhChuKyFilePath,
        anhChuKyNhayFilePath: anhChuKyNhayFilePath,
        thoiGianCapNhat: thoiGianCapNhat,
        chucVu: chucVu,
        donVi: donVi,
        diaChi: diaChi,
        thuTu: thuTu,
        iThuTu: iThuTu,
        tinh: tinh,
        huyen: huyen,
        xa: xa,
        departments: departments?.map((e) => e.toModel()).toList() ?? [],
        userAccounts: userAccounts?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class DepartmentsResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'tenChucVu')
  String? tenChucVu;
  @JsonKey(name: 'tenChucVuKhongDau')
  String? tenChucVuKhongDau;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'isDefault')
  bool? isDefault;
  @JsonKey(name: 'tenDonViKhongDau')
  String? tenDonViKhongDau;
  @JsonKey(name: 'trangThai')
  int? trangThai;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

//

  DepartmentsResponse();

  factory DepartmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentsResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  Departments toModel() => Departments(
        id: id,
        chucVuId: chucVuId,
        tenChucVu: tenChucVu,
        tenChucVuKhongDau: tenChucVuKhongDau,
        donViId: donViId,
        tenDonVi: tenDonVi,
        isDefault: isDefault,
        tenDonViKhongDau: tenDonViKhongDau,
        trangThai: trangThai,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class UserAccountsResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'password')
  String? password;
  @JsonKey(name: 'applications')
  List<ApplicationsResponse>? applications;
  @JsonKey(name: 'trangThai')
  int? trangThai;

//

  UserAccountsResponse();

  factory UserAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountsResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  UserAccounts toModel() => UserAccounts(
        id: id,
        userName: userName,
        userId: userId,
        password: password,
        applications: applications?.map((e) => e.toModel()).toList() ?? [],
        trangThai: trangThai,
      );
}

@JsonSerializable()
class ApplicationsResponse {
  @JsonKey(name: 'applicationName')
  String? applicationName;
  @JsonKey(name: 'applicationId')
  String? applicationId;
  @JsonKey(name: 'userId')
  String? userId;

//

  ApplicationsResponse();

  factory ApplicationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplicationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationsResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  Applications toModel() => Applications(
        applicationName: applicationName,
        applicationId: applicationId,
        userId: userId,
      );
}
