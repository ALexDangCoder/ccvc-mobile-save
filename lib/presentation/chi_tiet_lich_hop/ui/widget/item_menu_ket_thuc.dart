import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/tao_moi_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';

enum KetThuc { taomoinv, ketluanch, guimail, thuhoi, xoa }

List<KetThucView> listKetThucView = [
  KetThucView(
    ImageAssets.icPlus2,
    S.current.tao_moi_nhiem_vu,
    KetThuc.taomoinv,
  ),
  KetThucView(
    ImageAssets.icMessage,
    S.current.gui_mail_ket_luan,
    KetThuc.ketluanch,
  ),
<<<<<<< HEAD
  KetThucView(ImageAssets.icDocument2, S.current.gui_email, KetThuc.guimail),
=======
  KetThucView(ImageAssets.icMessage, S.current.gui_email, KetThuc.guimail),
>>>>>>> develop
  KetThucView(ImageAssets.Group2, S.current.thu_hoi, KetThuc.thuhoi),
  KetThucView(ImageAssets.icDeleteRed, S.current.xoa, KetThuc.xoa),
];

extension GetScreen on KetThuc {
  Widget getScreen() {
    switch (this) {
      case KetThuc.taomoinv:
        return const TaoMoiNhiemVuWidget();

      case KetThuc.ketluanch:
        return Container();

      case KetThuc.guimail:
        return Container();

      case KetThuc.thuhoi:
        return Container();

      case KetThuc.xoa:
        return Container();
    }
  }

  Widget getScreenTablet() {
    switch (this) {
      case KetThuc.taomoinv:
        return const TaoMoiNhiemVuWidget();
      case KetThuc.ketluanch:
        return Container();

      case KetThuc.guimail:
        return Container();

      case KetThuc.thuhoi:
        return Container();

      case KetThuc.xoa:
        return Container();
    }
  }
}

class KetThucView {
  String icon;
  String name;
  KetThuc ketThuc;

  KetThucView(this.icon, this.name, this.ketThuc);
}
