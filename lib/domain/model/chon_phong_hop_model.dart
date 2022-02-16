enum LoaiPhongHopEnum { PHONG_HOP_THUONG, PHONG_TRUNG_TAM_DIEU_HANH }

class ChonPhongHopModel {
  final LoaiPhongHopEnum loaiPhongHopEnum;
  final List<ThietBiValue> listThietBi;
  final String yeuCauKhac;

  ChonPhongHopModel({
    required this.loaiPhongHopEnum,
    required this.listThietBi,
    required this.yeuCauKhac,
  });
}

class ThietBiValue {
  final String tenThietBi;
  final int soLuong;

  ThietBiValue({required this.tenThietBi, required this.soLuong});
}
