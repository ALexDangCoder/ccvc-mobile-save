class DanhSachCongViecRequest {
  bool? isSortByHanXuLy;
  bool? isCaNhan;
  int? size;
  int? index;
  List<String>? mangTrangThai;
  HanXuLy? hanXuLy;
  List<String>? trangThaiFilter;

  DanhSachCongViecRequest(
      {this.isSortByHanXuLy,
      this.isCaNhan,
      this.size,
      this.index,
      this.mangTrangThai,
      this.hanXuLy,
      this.trangThaiFilter});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSortByHanXuLy'] = isSortByHanXuLy;
    data['IsCaNhan'] = isCaNhan;
    data['Size'] = size;
    data['Index'] = index;
    data['MangTrangThai'] = mangTrangThai;
    if (hanXuLy != null) {
      data['HanXuLy'] = hanXuLy!.toJson();
    }
    data['TrangThaiFilter'] = trangThaiFilter;
    return data;
  }
}

class HanXuLy {
  String? fromDate;
  String? toDate;

  HanXuLy({this.fromDate, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    return data;
  }
}
