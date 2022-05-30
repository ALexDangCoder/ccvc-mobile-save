class PostAnhModel {
  DataPostAnhModel? data;

  PostAnhModel({
    this.data,
  });
}

class DataPostAnhModel {
  String? originName;
  String? filePath;
  String? filePathFull;
  int? fileLength;
  String? fileExtend;

  DataPostAnhModel({
    this.originName,
    this.filePath,
    this.filePathFull,
    this.fileLength,
    this.fileExtend,
  });
}
