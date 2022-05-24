class DataResponse {
  PathFileAnhModel data;

  DataResponse({required this.data});
}

class PathFileAnhModel {
  int? id;
  String? fileUrl;
  String? fileName;
  String? fileType;
  String? filePath;
  String? fieldUpload;

  PathFileAnhModel({
    this.id,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.filePath,
    this.fieldUpload,
  });
}
