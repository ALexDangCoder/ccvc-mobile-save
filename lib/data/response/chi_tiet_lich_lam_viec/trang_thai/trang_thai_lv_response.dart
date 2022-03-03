import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/trang_thai_lv.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trang_thai_lv_response.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class TrangThaiLVResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataTrangThaiLvResponse>? data;

  TrangThaiLVResponse(this.data);

  factory TrangThaiLVResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TrangThaiLVResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrangThaiLVResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<TrangThaiLvModel> toDomain() =>
      data?.map((e) => e.toDomain()).toList() ?? [];
}

@JsonSerializable()
class DataTrangThaiLvResponse {
  @JsonKey(name: 'displayName')
  String? displayName;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'type')
  String? type;
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

  DataTrangThaiLvResponse({
    this.displayName,
    this.code,
    this.type,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.id,
  });

  factory DataTrangThaiLvResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataTrangThaiLvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTrangThaiLvResponseToJson(this);

  TrangThaiLvModel toDomain() => TrangThaiLvModel(
        displayName: displayName,
        code: code,
        type: type,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        id: id,
      );
}
