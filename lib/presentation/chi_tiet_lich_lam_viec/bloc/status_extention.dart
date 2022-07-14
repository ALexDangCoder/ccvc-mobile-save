import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

extension StatusCooperative on DonViModel {
  String get getTextStatus {
    switch (status) {
      case 1: return S.current.tham_gia;
      case 2: return S.current.tu_choi;
      default : return S.current.cho_xac_nhan;
    }
  }
  Color get getColorStatus {
    switch (status) {
      case 1: return itemWidgetUsing;
      case 2: return statusCalenderRed;
      default : return color02C5DD;
    }
  }
}
extension OfficersExtension on Officer {
  String get getTextStatus {
    switch (status) {
      case StatusOfficersConst.STATUS_CHO_XAC_NHAN:
        return S.current.cho_xac_nhan;
      case StatusOfficersConst.STATUS_THAM_GIA:
        return S.current.tham_gia;
      case StatusOfficersConst.STATUS_TU_CHOI:
        return S.current.tu_choi;
      case StatusOfficersConst.STATUS_THU_HOI:
        return S.current.thu_hoi;
      default:
        return S.current.cho_xac_nhan;
    }
  }

  Color get getColorStatus {
    switch (status) {
      case StatusOfficersConst.STATUS_CHO_XAC_NHAN:
        return color02C5DD;
      case StatusOfficersConst.STATUS_THAM_GIA:
        return itemWidgetUsing;
      case StatusOfficersConst.STATUS_TU_CHOI:
        return statusCalenderRed;
      case StatusOfficersConst.STATUS_THU_HOI:
        return statusCalenderRed;
      default:
        return color02C5DD;
    }
  }
}

