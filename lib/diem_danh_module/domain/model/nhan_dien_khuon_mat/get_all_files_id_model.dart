class GetAllFilesIdModel {
  List<String>? item;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  GetAllFilesIdModel({
    required this.item,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });

  GetAllFilesIdModel.empty();
}
