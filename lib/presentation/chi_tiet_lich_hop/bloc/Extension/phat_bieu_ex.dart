import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///phat Bieu

class StatePhatBieu {
  static const int danh_Sach_phat_bieu = 0;
  static const int cho_duyet = 1;
  static const int da_duyet = 2;
  static const int huy_duyet = 3;
}

extension PhatBieu on DetailMeetCalenderCubit {
  Future<void> getDanhSachPhatBieuLichHop({
    int? status,
    String? lichHopId,
    String? phienHop,
  }) async {
    showLoading();
    final result = await hopRp.getDanhSachPhatBieuLichHop(
      status ?? 0,
      lichHopId ?? '',
      phienHop ?? '',
    );
    result.when(
      success: (res) {
        showContent();
        streamPhatBieu.sink.add(res);
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  void getValueStatus(int value) {
    typeStatus.sink.add(value);
    getDanhSachPhatBieuLichHop(status: value, lichHopId: idCuocHop);
  }

  Future<void> soLuongPhatBieuData({required String id}) async {
    final result = await hopRp.getSoLuongPhatBieu(id);
    result.when(
      success: (res) {
        buttonStatePhatBieu[StatePhatBieu.danh_Sach_phat_bieu].value =
            res.danhSachPhatBieu;
        buttonStatePhatBieu[StatePhatBieu.cho_duyet].value = res.choDuyet;
        buttonStatePhatBieu[StatePhatBieu.da_duyet].value = res.daDuyet;
        buttonStatePhatBieu[StatePhatBieu.huy_duyet].value = res.huyDuyet;
        dataSoLuongPhatBieuSubject.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> taoPhatBieu(TaoBieuQuyetRequest taoBieuQuyetRequest) async {
    showLoading();
    final result = await hopRp.postTaoPhatBieu(taoBieuQuyetRequest);

    result.when(
      success: (value) {
        if (value.succeeded == true) {
          callApiPhatBieu();
          MessageConfig.show(
            title: S.current.dang_ky_thanh_cong,
          );
        }
      },
      error: (error) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.dang_ky_that_bai,
        );
      },
    );
    showContent();
  }

  Future<void> duyetOrHuyDuyetPhatBieu({
    required String lichHopId,
    required int type,
  }) async {
    showLoading();
    final result = await hopRp.postDuyetOrHuyDuyetPhatBieu(
      selectPhatBieu,
      lichHopId,
      type,
    );
    result.when(
      success: (value) {
        showContent();
        callApiPhatBieu();
      },
      error: (error) {
        showError();
      },
    );
    showContent();
  }

  Color bgrColorButton(int value) {
    switch (value) {
      case StatePhatBieu.danh_Sach_phat_bieu:
        return color5A8DEE;
      case StatePhatBieu.cho_duyet:
        return itemWidgetNotUse;
      case StatePhatBieu.da_duyet:
        return itemWidgetUsing;
      case StatePhatBieu.huy_duyet:
        return statusCalenderRed;
    }
    return backgroundColorApp;
  }

  Future<void> callApiPhatBieu() async {
    showLoading();
    await getDanhSachPhatBieuLichHop(
      status: typeStatus.valueOrNull ?? 0,
      lichHopId: idCuocHop,
    );
    await soLuongPhatBieuData(id: idCuocHop);
    showContent();
  }
}
