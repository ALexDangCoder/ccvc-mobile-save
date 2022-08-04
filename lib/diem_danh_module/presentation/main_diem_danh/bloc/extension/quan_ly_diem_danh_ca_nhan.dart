import 'dart:async';

import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/syncfusion_flutter_calendar/calendar.dart';
import 'package:queue/queue.dart';

extension QuanLyDiemDanhCaNhan on DiemDanhCubit {
  Future<void> getDataDayWage({required DateTime dateTime}) async {
    currentTime = DateTime(dateTime.year, dateTime.month);
    final Queue queue = Queue(parallel: 2);
    showLoading();
    unawaited(queue.add(() => postDiemDanhThongKe(dateTime)));
    unawaited(queue.add(() => postBangDiemDanhCaNhan(dateTime)));
    await queue.onComplete;
    showContent();
  }

  int get endYear => DateTime.now().year + 5;

  int get startYear => DateTime.now().year - 5;

  bool isMatchDay(
    DateTime dateNew,
    DateTime dateOld,
  ) {
    if (dateNew.year == dateOld.year &&
        dateNew.month == dateOld.month &&
        dateNew.day == dateOld.day) {
      return true;
    }
    return false;
  }

  List<TypeStateDiemDanh> getStateDiemDanh(BangDiemDanhCaNhanModel model) {
    final List<TypeStateDiemDanh> dataState = [];
    if (model.leaveType == LeaveType.NL) {
      dataState.add(TypeStateDiemDanh.NGHI_LAM);
    }

    if ((model.isLate ?? false) && model.type == Type.WORKING) {
      dataState.add(TypeStateDiemDanh.MUON);
    }

    if ((model.isComeBackEarly ?? false) && model.type == Type.WORKING) {
      dataState.add(TypeStateDiemDanh.VE_SOM);
    }

    if ((model.leaveRequestReasonName ?? '').isNotEmpty) {
      dataState.add(TypeStateDiemDanh.NGHI_PHEP);
    }

    return dataState;
  }

  Future<void> postDiemDanhThongKe(DateTime date) async {
    final thongKeDiemDanhCaNhanRequest = ThongKeDiemDanhCaNhanRequest(
      thoiGian: date.convertDateTimeApi,
      userId: dataUser?.userId ?? '',
    );
    final result =
        await diemDanhRepo.thongKeDiemDanh(thongKeDiemDanhCaNhanRequest);
    result.when(
      success: (res) {
        thongKeSubject.sink.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> postBangDiemDanhCaNhan(DateTime date) async {
    final bangDiemDanhCaNhanRequest = BangDiemDanhCaNhanRequest(
      thoiGian: date.convertDateTimeApi,
      userId: dataUser?.userId ?? '',
    );
    final result = await diemDanhRepo.bangDiemDanh(bangDiemDanhCaNhanRequest);
    result.when(
      success: (res) {
        listBangDiemDanh.sink.add(res.items ?? []);
      },
      error: (err) {},
    );
  }

  bool isEndWeek(BangDiemDanhCaNhanModel model) {
    final date = DateTime.parse(
      timeFormat(
        model.date ?? '',
        DateTimeFormat.DAY_MONTH_YEAR,
        DateTimeFormat.FORMAT_REQUEST,
      ),
    );

    ///nếu cuối tuần mà vẫn đi làm thì hiển thị còn nếu như không đi làm thì không hiển thị
    if ((date.weekday == WeekDay.SATURDAY || date.weekday == WeekDay.SUNDAY) &&
        ((model.timeIn ?? '').isNotEmpty || (model.timeOut ?? '').isNotEmpty)) {
      return false;
    }

    if (date.weekday == WeekDay.SATURDAY || date.weekday == WeekDay.SUNDAY) {
      return true;
    }

    return false;
  }

  List<AppointmentWithDuplicate> toDataFCalenderSource() {
    final List<AppointmentWithDuplicate> appointments = [];
    if ((listBangDiemDanh.valueOrNull ?? []).isNotEmpty) {
      final tmpList = listBangDiemDanh.value.where((element) {
        final dataTime = DateTime.parse(
          timeFormat(
            element.date ?? '',
            DateTimeFormat.DAY_MONTH_YEAR,
            DateTimeFormat.FORMAT_REQUEST,
          ),
        );

        ///chỉ được hiển thị ngày trong tháng và không hiển thị ngày cuối tuần
        ///( trừ khi đi làm ) và chỉ hiển thị đến ngày hiện tại hoặc ngày nghỉ được xin phép
        return dataTime.month == currentTime.month &&
                !isEndWeek(element) &&
                dataTime.isBefore(DateTime.now()) ||
            ((element.leaveRequestReasonName ?? '').isNotEmpty &&
                dataTime.month == currentTime.month);
      });
      for (final BangDiemDanhCaNhanModel e in tmpList) {
        appointments.add(
          AppointmentWithDuplicate(
            date: e.date ?? '',
            model: e,
          ),
        );
      }
    }
    return appointments;
  }
}

class AppointmentWithDuplicate extends Appointment {
  final BangDiemDanhCaNhanModel model;

  AppointmentWithDuplicate({
    required String date,
    required this.model,
  }) : super(
          startTime: date.convertStringToDate(
            formatPattern: DateTimeFormat.DAY_MONTH_YEAR,
          ),
          endTime: date.convertStringToDate(
            formatPattern: DateTimeFormat.DAY_MONTH_YEAR,
          ),
        );
}

class LeaveType {
  static const String NL = 'NL';
}

class Type {
  static const String WORKING = 'working';
  static const String HOLIDAY = 'holiday';
  static const String OFFWORK = 'off-work';
}

class WeekDay {
  static const int MONDAY = 1;
  static const int TUESDAY = 2;
  static const int WEDNESDAY = 3;
  static const int THURSDAY = 4;
  static const int FRIDAY = 5;
  static const int SATURDAY = 6;
  static const int SUNDAY = 7;
}
