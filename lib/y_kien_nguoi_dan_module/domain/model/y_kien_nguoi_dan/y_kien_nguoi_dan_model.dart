import 'package:ccvc_mobile/utils/constants/image_asset.dart';

class DanhSachYKienNguoiDan {
  List<YKienNguoiDanModel> listYKienNguoiDan;

  DanhSachYKienNguoiDan({required this.listYKienNguoiDan});
}

class YKienNguoiDanModel {
  String? id;
  String? tieuDe;
  String? ngayNhan;
  String? tenNguoiPhanAnh;
  int? soNgayToiHan;
  String? taskID;

  YKienNguoiDanModel({
    this.id,
    this.tieuDe,
    this.ngayNhan,
    this.tenNguoiPhanAnh,
    this.soNgayToiHan,
    this.taskID,
  });
}

class ImageThongTinYKienNguoiDan {
  String imgChoDuyet = ImageAssets.icChoDuyetYKND;
  String imgChoTiepNhanXuLy = ImageAssets.ic_cho_tiep_nhan_xu_ly;
  String imgChoBoSungThongTin = ImageAssets.ic_cho_cho_bo_sung_y_kien;
  String imgChoTiepNhan = ImageAssets.ic_cho_tiep_nhan;
  String imgChoPhanCongXuLy = ImageAssets.ic_cho_phan_cong_xu_ly;
  String imgChoChoYKien = ImageAssets.ic_cho_cho_y_kien;
  String imgChoChoXuLy = ImageAssets.ic_cho_xu_ly_yknd;
  String imgTongSoYkND = ImageAssets.ic_tong_so_yknd;
}
