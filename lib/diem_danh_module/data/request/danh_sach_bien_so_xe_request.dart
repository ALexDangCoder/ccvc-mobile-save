class DanhSachBienSoXeRequest {
  String? userId;
  int? pageIndex;
  int? pageSize;

  DanhSachBienSoXeRequest({
    this.userId,
    this.pageIndex,
    this.pageSize,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}
