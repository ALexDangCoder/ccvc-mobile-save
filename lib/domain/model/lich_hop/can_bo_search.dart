class CanBoSearchModel {
  List<CanBoSearchModelData>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  CanBoSearchModel.empty();

  CanBoSearchModel({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });
}

class CanBoSearchModelData {
  String? canBoId;
  String? chucVu;
  String? chucVuId;
  String? donViId;
  String? hoTen;
  String? id;
  String? tenDonVi;
  String? userId;
  String? userName;
  String? userTaoHoId;

  CanBoSearchModelData({
    required this.canBoId,
    required this.chucVu,
    required this.chucVuId,
    required this.donViId,
    required this.hoTen,
    required this.id,
    required this.tenDonVi,
    required this.userId,
    required this.userName,
    required this.userTaoHoId,
  });
}
