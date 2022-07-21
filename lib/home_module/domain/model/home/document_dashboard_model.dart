import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DocumentDashboardModel {
  int soLuongChoTrinhKy = 0;
  int soLuongChoXuLy = 0;
  int soLuongDaXuLy = 0;
  int soLuongChoYKien = 0;
  int soLuongDaChoYKien = 0;
  int soLuongChoBanHanh = 0;
  int soLuongChoCapSo = 0;
  int soLuongDaBanHanh = 0;
  int soLuongNoiBo = 0;
  int soLuongDaTraLai = 0;
  int soLuongQuaHan = 0;
  int soLuongDenHan = 0;
  int soLuongTrongHan = 0;
  int soLuongKhongCoHan = 0;
  int soLuongThuongKhan = 0;
  int soLuongDangXuLy = 0;
  int soLuongChoVaoSo = 0;
  int soLuongChoTiepNhan = 0;
  int soLuongPhanXuLy = 0;
  int soLuongChoPhanXuLy = 0;
  int soLuongChoDuyet = 0;
  int soLuongChoDuyetXuLy = 0;
  int soLuongChoBoSungThongTin = 0;
  int soLuongChoTiepNhanXuLy = 0;
  int soLuongDaPhanCong = 0;
  int soLuongDaHoanThanh = 0;
  int soLuongChuaThucHien ;
  int soLuongHoanThanhNhiemVu;
  int soLuongDangThucHien;
  DocumentDashboardModel({
    this.soLuongChoTrinhKy  =0,
    this.soLuongChoXuLy = 0,
    this.soLuongDaXuLy= 0,
    this.soLuongChoYKien= 0,
    this.soLuongDaChoYKien =0,
    this.soLuongChoBanHanh=0,
    this.soLuongChoCapSo=0,
    this.soLuongDaBanHanh=0,
    this.soLuongNoiBo=0,
    this.soLuongDaTraLai=0,
    this.soLuongQuaHan=0,
    this.soLuongDenHan=0,
    this.soLuongTrongHan=0,
    this.soLuongKhongCoHan=0,
    this.soLuongThuongKhan=0,
    this.soLuongDangXuLy=0,
    this.soLuongChoVaoSo=0,
    this.soLuongChoTiepNhan=0,
    this.soLuongPhanXuLy=0,
    this.soLuongChoDuyet=0,
    this.soLuongChoBoSungThongTin=0,
    this.soLuongChoTiepNhanXuLy=0,
    this.soLuongChoPhanXuLy=0,
    this.soLuongDaPhanCong=0,
    this.soLuongDaHoanThanh = 0,
    this.soLuongChuaThucHien = 0,
    this.soLuongHoanThanhNhiemVu = 0,
    this.soLuongDangThucHien = 0,
    this.soLuongChoDuyetXuLy = 0,
  });

  List<DataRow> listVBDen() {
    final List<DataRow> list = [];
    list.addAll([
      DataRow(SelectKey.CHO_XU_LY, choXuLyColor, soLuongChoXuLy ),
      DataRow(SelectKey.DANG_XU_LY, dangXyLyColor, soLuongDangXuLy ),
      DataRow(SelectKey.DA_XU_LY, daXuLyColor, soLuongDaXuLy),
    ]);
    if (HiveLocal.checkPermissionApp(
        permissionTxt: PermissionConst.VB_DEN_VAO_SO_VAN_BAN_BANG_TAY,
        permissionType: PermissionType.QLVB)) {
      list.add(
          DataRow(SelectKey.CHO_VAO_SO, choVaoSoColor, soLuongChoVaoSo ));
    }
    return list;
  }
}

class DataRow {
  final SelectKey key;
  final Color color;
  final int value;

  DataRow(this.key, this.color, this.value);
}

enum VBDenDocumentType {
  CHO_XU_LY,
  DANG_XU_LY,
  DA_XU_LY,
  CHO_VAO_SO,
  QUA_HAN,
  TRONG_HAN,
  THUONG_KHAN
}

extension TypeVBDen on VBDenDocumentType {
  String getName() {
    switch (this) {
      case VBDenDocumentType.CHO_VAO_SO:
        return 'CHO_VAO_SO';
      case VBDenDocumentType.DANG_XU_LY:
        return 'DANG_XU_LY';
      case VBDenDocumentType.DA_XU_LY:
        return 'DA_XU_LY';
      case VBDenDocumentType.CHO_XU_LY:
        return 'CHO_XU_LY';
      case VBDenDocumentType.QUA_HAN:
        return 'DANG_THUC_HIEN';
      case VBDenDocumentType.TRONG_HAN:
        return 'TRONG_HAN';
      case VBDenDocumentType.THUONG_KHAN:
        return 'THUONG_KHAN';
    }
  }
}
