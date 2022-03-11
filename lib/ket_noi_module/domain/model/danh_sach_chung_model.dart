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
List<String> subStringImage(String image){
    return image.split(',',);
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
    this.id,
    this.tenSuKien,
    this.thoiGianBatDau,
    this.diaChi,
    this.thanhPhanThamGia,
    this.thongTinLienHe,
    this.danhSachHinhAnh,
    this.danhSachIdLoaiSuKien,
    this.isBookMark,
  });
}
