import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/extension_status.dart';
import 'package:flutter/cupertino.dart';

enum TrangThaiNhiemVu { ChoPhanXuLy, DangThucHien, DaThucHien }

class DanhSachNhiemVuLichHopModel {
  String soNhiemVu = '';
  String noiDungTheoDoi = '';
  String tinhHinhThucHienNoiBo = '';
  String hanXuLy;
  String loaiNhiemVu = '';
  TrangThaiNhiemVu trangThai = TrangThaiNhiemVu.ChoPhanXuLy;

  DanhSachNhiemVuLichHopModel({
    required this.soNhiemVu,
    required this.noiDungTheoDoi,
    required this.tinhHinhThucHienNoiBo,
    required this.hanXuLy,
    required this.loaiNhiemVu,
    required this.trangThai,
  });
}

extension trangThai on TrangThaiNhiemVu {
  Widget getWidgetTTNhiemVu() {
    switch (this) {
      case TrangThaiNhiemVu.ChoPhanXuLy:
        return status(S.current.cho_phan_xu_ly, processingColor);

      case TrangThaiNhiemVu.DangThucHien:
        return status(S.current.dang_thuc_hien, colorPrimary);

      case TrangThaiNhiemVu.DaThucHien:
        return status(S.current.da_thuc_hien, canceledColor);
    }
  }
}
