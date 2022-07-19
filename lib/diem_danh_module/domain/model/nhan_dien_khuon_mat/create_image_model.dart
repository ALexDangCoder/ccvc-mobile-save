class CreateImageDataModel {
  String? userId;
  String? loaiGocAnh;
  String? loaiAnh;
  String? fileId;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  bool? isDeleted;
  String? id;

  CreateImageDataModel.empty();

  CreateImageDataModel({
    required this.userId,
    required this.loaiGocAnh,
    required this.loaiAnh,
    required this.fileId,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.isDeleted,
    required this.id,
  });
}

class CreateImageModel {
  CreateImageDataModel? data;
  String? message;

  CreateImageModel({required this.data,required this.message});
}
