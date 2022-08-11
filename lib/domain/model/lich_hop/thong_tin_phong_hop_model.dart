import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

const _CHO_DUYET = 0;
const _DA_DUYET = 1;
const _HUY_DUYET = 2;

enum TrangThaiPhongHop { CHO_DUYET, DA_DUYET, HUY_DUYET }

extension TrangThaiPhongHopEX on TrangThaiPhongHop {
  String getText() {
    switch (this) {
      case TrangThaiPhongHop.CHO_DUYET:
        return S.current.cho_duyet;
      case TrangThaiPhongHop.DA_DUYET:
        return S.current.da_duyet;
      case TrangThaiPhongHop.HUY_DUYET:
        return S.current.huy_duyet;
    }
  }

  Color getColor() {
    switch (this) {
      case TrangThaiPhongHop.CHO_DUYET:
        return itemWidgetNotUse;
      case TrangThaiPhongHop.DA_DUYET:
        return itemWidgetUsing;
      case TrangThaiPhongHop.HUY_DUYET:
        return colord32f2f;
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
  String? lichHopPhongHopId;
  String? noiDungYeuCau;
  String? tenTrangThai;
  String? ghiChu;
  String? trangThaiChuanBiId;
  String? trangThaiChuanBi;

  ThongTinPhongHopModel({
    this.id = '',
    this.sucChua = '0',
    this.diaDiem = '',
    this.trangThai,
    this.thietBiSanCo,
    this.tenPhong,
    this.lichHopPhongHopId,
    this.noiDungYeuCau,
    this.tenTrangThai,
    this.ghiChu,
    this.trangThaiChuanBiId,
    this.trangThaiChuanBi,
  }) {
    trangThaiPhongHop = fromEnum();
  }

  Color getColor(String? status) {
    if (status == S.current.chua_thuc_hien) {
      return textColorForum;
    } else {
      return greenChart;
    }
  }

  TrangThaiPhongHop fromEnum() {
    switch (trangThai) {
      case _CHO_DUYET:
        return TrangThaiPhongHop.CHO_DUYET;
      case _DA_DUYET:
        return TrangThaiPhongHop.DA_DUYET;
      case _HUY_DUYET:
        return TrangThaiPhongHop.HUY_DUYET;
    }
    return TrangThaiPhongHop.CHO_DUYET;
  }

  PhongHopModel convertToPhongHopModel({
    required bool isTTDH,
    required int trangThai,
    required List<ThietBiModel> listThietBi,
  }) {
    return PhongHopModel(
      sucChua: int.parse(sucChua ?? '0'),
      bit_TTDH: isTTDH,
      diaChi: diaDiem ?? '',
      donViDuyetId: '',
      ten: tenPhong ?? '',
      id: id ?? '',
      trangThai: trangThai,
      listThietBi: listThietBi,
    );
  }
}

class ThietBiPhongHopModel {
  String? loaiThietBi;
  String? soLuong;
  int? trangThai;
  TrangThaiPhongHop trangThaiPhongHop = TrangThaiPhongHop.DA_DUYET;
  String id;

  ThietBiPhongHopModel({
    this.loaiThietBi = '',
    this.soLuong = '0',
    this.trangThai = 0,
    this.id = '',
  }) {
    trangThaiPhongHop = fromEnum();
  }

  TrangThaiPhongHop fromEnum() {
    switch (trangThai) {
      case _CHO_DUYET:
        return TrangThaiPhongHop.CHO_DUYET;
      case _DA_DUYET:
        return TrangThaiPhongHop.DA_DUYET;
      case _HUY_DUYET:
        return TrangThaiPhongHop.HUY_DUYET;
    }
    return TrangThaiPhongHop.CHO_DUYET;
  }
}

class PhienHopModel {
  String? canBoId;
  String? donViId;
  String? hoTen;
  String? id;
  String? lichHopId;
  String? noiDung;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  int? thuTu;
  String? tieuDe;
  int? trangThai;

  PhienHopModel({
    this.canBoId,
    this.donViId,
    this.hoTen,
    this.id,
    this.lichHopId,
    this.noiDung,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.thuTu,
    this.tieuDe,
    this.trangThai,
  });

  PhienHopModel.empty();

  factory PhienHopModel.fromJson(Map<String, dynamic> json) {
    return PhienHopModel(
      canBoId: json['CanBoId'],
      donViId: json['DonViId'],
      hoTen: json['HoTen'],
      id: json['Id'],
      lichHopId: json['LichHopId'],
      noiDung: json['NoiDung'],
      thoiGianBatDau: json['ThoiGian_BatDau'],
      thoiGianKetThuc: json['ThoiGian_KetThuc'],
      thuTu: json['ThuTu'],
      tieuDe: json['TieuDe'],
      trangThai: json['TrangThai'],
    );
  }
}
