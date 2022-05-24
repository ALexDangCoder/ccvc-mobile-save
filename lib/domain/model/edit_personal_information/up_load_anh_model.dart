class UpLoadAnhModel {
  DataUpLoadAnhModel? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  UpLoadAnhModel({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });
}

class DataUpLoadAnhModel {
  int? id;
  String? fileUrl;
  String? fileName;
  String? fileType;
  String? filePath;
  String? fieldUpload;

  DataUpLoadAnhModel({
    this.id,
    this.fileUrl,
    this.fileName,
    this.fileType,
    this.filePath,
    this.fieldUpload,
  });
}
