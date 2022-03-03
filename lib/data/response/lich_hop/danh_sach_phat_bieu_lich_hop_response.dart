import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_phat_bieu_lich_hop_response.g.dart';

@JsonSerializable()
class DanhSachPhatBieuLichHopDataResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DanhSachPhatBieuLichHopResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DanhSachPhatBieuLichHopDataResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DanhSachPhatBieuLichHopDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachPhatBieuLichHopDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachPhatBieuLichHopDataResponseToJson(this);

  List<DanhSachPhatBieuLichHopModel> toModel() =>
      data?.map((e) => e.toModel()).toList() ?? [];

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DanhSachPhatBieuLichHopResponse extends Equatable {
  @JsonKey(name: 'chuTriCanBoId')
  String? chuTriCanBoId;
  @JsonKey(name: 'chuTriDonViId')
  String? chuTriDonViId;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'phienHopId')
  String? phienHopId;
  @JsonKey(name: 'personName')
  String? personName;
  @JsonKey(name: 'unitName')
  String? unitName;
  @JsonKey(name: 'time')
  int? time;
  @JsonKey(name: 'meetingSection')
  int? meetingSection;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'tenPhienHop')
  String? tenPhienHop;
  @JsonKey(name: 'createdBy')
  String? createdBy;

  DanhSachPhatBieuLichHopResponse({
    this.chuTriCanBoId,
    this.chuTriDonViId,
    this.id,
    this.userId,
    this.donViId,
    this.phienHopId,
    this.personName,
    this.unitName,
    this.time,
    this.meetingSection,
    this.status,
    this.content,
    this.lichHopId,
    this.tenPhienHop,
    this.createdBy,
  });

  factory DanhSachPhatBieuLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPhatBieuLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachPhatBieuLichHopResponseToJson(this);

  DanhSachPhatBieuLichHopModel toModel() => DanhSachPhatBieuLichHopModel(
        chuTriCanBoId: chuTriCanBoId,
        chuTriDonViId: chuTriDonViId,
        id: id,
        userId: userId,
        donViId: donViId,
        phienHopId: phienHopId,
        personName: personName,
        unitName: unitName,
        time: time,
        meetingSection: meetingSection,
        status: status,
        content: content,
        lichHopId: lichHopId,
        tenPhienHop: tenPhienHop,
        createdBy: createdBy,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
