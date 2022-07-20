import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/file_upload_model.dart';

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
  List<FileUploadModel> file;
  String? soVanBan;
  String? ngayVanBan;
  String? trichYeu;
  String? hinhThucVanBan;

  VBGiaoNhiemVuModel({
    this.file = const [],
    this.soVanBan,
    this.ngayVanBan,
    this.trichYeu,
    this.hinhThucVanBan,
  });
}
