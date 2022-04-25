class ThongBaoModel {
  String? id;
  String? name;
  String? code;
  String? description;
  int? unreadCount;
  int? total;
  bool? statusSwitch;

  ThongBaoModel({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.unreadCount,
    required this.total,
    this.statusSwitch = false,
  });
}
