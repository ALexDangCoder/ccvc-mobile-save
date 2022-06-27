class GetAllFilesIdModel {
  List<FileImageModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  GetAllFilesIdModel({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });

  GetAllFilesIdModel.empty();
}

class FileImageModel {
  String? id;
  String? entityName;
  String? fileTypeUpload;

  FileImageModel({
    required this.id,
    required this.entityName,
    required this.fileTypeUpload,
  });
}
