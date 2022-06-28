class DanhSachBienSoXeRequest {
  String? userId;

  DanhSachBienSoXeRequest({
    this.userId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}