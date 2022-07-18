class BangDiemDanhCaNhanRequest {
  String? userId;
  String? thoiGian;

  BangDiemDanhCaNhanRequest({
    this.userId,
    this.thoiGian,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['thoiGian'] = thoiGian;
    return data;
  }
}
