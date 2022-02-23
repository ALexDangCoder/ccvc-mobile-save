class LinhVucModel {
  List<ItemLinhVucModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  LinhVucModel.empty();

  LinhVucModel({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });
}

class ItemLinhVucModel {
  String? id;
  String? name;
  String? code;
  int? totalItems;

  ItemLinhVucModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.totalItems,});
}
