import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ds_user_ngoai_he_thong_duoc_truy_cap_res.g.dart';

@JsonSerializable()
class UserNgoaiHeThongTruyCapTotalResponse {
  @JsonKey(name: 'message')
  String? messageResponse;

  @JsonKey(name: 'data')
  ListUserNgoaiHeThongTruyCapResponse? data;

  UserNgoaiHeThongTruyCapTotalResponse(
    this.messageResponse,
    this.data,
  );

  factory UserNgoaiHeThongTruyCapTotalResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserNgoaiHeThongTruyCapTotalResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserNgoaiHeThongTruyCapTotalResponseToJson(this);
}

@JsonSerializable()
class ListUserNgoaiHeThongTruyCapResponse {
  @JsonKey(name: 'items')
  List<UserNgoaiHeThongTruyCapResponse>? items;

  ListUserNgoaiHeThongTruyCapResponse(
    this.items,
  );

  factory ListUserNgoaiHeThongTruyCapResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ListUserNgoaiHeThongTruyCapResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListUserNgoaiHeThongTruyCapResponseToJson(this);
}

@JsonSerializable()
class UserNgoaiHeThongTruyCapResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'fullname')
  String? fullName;
  @JsonKey(name: 'position')
  String? chucVu;
  @JsonKey(name: 'unit')
  String? donVi;
  @JsonKey(name: 'password')
  String? password;

  UserNgoaiHeThongDuocTruyCapModel toModel() =>
      UserNgoaiHeThongDuocTruyCapModel(
        id: id ?? '',
        email: email ?? '',
        fullName: fullName ?? '',
        chucVu: chucVu ?? '',
        donVi: donVi ?? '',
        passWord: password ?? '',
      );

  UserNgoaiHeThongTruyCapResponse(
    this.id,
    this.email,
    this.fullName,
    this.chucVu,
    this.donVi,
    this.password,
  );

  factory UserNgoaiHeThongTruyCapResponse.fromJson(Map<String, dynamic> json) =>
      _$UserNgoaiHeThongTruyCapResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserNgoaiHeThongTruyCapResponseToJson(this);
}
