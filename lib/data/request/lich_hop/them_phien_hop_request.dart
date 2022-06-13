import 'dart:io';

class TaoPhienHopRequest {
  String? canBoId;
  String? donViId;
  String thoiGian_BatDau;
  String thoiGian_KetThuc;
  String noiDung;
  String tieuDe;
  String hoTen;
  bool IsMultipe;
  List<File>? Files;

  //sử dụng để xử lý UI
  String? timeEnd;
  String? date;
  String? timeStart;

  TaoPhienHopRequest({
    this.canBoId,
    this.donViId,
    required this.thoiGian_BatDau,
    required this.thoiGian_KetThuc,
    this.noiDung = '',
    this.tieuDe = '',
    this.hoTen = '',
    this.IsMultipe = false,
    this.Files,
  });
}
