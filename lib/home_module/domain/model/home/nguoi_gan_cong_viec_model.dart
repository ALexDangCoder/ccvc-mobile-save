class NguoiGanCongViecModel {
  List<ItemNguoiGanModel> items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;
  NguoiGanCongViecModel({
    required this.items,
    this.totalPage=0,
    this.pageSize=0,
    this.pageIndex=0,
    this.totalCount=0,
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
