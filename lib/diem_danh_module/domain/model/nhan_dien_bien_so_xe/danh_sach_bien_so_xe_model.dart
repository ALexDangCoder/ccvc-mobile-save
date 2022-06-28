class ListItemChiTietBienSoXeModel {
  List<ChiTietBienSoXeModel>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  ListItemChiTietBienSoXeModel({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class ChiTietBienSoXeModel {
  String? id;
  String? userId;
  String? loaiXeMay;
  String? bienKiemSoat;
  String? loaiSoHuu;

  ChiTietBienSoXeModel({
    this.id,
    this.userId,
    this.loaiXeMay,
    this.bienKiemSoat,
    this.loaiSoHuu,
  });
}
