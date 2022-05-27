import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

enum StatusYKien { DANG_XU_LY, QUA_HAN }

extension DanhSachYKien on StatusYKien {
  StatusData getText() {
    switch (this) {
      case StatusYKien.DANG_XU_LY:
        return StatusData(text: S.current.dang_xu_ly, color: textColorForum);
      case StatusYKien.QUA_HAN:
        return StatusData(text: S.current.qua_han, color: statusCalenderRed);
    }
  }
}

class NguoiDanModel {
  final String? ngheNghiep;
  final String? ngayThang;
  final String? ten;
  final StatusYKien statusData;

  NguoiDanModel({
    this.ngheNghiep,
    this.ngayThang,
    this.ten,
    required this.statusData,
  });
}

class StatusData {
  String text;
  Color color;

  StatusData({required this.text, required this.color});
}
