class ThongBaoModel {
  String image = '';
  String title = '';
  String content = '';
  bool status = false;
  String time = '';
  String typeNotify = '';

  ThongBaoModel.empty();

  ThongBaoModel({
    required this.image,
    required this.title,
    required this.content,
    required this.status,
    required this.time,
    required this.typeNotify,
  });
}
