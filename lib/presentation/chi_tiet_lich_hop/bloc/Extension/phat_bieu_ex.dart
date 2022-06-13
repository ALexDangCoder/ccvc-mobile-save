import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///phat Bieu
extension PhatBieu on DetailMeetCalenderCubit {
  Future<void> getDanhSachPhatBieuLichHop(
      {int? status, String? lichHopId, String? phienHop}) async {
    final result = await hopRp.getDanhSachPhatBieuLichHop(
      status ?? 0,
      lichHopId ?? '',
      phienHop ?? '',
    );
    result.when(
      success: (res) {
        streamPhatBieu.sink.add(res);
      },
      error: (err) {},
    );
  }

  void getValueStatus(int value) {
    typeStatus.sink.add(value);
    getDanhSachPhatBieuLichHop(status: value, lichHopId: idCuocHop);
  }

  Future<void> soLuongPhatBieuData({required String id}) async {
    final result = await hopRp.getSoLuongPhatBieu(id);
    result.when(
      success: (res) {
        buttonStatePhatBieu[DANHSACHPHATBIEU].value = res.danhSachPhatBieu;
        buttonStatePhatBieu[CHODUYET].value = res.choDuyet;
        buttonStatePhatBieu[DADUYET].value = res.daDuyet;
        buttonStatePhatBieu[HUYDUYET].value = res.huyDuyet;
      },
      error: (err) {},
    );
  }

  Future<void> taoPhatBieu(TaoBieuQuyetRequest taoBieuQuyetRequest) async {
    final result = await hopRp.postTaoPhatBieu(taoBieuQuyetRequest);

    result.when(
      success: (value) {
        if (value.succeeded == true) {
          getDanhSachPhatBieuLichHop(
              status: 1, lichHopId: taoBieuQuyetRequest.lichHopId ?? '');

          soLuongPhatBieuData(id: taoBieuQuyetRequest.lichHopId ?? '');
        }
      },
      error: (error) {},
    );
  }

  Future<void> duyetOrHuyDuyetPhatBieu({
    required String lichHopId,
    required int type,
  }) async {
    final result = await hopRp.postDuyetOrHuyDuyetPhatBieu(
      selectPhatBieu,
      lichHopId,
      type,
    );
    result.when(
      success: (value) {
        if (value.succeeded == true) {}
      },
      error: (error) {},
    );
  }

  Color bgrColorButton(int vl) {
    switch (vl) {
      case DANHSACHPHATBIEU:
        return color5A8DEE;
      case CHODUYET:
        return itemWidgetNotUse;
      case DADUYET:
        return itemWidgetUsing;
      case HUYDUYET:
        return statusCalenderRed;
    }
    return backgroundColorApp;
  }
}
