import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nhiem_vu_theo_don_vi.g.dart';

@JsonSerializable()
class NhiemVuDonTheoDonViResponse extends Equatable {
  @JsonKey(name: 'CanBoId')
  String? canBoId;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'NhiemVuChuaHoanThanh')
  int? nhiemVuChuaHoanThanh;
  @JsonKey(name: 'NhiemVuHoanThanh')
  int? nhiemVuHoanThanh;
  @JsonKey(name: 'NhiemVuQuaHan')
  int? nhiemVuQuaHan;

  NhiemVuDonTheoDonViResponse(
    this.canBoId,
    this.donViId,
    this.name,
    this.nhiemVuChuaHoanThanh,
    this.nhiemVuHoanThanh,
    this.nhiemVuQuaHan,
  );

  factory NhiemVuDonTheoDonViResponse.fromJson(Map<String, dynamic> json) =>
      _$NhiemVuDonTheoDonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NhiemVuDonTheoDonViResponseToJson(this);

  NhiemVuDonVi toDomain() => NhiemVuDonVi(
        canBoId: canBoId,
        donViId: donViId,
        name: name,
        nhiemVuHoanThanh: nhiemVuHoanThanh,
        nhiemVuQuaHan: nhiemVuQuaHan,
        nhiemVuChuaHoanThanh: nhiemVuChuaHoanThanh,
        tongSoNhiemVu: (nhiemVuQuaHan ?? 0) +
            (nhiemVuChuaHoanThanh ?? 0) +
            (nhiemVuHoanThanh ?? 0),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
