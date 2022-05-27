import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/nguon_bao_cao_model.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_theo_nguon_response.g.dart';

@JsonSerializable()
class ThongKeTheoNguonResponse {
  @JsonKey(name: 'BaoChi')
  List<LineData> baoChi;
  @JsonKey(name: 'MangXaHoi')
  List<LineData> mangXaHoi;
  @JsonKey(name: 'Blog')
  List<LineData> blog;
  @JsonKey(name: 'Forum')
  List<LineData> forum;
  @JsonKey(name: 'NguonKhac')
  List<LineData> nguonKhac;

  ThongKeTheoNguonResponse(
    this.baoChi,
    this.mangXaHoi,
    this.blog,
    this.forum,
    this.nguonKhac,
  );

  factory ThongKeTheoNguonResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongKeTheoNguonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongKeTheoNguonResponseToJson(this);

  NguonBaoCaoLineChartModel toDomain() => NguonBaoCaoLineChartModel(
        baoChi: baoChi.map((e) => e.toDomain()).toList(),
        mangXaHoi: mangXaHoi.map((e) => e.toDomain()).toList(),
        blog: blog.map((e) => e.toDomain()).toList(),
        forum: forum.map((e) => e.toDomain()).toList(),
        nguonKhac: nguonKhac.map((e) => e.toDomain()).toList(),
      );
}

@JsonSerializable()
class LineData {
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'value')
  int? value;

  LineData(
    this.date,
    this.value,
  );

  factory LineData.fromJson(Map<String, dynamic> json) =>
      _$LineDataFromJson(json);

  Map<String, dynamic> toJson() => _$LineDataToJson(this);

  LineChartData toDomain() => LineChartData(
        date: DateFormat('yyyy/MM/dd HH:mm:ss')
            .parse(date ?? '')
            .toStringWithListFormat,
        count: value ?? 0,
      );
}
