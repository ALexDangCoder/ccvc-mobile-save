import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/ket_thuc_widget/tao_moi_nhiem_vu_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/phan_cong_thu_ky.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/tao_boc_bang_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/thu_hoi_lich_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';

enum KetThuc {
  taomoinv,
  ketluanch,
  guimail,
  thuhoi,
  xoa,
}

enum ChiTietLichHop {
  huyLichHop,
  xoaLich,
  suaLich,
  thuhoi,
  phanCongThuKy,
  taoBocBang
}

List<KetThucView> listKetThucView = [
  KetThucView(
    ImageAssets.icPlusBlu,
    S.current.tao_moi_nhiem_vu,
    KetThuc.taomoinv,
  ),
  KetThucView(
    ImageAssets.icDocumentEnd,
    S.current.gui_mail_ket_luan,
    KetThuc.ketluanch,
  ),
  KetThucView(ImageAssets.icMessYealow, S.current.gui_email, KetThuc.guimail),
  KetThucView(ImageAssets.icSync, S.current.thu_hoi, KetThuc.thuhoi),
  KetThucView(ImageAssets.icDeleteRed, S.current.xoa, KetThuc.xoa),
];

List<MenuChiTietLichHopView> listChiTietLichHop = [
  MenuChiTietLichHopView(
    ImageAssets.icCloseSquare2,
    S.current.huy_lich_hop,
    ChiTietLichHop.huyLichHop,
  ),
  MenuChiTietLichHopView(
      ImageAssets.icDelete2, S.current.xoa_lich, ChiTietLichHop.xoaLich),
  MenuChiTietLichHopView(
      ImageAssets.icEdit2, S.current.sua_lich, ChiTietLichHop.suaLich),
  MenuChiTietLichHopView(
      ImageAssets.icSync, S.current.thu_hoi, ChiTietLichHop.thuhoi),
  MenuChiTietLichHopView(ImageAssets.icSwap, S.current.phan_cong_thu_ky,
      ChiTietLichHop.phanCongThuKy),
  MenuChiTietLichHopView(ImageAssets.icVideos, S.current.tao_boc_bang_cuoc_hop,
      ChiTietLichHop.taoBocBang),
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

extension GetScreenChiTietLichHop on ChiTietLichHop {


  Widget getScreenChiTietLichHop() {
    switch (this) {
      case ChiTietLichHop.huyLichHop:
        return Container();

      case ChiTietLichHop.xoaLich:
        return Container();

      case ChiTietLichHop.suaLich:
        return Container();

      case ChiTietLichHop.thuhoi:
        return const ThuHoiLichWidget();

      case ChiTietLichHop.phanCongThuKy:
        return const PhanCongThuKyWidget();

      case ChiTietLichHop.taoBocBang:
        return const TaoBocBangWidget();
    }
  }
}

class KetThucView {
  String icon;
  String name;
  KetThuc ketThuc;

  KetThucView(this.icon, this.name, this.ketThuc);
}

class MenuChiTietLichHopView {
  String icon;
  String name;
  ChiTietLichHop chiTietLichHop;

  MenuChiTietLichHopView(this.icon, this.name, this.chiTietLichHop);
}
