import 'dart:async';

import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/extensions/date_time_extension.dart';
import 'package:queue/queue.dart';

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

  Future<void> changeData(DateTime date) async {
    final Queue queue = Queue();
    showLoading();
    unawaited(queue.add(() => postDiemDanhThongKe(date)));
    unawaited(queue.add(() => postBangDiemDanhCaNhan(date)));
    await queue.onComplete;
    showContent();
  }

  bool isMatchDay(
    DateTime a,
    DateTime b,
  ) {
    if (a.year == b.year && a.month == b.month && a.day == b.day) {
      return true;
    }
    return false;
  }

  DateTime? stringToDate(String date, String time) {
    if (date.isEmpty || time.isEmpty) {
      return null;
    } else {}
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

  String getStringDate(String? timeIn, String? timeOut) {
    if (timeIn == null && timeOut != null) {
      return '??:$timeOut';
    }

    if (timeOut == null && timeIn != null) {
      return '$timeIn:??';
    }

    if (timeIn == null && timeOut == null) {
      return '??:??';
    }

    if (timeIn != null && timeOut != null) {
      return '$timeIn:$timeOut';
    }

    return '??:??';
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
}

class LeaveType {
  static const String NL = 'NL';
}

class Type {
  static const String WORKING = 'working';
  static const String HOLIDAY = 'holiday';
  static const String OFFWORK = 'off-work';
}
