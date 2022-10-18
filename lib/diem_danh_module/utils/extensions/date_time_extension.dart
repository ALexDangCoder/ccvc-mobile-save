import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:intl/intl.dart';

enum TimeRange { HOM_NAY, TUAN_NAY, THANG_NAY, NAM_NAY }

extension DateFormatString on DateTime {
  String get getMonth => 'Th${this.month.toString().padLeft(2, '0')}';

  String get convertDateTimeApi => toString().replaceFirst(' ', 'T');

  String get formatMonthAndYear {
    final dateString =
        (DateFormat('MM-yyyy').format(this)).replaceAll('-', ' năm ');

    return dateString;
  }
}
