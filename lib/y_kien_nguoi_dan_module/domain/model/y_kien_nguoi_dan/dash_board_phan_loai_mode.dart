class PhanLoaiModel {
  List<PhanLoaiDataModel> listPhanLoai;

  PhanLoaiModel({required this.listPhanLoai});
}

class PhanLoaiDataModel {
  int soLuong;
  String tenNguon;

  PhanLoaiDataModel({required this.soLuong, required this.tenNguon});
}
