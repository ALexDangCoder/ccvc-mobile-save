class DanhSachLichlamViecModel {
  List<ItemDanhSachLichLamViec>? item;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  DanhSachLichlamViecModel.empty();

  DanhSachLichlamViecModel(
      {this.item,
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPage});
}

class ItemDanhSachLichLamViec {
  String? id;
  String? title;
  String? content;
  int? status;
  String? location;
  bool? isLichLap;
  bool? isAllDay;
  int? trangThaiTheoUser;
  String? dateFrom;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  String? dateTimeFrom;
  String? dateTimeTo;
  String? createAt;
  dynamic color;
  String? typeSchedule;
  CanBoChuTri? canBoChuTriInfo;
  CanBoChuTri? canBoChuTriDangKyInfo;

  ItemDanhSachLichLamViec.empty();

  ItemDanhSachLichLamViec(
      {this.id,
      this.title,
      this.content,
      this.status,
      this.location,
      this.isLichLap,
      this.isAllDay,
      this.trangThaiTheoUser,
      this.dateFrom,
      this.dateTo,
      this.timeFrom,
      this.timeTo,
      this.dateTimeFrom,
      this.dateTimeTo,
      this.createAt,
      this.color,
      this.typeSchedule,
      this.canBoChuTriInfo,
      this.canBoChuTriDangKyInfo});
}

class CanBoChuTri {
  String? id;
  String? chucVu;
  String? chucVuId;
  String? hoTen;
  String? sdtDiDong;
  String? donViId;
  String? tenDonVi;
  String? donViGocId;
  String? tenDonViGoc;

  CanBoChuTri.empty();

  CanBoChuTri(
      {this.id,
      this.chucVu,
      this.chucVuId,
      this.hoTen,
      this.sdtDiDong,
      this.donViId,
      this.tenDonVi,
      this.donViGocId,
      this.tenDonViGoc});
}
