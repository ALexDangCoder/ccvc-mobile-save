import 'dart:io';

import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/vb_giao_nhiem_vu_widget.dart';

class DanhSachLoaiNhiemVuLichHopModel {
  String? id;
  String? ma;
  bool? nhiemVuChinhPhu;
  String? ten;

  DanhSachLoaiNhiemVuLichHopModel.emty();

  DanhSachLoaiNhiemVuLichHopModel({
    this.id,
    this.ma,
    this.nhiemVuChinhPhu,
    this.ten,
  });
}

class VBGiaoNhiemVuModel {
  List<File>? file;
  String? soVanBan;
  String? ngayVanBan;
  String? trichYeu;
  String? hinhThucVanBan;

  VBGiaoNhiemVuModel.emty();

  VBGiaoNhiemVuModel({
    this.file,
    this.soVanBan,
    this.ngayVanBan,
    this.trichYeu,
    this.hinhThucVanBan,
  });
}
