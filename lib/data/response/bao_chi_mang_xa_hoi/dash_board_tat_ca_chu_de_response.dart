import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_tat_ca_chu_de_response.g.dart';

@JsonSerializable()
class DoashBoashTatCaChuDeResponse {
  List<DataResponseDoashBoashTatCaChuDe>? listDashBoardTatCaChuDe;
  DoashBoashTatCaChuDeResponse(this.listDashBoardTatCaChuDe);
  factory DoashBoashTatCaChuDeResponse.fromJson(Map<String, dynamic> json) =>
      _$DoashBoashTatCaChuDeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoashBoashTatCaChuDeResponseToJson(this);

  ListDashBoardItemModel toDomain() => ListDashBoardItemModel(
        listDashBoardItem:
            listDashBoardTatCaChuDe?.map((e) => e.toDomain()).toList()??[],
      );
}

@JsonSerializable()
class DataResponseDoashBoashTatCaChuDe {
  @JsonKey(name: 'sourceId')
  int? sourceId;
  @JsonKey(name: 'sourceTitle')
  String? sourceTitle;
  @JsonKey(name: 'total')
  int? total;

  DataResponseDoashBoashTatCaChuDe(this.sourceId, this.sourceTitle, this.total);

  factory DataResponseDoashBoashTatCaChuDe.fromJson(
          Map<String, dynamic> json) =>
      _$DataResponseDoashBoashTatCaChuDeFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataResponseDoashBoashTatCaChuDeToJson(this);

  DashBoardItemTatCaChuDeModel toDomain() => DashBoardItemTatCaChuDeModel(
        sourceId: sourceId,
        sourceTitle: sourceTitle,
        total: total,
      );
}
