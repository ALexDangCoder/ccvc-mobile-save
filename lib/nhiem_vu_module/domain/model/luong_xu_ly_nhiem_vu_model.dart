import 'dart:developer';
import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
class DonViLuongNhiemVuModel  {
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


  DonViLuongNhiemVuModel({
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
    this.isCaNhan,

  });


  bool isCaNhanFunc(){
    return isCaNhan !=null;
  }
  Color getColor(){
    switch(maTrangThai){
      case 'CHO_PHAN_XU_LY':
        return color5A8DEE;
      case 'CHUA_THUC_HIEN':
        return colorF2994A;
      case 'DANG_THUC_HIEN':
        return color02C5DD;
      case 'DA_THUC_HIEN':
        return color28C76F;
      case 'TRA_LAI':
        return colorFB7897;
      case 'THU_HOI':
        return color667793;

    }
    return Colors.transparent;
  }
  Color textColor(){
    if(maTrangThai == 'TRA_LAI'){
      return Colors.black;
    }
    return Colors.white;
  }
  Color vaiTroColor(){
    final vaiTroParseVn = vaiTro?.vietNameseParse().toLowerCase();

    switch(vaiTroParseVn){
      case 'chu tri':
        return color2467D2;
      case 'phoi hop':
        return color2ED47A;
    }
    return Colors.black;
  }
  String get textChucVuDonVi {
    if( chucVu?.isNotEmpty ?? false){
      return '$ten - $chucVu';
    }
    return '$ten';
  }

}