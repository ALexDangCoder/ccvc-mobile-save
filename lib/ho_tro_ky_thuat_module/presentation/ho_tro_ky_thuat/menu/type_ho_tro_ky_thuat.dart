import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/item_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/item_menu_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/mobile/danh_sach_su_co_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/mobile/thong_tin_chung_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/tablet/danh_sach_su_co_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/tablet/thong_tin_chung_tablet.dart';
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
        return ThongTinChungMobile(
          cubit: cubit,
        );
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return DanhSachSuCoMobile(
          cubit: cubit,
        );
    }
  }

  Widget getScreenTablet(HoTroKyThuatCubit cubit) {
    switch (this) {
      case TypeHoTroKyThuat.THONG_TIN_CHUNG:
        return ThongTinChungTablet(
          cubit: cubit,
        );
      case TypeHoTroKyThuat.DANH_SACH_SU_CO:
        return DanhSachSuCoTablet(
          cubit: cubit,
        );
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
