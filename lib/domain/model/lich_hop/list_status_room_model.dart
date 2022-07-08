class ListStatusModel {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ListStatusModel({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });
}

class Data {
  String? displayName;
  String? code;
  String? type;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? id;

  Data({
    this.displayName,
    this.code,
    this.type,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.id,
  });
}
