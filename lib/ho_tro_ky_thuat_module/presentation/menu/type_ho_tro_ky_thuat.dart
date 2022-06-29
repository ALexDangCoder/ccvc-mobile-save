import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/mobile/ho_tro_ky_thuat_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/tablet/ho_tro_ky_thuat_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/menu/item_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/menu/item_menu_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

enum TypeHoTroKyThuat {
  THONG_TIN_CHUNG,
  DANH_SACH_SU_CO,
}

extension HoTroKyThuatEx on TypeHoTroKyThuat {
  Widget getScreen(HoTroKyThuatCubit cubit) {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return const HoTroKyThuatMobile();
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return const Scaffold(); //todo
    }
  }

  Widget getScreenTablet(HoTroKyThuatCubit cubit) {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return const HoTroKyThuatTablet();
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return const Scaffold(); //todo
    }
  }

  bool isState(TypeHoTroKyThuat type) {
    if (this == type) {
      return true;
    }
    return false;
  }
}

extension HoTroKyThuatMenuEx on TypeHoTroKyThuat {
  String get getIconMenu {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return ImageAssets.ic_info_circle;
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return ImageAssets.ic_document;
    }
  }

  String get getTitleMenu {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return S.current.thong_tin_chung;
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return S.current.danh_sach_su_co;
    }
  }

  Widget getItemMenu({
    required TypeHoTroKyThuat type,
    required TypeHoTroKyThuat selectType,
    required Function onTap,
  }) {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return ItemMenuMobile(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return ItemMenuMobile(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
    }
  }

  Widget getItemMenuTablet({
    required TypeHoTroKyThuat type,
    required TypeHoTroKyThuat selectType,
    required Function onTap,
  }) {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return ItemMenuTablet(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return ItemMenuTablet(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
    }
  }
}
