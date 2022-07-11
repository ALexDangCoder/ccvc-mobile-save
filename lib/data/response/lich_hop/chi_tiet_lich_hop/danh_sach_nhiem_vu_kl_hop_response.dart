import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_nhiem_vu_kl_hop_response.g.dart';

@JsonSerializable()
class DanhSachNhiemVulichHopResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'Ma')
  String? ma;
  @JsonKey(name: 'NhiemVuChinhPhu')
  bool? nhiemVuChinhPhu;

  DanhSachNhiemVulichHopResponse(
    this.id,
    this.ten,
    this.ma,
    this.nhiemVuChinhPhu,
  );

  factory DanhSachNhiemVulichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachNhiemVulichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachNhiemVulichHopResponseToJson(this);

  @override
  List<Object?> get props => [];

  DanhSachLoaiNhiemVuLichHopModel toModel() => DanhSachLoaiNhiemVuLichHopModel(
        id: id,
        ten: ten,
        ma: ma,
        nhiemVuChinhPhu: nhiemVuChinhPhu,
      );
}
