import 'package:ccvc_mobile/domain/model/lich_hop/them_lich_hop_chi_tiet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'them_phien_hop_chi_tiet_response.g.dart';

@JsonSerializable()
class ThemPhienHopChiTietResponse {
  @JsonKey(name: 'data')
  List<DataThemPhienHopResponse>? data;

  ThemPhienHopChiTietResponse(this.data);

  factory ThemPhienHopChiTietResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThemPhienHopChiTietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemPhienHopChiTietResponseToJson(this);

  List<ThemPhienHopChiTietModel> toDoMain() =>
      data?.map((e) => e.todoMain()).toList() ?? [];
}

@JsonSerializable()
class DataThemPhienHopResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'tieuDe')
  String? tieuDe;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'thuTu')
  int? thuTu;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'trangThai')
  int? trangThai;
  @JsonKey(name: 'jobId')
  String? jobId;
  @JsonKey(name: 'referenceId')
  String? referenceId;

  DataThemPhienHopResponse({
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

  factory DataThemPhienHopResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataThemPhienHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataThemPhienHopResponseToJson(this);

  ThemPhienHopChiTietModel todoMain() => ThemPhienHopChiTietModel(
        id: id,
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
