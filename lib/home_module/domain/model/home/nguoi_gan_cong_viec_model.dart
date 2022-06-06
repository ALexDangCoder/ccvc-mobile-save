class NguoiGanCongViecModel {
  List<ItemNguoiGanModel> items;
  NguoiGanCongViecModel({
    required this.items,
  });
}

class ItemNguoiGanModel {
  String id;
  String hoTen;
  List<String> chucVu;
  List<String> donVi;

  ItemNguoiGanModel(
      {required this.id,
      required this.hoTen,
      required this.chucVu,
      required this.donVi,});
}
