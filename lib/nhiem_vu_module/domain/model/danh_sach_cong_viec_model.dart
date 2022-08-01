import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DanhSachCongViecModel {
  List<PageDatas>? pageData;
  int? totalRows;
  int? currentPage;
  int? pageSize;
  int? totalPage;

  DanhSachCongViecModel({
    required this.pageData,
    required this.totalRows,
    required this.currentPage,
    required this.pageSize,
    required this.totalPage,
  });
}

class PageDatas {
  String? stt;
  String? id;
  String? tenCv;
  String? maCv;
  int? trangThaiHanXuLy;
  String? noiDungCongViec;
  String? doiTuongThucHien;
  String? donViThucHien;
  String? donViThucHienId;
  String? caNhanThucHien;
  String? nguoiThucHienId;
  String? nguoiThucHien;
  String? hanXuLyFormatDate;
  String? thoiGianGiaoFormatDate;
  String? hanXuLy;
  String? thoiGianGiaoViec;
  String? nguoiGiaoViec;
  String? donViGiaoViec;
  String? donViGiaoViecId;
  String? trangThai;
  String? maTrangThai;
  String? trangThaiId;
  String? maNhiemVu;
  String? nhiemVuId;
  String? mucDoCongViecId;
  String? mucDoCongViec;
  String? noiDungNhiemVu;
  String? nguoiTaoId;
  String? nguoiTao;
  String? currentDonVi;
  String? actionDate;
  String? congViecLienQuan;
  bool? isFromCaNhan;
  int? wTrangThai;
  bool? coTheCapNhatTinhHinh;
  bool? coTheSua;
  bool? coTheHuy;
  bool? coTheGan;
  bool? coTheXoa;

  PageDatas({
    required this.stt,
    required this.id,
    required this.tenCv,
    required this.maCv,
    required this.trangThaiHanXuLy,
    required this.noiDungCongViec,
    required this.doiTuongThucHien,
    required this.donViThucHien,
    required this.donViThucHienId,
    required this.caNhanThucHien,
    required this.nguoiThucHienId,
    required this.nguoiThucHien,
    required this.hanXuLyFormatDate,
    required this.thoiGianGiaoFormatDate,
    required this.hanXuLy,
    required this.thoiGianGiaoViec,
    required this.nguoiGiaoViec,
    required this.donViGiaoViec,
    required this.donViGiaoViecId,
    required this.trangThai,
    required this.maTrangThai,
    required this.trangThaiId,
    required this.maNhiemVu,
    required this.nhiemVuId,
    required this.mucDoCongViecId,
    required this.mucDoCongViec,
    required this.noiDungNhiemVu,
    required this.nguoiTaoId,
    required this.nguoiTao,
    required this.currentDonVi,
    required this.actionDate,
    required this.congViecLienQuan,
    required this.isFromCaNhan,
    required this.wTrangThai,
    required this.coTheCapNhatTinhHinh,
    required this.coTheSua,
    required this.coTheHuy,
    required this.coTheGan,
    required this.coTheXoa,
  });
}

extension CheckColor on String {
  Color trangThaiToColor() {
    switch (this) {
      case NhiemVuLowerCase.THU_HOI:
        return Colors.red;
      case NhiemVuLowerCase.CHO_PHAN_XU_LY:
        return color5A8DEE;
      case NhiemVuLowerCase.CHUA_THUC_HIEN:
        return choVaoSoColor;
      case NhiemVuLowerCase.DANG_THUC_HIEN:
        return choTrinhKyColor;
      case NhiemVuLowerCase.DA_HOAN_THANH:
        return daXuLyColor;
      case NhiemVuLowerCase.TRA_LAI:
        return Colors.red;
      default:
        return Colors.red;
    }
  }


  Color statusCharLoaiDSNV() {
    switch (this) {
      case NhiemVuLowerCase.NHIEM_VU_DON_VI:
        return AppTheme.getInstance().nhiemDonViColor();
      case NhiemVuLowerCase.NHIEM_VU_CP_CPCP:
        return AppTheme.getInstance().choXuLyColor();
      case NhiemVuLowerCase.NHIEM_VU_UBND_TINH:
        return color0A45B9;
      default:
        return AppTheme.getInstance().mainColor();
    }
  }


  Color status() {
    switch (this) {
      case NhiemVuLowerCase.QUA_HAN:
        return statusCalenderRed;
      case NhiemVuLowerCase.DEN_HAN:
        return denHanColor;
      case NhiemVuLowerCase.TRONG_HAN:
        return textTitle;
      default:
        return Colors.red;
    }
  }

  int statusBox() {
    switch (this) {
      case NhiemVuLowerCase.QUA_HAN:
        return 2;
      case NhiemVuLowerCase.DEN_HAN:
        return 1;
      case NhiemVuLowerCase.TRONG_HAN:
        return 3;
      default:
        return 2;
    }
  }

  String titleTrangThai() {
    switch (this) {
      case CHUA_THUC_HIEN:
        return S.current.chua_thuc_hien;
      case DA_HOAN_THANH:
        return S.current.da_thuc_hien;
      case DANG_THUC_HIEN:
        return S.current.dang_thuc_hien;
      case CHO_PHAN_XU_LY:
        return S.current.cho_phan_xu_ly;
      case TRA_LAI_VPCP:
        return S.current.tra_lai_vpcp;
      default:
        return '';
    }
  }
}
