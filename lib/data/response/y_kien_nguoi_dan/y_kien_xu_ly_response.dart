import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/result_xin_y_kien_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'y_kien_xu_ly_response.g.dart';

@JsonSerializable()
class YKienXuLyResponse {
  @JsonKey(name: 'DanhSachKetQua')
  bool? danhSachKetQua;
  @JsonKey(name: 'NoiDungThongDiep')
  String? noiDungThongDiep;
  @JsonKey(name: 'MaTraLoi')
  int? maTraLoi;
  @JsonKey(name: 'MaMenu')
  String? maMenu;

  YKienXuLyResponse(
    this.danhSachKetQua,
    this.noiDungThongDiep,
    this.maTraLoi,
    this.maMenu,
  );

  factory YKienXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$YKienXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YKienXuLyResponseToJson(this);

  ResultXinYKienNguoiDan toDomain() => ResultXinYKienNguoiDan(
        danhSachKetQua: danhSachKetQua,
        noiDungThongDiep: noiDungThongDiep,
        maMenu: maMenu,
        maTraLoi: maTraLoi,
      );
}
