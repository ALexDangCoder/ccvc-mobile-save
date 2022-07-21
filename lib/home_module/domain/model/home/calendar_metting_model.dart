import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/extensions/date_time_extension.dart';

const _CHUA_THUC_HIEN = 'CHUA_THUC_HIEN';
const _DANG_THUC_HIEN = 'DANG_THUC_HIEN';
const _CHO_XAC_NHAN = 0;
const _THAM_GIA = 1;
enum ScreenTypeMetting { LICH_LAM_VIEC, LICH_HOP }

class CalendarMeetingModel {
  final String title;
  final String time;
  final String address;
  final String nguoiChuTri;
  final String nguoiChuTriId;
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
  final int trangThaiTheoUser;
  final String typeSchedule;
  final int trangThaiHanXuLy;
  ScreenTypeMetting screenTypeMetting = ScreenTypeMetting.LICH_LAM_VIEC;

  CalendarMeetingModel({
    this.title = '',
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
    this.isHopTrucTuyen = false,
    this.trangThaiTheoUser = 0,
    this.nguoiChuTriId = '',
    this.typeSchedule = '',
    this.trangThaiHanXuLy = -1,
  }) {
    codeStatus = fromEnum();
    screenTypeMetting = enumScreen();
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

  ScreenTypeMetting enumScreen() {
    switch (typeSchedule) {
      case 'Schedule':
        return ScreenTypeMetting.LICH_LAM_VIEC;
      case 'MeetingSchedule':
        return ScreenTypeMetting.LICH_HOP;
    }
    return ScreenTypeMetting.LICH_LAM_VIEC;
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

  DocumentStatus? trangThaiTheoUserEnum(String userId) {
    if (userId == nguoiChuTriId) {
      return null;
    }
    switch (trangThaiTheoUser) {
      case _CHO_XAC_NHAN:
        return DocumentStatus.CHO_XAC_NHAN;
      case _THAM_GIA:
        return DocumentStatus.THAM_GIA;
    }
  }

  DocumentStatus? get trangThaiHanXuLyEnum {
    switch (trangThaiHanXuLy) {
      case 1:
        return DocumentStatus.DEN_HAN;
      case 3:
        return DocumentStatus.TRONG_HAN;
      case 2:
        return DocumentStatus.QUA_HAN;
    }
  }
}
