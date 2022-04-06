import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_y_kien_nguoi_dan_response.g.dart';

@JsonSerializable()
class SearchYKienNguoiDanResponse {
  @JsonKey(name: 'DanhSachKetQua')
  List<YKienNguoiDanData>? listDanhSachYKien;

  SearchYKienNguoiDanResponse(this.listDanhSachYKien);

  factory SearchYKienNguoiDanResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchYKienNguoiDanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchYKienNguoiDanResponseToJson(this);

  DanhSachYKienNguoiDan toDomain() => DanhSachYKienNguoiDan(
    listYKienNguoiDan:
    listDanhSachYKien?.map((e) => e.toDomain()).toList() ?? [],);
}

@JsonSerializable()
class YKienNguoiDanData {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'TieuDe')
  String? tieuDe;
  @JsonKey(name: 'NgayNhan')
  String? ngayNhan;
  @JsonKey(name: 'SoNgayToiHan')
  int? soNgayToiHan;
  @JsonKey(name: 'TaskId')
  String? taskId;

  YKienNguoiDanData(
      this.id,
      this.tieuDe,
      this.ngayNhan,
      this.soNgayToiHan,
      this.taskId,
      );

  factory YKienNguoiDanData.fromJson(Map<String, dynamic> json) =>
      _$YKienNguoiDanDataFromJson(json);

  Map<String, dynamic> toJson() => _$YKienNguoiDanDataToJson(this);

  YKienNguoiDanModel toDomain() => YKienNguoiDanModel(
    id: id ?? '',
    tieuDe: tieuDe ?? '',
    ngayNhan: ngayNhan ?? '',
    soNgayToiHan: soNgayToiHan ?? 0,
    taskID: taskId??'',
  );
}
