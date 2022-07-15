import 'dart:async';

import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/widgets/data_view_widget/type_calender/data_view_calendar_day.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:queue/queue.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

extension QuanLyDiemDanhCaNhan on DiemDanhCubit {
  Future<void> initData() async {
    final DateTime initData =
        DateTime(DateTime.now().year, DateTime.now().month);
    final Queue queue = Queue();
    showLoading();
    unawaited(queue.add(() => postDiemDanhThongKe(initData)));
    unawaited(queue.add(() => postBangDiemDanhCaNhan(initData)));
    await queue.onComplete;
    showContent();
  }

  int get endYear => DateTime.now().year + 5;

  int get startYear => DateTime.now().year - 5;

  Future<void> changeData(DateTime date) async {
    final Queue queue = Queue();
    showLoading();
    unawaited(queue.add(() => postDiemDanhThongKe(date)));
    unawaited(queue.add(() => postBangDiemDanhCaNhan(date)));
    await queue.onComplete;
    showContent();
  }

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
      for (final BangDiemDanhCaNhanModel e
          in listBangDiemDanh.valueOrNull ?? []) {
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
            formatPattern: 'dd/MM/yyyy',
          ),
          endTime: date.convertStringToDate(
            formatPattern: 'dd/MM/yyyy',
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
