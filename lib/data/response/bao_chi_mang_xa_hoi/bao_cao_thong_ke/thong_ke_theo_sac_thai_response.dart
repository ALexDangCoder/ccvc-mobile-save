import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/nguon_bao_cao_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_theo_sac_thai_response.g.dart';

@JsonSerializable()
class SacThaiResponse {
  @JsonKey(name: 'TrungLap')
  int? trungLap;
  @JsonKey(name: 'TichCuc')
  int? tichCuc;
  @JsonKey(name: 'TieuCuc')
  int? tieuCuc;
  SacThaiResponse(
    this.trungLap,
    this.tichCuc,
    this.tieuCuc,
  );

  factory SacThaiResponse.fromJson(Map<String, dynamic> json) =>
      _$SacThaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SacThaiResponseToJson(this);

  SacThaiModel toDomain() => SacThaiModel(
        trungLap: trungLap ?? 0,
        tichCuc: tichCuc ?? 0,
        tieuCuc: tichCuc ?? 0,
      );
}
