import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_ket_luan_hop_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_bieu_quyet_lich_hop_response.g.dart';

@JsonSerializable()
class ListKetLuanHopResponse extends Equatable {
  @JsonKey(name: 'data')
  List<ListKetLuanHopResponseData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ListKetLuanHopResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory ListKetLuanHopResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ListKetLuanHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListKetLuanHopResponseToJson(this);

  List<DanhSachKetLuanHopModel> toModel() =>
      data?.map((e) => e.toModel()).toList() ?? [];

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ListKetLuanHopResponseData extends Equatable {
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

  ListKetLuanHopResponseData({
    this.displayName,
    this.code,
    this.type,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.id,
  });

  factory ListKetLuanHopResponseData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ListKetLuanHopResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListKetLuanHopResponseDataToJson(this);

  DanhSachKetLuanHopModel toModel() => DanhSachKetLuanHopModel(
        displayName: displayName,
        code: code,
        type: type,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        id: id,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
