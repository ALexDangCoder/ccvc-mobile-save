class DanhSachLichHopModel {
  List<ItemDanhSachLichHop>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  DanhSachLichHopModel.empty();

  DanhSachLichHopModel({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });
}

class ItemDanhSachLichHop {
  String? id;
  dynamic soNguoiThamDu;
  String? noiDung;
  dynamic tenPhongHop;
  String? linkTrucTuyen;
  dynamic phongHopId;
  int? mucDo;
  int? status;
  String? statusName;
  String? statusCode;
  String? title;
  bool? bit_HopTrucTuyen;
  dynamic color;
  bool? isThuKy;
  bool? isAllDay;
  bool? isLichLap;
  String? createAt;
  int? trangThaiTheoUser;
  String? diaDiem;
  String? trangThaiCuocHop;
  String? timeStart;
  String? timeTo;
  String? dateTimeFrom;
  String? dateTimeTo;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  CanBo? canBoChuTriInfo;
  CanBo? canBoDangKyInfo;

  ItemDanhSachLichHop.empty();

  ItemDanhSachLichHop({
    required this.id,
    required this.soNguoiThamDu,
    required this.noiDung,
    required this.tenPhongHop,
    required this.linkTrucTuyen,
    required this.phongHopId,
    required this.mucDo,
    required this.status,
    required this.statusName,
    required this.statusCode,
    required this.title,
    required this.bit_HopTrucTuyen,
    required this.color,
    required this.isThuKy,
    required this.isAllDay,
    required this.isLichLap,
    required this.createAt,
    required this.trangThaiTheoUser,
    required this.diaDiem,
    required this.trangThaiCuocHop,
    required this.timeStart,
    required this.timeTo,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.canBoChuTriInfo,
    required this.canBoDangKyInfo,
  });
}

class CanBo {
  String? canBoId;
  String? userName;
  String? tenChucVu;
  String? chucVuId;
  String? hoTen;
  String? sdtCanBo;
  String? sdtDonVi;
  String? emailDonVi;
  String? donViId;
  String? tenDonVi;
  String? donViGocId;
  String? tenDonViGoc;

  CanBo.empty();

  CanBo({
    required this.canBoId,
    required this.userName,
    required this.tenChucVu,
    required this.chucVuId,
    required this.hoTen,
    required this.sdtCanBo,
    required this.sdtDonVi,
    required this.emailDonVi,
    required this.donViId,
    required this.tenDonVi,
    required this.donViGocId,
    required this.tenDonViGoc,
  });
}
