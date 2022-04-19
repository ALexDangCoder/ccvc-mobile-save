import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_ket_luan_hop_response.g.dart';

@JsonSerializable()
class StatusKetLuanHopResponse {
  @JsonKey(name: 'data')
  List<StatusKetLuanHopData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  StatusKetLuanHopResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory StatusKetLuanHopResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusKetLuanHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatusKetLuanHopResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class StatusKetLuanHopData {
  String? code;
  String? createdAt;
  String? createdBy;
  String? displayName;
  String? id;
  String? type;
  String? updatedAt;
  String? updatedBy;

  StatusKetLuanHopData({
    this.code,
    this.createdAt,
    this.createdBy,
    this.displayName,
    this.id,
    this.type,
    this.updatedAt,
    this.updatedBy,
  });

  factory StatusKetLuanHopData.fromJson(Map<String, dynamic> json) =>
      _$StatusKetLuanHopDataFromJson(json);

  Map<String, dynamic> toJson() => _$StatusKetLuanHopDataToJson(this);

  StatusKetLuanHopModel toModel() => StatusKetLuanHopModel(
        code: code ?? '',
        createdAt: createdAt ?? '',
        createdBy: createdBy ?? '',
        displayName: displayName ?? '',
        id: id ?? '',
        type: type ?? '',
        updatedAt: updatedAt ?? '',
        updatedBy: updatedBy ?? '',
      );

  @override
  List<Object?> get props => [];
}
