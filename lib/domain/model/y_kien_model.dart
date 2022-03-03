class YKienModel {
  String time = '';
  String name = '';
  String imgAvatar = '';
  String fileName = '';
  String content;
  YKienModel({
    required this.time,
    required this.fileName,
    required this.imgAvatar,
    required this.name,
    this.content = '',
  });
}
