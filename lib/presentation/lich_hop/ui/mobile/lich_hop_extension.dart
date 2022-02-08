import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
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
