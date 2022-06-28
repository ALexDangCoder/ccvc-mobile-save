import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

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
  String? pictureId;
  String? loaiXeMay;
  String? bienKiemSoat;
  String? loaiSoHuu;

  ChiTietBienSoXeModel({
    this.id,
    this.userId,
    this.pictureId,
    this.loaiXeMay,
    this.bienKiemSoat,
    this.loaiSoHuu,
  });
}

extension DangKyXe on String {
  String loaiXe() {
    switch (this) {
      case DanhSachBienSoXeConst.XE_MAY:
        return S.current.xe_may;
      case DanhSachBienSoXeConst.O_TO:
        return S.current.xe_o_to;
      default:
        return S.current.xe_may;
    }
  }
  String loaiSoHuu() {
    switch (this) {
      case DanhSachBienSoXeConst.XE_CAN_BO:
        return S.current.xe_can_bo;
      case DanhSachBienSoXeConst.XE_LANH_DAO:
        return S.current.xe_lanh_dao;
      default:
        return S.current.xe_can_bo;
    }
  }
}
