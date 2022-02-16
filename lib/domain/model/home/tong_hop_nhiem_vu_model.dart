enum TongHopNhiemVuType {
  tongSoNV,
  hoanThanhNhiemVu,
  nhiemVuDangThucHien,
  nhiem
}

class TongHopNhiemVuModel {
  final String code;
  final String name;
  final int value;

  TongHopNhiemVuModel({
    required this.code,
    required this.name,
    required this.value,
  });
}
