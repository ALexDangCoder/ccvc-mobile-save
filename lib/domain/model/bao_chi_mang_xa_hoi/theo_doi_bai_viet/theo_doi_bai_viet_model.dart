class TheoDoiBaiVietModel {
  int pageIndex;
  int totalPages;
  int totalItems;
  List<BaiVietModel> listBaiViet;

  TheoDoiBaiVietModel({
    required this.pageIndex,
    required this.listBaiViet,
    required this.totalItems,
    required this.totalPages,
  });
}

class BaiVietModel {
  String title;
  String imageSources;
  String publishedTime;
  String url;
  String domain;
  String iconUrl;

  BaiVietModel({
    required this.title,
    required this.imageSources,
    required this.publishedTime,
    required this.url,
    required this.domain,
    required this.iconUrl,
  });
}
