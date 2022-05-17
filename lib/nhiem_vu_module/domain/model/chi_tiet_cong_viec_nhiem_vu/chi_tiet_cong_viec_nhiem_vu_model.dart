import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/string_extension.dart';

class ChiTietCongViecNhiemVuModel {
  String? hanXuLy;
  String? tenDonViThucHien;
  String? tenNguoiThucHien;
  String? donViCaNhanThucHien;
  String? noiDung;
  String? tenNguoiGiao;
  String? tenDonViGiaoViec;
  String? maTrangThai;
  String? trangThai;
  String? mucDoCongViec;
  List<String>? danhSachCVLQ;

  ChiTietCongViecNhiemVuModel({
    this.hanXuLy,
    this.tenDonViThucHien,
    this.tenNguoiThucHien,
    this.donViCaNhanThucHien,
    this.noiDung,
    this.tenNguoiGiao,
    this.tenDonViGiaoViec,
    this.maTrangThai,
    this.trangThai,
    this.danhSachCVLQ,
    this.mucDoCongViec,
  });

  List<ChiTietCongViecNhiemVuRow> toListMobile() {
    final List<ChiTietCongViecNhiemVuRow> list = [
      ChiTietCongViecNhiemVuRow(
        S.current.don_vi_giao_viec,
        tenDonViGiaoViec ?? '',
      ),
      ChiTietCongViecNhiemVuRow(
        S.current.nguoi_giao_viec,
        tenNguoiGiao ?? '',
      ),
      ChiTietCongViecNhiemVuRow(
        S.current.don_vi_thuc_hien,
        tenDonViThucHien ?? '',
      ),
      ChiTietCongViecNhiemVuRow(
        S.current.nguoi_thuc_hien,
        tenNguoiThucHien ?? '',
      ),
      ChiTietCongViecNhiemVuRow(
        S.current.han_xu_ly,
        hanXuLy ?? '',
      ),
      ChiTietCongViecNhiemVuRow(
          S.current.muc_do_cong_viec, mucDoCongViec ?? ''),
      ChiTietCongViecNhiemVuRow(S.current.noi_dung, noiDung?.parseHtml() ?? ''),
      ChiTietCongViecNhiemVuRow(
          S.current.cong_viec_lien_quan, danhSachCVLQ ?? ''),
    ];
    return list;
  }
}

class ChiTietCongViecNhiemVuRow {
  String title = '';
  dynamic value;

  ChiTietCongViecNhiemVuRow(this.title, this.value);
}
