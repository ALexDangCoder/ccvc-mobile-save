import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_so_luong_yknd_response.g.dart';

@JsonSerializable()
class SoLuongYKNDBtMonthResponse {
  @JsonKey(name: 'Data')
  List<SoLuongByMonthData>? listData;

  SoLuongYKNDBtMonthResponse(
    this.listData,
  );

  factory SoLuongYKNDBtMonthResponse.fromJson(Map<String, dynamic> json) =>
      _$SoLuongYKNDBtMonthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SoLuongYKNDBtMonthResponseToJson(this);

  ChartYKNDByMonthModel toDomain() => ChartYKNDByMonthModel(
        listChartData: listData?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class SoLuongByMonthData {
  @JsonKey(name: 'Month')
  int? month;
  @JsonKey(name: 'Quantities')
  int? quantities;

  SoLuongByMonthData(
    this.month,
    this.quantities,
  );

  factory SoLuongByMonthData.fromJson(Map<String, dynamic> json) =>
      _$SoLuongByMonthDataFromJson(json);

  Map<String, dynamic> toJson() => _$SoLuongByMonthDataToJson(this);

  YKNDByMonth toDomain() => YKNDByMonth(
        month: month ?? 0,
        quantities: quantities ?? 0,
      );
}
