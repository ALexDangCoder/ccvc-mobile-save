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
    this.id,
    this.lichHopId,
    this.donViId,
    this.canBoId,
    this.vaiTro,
    this.tenCanBo,
    this.ghiChu,
    this.parentId,
    this.vaiTroThamGia,
    this.email,
    this.soDienThoai,
    this.dauMoiLienHe,
    this.tenCoQuan,
    this.isThuKy,
    this.isThamGiaBocBang,
    this.createAt,
    this.isDiemDanhInView = false,
  });

  String trangThaiTPTG() {
    switch (trangThai) {
      case 1:
        return S.current.tham_gia;
      case 2:
        return S.current.tu_choi_tham_du;
      case 4:
        return S.current.thu_hoi;
      default:
        return S.current.cho_xac_nhan;
    }
  }
String titleCanBo(){
    if(dauMoiLienHe?.isNotEmpty ?? false){
      return dauMoiLienHe ?? '';
    }
    return tenCanBo ?? '';
}
  Color trangThaiColor() {
    switch (trangThai) {
      case 1:
        return daXuLyColor;
      case 2:
        return statusCalenderRed;
      case 4:
        return color5A8DEE;
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
      return true;
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

  String getNameVaiTro() {
    if(isThuKy ?? false){
      return S.current.thu_ky;
    }
    switch (vaiTroThamGia) {
      case 0:
        return S.current.can_bo_chu_tri;
      case 1:
        return S.current.khach_moi_trong_don_vi;
      case 2:
        return S.current.khach_moi_can_bo_trong_don_vi;
      case 3:
        return S.current.cu_di;
      case 4:
        return S.current.khach_moi_ngoai_don_vi;
      case 5:
        return S.current.khach_moi_can_bo_ngoai_don_vi;
    }
    return '';
  }
}
