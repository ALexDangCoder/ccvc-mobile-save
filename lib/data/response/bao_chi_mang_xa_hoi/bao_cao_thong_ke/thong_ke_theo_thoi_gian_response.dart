import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_theo_thoi_gian_response.g.dart';

@JsonSerializable()
class ThongKeTheoThoiGianResponse {
  @JsonKey(name: 'data')
  List<ThongKeThoiGianData> thoiGianData;

  ThongKeTheoThoiGianResponse(
    this.thoiGianData,
  );

  factory ThongKeTheoThoiGianResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongKeTheoThoiGianResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongKeTheoThoiGianResponseToJson(this);

  List<LineChartData> toDomain() {
    return thoiGianData
        .map((e) => LineChartData(
            date: DateFormat('yyyy/MM/dd HH:mm:ss')
                .parse(e.date ?? '')
                .toStringWithListFormat,
            count: e.count ?? 0,),)
        .toList();
  }
}

@JsonSerializable()
class ThongKeThoiGianData {
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'count')
  int? count;

  ThongKeThoiGianData(
    this.date,
    this.count,
  );

  factory ThongKeThoiGianData.fromJson(Map<String, dynamic> json) =>
      _$ThongKeThoiGianDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThongKeThoiGianDataToJson(this);
}
