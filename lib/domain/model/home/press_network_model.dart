class PressNetWorkModel {
  final String avatar;
  final String title;
  final String publishedTime;
  final String url;
  final String domain;

  PressNetWorkModel({
    required this.avatar,
    required this.title,
    required this.publishedTime,
    required this.url,
    required this.domain,
  });
}

class TagModel {
  String title;
  bool select;

  TagModel(this.title, this.select);
}
