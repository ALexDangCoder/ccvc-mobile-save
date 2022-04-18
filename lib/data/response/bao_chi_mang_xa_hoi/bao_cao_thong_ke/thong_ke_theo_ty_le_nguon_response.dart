import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/nguon_bao_cao_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_theo_ty_le_nguon_response.g.dart';

@JsonSerializable()
class TyLeNguonResponse {
  @JsonKey(name: 'BaoChi')
  String? baoChi;
  @JsonKey(name: 'Blog')
  String? blog;
  @JsonKey(name: 'Forum')
  String? forum;
  @JsonKey(name: 'MangXaHoi')
  String? mangXaHoi;
  @JsonKey(name: 'NguonKhac')
  String? nguonKhac;
  @JsonKey(name: 'total')
  String? total;

  TyLeNguonResponse(
    this.baoChi,
    this.total,
    this.nguonKhac,
    this.mangXaHoi,
    this.forum,
    this.blog,
  );

  factory TyLeNguonResponse.fromJson(Map<String, dynamic> json) =>
      _$TyLeNguonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TyLeNguonResponseToJson(this);

  NguonBaoCaoModel toDomain() => NguonBaoCaoModel(
        baoChi: baoChi ?? '',
        blog: blog ?? '',
        forum: forum ?? '',
        mangXaHoi: mangXaHoi ?? '',
        nguonKhac: nguonKhac ?? '',
        total: total ?? '',
      );
}
