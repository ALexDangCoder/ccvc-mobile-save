import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'db_vb_di_response.g.dart';

@JsonSerializable()
class DoashBoashVBDiResponse {
  @JsonKey(name: 'Data')
  DataResponseDoashBoashVBDi danhSachVB;

  DoashBoashVBDiResponse(this.danhSachVB);

  factory DoashBoashVBDiResponse.fromJson(Map<String, dynamic> json) =>
      _$DoashBoashVBDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoashBoashVBDiResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponseDoashBoashVBDi {
  @JsonKey(name: 'SoLuongChoTrinhKy')
  int? soLuongChoTrinhKy;
  @JsonKey(name: 'SoLuongChoXuLy')
  int? soLuongChoXuLy;
  @JsonKey(name: 'SoLuongDaXuLy')
  int? soLuongDaXuLy;
  @JsonKey(name: 'SoLuongThuongKhan')
  int? soLuongThuongKhan;
  @JsonKey(name: 'SoLuongChoCapSo')
  int? soLuongChoCapSo;
  @JsonKey(name: 'SoLuongChoBanHanh')
  int? soLuongChoBanHanh;

  DataResponseDoashBoashVBDi(this.soLuongChoTrinhKy, this.soLuongChoXuLy,
      this.soLuongDaXuLy, this.soLuongThuongKhan);

  factory DataResponseDoashBoashVBDi.fromJson(Map<String, dynamic> json) =>
      _$DataResponseDoashBoashVBDiFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseDoashBoashVBDiToJson(this);

  DocumentDashboardModel toDomain() => DocumentDashboardModel(
        soLuongChoTrinhKy: soLuongChoTrinhKy,
        soLuongChoXuLy: soLuongChoXuLy,
        soLuongDaXuLy: soLuongDaXuLy,
        soLuongThuongKhan: soLuongThuongKhan,
        soLuongChoCapSo: soLuongChoCapSo,
        soLuongChoBanHanh: soLuongChoBanHanh,
      );

  @override
  List<Object?> get props => [];
}
