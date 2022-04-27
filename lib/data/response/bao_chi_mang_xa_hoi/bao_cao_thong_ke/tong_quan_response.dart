import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bao_cao_tong_quan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tong_quan_response.g.dart';

@JsonSerializable()
class TongQuanDeResponse {
  @JsonKey(name: 'TongTin')
  int? tongTin = 0;
  @JsonKey(name: 'TichCuc')
  int? tichCuc = 0;
  @JsonKey(name: 'TieuCuc')
  int? tieuCuc = 0;
  @JsonKey(name: 'TrungLap')
  int? trungLap = 0;
  @JsonKey(name: 'BaoChi')
  int? baoChi = 0;
  @JsonKey(name: 'MangXaHoi')
  int? mangXaHoi = 0;
  @JsonKey(name: 'Blog')
  int? blog = 0;
  @JsonKey(name: 'Forum')
  int? forum = 0;
  @JsonKey(name: 'NguonKhac')
  int? nguonKhac = 0;
  @JsonKey(name: 'Like')
  int? like = 0;
  @JsonKey(name: 'Share')
  int? share = 0;
  @JsonKey(name: 'Comment')
  int? comment = 0;

  TongQuanDeResponse(
    this.tongTin,
    this.tichCuc,
    this.tieuCuc,
    this.trungLap,
    this.baoChi,
    this.mangXaHoi,
    this.blog,
    this.forum,
    this.nguonKhac,
    this.like,
    this.share,
    this.comment,
  );

  factory TongQuanDeResponse.fromJson(Map<String, dynamic> json) =>
      _$TongQuanDeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TongQuanDeResponseToJson(this);

  BaoCaoTongQuanModel toDomain() => BaoCaoTongQuanModel(
        tongTin: tongTin ?? 0,
        tichCuc: tichCuc ?? 0,
        tieuCuc: tieuCuc ?? 0,
        trungLap: trungLap ?? 0,
        baoChi: baoChi ?? 0,
        mangXaHoi: mangXaHoi ?? 0,
        blog: blog ?? 0,
        forum: forum ?? 0,
        nguonKhac: nguonKhac ?? 0,
        like: like ?? 0,
        share: share ?? 0,
        comment: comment ?? 0,
      );
}
