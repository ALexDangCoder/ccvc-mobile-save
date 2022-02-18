import 'package:ccvc_mobile/utils/constants/app_constants.dart';

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
  });
}
