import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_phien_hop_response.g.dart';

@JsonSerializable()
class TaoPhienHopResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataTaoPhienHop>? data;

  TaoPhienHopResponse(this.data);

  factory TaoPhienHopResponse.fromJson(Map<String, dynamic> json) =>
      _$TaoPhienHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaoPhienHopResponseToJson(this);

  List<TaoPhienHopModel> toMoDel() =>
      data?.map((e) => e.toDomain()).toList() ?? [];

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataTaoPhienHop {
  String? id;
  String? lichHopId;
  String? tieuDe;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? canBoId;
  String? donViId;
  String? createdAt;
  String? updatedAt;
  int? thuTu;
  String? noiDung;
  String? hoTen;
  int? trangThai;
  String? jobId;
  String? referenceId;

  DataTaoPhienHop({
    this.id,
    this.lichHopId,
    this.tieuDe,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.canBoId,
    this.donViId,
    this.createdAt,
    this.updatedAt,
    this.thuTu,
    this.noiDung,
    this.hoTen,
    this.trangThai,
    this.jobId,
    this.referenceId,
  });

  factory DataTaoPhienHop.fromJson(Map<String, dynamic> json) =>
      _$DataTaoPhienHopFromJson(json);

  Map<String, dynamic> toJson() => _$DataTaoPhienHopToJson(this);

  TaoPhienHopModel toDomain() => TaoPhienHopModel(
        lichHopId: lichHopId,
        tieuDe: tieuDe,
        thoiGianBatDau: thoiGianBatDau,
        thoiGianKetThuc: thoiGianKetThuc,
        canBoId: canBoId,
        donViId: donViId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        thuTu: thuTu,
        noiDung: noiDung,
        hoTen: hoTen,
        trangThai: trangThai,
        jobId: jobId,
        referenceId: referenceId,
      );
}
