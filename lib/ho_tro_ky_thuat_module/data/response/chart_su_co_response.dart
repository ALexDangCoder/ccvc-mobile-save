import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_su_co_response.g.dart';

@JsonSerializable()
class ChartSuCoResponse {
  @JsonKey(name: 'data')
  List<ChartSuCoChildResponse>? data;
  @JsonKey(name: 'message')
  String? message;

  ChartSuCoResponse(
    this.data,
    this.message,
  );

  factory ChartSuCoResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChartSuCoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartSuCoResponseToJson(this);
}

@JsonSerializable()
class ChartSuCoChildResponse {
  @JsonKey(name: 'khuVucId')
  String? khuVucId;
  @JsonKey(name: 'tenKhuVuc')
  String? tenKhuVuc;
  @JsonKey(name: 'codeKhuVuc')
  String? codeKhuVuc;
  @JsonKey(name: 'danhSachSuCo')
  List<DanhSachKhuVucResponse>? danhSachSuCo;

  ChartSuCoChildResponse(
    this.khuVucId,
    this.tenKhuVuc,
    this.codeKhuVuc,
    this.danhSachSuCo,
  );

  factory ChartSuCoChildResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChartSuCoChildResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartSuCoChildResponseToJson(this);

  ChartSuCoModel toModel() => ChartSuCoModel(
        khuVucId: khuVucId,
        codeKhuVuc: codeKhuVuc,
        tenKhuVuc: tenKhuVuc,
        danhSachSuCo: danhSachSuCo?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class DanhSachKhuVucResponse {
  @JsonKey(name: 'tenSuCo')
  String? tenSuCo;
  @JsonKey(name: 'soLuong')
  int? soLuong;

  DanhSachKhuVucResponse(
    this.tenSuCo,
    this.soLuong,
  );

  factory DanhSachKhuVucResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachKhuVucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachKhuVucResponseToJson(this);

  DanhSachSuCo toModel() => DanhSachSuCo(
        tenSuCo: tenSuCo,
        soLuong: soLuong,
      );
}
