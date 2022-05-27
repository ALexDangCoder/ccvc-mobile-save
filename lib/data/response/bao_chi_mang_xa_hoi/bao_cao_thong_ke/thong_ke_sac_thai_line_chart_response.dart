import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/nguon_bao_cao_model.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_sac_thai_line_chart_response.g.dart';

@JsonSerializable()
class ThongKeTheoSacThaiResponse {
  @JsonKey(name: 'data')
  List<SacThaiData> listSacThai;

  ThongKeTheoSacThaiResponse(
    this.listSacThai,
  );

  factory ThongKeTheoSacThaiResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongKeTheoSacThaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongKeTheoSacThaiResponseToJson(this);

  SacThaiLineChartModel toDomain() {
    return SacThaiLineChartModel(
      trungLap: listSacThai
          .map(
            (e) => LineChartData(
              date: DateFormat('yyyy/MM/dd HH:mm:ss')
                  .parse(e.date ?? '')
                  .toStringWithListFormat,
              count: e.trungLap ?? 0,
            ),
          )
          .toList(),
      tichCuc: listSacThai
          .map(
            (e) => LineChartData(
              date: DateFormat('yyyy/MM/dd HH:mm:ss')
                  .parse(e.date ?? '')
                  .toStringWithListFormat,
              count: e.tichCuc ?? 0,
            ),
          )
          .toList(),
      tieuCuc: listSacThai
          .map(
            (e) => LineChartData(
              date: DateFormat('yyyy/MM/dd HH:mm:ss')
                  .parse(e.date ?? '')
                  .toStringWithListFormat,
              count: e.tieuCuc ?? 0,
            ),
          )
          .toList(),
    );
  }
}

@JsonSerializable()
class SacThaiData {
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'TichCuc')
  int? tichCuc;
  @JsonKey(name: 'TieuCuc')
  int? tieuCuc;
  @JsonKey(name: 'TrungLap')
  int? trungLap;

  SacThaiData(
    this.date,
    this.tichCuc,
    this.tieuCuc,
    this.trungLap,
  );

  factory SacThaiData.fromJson(Map<String, dynamic> json) =>
      _$SacThaiDataFromJson(json);

  Map<String, dynamic> toJson() => _$SacThaiDataToJson(this);
}
