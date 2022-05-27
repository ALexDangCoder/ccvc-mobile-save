class DashboardTinhHinhXuLuModel {
  TinhHinhXuLyModel tinhHinhXuLyModel;

  DashboardTinhHinhXuLuModel({required this.tinhHinhXuLyModel});
}

class TinhHinhXuLyModel {
  List<TinhHinhModel> listTinhHinh;
  List<TinhHinhModel> listTrangThai;

  TinhHinhXuLyModel({required this.listTrangThai, required this.listTinhHinh});
}

class TinhHinhModel {
  int soLuong;
  String status;

  TinhHinhModel({required this.soLuong, required this.status});
}
