class ResponseModel {
  String? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ResponseModel({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });
}
