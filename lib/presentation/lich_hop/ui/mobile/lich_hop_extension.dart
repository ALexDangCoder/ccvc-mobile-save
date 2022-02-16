import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/danh_sach_lich_hop_tablet/danh_sach_lich_hop_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_danh_sach_ngay_tuan_thang_tablet/lich_hop_theo_danh_sach_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_ngay_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_thang_tablet.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/tablet/lich_hop_theo_ngay_tuan_thang_tablet/lich_hop_theo_tuan_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'danh_sach_lich_hop/danh_sach_lich_hop.dart';
import 'lich_hop_danh_sach_ngay_tuan_thang/lich_hop_theo_danh_sach_ngay.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_ngay.dart';
import 'lich_hop_theo_ngay_tuan_thang/lich_hop_theo_thang.dart';
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
        return const LichHopTheoThang();
      default:
        return const SizedBox();
    }
  }
  Widget getLichHopStateDanhSach() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const DanhSachLichHop();
      case Type_Choose_Option_Day.WEEK:
        return const DanhSachLichHop();
      case Type_Choose_Option_Day.MONTH:
        return const DanhSachLichHop();
      default:
        return const SizedBox();
    }
  }
  // icons
  Widget getLichHopIconsMobile() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return SvgPicture.asset(
          ImageAssets.icCalenderDayBig,
        );
      case Type_Choose_Option_Day.WEEK:
        return SvgPicture.asset(
          ImageAssets.icCalenderWeekBig,
        );
      case Type_Choose_Option_Day.MONTH:
        return SvgPicture.asset(
          ImageAssets.icCalenderMonthBig,
        );
      default:
        return Container();
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
      return type.getLichHopStateDanhSach();
    } else {
      return const SizedBox();
    }
  }
  Widget lichLamViecIconsMobile() {
    if (this is LichHopStateDangList) {
      return type.getLichHopIconsMobile();
    } else if (this is LichHopStateDangLich) {
      return type.getLichHopIconsMobile();
    }else if (this is LichHopStateDangDanhSach) {
      return type.getLichHopIconsMobile();
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
        return const LichHopTheoThangTablet();
      default:
        return const SizedBox();
    }
  }
  Widget getLichHopStateDanhSachTablet() {
    switch (this) {
      case Type_Choose_Option_Day.DAY:
        return const DanhSachLichHopNgayTablet();
      case Type_Choose_Option_Day.WEEK:
        return const DanhSachLichHopNgayTablet();
      case Type_Choose_Option_Day.MONTH:
        return const DanhSachLichHopNgayTablet();
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
      return type.getLichHopStateDanhSachTablet();
    } else {
      return const SizedBox();
    }
  }
}
