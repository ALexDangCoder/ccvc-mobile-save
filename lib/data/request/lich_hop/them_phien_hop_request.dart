import 'dart:io';
import 'package:ccvc_mobile/widgets/button/select_file2/select_file_cubit.dart';

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
  List<BytesFileModel>? listFileBytes;

  //sử dụng để xử lý UI
  String? timeEnd;
  String? date;
  String? timeStart;
  String? uuid;

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
    this.listFileBytes,
  });
}
