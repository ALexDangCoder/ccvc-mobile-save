import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/themes/app_theme.dart';

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

