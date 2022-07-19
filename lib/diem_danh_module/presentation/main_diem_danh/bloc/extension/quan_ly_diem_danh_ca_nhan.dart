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
import 'package:queue/queue.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

extension QuanLyDiemDanhCaNhan on DiemDanhCubit {
  Future<void> getDataDayWage({required DateTime dateTime}) async {
    currentTime = DateTime (dateTime.year, dateTime.month);
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

  TypeStateDiemDanh getStateDiemDanh(BangDiemDanhCaNhanModel model) {
    if (model.leaveType == LeaveType.NL) {
      return TypeStateDiemDanh.NGHI_LAM;
    }

    if ((model.isLate ?? false) && model.type == Type.WORKING) {
      return TypeStateDiemDanh.MUON;
    }

    if ((model.timeIn ?? '').isNotEmpty &&
        (model.timeOut ?? '').isNotEmpty &&
        model.type == Type.WORKING) {
      return TypeStateDiemDanh.DI_LAM;
    }

    if ((model.isComeBackEarly ?? false) && model.type == Type.WORKING) {
      return TypeStateDiemDanh.VE_SOM;
    }

    if ((model.leaveRequestReasonName ?? '').isNotEmpty) {
      return TypeStateDiemDanh.NGHI_PHEP;
    }

    return TypeStateDiemDanh.NGHI_LAM;
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
        return dataTime.month == currentTime.month;
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
