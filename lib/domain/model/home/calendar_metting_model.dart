import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

const _CHUA_THUC_HIEN = 'CHUA_THUC_HIEN';
const _DANG_THUC_HIEN = 'DANG_THUC_HIEN';

class CalendarMeetingModel {
  final String title;
  final String time;
  final String address;
  final String nguoiChuTri;
  DocumentStatus codeStatus;
  final String loaiNhiemVu;
  final String hanXuLy;
  final String id;
  final String maTrangThai;
  final String dataTimeFrom;
  final String dateTimeTo;
  final String timeFrom;
  final String timeTo;
  final bool isHopTrucTuyen;
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
      this.timeTo = '',
      this.isHopTrucTuyen = false
      }) {
    codeStatus = fromEnum();
  }

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

  DocumentStatus fromEnum() {
    switch (maTrangThai) {
      case _CHUA_THUC_HIEN:
        return DocumentStatus.CHUA_THUC_HIEN;
      case _DANG_THUC_HIEN:
        return DocumentStatus.DANG_THUC_HIEN;
    }
    return DocumentStatus.CHO_PHAN_XU_LY;
  }
}
