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
  num? soLanDiMuon;
  @JsonKey(name: 'soLanVeSom')
  num? soLanVeSom;
  @JsonKey(name: 'soNgayLamViec')
  num? soNgayLamViec;
  @JsonKey(name: 'soLanChamCongThuCong')
  num? soLanChamCongThuCong;
  @JsonKey(name: 'soNgayVangMatKhongLyDo')
  num? soNgayVangMatKhongLyDo;
  @JsonKey(name: 'soNgayNghiCoLyDo')
  num? soNgayNghiCoLyDo;

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
        soLanDiMuon: soLanDiMuon??0,
        soLanVeSom: soLanVeSom??0,
        soNgayNghiCoLyDo: soNgayNghiCoLyDo??0,
        soLanChamCongThuCong: soLanChamCongThuCong??0,
        soNgayLamViec: soNgayLamViec??0,
        soNgayVangMatKhongLyDo: soNgayVangMatKhongLyDo??0,
      );
}
