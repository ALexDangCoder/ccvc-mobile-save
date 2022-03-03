class CatogoryListRequest {
  int? pageIndex;
  int? pageSize;
  int? type;

  CatogoryListRequest({this.pageIndex, this.pageSize, this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['type'] = type;
    return data;
  }
}
