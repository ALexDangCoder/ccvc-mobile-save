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
        return color59C6FA;
      case 'CHO_PHAN_XU_LY':
        return color5252D4;
      case 'CHO_VAO_SO':
        return color0034FF;
      case 'CHO_XU_LY':
        return color8B4DB4;
      case 'DA_XU_LY':
        return color42B432;
      case 'THU_HOI':
        return color9B7938;
      case 'TRA_LAI':
        return colorE5F52F;
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
    switch(vaiTro){
      case 'Chủ trì':
        return color2467D2;
      case 'Phối hợp':
        return color2ED47A;
      case 'Nhận để biết':
        return colorEFECEC;

    }
    return Colors.black;
  }

}