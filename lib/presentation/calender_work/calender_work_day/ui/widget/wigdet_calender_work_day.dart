import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

final listCalenderWorkDay = [
  CalenderType.tongLichLamViec,
  CalenderType.congTacTrongNuoc,
  CalenderType.lichLamViec,
  CalenderType.lichCongTacNuocNgoai,
  CalenderType.rongA,
  CalenderType.lichTiepDan,
  CalenderType.lichAdminTao,
  CalenderType.rongB
];
enum CalenderType {
  tongLichLamViec,
  congTacTrongNuoc,
  lichLamViec,
  lichCongTacNuocNgoai,
  rongA,
  lichTiepDan,
  lichAdminTao,
  rongB
}

extension MenuTypeItem on CalenderType {
  MenuCellType getItem() {
    switch (this) {
      case CalenderType.tongLichLamViec:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icTongSoLichLamviec,
          ),
          title: S.current.hop,
          content: '',
        );
      case CalenderType.congTacTrongNuoc:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icLichCongTacTrongNuoc,
          ),
          title: S.current.quan_ly_nhiem_vu,
          content: '',
        );
      case CalenderType.lichLamViec:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icLichLamViec,
          ),
          title: S.current.hanh_chinh_cong,
          content: '',
        );
      case CalenderType.lichCongTacNuocNgoai:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icLichCongTacNuocNgoai,
          ),
          title: S.current.y_kien_nguoi_dan,
          content: '',
        );
      case CalenderType.rongA:
        return MenuCellType(url: '', content: '', title: '');
      case CalenderType.lichTiepDan:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icLichTiepDan,
          ),
          title: S.current.quan_ly_van_ban,
          content: '',
        );
      case CalenderType.lichAdminTao:
        return MenuCellType(
          url: urlIconScreen(
            iconTablet: ImageAssets.icAdminTao,
          ),
          title: S.current.bao_chi_mang_xa_hoi,
          content: '',
        );
      case CalenderType.rongB:
        return MenuCellType(url: '', content: '', title: '');
    }
  }

  String urlIconScreen({
    required String iconTablet,
  }) {
    return iconTablet;
  }
}

class MenuCellType {
  final String url;
  final String title;
  final String content;

  MenuCellType({required this.url, required this.title, required this.content});
}
