class BackgroundModel {
  String? userId;
  String? typeNoti;

  BackgroundModel({required this.userId, required this.typeNoti});

  factory BackgroundModel.fromJson(Map<String, dynamic> json) {
    return BackgroundModel(userId: json['userId'], typeNoti: json['typeNoti']);
  }
}
