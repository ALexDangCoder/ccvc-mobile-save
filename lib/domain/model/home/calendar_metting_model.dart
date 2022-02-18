import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

class CalendarMeetingModel {
  final String title;
  final String time;
  final String address;
  final String nguoiChuTri;
  final DocumentStatus codeStatus;
  final String loaiNhiemVu;
  final String hanXuLy;
  final String id;
  final String maTrangThai;
  final String dataTimeFrom;
  final String dateTimeTo;
  final String timeFrom;
  final String timeTo;
  CalendarMeetingModel(
      {this.title = '',
      this.time = '',
      this.address = '',
      this.codeStatus = DocumentStatus.CHO_PHAN_XU_LY,
      this.nguoiChuTri = '',
      this.hanXuLy = '',
      this.loaiNhiemVu = '',
      this.id = '',
      this.maTrangThai = '',
      this.dataTimeFrom = '',
      this.dateTimeTo = '',
      this.timeFrom = '',
      this.timeTo = ''});

  String convertTime() {
    String time = '';
    try {
      DateTime startDate = DateTime.parse(dataTimeFrom);
      DateTime endDate = DateTime.parse(dateTimeTo);
      if (startDate.toStringWithListFormat == endDate.toStringWithListFormat) {
        time = '${startDate.toStringWithListFormat} $timeFrom - $timeTo';
      } else {
        return '${startDate.toStringWithListFormat} - ${endDate.toStringWithListFormat}';
      }
    } catch (err) {
      return '';
    }
    return time;
  }
}
