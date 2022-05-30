class TinTucModel {
  int pageIndex;
  int totalItems;
  int totalPages;
  List<TinTucData> listData;

  TinTucModel({
    required this.pageIndex,
    required this.totalItems,
    required this.totalPages,
    required this.listData,
  });
}

class TinTucData {
  String title;
  String url;

  TinTucData({required this.title, required this.url});
}
