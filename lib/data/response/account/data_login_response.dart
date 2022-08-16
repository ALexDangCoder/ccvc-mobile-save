import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_login_response.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class DataLoginResponse extends Equatable {
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'userInformation')
  UserInformationResponse? userInformation;
  @JsonKey(name: 'accessToken')
  String? accessToken;
  @JsonKey(name: 'refreshToken')
  String? refreshToken;

  DataLoginResponse();

  factory DataLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLoginResponseToJson(this);

  DataUser toDomainDataUser() => DataUser(
        username: username,
        userId: userId,
        userInformation: userInformation?.toDomain(),
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class UserInformationResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'canBoDepartmentId')
  String? canBoDepartmentId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'anhDaiDien_FilePath')
  String? anhDaiDienFilePath;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'donVi')
  String? donVi;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'userCanBoDepartmentId')
  String? userCanBoDepartmentId;
  @JsonKey(name: 'donViGoc')
  DonViGocResponse? donViGoc;
  @JsonKey(name: 'donViTrucThuoc')
  DonViTrucThuocResponse? donViTrucThuoc;
  @JsonKey(name: 'gioiTinh')
  bool? gioiTinh;
  @JsonKey(name: 'ngaySinh')
  String? ngaySinh;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;

  UserInformation toDomain() => UserInformation(
        id: id,
        hoTen: hoTen,
        anhDaiDienFilePath: anhDaiDienFilePath,
        chucVu: chucVu,
        canBoDepartmentId: canBoDepartmentId,
        donVi: donVi,
        email: email,
        userName: userName,
        userCanBoDepartmentId: userCanBoDepartmentId,
        donViGoc: donViGoc?.toDomain(),
        donViTrucThuoc: donViTrucThuoc?.toDomain(),
        gioiTinh: gioiTinh,
        ngaySinh: ngaySinh,
        soDienThoai: soDienThoai,
      );

  UserInformationResponse();

  factory UserInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInformationResponseToJson(this);
}

@JsonSerializable()
class DonViGocResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'chucVu')
  String? chucVu;

  DonViGocResponse();

  DonViGoc toDomain() =>
      DonViGoc(id: id, tenDonVi: tenDonVi, chucVu: chucVu, chucVuId: chucVuId);

  factory DonViGocResponse.fromJson(Map<String, dynamic> json) =>
      _$DonViGocResponseFromJson(json);
}

@JsonSerializable()
class DonViTrucThuocResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'maChucVu')
  String? maChucVu;

  DonViTrucThuoc toDomain() => DonViTrucThuoc(
        id: id,
        tenDonVi: tenDonVi,
        chucVu: chucVu,
        chucVuId: chucVuId,
        maChucVu: maChucVu,
      );

  DonViTrucThuocResponse();

  factory DonViTrucThuocResponse.fromJson(Map<String, dynamic> json) =>
      _$DonViTrucThuocResponseFromJson(json);
}
