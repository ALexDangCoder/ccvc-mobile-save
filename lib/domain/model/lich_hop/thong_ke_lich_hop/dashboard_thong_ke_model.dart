import 'package:ccvc_mobile/utils/constants/image_asset.dart';

class DashBoardThongKeModel {
  String? code;
  String? name;
  int? quantities;

  DashBoardThongKeModel({
    required this.code,
    required this.name,
    required this.quantities,
  });

  String getImageUrl() {
    switch (code) {
      case 'TongSoLich':
        return ImageAssets.tongSoLichHop;
      case 'SoLichHopTrucTuyen':
        return ImageAssets.soLichHopTrucTuyen;
      case 'SoLichHopTrucTiep':
        return ImageAssets.soLichHopTrucTiep;
      default:
        return '';
    }
  }
}
