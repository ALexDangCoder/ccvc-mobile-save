class NguoiChuTriRequest {
  bool? isTaoHo;
  int? pageIndex;
  int? pageSize;
  String? userId;

  NguoiChuTriRequest(
      {this.isTaoHo, this.pageIndex, this.pageSize, this.userId});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isTaoHo'] = isTaoHo;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['userId'] = userId;
    return data;
  }
}