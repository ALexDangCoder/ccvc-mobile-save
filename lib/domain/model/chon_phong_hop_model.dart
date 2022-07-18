import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';

enum LoaiPhongHopEnum { PHONG_HOP_THUONG, PHONG_TRUNG_TAM_DIEU_HANH }

class ChonPhongHopModel {
  final LoaiPhongHopEnum loaiPhongHopEnum;
  final List<ThietBiValue> listThietBi;
  final String yeuCauKhac;
  final PhongHop? phongHop;

  ChonPhongHopModel({
    required this.loaiPhongHopEnum,
    required this.listThietBi,
    required this.yeuCauKhac,
    this.phongHop,
  });
}

class ThietBiValue {
  final String tenThietBi;
  final int soLuong;

  String get convertToString => '$tenThietBi ($soLuong)';

  ThietBiValue({required this.tenThietBi, required this.soLuong});
}
