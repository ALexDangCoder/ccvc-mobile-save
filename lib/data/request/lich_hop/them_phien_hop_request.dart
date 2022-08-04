import 'dart:io';

import 'package:dio/src/multipart_file.dart';

class TaoPhienHopRequest {
  String? canBoId;
  String? donViId;
  String thoiGian_BatDau;
  String thoiGian_KetThuc;
  String noiDung;
  String tieuDe;
  String hoTen;
  bool isMultipe;
  List<File>? files;

  //sử dụng để xử lý UI
  String? timeEnd;
  String? date;
  String? timeStart;
  String? uuid;
  List<MultipartFile>? listFileFlatform;

  TaoPhienHopRequest({
    this.canBoId,
    this.donViId,
    required this.thoiGian_BatDau,
    required this.thoiGian_KetThuc,
    this.noiDung = '',
    this.tieuDe = '',
    this.hoTen = '',
    this.isMultipe = false,
    this.files,
  });
}
