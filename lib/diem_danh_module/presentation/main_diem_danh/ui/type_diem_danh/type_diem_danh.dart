import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/mobile/diem_danh_ca_nhan_mobile_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/tablet/diem_danh_ca_nhan_tablet_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/ui/mobile/quan_ly_nhan_dien_bien_so_xe_mobile_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_bien_so_xe/ui/tablet/quan_ly_nhan_dien_bien_so_xe_tablet_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/quan_ly_nhan_dien_khuon_mat_mobile_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/tablet/quan_ly_nhan_dien_khuon_mat_tablet_screen.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/widget_item_menu_diem_danh_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/widget/widget_item_menu_diem_danh_tablet.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

enum TypeDiemDanh { CA_NHAN, KHUON_MAT, BIEN_SO_XE }

extension DiemDanhEx on TypeDiemDanh {
  Widget getScreen(DiemDanhCubit cubit) {
    switch (this) {
      case TypeDiemDanh.CA_NHAN:
        return DiemDanhCaNhanMobileScreen(
          cubit: cubit,
        );
      case TypeDiemDanh.KHUON_MAT:
        return QuanLyNhanDienKhuonMatMobileScreen(
          cubit: cubit,
        );
      case TypeDiemDanh.BIEN_SO_XE:
        return QuanLyNhanDienBienSoXeMobileScreen(
          cubit: cubit,
        );
    }
  }

  Widget getScreenTablet(DiemDanhCubit cubit) {
    switch (this) {
      case TypeDiemDanh.CA_NHAN:
        return DiemDanhCaNhanTabletScreen(
          cubit: cubit,
        );
      case TypeDiemDanh.KHUON_MAT:
        return QuanLyNhanDienKhuonMatTabletScreen(
          cubit: cubit,
        );
      case TypeDiemDanh.BIEN_SO_XE:
        return QuanLyNhanDienBienSoXeTabletScreen(
          cubit: cubit,
        );
    }
  }

  bool isState(TypeDiemDanh type) {
    if (this == type) {
      return true;
    }
    return false;
  }
}

extension DiemDanhMenuEx on TypeDiemDanh {
  String get getIconMenu {
    switch (this) {
      case TypeDiemDanh.CA_NHAN:
        return ImageAssets.icDiemDanhCaNhan;
      case TypeDiemDanh.KHUON_MAT:
        return ImageAssets.icDiemDanhKhuonMat;
      case TypeDiemDanh.BIEN_SO_XE:
        return ImageAssets.icDiemDanhBienSoXe;
    }
  }

  String get getTitleMenu {
    switch (this) {
      case TypeDiemDanh.CA_NHAN:
        return S.current.diem_danh_ca_nhan;
      case TypeDiemDanh.KHUON_MAT:
        return S.current.quan_ly_nhan_dien_khuon_mat;
      case TypeDiemDanh.BIEN_SO_XE:
        return S.current.quan_ly_nhan_dien_bien_so_xe;
    }
  }

  Widget getItemMenu({
    required TypeDiemDanh type,
    required TypeDiemDanh selectType,
    required Function onTap,
  }) {
    switch (this) {
      case TypeDiemDanh.CA_NHAN:
        return ItemMenuDiemDanhWidgetMobile(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
      case TypeDiemDanh.KHUON_MAT:
        return ItemMenuDiemDanhWidgetMobile(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
      case TypeDiemDanh.BIEN_SO_XE:
        return ItemMenuDiemDanhWidgetMobile(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
    }
  }

  Widget getItemMenuTablet({
    required TypeDiemDanh type,
    required TypeDiemDanh selectType,
    required Function onTap,
  }) {
    switch (this) {
      case TypeDiemDanh.CA_NHAN:
        return ItemMenuDiemDanhWidgetTablet(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
      case TypeDiemDanh.KHUON_MAT:
        return ItemMenuDiemDanhWidgetTablet(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
      case TypeDiemDanh.BIEN_SO_XE:
        return ItemMenuDiemDanhWidgetTablet(
          onTap: () {
            onTap();
          },
          type: this,
          isSelect: type.isState(selectType),
        );
    }
  }
}