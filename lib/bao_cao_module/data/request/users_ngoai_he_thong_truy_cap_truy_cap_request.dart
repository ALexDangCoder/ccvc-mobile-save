class UsersNgoaiHeThongTruyCapRequest {
  int? pageIndex;
  int? pageSize;
  String? keyword;
  int? status;
  bool? isLock;

  UsersNgoaiHeThongTruyCapRequest({
    this.pageIndex,
    this.pageSize,
    this.keyword,
    this.status,
    this.isLock,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['keyword'] = keyword;
    data['status'] = status;
    data['isLock'] = isLock;
    return data;
  }
}
