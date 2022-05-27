class ItemChonBienBanCuocHopModel {
  List<NguoiThucHienModel> items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  ItemChonBienBanCuocHopModel({
    required this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });
}

class NguoiThucHienModel {
  String id;
  String hoten;
  List<String> donVi;
  List<String> chucVu;

  NguoiThucHienModel({
    required this.id,
    required this.hoten,
    required this.donVi,
    required this.chucVu,
  });

  String data() {
    return '${hoten.isNotEmpty ? hoten : ''}${donVi.isNotEmpty ? ' - ${donVi.join(', ')}' : ''}${chucVu.isNotEmpty ? ' - ${chucVu.join(', ')}' : ''}';
  }
}
