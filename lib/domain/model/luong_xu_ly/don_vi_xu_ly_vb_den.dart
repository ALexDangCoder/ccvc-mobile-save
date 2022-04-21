import 'dart:ui';

import 'package:flutter/material.dart';

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
  });

  DonViLuongModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    parentId = json['ParentId'];
    ten = json['Ten'];
    tenNguoiTao = json['TenNguoiTao'];
    maTrangThai = json['MaTrangThai'];
    trangThai = json['TrangThai'];
    tenDonVi = json['TenDonVi'];
    vaiTro = json['VaiTro'];
    avatar = json['Avatar'];
    avatarCommon = json['AvatarCommon'];
    isBaoCaoLanhDao = json['IsBaoCaoLanhDao'];
    taskId = json['TaskId'];
    canBoTaoId = json['CanBoTaoId'];
    type = json['Type'];
    chucVu = json['ChucVu'];
    level = json['Level'];
    isCaNhan = json['IsCaNhan'];
  }
  bool isCaNhanFunc(){
    return isCaNhan !=null;
  }
  Color getColor(){
    switch(maTrangThai){
      case 'DANG_XU_LY':
        return const Color(0xff59c6fa);
      case 'CHO_PHAN_XU_LY':
        return const Color(0xff5252d4);
      case 'CHO_VAO_SO':
        return const Color(0xff0034ff);
      case 'CHO_XU_LY':
        return const Color(0xff8b4db4);
      case 'DA_XU_LY':
        return const Color(0xff42b432);
      case 'THU_HOI':
        return const Color(0xff9b7938);
      case 'TRA_LAI':
        return const Color(0xffe5f52f);
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
    switch(vaiTro){
      case 'Chủ trì':
        return const Color(0xff2467d2);
      case 'Phối hợp':
        return const Color(0xff2ed47a);
      case 'Nhận để biết':
        return const Color(0xffEFECEC);

    }
    return Colors.black;
  }

}