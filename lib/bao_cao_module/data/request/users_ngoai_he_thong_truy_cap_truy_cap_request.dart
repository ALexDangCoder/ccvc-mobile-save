class UsersNgoaiHeThongTruyCapRequest {
  String? fullname;
  String? email;
  String? position;
  String? unit;
  int? status;
  bool? isLock;

  UsersNgoaiHeThongTruyCapRequest({
    this.fullname,
    this.status,
    this.isLock,
    this.email,
    this.position,
    this.unit,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['email'] = email;
    data['position'] = position;
    data['unit'] = unit;
    data['status'] = status;
    data['isLock'] = isLock;
    return data;
  }
}
