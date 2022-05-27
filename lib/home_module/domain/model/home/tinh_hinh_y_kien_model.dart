import 'package:flutter/cupertino.dart';

import '/home_module//config/resources/color.dart';

class TinhHinhYKienModel {
  final String status;
  final int soLuong;

  TinhHinhYKienModel({this.soLuong = 0, this.status = ''});

  static List<Color> listColor = [
    choVaoSoColor,
    statusCalenderRed,
    itemWidgetUsing
  ];
}
