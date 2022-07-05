import 'dart:developer';
import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class DonViLuongModel  {
  String? Id;
  String? parentId;
  String? ten;
  String? tenNguoiTao;
  String? maTrangThai;
  String? trangThai;
  String? tenDonVi;
  String? vaiTro;
  bool? isCaNhan;
  String? avatar;
  String? avatarCommon;
  bool? isBaoCaoLanhDao;
  String? taskId;
  String? canBoTaoId;
  String? type;
  String? chucVu;
  int? level;

  DonViLuongModel({
    this.parentId,
    this.ten,
    this.tenNguoiTao,
    this.maTrangThai,
    this.trangThai,
    this.tenDonVi,
    this.vaiTro,
    this.avatar,
    this.avatarCommon,
    this.isBaoCaoLanhDao,
    this.taskId,
    this.canBoTaoId,
    this.type,
    this.chucVu,
    this.level,
    this.isCaNhan
  });


  bool isCaNhanFunc(){
    return isCaNhan !=null;
  }
  Color getColor(){
    switch(maTrangThai){
      case XemLuongConstant.DANG_XU_LY:
        return color02C5DD;
      case XemLuongConstant.CHO_PHAN_XU_LY:
        return color5A8DEE;
      case XemLuongConstant.CHO_VAO_SO:
        return color9B8DFF;
      case XemLuongConstant.CHO_XU_LY:
        return choVaoSoColor;
      case XemLuongConstant.DA_XU_LY:
        return daXuLyColor;
      case XemLuongConstant.THU_HOI:
        return infoColor;
      case XemLuongConstant.TRA_LAI:
        return pinkColor;
    }
    return Colors.transparent;
  }
  Color textColor(){
    if(maTrangThai == XemLuongConstant.TRA_LAI){
      return Colors.black;
    }
    return Colors.white;
  }
  Color vaiTroColor(){
    final vaiTroParseVn = vaiTro?.vietNameseParse().toLowerCase();
    switch(vaiTroParseVn){
      case XemLuongConstant.CHU_TRI:
        return color6FCF97;
      case XemLuongConstant.PHOI_HOP:
        return dangThucHienPurble;
      case XemLuongConstant.NHAN_DE_BIET:
        return color979797;

    }
    return Colors.black;
  }
  bool isRoot(){
    return vaiTro == XemLuongConstant.ROOT;
  }
  bool isCanBo(){
    return type == XemLuongConstant.CAN_BO;
  }
}
class XemLuongConstant{
  static const String ROOT = 'ROOT';
  static const String CAN_BO = 'CAN_BO';
  static const String NHAN_DE_BIET = 'nhan de biet';
  static const String PHOI_HOP = 'phoi hop';
  static const String CHU_TRI = 'chu tri';
  static const String DANG_XU_LY = 'DANG_XU_LY';
  static const String CHO_PHAN_XU_LY = 'CHO_PHAN_XU_LY';
  static const String CHO_VAO_SO = 'CHO_VAO_SO';
  static const String CHO_XU_LY = 'CHO_XU_LY';
  static const String DA_XU_LY = 'DA_XU_LY';
  static const String THU_HOI = 'THU_HOI';
  static const String TRA_LAI = 'TRA_LAI';
}