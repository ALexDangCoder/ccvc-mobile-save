class DanhSachVBRequest {
  List<String>? maTrangThai;
  bool? isSortByDoKhan;
  int? size;
  int? index;
  bool? isDaChoYKien;
  bool? isChoYKien;
  String? thoiGianStartFilter;
  String? thoiGianEndFilter;
  String? keySearch;
  bool? isDanhSachDaXuLy;
  int? trangThaiXuLy;
  bool? isSortByTrangThai;

  DanhSachVBRequest({
    this.maTrangThai,
    this.isSortByDoKhan,
    this.size,
    this.index,
    this.isDaChoYKien,
    this.isChoYKien,
    this.thoiGianStartFilter,
    this.thoiGianEndFilter,
    this.keySearch,
    this.isDanhSachDaXuLy,
    this.trangThaiXuLy,
    this.isSortByTrangThai,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MaTrangThai'] = maTrangThai;
    data['IsSortByDoKhan'] = isSortByDoKhan;
    data['Size'] = size;
    data['Index'] = index;
    data['IsDaChoYKien'] = isDaChoYKien;
    data['IsChoYKien'] = isChoYKien;
    data['ThoiGianStartFilter'] = thoiGianStartFilter;
    data['ThoiGianEndFilter'] = thoiGianEndFilter;
    data['KeySearch'] = keySearch;
    data['IsDanhSachDaXuLy'] = isDanhSachDaXuLy;
    data['TrangThaiXuLy'] = trangThaiXuLy;
    data['IsSortByTrangThai'] = isSortByTrangThai;
    return data;
  }
}

class SearchVBRequest {
  List<int>? trangThaiFilter;
  bool? isSortByDoKhan;
  int? size;
  int? index;
  bool? isDaChoYKien;
  bool? isChoYKien;
  String? ngayTaoStartSearch;
  String? ngayTaoEndSearch;
  bool? isDanhSachChoXuLy;
  bool? isDanhSachChoCapSo;
  bool? isDanhSachDaBanHanh;
  bool? isDanhSachChoTrinhKy;

  SearchVBRequest({
    this.trangThaiFilter,
    this.isSortByDoKhan,
    this.size,
    this.index,
    this.isDaChoYKien,
    this.isChoYKien,
    this.ngayTaoStartSearch,
    this.ngayTaoEndSearch,
    this.isDanhSachChoXuLy,
    this.isDanhSachChoCapSo,
    this.isDanhSachDaBanHanh,
    this.isDanhSachChoTrinhKy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TrangThaiFilter'] = trangThaiFilter;
    data['IsSortByDoKhan'] = isSortByDoKhan;
    data['Size'] = size;
    data['Index'] = index;
    data['IsDaChoYKien'] = isDaChoYKien;
    data['IsChoYKien'] = isChoYKien;
    data['NgayTaoStartSearch'] = ngayTaoStartSearch;
    data['NgayTaoEndSearch'] = ngayTaoEndSearch;
    data['IsDanhSachChoXuLy'] = isDanhSachChoXuLy;
    data['IsDanhSachChoCapSo'] = isDanhSachChoCapSo;
    data['IsDanhSachDaBanHanh'] = isDanhSachDaBanHanh;
    data['IsDanhSachChoTrinhKy'] = isDanhSachChoTrinhKy;
    return data;
  }
}

class SearchDanhSachVanBanRequest {
  List<int>? trangThaiFilter;
  bool? isSortByDoKhan;
  int? size;
  int? index;
  bool? isDaChoYKien;
  bool? isChoYKien;
  String? ngayTaoStartSearch;
  String? ngayTaoEndSearch;
  bool? isDanhSachChoXuLy;
  bool? isDanhSachChoCapSo;
  bool? isDanhSachDaBanHanh;
  bool? isDanhSachChoTrinhKy;

  SearchDanhSachVanBanRequest({
    this.trangThaiFilter,
    this.isSortByDoKhan,
    this.size,
    this.index,
    this.isDaChoYKien,
    this.isChoYKien,
    this.ngayTaoStartSearch,
    this.ngayTaoEndSearch,
    this.isDanhSachChoXuLy,
    this.isDanhSachChoCapSo,
    this.isDanhSachDaBanHanh,
    this.isDanhSachChoTrinhKy,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TrangThaiFilter'] = trangThaiFilter;
    data['IsSortByDoKhan'] = isSortByDoKhan;
    data['Size'] = size;
    data['Index'] = index;
    data['IsDaChoYKien'] = isDaChoYKien;
    data['IsChoYKien'] = isChoYKien;
    data['NgayTaoStartSearch'] = ngayTaoStartSearch;
    data['NgayTaoEndSearch'] = ngayTaoEndSearch;
    data['IsDanhSachChoXuLy'] = isDanhSachChoXuLy;
    data['IsDanhSachChoCapSo'] = isDanhSachChoCapSo;
    data['IsDanhSachDaBanHanh'] = isDanhSachDaBanHanh;
    data['IsDanhSachChoTrinhKy'] = isDanhSachChoTrinhKy;
    return data;
  }
}
