import 'package:ccvc_mobile/utils/constants/app_constants.dart';

const _MUA_XUAN = 'MUA_XUAN';
const _MUA_HA = 'MUA_HA';
const _MUA_THU = 'MUA_THU';
const _MUA_DONG = 'MUA_DONG';
const _TET_NGUYEN_DAN = 'TET_NGUYEN_DAN';
const _LE_TINH_NHAN = 'LE_TINH_NHAN';
const _NGAY_QUOC_TE_PHU_NU = 'NGAY_QUOC_TE_PHU_NU';
const _GIO_TO_HUNG_VUONG = 'GIO_TO_HUNG_VUONG';
const _NGAY_QUOC_TE_LAO_DONG = 'NGAY_QUOC_TE_LAO_DONG';
const _NGAY_QUOC_TE_THIEU_NHI = 'NGAY_QUOC_TE_THIEU_NHI';
const _NGAY_QUOC_KHANH = 'NGAY_QUOC_KHANH';
const _TET_TRUNG_THU = 'TET_TRUNG_THU';
const _NGAY_PHU_NU_VIET_NAM = 'NGAY_PHU_NU_VIET_NAM';
const _NGAY_LE_GIANG_SINH = 'NGAY_LE_GIANG_SINH';
const _NGAY_HALLOWEEN = 'NGAY_HALLOWEEN';
const _NGAY_NHA_GIAO_VIET_NAM = 'NGAY_NHA_GIAO_VIET_NAM';
const _MAC_DINH = 'MAC_DINH';
const _MAU_XANH = 'MAU_XANH';
const _MAU_HONG = 'MAU_HONG';
const _MAU_VANG = 'MAU_VANG';

class AppThemModel {
  AppMode? appMode;
  AppBackGround? appBackGround;

  AppThemModel({this.appMode, this.appBackGround});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_theme'] = appMode?._getCode();
    data['app_back_ground'] = appBackGround?._getCode();
    return data;
  }

  AppThemModel.fromJson(Map<String, dynamic> json) {
    appMode = json['app_theme']?.toString()._coverAppMode() ?? AppMode.MAC_DINH;
    appBackGround =
        json['app_back_ground']?.toString()._fromEnumAppBackGround();
  }
}

extension AppBackGroundEx on AppBackGround {
  String _getCode() {
    switch (this) {
      case AppBackGround.XUAN:
        return _MUA_XUAN;
      case AppBackGround.HA:
        return _MUA_HA;
      case AppBackGround.THU:
        return _MUA_THU;
      case AppBackGround.DONG:
        return _MUA_DONG;
      case AppBackGround.TET_NGUYEN_DAN:
        return _TET_NGUYEN_DAN;
      case AppBackGround.LE_TINH_NHAN:
        return _LE_TINH_NHAN;
      case AppBackGround.NGAY_QUOC_TE_PHU_NU:
        return _NGAY_QUOC_TE_PHU_NU;

      case AppBackGround.GIO_TO_HUNG_VUONG:
        return _GIO_TO_HUNG_VUONG;

      case AppBackGround.NGAY_QUOC_TE_LAO_DONG:
        return _NGAY_QUOC_TE_LAO_DONG;

      case AppBackGround.NGAY_QUOC_TE_THIEU_NHI:
        return _NGAY_QUOC_TE_THIEU_NHI;

      case AppBackGround.NGAY_QUOC_KHANH:
        return _NGAY_QUOC_KHANH;

      case AppBackGround.TET_TRUNG_THU:
        return _TET_TRUNG_THU;

      case AppBackGround.NGAY_PHU_NU_VIET_NAM:
        return _NGAY_PHU_NU_VIET_NAM;

      case AppBackGround.NGAY_LE_GIANG_SINH:
        return _NGAY_LE_GIANG_SINH;
      case AppBackGround.NGAY_HALLOWEEN:
        return _NGAY_HALLOWEEN;

      case AppBackGround.NGAY_NHA_GIAO_VIET_NAM:
        return _NGAY_NHA_GIAO_VIET_NAM;
    }
  }
}

extension StringCover on String {
  AppBackGround? _fromEnumAppBackGround() {
    switch (this) {
      case _MUA_XUAN:
        return AppBackGround.XUAN;
      case _MUA_HA:
        return AppBackGround.HA;
      case _MUA_THU:
        return AppBackGround.THU;
      case _MUA_DONG:
        return AppBackGround.DONG;
      case _TET_NGUYEN_DAN:
        return AppBackGround.TET_NGUYEN_DAN;
      case _LE_TINH_NHAN:
        return AppBackGround.LE_TINH_NHAN;
      case _NGAY_QUOC_TE_PHU_NU:
        return AppBackGround.NGAY_QUOC_TE_PHU_NU;

      case _GIO_TO_HUNG_VUONG:
        return AppBackGround.GIO_TO_HUNG_VUONG;

      case _NGAY_QUOC_TE_LAO_DONG:
        return AppBackGround.NGAY_QUOC_TE_LAO_DONG;

      case _NGAY_QUOC_TE_THIEU_NHI:
        return AppBackGround.NGAY_QUOC_TE_THIEU_NHI;

      case _NGAY_QUOC_KHANH:
        return AppBackGround.NGAY_QUOC_KHANH;

      case _TET_TRUNG_THU:
        return AppBackGround.TET_TRUNG_THU;

      case _NGAY_PHU_NU_VIET_NAM:
        return AppBackGround.NGAY_PHU_NU_VIET_NAM;

      case _NGAY_LE_GIANG_SINH:
        return AppBackGround.NGAY_LE_GIANG_SINH;
      case _NGAY_HALLOWEEN:
        return AppBackGround.NGAY_HALLOWEEN;

      case _NGAY_NHA_GIAO_VIET_NAM:
        return AppBackGround.NGAY_NHA_GIAO_VIET_NAM;
    }
  }

  AppMode _coverAppMode() {
    switch (this) {
      case _MAC_DINH:
        return AppMode.MAC_DINH;
      case _MAU_XANH:
        return AppMode.XANH;
      case _MAU_HONG:
        return AppMode.HONG;
      case _MAU_VANG:
        return AppMode.VANG;
    }
    return AppMode.MAC_DINH;
  }
}

extension AppModeEx on AppMode {
  String _getCode() {
    switch (this) {
      case AppMode.MAC_DINH:
        return _MAC_DINH;
      case AppMode.XANH:
        return _MAU_XANH;
      case AppMode.HONG:
        return _MAU_HONG;
      case AppMode.VANG:
        return _MAU_VANG;
    }
  }
}
