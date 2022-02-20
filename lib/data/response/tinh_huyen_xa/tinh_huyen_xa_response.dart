import 'package:ccvc_mobile/domain/model/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tinh_huyen_xa_response.g.dart';

@JsonSerializable()
class TinhHuyenXaResponse {
  @JsonKey(name: 'data')
  List<DataTinhHuyenXaResponse>? listdata;

  TinhHuyenXaResponse(this.listdata);

  factory TinhHuyenXaResponse.fromJson(Map<String, dynamic> json) =>
      _$TinhHuyenXaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TinhHuyenXaResponseToJson(this);

  List<TinhHuyenXaModel> toDomain() =>
      listdata?.map((e) => e.toDomain()).toList() ?? [];
}

@JsonSerializable()
class DataTinhHuyenXaResponse {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'level')
  int? level;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'codeName')
  String? codeName;
  @JsonKey(name: 'divisionType')
  String? divisionType;
  @JsonKey(name: 'phoneCode')
  int? phoneCode;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'id')
  String? id;

  DataTinhHuyenXaResponse(
    this.code,
    this.level,
    this.name,
    this.codeName,
    this.divisionType,
    this.phoneCode,
    this.parentId,
    this.isDeleted,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.id,
  );

  factory DataTinhHuyenXaResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTinhHuyenXaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTinhHuyenXaResponseToJson(this);

  TinhHuyenXaModel toDomain() => TinhHuyenXaModel(
        code: code,
        level: level,
        name: name,
        codeName: codeName,
        divisionType: divisionType,
        phoneCode: phoneCode,
        parentId: parentId,
        isDeleted: isDeleted,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        id: id,
      );
}
