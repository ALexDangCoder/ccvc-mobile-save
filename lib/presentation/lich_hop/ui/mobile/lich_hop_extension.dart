import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/danh_sach_lich_hop_tablet/danh_sach_lich_hop_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_danh_sach_ngay_tuan_thang_tablet/lich_hop_theo_danh_sach_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_tuan_tablet.dart';
import 'package:flutter/cupertino.dart';
import 'danh_sach_lich_hop/danh_sach_lich_hop.dart';
import 'lich_hop_danh_sach_ngay_tuan_thang/lich_hop_theo_danh_sach_ngay.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_ngay.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_tuan.dart';

enum Type_Choose_Option_Day {
  DAY,
  WEEK,
  MONTH,
}
enum Type_Choose_Option_List {
  DANH_SACH,
  DANG_LICH,
  DANG_LIST,
}

extension lichHopOptionDayCubit on Type_Choose_Option_Day {
  Widget getLichHopStateDangList() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const LichHopTheoDanhSachNgay();
      case Type_Choose_Option_Day.WEEK:
        return const LichHopTheoDanhSachNgay();
      case Type_Choose_Option_Day.MONTH:
        return const LichHopTheoDanhSachNgay();
      default:
        return const SizedBox();
    }
  }

  Widget getLichHopStateDangLich() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const LichHopTheoNgay();
      case Type_Choose_Option_Day.WEEK:
        return const LichHopTheoTuan();
      case Type_Choose_Option_Day.MONTH:
        return const LichHopTheoTuan();
      default:
        return const SizedBox();
    }
  }
}

extension lichHopCubit on LichHopState {
  Widget lichHop() {
    if (this is LichHopStateDangList) {
      return type.getLichHopStateDangList();
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopStateDangLich();
    } else if (this is LichHopStateDangDanhSach) {
      return const DanhSachLichHop();
    } else {
      return const SizedBox();
    }
  }
}

extension lichHopOptionDayCubitTablet on Type_Choose_Option_Day {
  Widget getLichHopStateDangListTablet() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const LichHopTheoDanhSachNgayTablet();
      case Type_Choose_Option_Day.WEEK:
        return const LichHopTheoDanhSachNgayTablet();
      case Type_Choose_Option_Day.MONTH:
        return const LichHopTheoDanhSachNgayTablet();
      default:
        return const SizedBox();
    }
  }

  Widget getLichHopStateDangLichTablet() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const LichHopTheoNgayTablet();
      case Type_Choose_Option_Day.WEEK:
        return const LichHopTheoTuanTablet();
      case Type_Choose_Option_Day.MONTH:
        return const LichHopTheoTuanTablet();
      default:
        return const SizedBox();
    }
  }
}

extension lichHopCubitTablet on LichHopState {
  Widget lichHopTablet() {
    if (this is LichHopStateDangList) {
      return type.getLichHopStateDangListTablet();
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopStateDangLichTablet();
    } else if (this is LichHopStateDangDanhSach) {
      return const DanhSachLichHopTablet();
    } else {
      return const SizedBox();
    }
  }
}
