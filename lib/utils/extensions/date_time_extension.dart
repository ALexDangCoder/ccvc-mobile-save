import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:intl/intl.dart';

extension DateFormatString on DateTime {
  String get toStringWithAMPM {
    final dateString = DateFormat.jm('en').format(this);
    return dateString;
  }

  String get formatDdMMYYYY {
    final dateString =
        DateFormat('dd/MM/yyyy ').format(this) + toStringWithAMPM;
    return dateString;
  }

  String get toStringWithListFormat {
    final dateString = DateFormat('dd/MM/yyyy').format(this);
    return dateString;
  }

  String get formatDateTime {
    final dateString = (DateFormat('HH:mm ,dd-MM').format(this))
        .replaceAll('-', ' tháng ');

    return dateString;
  }

  String getDayofWeekTxt() {
    switch (weekday) {
      case 1:
        return S.current.thu_hai;
      case 2:
        return S.current.thu_ba;
      case 3:
        return S.current.thu_tu;
      case 4:
        return S.current.thu_nam;
      case 5:
        return S.current.thu_sau;
      case 6:
        return S.current.thu_bay;
      case 7:
        return S.current.chu_nhat;
    }
    return '';
  }
}
