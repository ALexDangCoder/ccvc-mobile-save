class GetAllFilesIdModel {
  String? id;
  String? userId;
  String? fileId;
  String? loaiGocAnh;
  String? loaiAnh;

  GetAllFilesIdModel({
    required this.id,
    required this.userId,
    required this.fileId,
    required this.loaiGocAnh,
    required this.loaiAnh,
  });

  GetAllFilesIdModel.empty();
}
