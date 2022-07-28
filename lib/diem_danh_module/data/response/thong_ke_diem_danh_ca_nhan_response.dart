import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_diem_danh_ca_nhan_response.g.dart';

@JsonSerializable()
class DataThongKeDiemDanhCaNhanResponse {
  @JsonKey(name: 'data')
  ThongKeDiemDanhCaNhanModelResponse? data;

  DataThongKeDiemDanhCaNhanResponse({
    this.data,
  });

  factory DataThongKeDiemDanhCaNhanResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataThongKeDiemDanhCaNhanResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataThongKeDiemDanhCaNhanResponseToJson(this);
}

@JsonSerializable()
class ThongKeDiemDanhCaNhanModelResponse {
  @JsonKey(name: 'soLanDiMuon')
  int? soLanDiMuon;
  @JsonKey(name: 'soLanVeSom')
  int? soLanVeSom;
  @JsonKey(name: 'soNgayLamViec')
  int? soNgayLamViec;
  @JsonKey(name: 'soLanChamCongThuCong')
  int? soLanChamCongThuCong;
  @JsonKey(name: 'soNgayVangMatKhongLyDo')
  int? soNgayVangMatKhongLyDo;
  @JsonKey(name: 'soNgayNghiCoLyDo')
  int? soNgayNghiCoLyDo;

  ThongKeDiemDanhCaNhanModelResponse(
      this.soLanDiMuon,
      this.soLanVeSom,
      this.soNgayLamViec,
      this.soLanChamCongThuCong,
      this.soNgayVangMatKhongLyDo,
      this.soNgayNghiCoLyDo);

  factory ThongKeDiemDanhCaNhanModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ThongKeDiemDanhCaNhanModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ThongKeDiemDanhCaNhanModelResponseToJson(this);

  ThongKeDiemDanhCaNhanModel toModel() => ThongKeDiemDanhCaNhanModel(
        soLanDiMuon: soLanDiMuon,
        soLanVeSom: soLanVeSom,
        soNgayNghiCoLyDo: soNgayNghiCoLyDo,
        soLanChamCongThuCong: soLanChamCongThuCong,
        soNgayLamViec: soNgayLamViec,
        soNgayVangMatKhongLyDo: soNgayVangMatKhongLyDo,
      );
}
