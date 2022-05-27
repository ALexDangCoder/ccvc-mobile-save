import 'dart:core';

import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';

const String MENU_BAOCAO = 'menu_baocao';
const String MENU_LICHLAMVIEC = 'menu_lichlamviec';
const String MENU_HOP = 'menu_hop';
const String MENU_QUANLYNHIEMVU = 'menu_quanlynhiemvu';
const String MENU_HANHCHINHCONG = 'menu_hanhchinhcong';
const String MENU_YKIENNGUOIDAN = 'menu_ykiennguoidan';
const String MENU_QUANLYVANBAN = 'menu_quanlyvanban';
const String MENU_BAOCHIMANGXAHOI = 'menu_baochi_mangxahoi';
const String MENU_CCTVCAMBIEN = 'menu_cctv_cambien';
const String MENU_KETNOI = 'menu_ketnoi';
const String MENU_TUONGTACNOIBO = 'menu_tuongtacnoibo';
const String MENU_TIENICH = 'menu_tienich';
const String MENU_DANHBA = 'menu_danhba';

enum TypeIconHDSD {
  menu_baocao,
  menu_lichlamviec,
  menu_hop,
  menu_quanlynhiemvu,
  menu_hanhchinhcong,
  menu_ykiennguoidan,
  menu_quanlyvanban,
  menu_baochi_mangxahoi,
  menu_cctv_cambien,
  menu_ketnoi,
  menu_tuongtacnoibo,
  menu_tienich,
  menu_danhba,
}

extension IconTypeItem on TypeIconHDSD {
  String getIconHDSD() {
    switch (this) {
      case TypeIconHDSD.menu_baocao:
        return ImageAssets.icBaoCao;
      case TypeIconHDSD.menu_lichlamviec:
        return ImageAssets.icLichLamViec;
      case TypeIconHDSD.menu_hop:
        return ImageAssets.icHop;
      case TypeIconHDSD.menu_quanlynhiemvu:
        return ImageAssets.icQuanLyNhiemVu;
      case TypeIconHDSD.menu_hanhchinhcong:
        return ImageAssets.icHanhChinhCong;
      case TypeIconHDSD.menu_ykiennguoidan:
        return ImageAssets.icYKienNguoiDan;
      case TypeIconHDSD.menu_quanlyvanban:
        return ImageAssets.icQuanLyVanBan;
      case TypeIconHDSD.menu_baochi_mangxahoi:
        return ImageAssets.icBaoChiMangXaHoi;
      case TypeIconHDSD.menu_cctv_cambien:
        return ImageAssets.icCctvCamBien;
      case TypeIconHDSD.menu_ketnoi:
        return ImageAssets.icKetNoi;
      case TypeIconHDSD.menu_tuongtacnoibo:
        return ImageAssets.icTuongTacNoiBo;
      case TypeIconHDSD.menu_tienich:
        return ImageAssets.icTienIch;
      case TypeIconHDSD.menu_danhba:
        return ImageAssets.icDanhBaDienTuHdsd;
    }
  }
}

class TopicHDSD {
  String? maTopic;
  String? icon;
  String? id;
  String? title;
  int? order;
  bool? inUsed;
  bool? isDeleted;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;

  TopicHDSD({
    this.maTopic,
    this.icon,
    this.id,
    this.title,
    this.order,
    this.inUsed,
    this.isDeleted,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
  });

  String toIcon() {
    switch (icon) {
      case MENU_BAOCAO:
        return ImageAssets.icBaoCao;
      case MENU_LICHLAMVIEC:
        return ImageAssets.icLichLamViec;
      case MENU_HOP:
        return ImageAssets.icHop;
      case MENU_QUANLYNHIEMVU:
        return ImageAssets.icQuanLyNhiemVu;
      case MENU_HANHCHINHCONG:
        return ImageAssets.icHanhChinhCong;
      case MENU_YKIENNGUOIDAN:
        return ImageAssets.icYKienNguoiDan;
      case MENU_QUANLYVANBAN:
        return ImageAssets.icQuanLyVanBan;
      case MENU_BAOCHIMANGXAHOI:
        return ImageAssets.icBaoChiMangXaHoi;
      case MENU_CCTVCAMBIEN:
        return ImageAssets.icCctvCamBien;
      case MENU_KETNOI:
        return ImageAssets.icKetNoi;
      case MENU_TUONGTACNOIBO:
        return ImageAssets.icTuongTacNoiBo;
      case MENU_TIENICH:
        return ImageAssets.icTienIch;
      case MENU_DANHBA:
        return ImageAssets.icDanhBaDienTuHdsd;
    }
    return '';
  }

  String toIconTablet() {
    switch (icon) {
      case MENU_BAOCAO:
        return ImageAssets.icBaoCao;
      case MENU_LICHLAMVIEC:
        return ImageAssets.icLichLamViec;
      case MENU_HOP:
        return ImageAssets.icHop;
      case MENU_QUANLYNHIEMVU:
        return ImageAssets.icQuanLyNhiemVu;
      case MENU_HANHCHINHCONG:
        return ImageAssets.icHanhChinhCong;
      case MENU_YKIENNGUOIDAN:
        return ImageAssets.icYKienNguoiDan;
      case MENU_QUANLYVANBAN:
        return ImageAssets.icQuanLyVanBan;
      case MENU_BAOCHIMANGXAHOI:
        return ImageAssets.icBaoChiMangXaHoiTablet;
      case MENU_CCTVCAMBIEN:
        return ImageAssets.icCctvCamBienTablet;
      case MENU_KETNOI:
        return ImageAssets.icKetNoiTablet;
      case MENU_TUONGTACNOIBO:
        return ImageAssets.icTuongTacNoiBoTablet;
      case MENU_TIENICH:
        return ImageAssets.icTienIch;
      case MENU_DANHBA:
        return ImageAssets.icDanhBaDienTuHdsdTablet;
    }
    return '';
  }

  TopicHDSD.empty();
}

class ItemTopicHDSD {
  final String url;
  final String title;

  ItemTopicHDSD({
    required this.url,
    required this.title,
  });
}
