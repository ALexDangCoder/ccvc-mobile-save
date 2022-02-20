import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/lich_duoc_moi/lich_duoc_moi_phone_screen.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/lich_duoc_moi/lich_duoc_moi_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/lich_tao_ho/lich_tao_ho_tablet_screen.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'mobile/menu/lich_tao_ho/lich_tao_ho_phone_screen.dart';

class ItemThongBao {
  String name;
  int index;
  Function(BuildContext context, CalenderCubit cubit) navigator;

  ItemThongBao({
    required this.name,
    required this.index,
    required this.navigator,
  });
}

List<ItemThongBao> lichTheoTrangThai = [
  ItemThongBao(
    name: S.current.lich_duoc_moi,
    index: 12,
    navigator: (context, cubit) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screenDevice(
            mobileScreen: LichDuocMoiPhoneScreen(
              cubit: cubit,
            ),
            tabletScreen: LichDuocMoiTabletScreen(
              cubit: cubit,
            ),
          ),
        ),
      );
    },
  ),
  ItemThongBao(
    name: S.current.lich_tao_ho,
    index: 12,
    navigator: (context, cubit) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => screenDevice(
                  mobileScreen: LichTaoHoPhoneScreen(
                    cubit: cubit,
                  ),
                  tabletScreen: LichTaoHoTabletScreen(
                    cubit: cubit,
                  ),
                )),
      );
    },
  ),
  ItemThongBao(
    name: S.current.lich_huy,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.lich_thu_hoi,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.lich_da_co_bao_cao,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.lich_chua_co_bao_cao,
    index: 12,
    navigator: (context, cubit) {},
  ),
];

List<ItemThongBao> lichLanhDao = [
  ItemThongBao(
    name: S.current.lanh_dao_ubnd_tinh,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.van_phong_ubnd_tinh,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.so_ke_hoach_va_dau_tu,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.so_noi_vu,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.phong_tai_chinh_noi_chinh,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.phong_kinh_te_nghanh,
    index: 12,
    navigator: (context, cubit) {},
  ),
  ItemThongBao(
    name: S.current.so_tai_chinh,
    index: 12,
    navigator: (context, cubit) {},
  ),
];
