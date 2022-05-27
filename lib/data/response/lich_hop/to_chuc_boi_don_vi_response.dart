import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'to_chuc_boi_don_vi_response.g.dart';

@JsonSerializable()
class ToChucBoiDonViResponse {
  @JsonKey(name: 'data')
  List<ToChucBoiDonViData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ToChucBoiDonViResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory ToChucBoiDonViResponse.fromJson(Map<String, dynamic> json) =>
      _$ToChucBoiDonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ToChucBoiDonViResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ToChucBoiDonViData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'quantities')
  int? quantities;

  ToChucBoiDonViData(this.id, this.tenDonVi, this.quantities);

  ToChucBoiDonViModel toModel() => ToChucBoiDonViModel(
        id: id,
        tenDonVi: tenDonVi,
        quantities: quantities,
      );

  factory ToChucBoiDonViData.fromJson(Map<String, dynamic> json) =>
      _$ToChucBoiDonViDataFromJson(json);

  Map<String, dynamic> toJson() => _$ToChucBoiDonViDataToJson(this);
}
