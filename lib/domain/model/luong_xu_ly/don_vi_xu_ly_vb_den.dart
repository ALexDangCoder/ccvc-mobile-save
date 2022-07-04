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
      case 'DANG_XU_LY':
        return color02C5DD;
      case 'CHO_PHAN_XU_LY':
        return color5A8DEE;
      case 'CHO_VAO_SO':
        return color9B8DFF;
      case 'CHO_XU_LY':
        return choVaoSoColor;
      case 'DA_XU_LY':
        return daXuLyColor;
      case 'THU_HOI':
        return infoColor;
      case 'TRA_LAI':
        return pinkColor;
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
        return color6FCF97;
      case 'phoi hop':
        return dangThucHienPurble;
      case 'nhan de biet':
        return color979797;

    }
    return Colors.black;
  }
  bool isRoot(){
    return vaiTro == 'ROOT';
  }

}