class ChonBienBanCuocHopModel {
  List<ItemsModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  ChonBienBanCuocHopModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class ItemsModel {
  String? id;
  String? name;
  String? content;
  int? totalItems;
  bool? isXoa;

  ItemsModel({
    required this.id,
    required this.name,
    required this.content,
    required this.totalItems,
    required this.isXoa,
  });
}
