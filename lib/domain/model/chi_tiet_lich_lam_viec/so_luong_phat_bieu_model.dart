import 'dart:ui';

class SoLuongPhatBieuModel {
  int danhSachPhatBieu;
  int choDuyet;
  int daDuyet;
  int huyDuyet;

  SoLuongPhatBieuModel({
    this.danhSachPhatBieu = 0,
    this.choDuyet = 0,
    this.daDuyet = 0,
    this.huyDuyet = 0,
  });
}

class ButtonStatePhatBieu {
  String? key;
  int? value;
  Color? color;

  ButtonStatePhatBieu({this.key, this.value, this.color});
}
