import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

enum CalendarType { DAY, WEEK, MONTH }

extension CalendarExtension on CalendarType {
  CalendarIcon getIcon() {
    switch (this) {
      case CalendarType.DAY:
        return CalendarIcon(
          icon: ImageAssets.icCalenderDay,
          title: S.current.ngay,
        );
      case CalendarType.WEEK:
        return CalendarIcon(
          icon: ImageAssets.icDayCalenderWeek,
          title: S.current.tuan,
        );
      case CalendarType.MONTH:
        return CalendarIcon(
          icon: ImageAssets.icDayCalenderMonth,
          title: S.current.thang,
        );
    }
  }
}

class CalendarIcon {
  final String title;
  final String icon;

  CalendarIcon({required this.title, required this.icon});
}
