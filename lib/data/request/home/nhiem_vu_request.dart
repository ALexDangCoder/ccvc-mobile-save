class NhiemVuRequest {
  int? size;
  int? index;
  bool? isNhiemVuCaNhan;
  List<String>? mangTrangThai;
  NgayTaoNhiemVu? ngayTaoNhiemVu;
  bool? isSortByHanXuLy;

  NhiemVuRequest(
      {this.size,
      this.index,
      this.isNhiemVuCaNhan,
      this.mangTrangThai,
      this.ngayTaoNhiemVu,
      this.isSortByHanXuLy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Size'] = size;
    data['Index'] = index;
    data['IsNhiemVuCaNhan'] = isNhiemVuCaNhan;
    data['MangTrangThai'] = mangTrangThai;
    if (ngayTaoNhiemVu != null) {
      data['NgayTaoNhiemVu'] = ngayTaoNhiemVu!.toJson();
    }
    data['IsSortByHanXuLy'] = isSortByHanXuLy;
    return data;
  }
}

class NgayTaoNhiemVu {
  String? fromDate;
  String? toDate;

  NgayTaoNhiemVu({this.fromDate, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    return data;
  }
}
