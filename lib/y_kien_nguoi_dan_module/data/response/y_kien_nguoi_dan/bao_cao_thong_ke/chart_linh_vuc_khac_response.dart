import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_linh_vuc_khac_response.g.dart';

@JsonSerializable()
class LinhVucKhacResponse {
  @JsonKey(name: 'Data')
  List<LinhVucKhacData>? listData;

  LinhVucKhacResponse(
    this.listData,
  );

  factory LinhVucKhacResponse.fromJson(Map<String, dynamic> json) =>
      _$LinhVucKhacResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucKhacResponseToJson(this);

  ChartLinhVucKhacModel toDomain() => ChartLinhVucKhacModel(
      listChartData: listData?.map((e) => e.toDomain()).toList()??[],);
}

@JsonSerializable()
class LinhVucKhacData {
  @JsonKey(name: 'LinhVucId')
  int? linhVucId;
  @JsonKey(name: 'TenLinhVuc')
  String? tenLinhVuc;
  @JsonKey(name: 'SoPhanAnhKienNghi')
  int? soPhanAnhKienNghi;

  LinhVucKhacData(
    this.linhVucId,
    this.tenLinhVuc,
    this.soPhanAnhKienNghi,
  );

  factory LinhVucKhacData.fromJson(Map<String, dynamic> json) =>
      _$LinhVucKhacDataFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucKhacDataToJson(this);

  LinhVucKhacModel toDomain() => LinhVucKhacModel(
        linhVucId: linhVucId ?? 0,
        tenLinhVuc: tenLinhVuc ?? '',
        soPhanAnhKienNghi: soPhanAnhKienNghi ?? 0,
      );
}
