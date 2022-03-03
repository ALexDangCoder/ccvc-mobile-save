import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';

class DashBoardChuDeResponse{
  List<DashBoardChuDeData>? data;
  DashBoardChuDeResponse.fromJson(List<dynamic>? json) {
    if(json !=null){
      final result = <DashBoardChuDeData>[];
      for (final element in json) {
        result.add(DashBoardChuDeData.fromJson(element));
      }
    }
  }
  ListDashBoardItemModel toDomain() => ListDashBoardItemModel(
    listDashBoardItem:
    data?.map((e) => e.toDomain()).toList()??[],
  );
}
class DashBoardChuDeData {
  int? sourceId;
  int? total;
  String? sourceTitle;

  DashBoardChuDeData({this.sourceId, this.total, this.sourceTitle});

  DashBoardChuDeData.fromJson(Map<String, dynamic> json) {
    sourceId = json['sourceId'];
    total = json['total'];
    sourceTitle = json['sourceTitle'];
  }
  DashBoardItemTatCaChuDeModel toDomain() => DashBoardItemTatCaChuDeModel(
    sourceId: sourceId,
    sourceTitle: sourceTitle,
    total: total,
  );
}