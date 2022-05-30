import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DocumentDashboardModel {
  int? soLuongChoTrinhKy = 0;
  int? soLuongChoXuLy = 0;
  int? soLuongDaXuLy = 0;
  int? soLuongChoYKien = 0;
  int? soLuongDaChoYKien = 0;
  int? soLuongChoBanHanh = 0;
  int? soLuongChoCapSo = 0;
  int? soLuongDaBanHanh = 0;
  int? soLuongNoiBo = 0;
  int? soLuongDaTraLai = 0;
  int? soLuongQuaHan = 0;
  int? soLuongDenHan = 0;
  int? soLuongTrongHan = 0;
  int? soLuongKhongCoHan = 0;
  int? soLuongThuongKhan = 0;
  int? soLuongDangXuLy = 0;
  int? soLuongChoVaoSo = 0;

  DocumentDashboardModel({
    this.soLuongChoTrinhKy,
    this.soLuongChoXuLy,
    this.soLuongDaXuLy,
    this.soLuongChoYKien,
    this.soLuongDaChoYKien,
    this.soLuongChoBanHanh,
    this.soLuongChoCapSo,
    this.soLuongDaBanHanh,
    this.soLuongNoiBo,
    this.soLuongDaTraLai,
    this.soLuongQuaHan,
    this.soLuongDenHan,
    this.soLuongTrongHan,
    this.soLuongKhongCoHan,
    this.soLuongThuongKhan,
    this.soLuongDangXuLy,
    this.soLuongChoVaoSo,
  });

  List<DataRow> listVBDen() {
    final List<DataRow> list = [];
    if (HiveLocal.checkPermissionApp(
        permissionTxt: PermissionConst.VB_DEN_VAO_SO_VAN_BAN_BANG_TAY,
        permissionType: PermissionType.QLVB)) {
      list.add(
          DataRow(SelectKey.CHO_VAO_SO, choVaoSoColor, soLuongChoVaoSo ?? 0));
    }
    list.addAll([
      DataRow(SelectKey.DANG_XU_LY, dangXyLyColor, soLuongDangXuLy ?? 0),
      DataRow(SelectKey.CHO_XU_LY, choXuLyColor, soLuongChoXuLy ?? 0),
      DataRow(SelectKey.DA_XU_LY, daXuLyColor, soLuongDaXuLy ?? 0),
    ]);
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
