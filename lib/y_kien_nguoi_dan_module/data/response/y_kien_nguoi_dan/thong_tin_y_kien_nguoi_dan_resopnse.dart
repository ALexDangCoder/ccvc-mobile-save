import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/thong_tin_y_kien_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_tin_y_kien_nguoi_dan_resopnse.g.dart';

@JsonSerializable()
class ThongTinYKienNguoiDanResponse {
  @JsonKey(name: 'ChoBoXungThongTin')
  int? choBoXungThongTin;
  @JsonKey(name: 'ChoChoYKien')
  int? choChoYKien;
  @JsonKey(name: 'ChoDuyet')
  int? choDuyet;
  @JsonKey(name: 'ChoPhanCongXuLy')
  int? choPhanCongXuLy;
  @JsonKey(name: 'ChoTiepNhan')
  int? choTiepNhan;
  @JsonKey(name: 'ChoTiepNhanXuLy')
  int? choTiepNhanXuLy;
  @JsonKey(name: 'ChoXuLy')
  int? choXuLy;
  @JsonKey(name: 'TongSoPakn')
  int? tongSoPakn;

  ThongTinYKienNguoiDanResponse(
    this.choBoXungThongTin,
    this.choChoYKien,
    this.choDuyet,
    this.choPhanCongXuLy,
    this.choTiepNhan,
    this.choTiepNhanXuLy,
    this.choXuLy,
    this.tongSoPakn,
  );

  factory ThongTinYKienNguoiDanResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinYKienNguoiDanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinYKienNguoiDanResponseToJson(this);

  ThongTinYKienModel toDomain() => ThongTinYKienModel(
    choBoXungThongTin:choBoXungThongTin,
    choChoYKien: choChoYKien,
    choDuyet: choDuyet,
    choPhanCongXuLy: choPhanCongXuLy,
    choTiepNhan: choTiepNhan,
    choTiepNhanXuLy: choTiepNhanXuLy,
    choXuLy: choXuLy,
    tongSoPakn: tongSoPakn,
  );
}
