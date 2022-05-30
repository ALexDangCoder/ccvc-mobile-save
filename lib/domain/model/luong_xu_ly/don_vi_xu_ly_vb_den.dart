import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class DonViLuongModel {
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

  DonViLuongModel(
      {this.parentId,
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
      this.isCaNhan});

  bool isCaNhanFunc() {
    return isCaNhan != null;
  }

  Color getColor() {
    switch (maTrangThai) {
      case 'DANG_XU_LY':
        return dangXuLyLuongColor;
      case 'CHO_PHAN_XU_LY':
        return choPhanXuLyColor;
      case 'CHO_VAO_SO':
        return choVaoSoLuongColor;
      case 'CHO_XU_LY':
        return choXuLyLuongColor;
      case 'DA_XU_LY':
        return daXuLyLuongColor;
      case 'THU_HOI':
        return thuHoiLuongColor;
      case 'TRA_LAI':
        return traLaiLuongColor;
    }
    return Colors.transparent;
  }

  Color textColor() {
    if (maTrangThai == 'TRA_LAI') {
      return Colors.black;
    }
    return Colors.white;
  }

  Color vaiTroColor() {
    final vaiTroParseVn = vaiTro?.vietNameseParse().toLowerCase();
    switch (vaiTro) {
      case 'Chủ trì':
        return nguoiChuTriColor;
      case 'Phối hợp':
        return phoiHopColor;
      case 'Nhận để biết':
        return nhanDeBietColor;
    }
    return Colors.black;
  }
}
