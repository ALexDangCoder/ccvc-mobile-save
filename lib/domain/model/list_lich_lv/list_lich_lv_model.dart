import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/calendar.dart';

class DataLichLvModel {
  List<ListLichLVModel>? listLichLVModel = [];
  int? pageIndex = 0;
  int? pageSize = 0;
  int? totalCount = 0;
  int? totalPage = 0;

  DataLichLvModel.empty();

  DataLichLvModel({
    this.listLichLVModel,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  DataSourceFCalendar toDataFCalenderSource() {
    final List<AppointmentWithDuplicate> appointments = [];
    if ((listLichLVModel ?? []).isNotEmpty) {
      for (final ListLichLVModel i in listLichLVModel ?? []) {
        appointments.add(
          AppointmentWithDuplicate(
            notes: i.typeSchedule,
            startTime: DateTime.parse(
              i.dateTimeFrom ?? '',
            ),
            endTime: DateTime.parse(
              i.dateTimeTo ?? '',
            ),
            subject: i.title ?? '',
            id: i.id ?? '',
            isDuplicate: i.isTrung,
          ),
        );
      }
      // getMatchDate(dataLichLvModels);
    }
    return DataSourceFCalendar(appointments);
  }
}

class AppointmentWithDuplicate extends Appointment {
  bool isDuplicate;

  bool isMore;

  int group = 0;

  AppointmentWithDuplicate({
    this.isDuplicate = false,
    this.isMore = false,
    String? notes,
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
  }) : super(
          notes: notes,
          startTime: startTime,
          endTime: endTime,
          subject: subject,
          id: id,
          isAllDay: getOnlyDate(startTime).millisecondsSinceEpoch !=
              getOnlyDate(endTime).millisecondsSinceEpoch,
        );

  static DateTime getOnlyDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}

class ListLichLVModel {
  String? id;

  String? title;

  String? content;

  int? status;

  String? location;

  bool? isLichLap;

  bool? isAllDay;

  int? trangThaiTheoUser;

  String? dateFrom;

  String? dateTo;

  String? timeFrom;

  String? timeTo;

  String? dateTimeFrom;

  String? dateTimeTo;

  String? createAt;

  String? color;

  String? typeSchedule;

  bool isTrung = false;

  // CreateBys? createBys;
  //
  // CreateBys? canBoChuTri;

  ListLichLVModel.empty();

  ListLichLVModel({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.location,
    required this.isLichLap,
    required this.isAllDay,
    required this.trangThaiTheoUser,
    required this.dateFrom,
    required this.dateTo,
    required this.timeFrom,
    required this.timeTo,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.createAt,
    required this.color,
    required this.typeSchedule,
    // required this.createBys,
    // required this.canBoChuTri,
  });
}

class CreateBys {
  String? id;

  String? chucVu;

  String? chucVuId;

  String? hoTen;

  String? sdtDiDong;

  String? donViId;

  String? tenDonVi;

  String? donViGocId;

  String? tenDonViGoc;

  CreateBys({
    required this.id,
    required this.chucVu,
    required this.chucVuId,
    required this.hoTen,
    required this.sdtDiDong,
    required this.donViId,
    required this.tenDonVi,
    required this.donViGocId,
    required this.tenDonViGoc,
  });
}
