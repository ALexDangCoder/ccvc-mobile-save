class UsersNgoaiHeThongTruyCapRequest {
  String? pageIndex;
  String? pageSize;
  String? keyword;

  UsersNgoaiHeThongTruyCapRequest({
    this.pageIndex,
    this.pageSize,
    this.keyword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['keyword'] = keyword;
    return data;
  }
}
