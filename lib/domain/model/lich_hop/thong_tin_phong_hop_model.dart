import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

const _CHO_DUYET = 0;
const _DA_DUYET = 1;
enum TrangThaiPhongHop { CHO_DUYET, DA_DUYET }

extension TrangThaiPhongHopEX on TrangThaiPhongHop {
  String getText() {
    switch (this) {
      case TrangThaiPhongHop.CHO_DUYET:
        return S.current.cho_duyet;
      case TrangThaiPhongHop.DA_DUYET:
        return S.current.da_duyet;
    }
  }

  Color getColor() {
    switch (this) {
      case TrangThaiPhongHop.CHO_DUYET:
        return itemWidgetNotUse;
      case TrangThaiPhongHop.DA_DUYET:
        return itemWidgetUsing;
    }
  }
}

class ThongTinPhongHopModel {
  String? id;
  String? sucChua;
  String? diaDiem;
  int? trangThai;
  String? thietBiSanCo;
  String? tenPhong;
  TrangThaiPhongHop trangThaiPhongHop = TrangThaiPhongHop.DA_DUYET;
  ThongTinPhongHopModel({
    this.id = '',
    this.sucChua = '0',
    this.diaDiem = '',
    this.trangThai,
    this.thietBiSanCo,
    this.tenPhong,
  }) {
    trangThaiPhongHop = fromEnum();
  }
  TrangThaiPhongHop fromEnum() {
    switch (trangThai) {
      case _CHO_DUYET:
        return TrangThaiPhongHop.CHO_DUYET;
      case _DA_DUYET:
        return TrangThaiPhongHop.DA_DUYET;
    }
    return TrangThaiPhongHop.CHO_DUYET;
  }
}

class ThietBiPhongHopModel {
  String? loaiThietBi;
  String? soLuong;
  int? trangThai;
  TrangThaiPhongHop trangThaiPhongHop = TrangThaiPhongHop.DA_DUYET;
  ThietBiPhongHopModel({
    this.loaiThietBi = '',
    this.soLuong = '0',
    this.trangThai = 0,
  }) {
    trangThaiPhongHop = fromEnum();
  }
  TrangThaiPhongHop fromEnum() {
    switch (trangThai) {
      case _CHO_DUYET:
        return TrangThaiPhongHop.CHO_DUYET;
      case _DA_DUYET:
        return TrangThaiPhongHop.DA_DUYET;
    }
    return TrangThaiPhongHop.CHO_DUYET;
  }
}
