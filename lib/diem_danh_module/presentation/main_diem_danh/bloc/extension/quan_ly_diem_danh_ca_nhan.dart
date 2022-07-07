import 'dart:async';

import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/diem_danh_ca_nhan/ui/type_state_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:queue/queue.dart';

extension QuanLyDiemDanhCaNhan on DiemDanhCubit {
  Future<void> initData() async {
    final Queue queue = Queue();
    showLoading();
    unawaited(queue.add(() => postDiemDanhThongKe()));
    unawaited(queue.add(() => postBangDiemDanhCaNhan()));
    await queue.onComplete;
    showContent();
  }

  bool isMatchDay(DateTime a,
      DateTime b,) {
    if (a.year == b.year && a.month == b.month && a.day == b.day) {
      return true;
    }
    return false;
  }

  DateTime? stringToDate(String date, String time) {
    if (date.isEmpty || time.isEmpty) {
      return null;
    } else {

    }
  }

  TypeStateDiemDanh getStateDiemDanh(BangDiemDanhCaNhanModel model) {
    if ((model.timeIn ?? '').isEmpty && (model.timeOut ?? '').isEmpty) {
      return TypeStateDiemDanh.NGHI_LAM;
    }

    if ((model.timeIn ?? '').isEmpty || (model.timeOut ?? '').isEmpty ) {
      return TypeStateDiemDanh.MUON;
    }

    if ((model.timeIn ?? '').isNotEmpty && (model.timeOut ?? '').isNotEmpty) {
      return TypeStateDiemDanh.DI_LAM;
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

  Future<void> postDiemDanhThongKe() async {
    final thongKeDiemDanhCaNhanRequest = ThongKeDiemDanhCaNhanRequest(
      thoiGian: '2022-06-01T00:00:00.00Z',
      userId: '93114dcb-dfe1-487b-8e15-9c378c168994',
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

  Future<void> postBangDiemDanhCaNhan() async {
    final bangDiemDanhCaNhanRequest = BangDiemDanhCaNhanRequest(
        thoiGian: '2022-06-01T00:00:00.00Z',
        userId: '93114dcb-dfe1-487b-8e15-9c378c168994');
    final result = await diemDanhRepo.bangDiemDanh(bangDiemDanhCaNhanRequest);
    result.when(
      success: (res) {
        listBangDiemDanh.sink.add(res.items ?? []);
      },
      error: (err) {},
    );
  }
}
