

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/cupertino.dart';

class TinhHinhYKienModel {
  final String status;
  final int soLuong;

  TinhHinhYKienModel({this.soLuong = 0, this.status = ''});
  static List<Color> listColor =[
    choVaoSoColor,
    statusCalenderRed,
    itemWidgetUsing
  ];
}
