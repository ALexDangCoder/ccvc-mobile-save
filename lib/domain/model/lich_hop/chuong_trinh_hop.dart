import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class ChuongTrinhHopModel {
  List<CanBoModel>? listCanBo;
  CountStatus? countStatus;

  ChuongTrinhHopModel.empty();

  ChuongTrinhHopModel({required this.listCanBo, required this.countStatus});
}

class CanBoModel {
  String? tenChucVu;
  bool? diemDanh;
  bool? disable;
  int? trangThai;
  bool? isVangMat;
  String? id;
  String? lichHopId;
  String? donViId;
  String? canBoId;
  String? vaiTro;
  String? ghiChu;
  String? parentId;
  int? vaiTroThamGia;
  String? email;
  String? soDienThoai;
  String? dauMoiLienHe;
  String? tenCoQuan;
  String? tenCanBo;
  bool? isThuKy;
  bool? isThamGiaBocBang;
  String? createAt;
  bool isDiemDanhInView;

  CanBoModel({
    this.tenChucVu,
    this.diemDanh,
    this.disable,
    this.trangThai,
    this.isVangMat,
    required this.id,
    required this.lichHopId,
    required this.donViId,
    required this.canBoId,
    required this.vaiTro,
    required this.tenCanBo,
    required this.ghiChu,
    required this.parentId,
    required this.vaiTroThamGia,
    required this.email,
    required this.soDienThoai,
    this.dauMoiLienHe,
    required this.tenCoQuan,
    required this.isThuKy,
    required this.isThamGiaBocBang,
    required this.createAt,
    this.isDiemDanhInView = false,
  });

  String trangThaiTPTG() {
    switch (trangThai) {
      case 1:
        return S.current.tham_gia;
      case 2:
        return S.current.tu_choi_tham_du;
      case 4:
        return S.current.tham_du;
      default:
        return S.current.cho_xac_nhan;
    }
  }

  Color trangThaiColor() {
    switch (trangThai) {
      case 1:
        return daXuLyColor;
      case 2:
        return choXuLyColor;
      case 4:
        return statusCalenderRed;
      default:
        return itemWidgetNotUse;
    }
  }

  String diemDanhTPTG() {
    if (isVangMat == true) {
      return S.current.vang_mat;
    } else if (isVangMat == false && diemDanh == true) {
      return S.current.da_diem_danh;
    } else if (isVangMat == false && diemDanh == false) {
      return S.current.chua_diem_danh;
    } else {
      return '';
    }
  }

  bool showCheckBox() {
    if (isVangMat == true) {
      return false;
    } else if (isVangMat == false && diemDanh == true) {
      return false;
    } else if (isVangMat == false && diemDanh == false) {
      return true;
    } else {
      return false;
    }
  }

  Color diemDanhColors() {
    if (isVangMat == true) {
      return infoColor;
    } else if (isVangMat == false && diemDanh == true) {
      return deliveredColor;
    } else if (isVangMat == false && diemDanh == false) {
      return statusCalenderRed;
    } else {
      return backgroundColorApp;
    }
  }
}
