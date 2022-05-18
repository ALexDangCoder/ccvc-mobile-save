class ChiTietYKienXuLyModel {
  String? urlAvatar;
  String? name;
  String? time;
  bool isInput;
  List<YKienModel>? listYKien;

  ChiTietYKienXuLyModel({
    this.urlAvatar,
    this.name,
    this.time,
    this.isInput = false,
    this.listYKien,
  });
}

class YKienModel {
  String? avatar;
  String? name;
  String? time;

  YKienModel({
    this.avatar,
    this.name,
    this.time,
  });
}
