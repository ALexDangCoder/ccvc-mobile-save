class DataDanhSachChungModel {
  int? pageIndex;
  int? totalPages;
  int? totalItems;
  List<DanhSachChungModel>? pageData;
  bool? hasPreviousPage;
  bool? hasNextPage;

  DataDanhSachChungModel({
    this.pageIndex,
    this.totalPages,
    this.totalItems,
    this.pageData,
    this.hasPreviousPage,
    this.hasNextPage,
  });
}

List<String> subStringImage(String image) {
  return image.split(
    ',',
  );
}

class DanhSachChungModel {
  String? id;
  String? tenSuKien;
  String? thoiGianBatDau;
  String? diaChi;
  String? thanhPhanThamGia;
  String? thongTinLienHe;
  String? danhSachHinhAnh;
  List<String>? danhSachIdLoaiSuKien;
  bool? isBookMark;

  DanhSachChungModel({
    required this.id,
    required this.tenSuKien,
    required this.thoiGianBatDau,
    required this.diaChi,
    required this.thanhPhanThamGia,
    required this.thongTinLienHe,
    required this.danhSachHinhAnh,
    required this.danhSachIdLoaiSuKien,
    required this.isBookMark,
  });
}
