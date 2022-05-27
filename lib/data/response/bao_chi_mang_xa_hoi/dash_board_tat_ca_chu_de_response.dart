import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_tat_ca_chu_de_response.g.dart';

@JsonSerializable()
class DashBoardTatCaChuDeResponse {
  @JsonKey(name: 'sourceId')
  int? sourceId;
  @JsonKey(name: 'sourceTitle')
  String? sourceTitle;
  @JsonKey(name: 'total')
  int? total;

  DashBoardTatCaChuDeResponse(this.sourceId, this.sourceTitle, this.total);

  factory DashBoardTatCaChuDeResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoardTatCaChuDeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardTatCaChuDeResponseToJson(this);

  DashBoardItemTatCaChuDeModel toDomain() => DashBoardItemTatCaChuDeModel(
        sourceId: sourceId ?? 0,
        sourceTitle: sourceTitle ?? '',
        total: total ?? 0,
      );
}
