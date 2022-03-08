class ListDashBoardItemModel{
  List<DashBoardItemTatCaChuDeModel>? listDashBoardItem;

  ListDashBoardItemModel({this.listDashBoardItem});
}

class DashBoardItemTatCaChuDeModel {
  int? sourceId;
  String? sourceTitle;
  int? total;

  DashBoardItemTatCaChuDeModel({
    this.sourceId,
    this.sourceTitle,
    this.total,
  });
}
class ChuDeDashBoardModel{
}
