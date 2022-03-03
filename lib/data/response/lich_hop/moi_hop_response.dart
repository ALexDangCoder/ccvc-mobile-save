import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'moi_hop_response.g.dart';

@JsonSerializable()
class MoiHopResponse extends Equatable {
  @JsonKey(name: 'data')
  List<MoiHopDataResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  MoiHopResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory MoiHopResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoiHopResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class MoiHopDataResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'DonViId')
  String? DonViId;
  @JsonKey(name: 'VaiTroThamgia')
  int? VaiTroThamGia;

  MoiHopModel toModel() => MoiHopModel(
        id: id,
        donViId: donViId,
        tenDonVi: tenDonVi,
        type: type,
        status: status,
        DonViId: DonViId,
        VaiTroThamGia: VaiTroThamGia,
      );

  MoiHopDataResponse({
    required this.id,
    required this.donViId,
    required this.tenDonVi,
    required this.type,
    required this.status,
    required this.DonViId,
    required this.VaiTroThamGia,
  });

  factory MoiHopDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiHopDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoiHopDataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
