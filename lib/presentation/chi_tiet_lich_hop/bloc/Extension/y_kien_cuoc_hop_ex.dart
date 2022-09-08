import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:intl/intl.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///Y kien cuoc hop
extension YKienCuocHop on DetailMeetCalenderCubit {
  Future<void> getDanhSachYKien(
      {required String id, required String phienHopId}) async {
    showLoading();
    final result = await hopRp.getDanhSachYKien(id, phienHopId);
    result.when(
      success: (res) {
        showContent();
        if (phienHopId.trim().isEmpty) {
          listYKienCuocHop.sink.add(res);
        } else {
          listYKienPhienHop.sink.add(res);
        }
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> themYKien({
    required String yKien,
    required String idLichHop,
    required String phienHopId,
    String? scheduleOpinionId,
  }) async {
    showLoading();
    final ThemYKienRequest themYKienRequest = ThemYKienRequest(
      content: yKien,
      scheduleId: idLichHop,
      phienHopId: phienHopId.isNotEmpty ? phienHopId : null,
      scheduleOpinionId: scheduleOpinionId,
    );
    final result = await hopRp.themYKienHop(themYKienRequest);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: '${S.current.them_y_kien} ${S.current.thanh_cong}',
        );
        reloadYKien(
          idLichHop: idLichHop,
          phienHopId: phienHopId,
        );
      },
      error: (err) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.co_loi_xay_ra,
        );
      },
    );
    showContent();
  }

  void reloadYKien({
    required String idLichHop,
    required String phienHopId,
  }) {
    getDanhSachYKien(
      id: idLichHop,
      phienHopId: indexYKien == CUOC_HOP ? '' : phienHopId,
    ).then(
      (value) {
        if (danhSachChuongTrinhHop.hasValue) {
          danhSachChuongTrinhHop.sink.add(danhSachChuongTrinhHop.value);
        }
      },
    );
  }

  String coverDateFormat(String date) {
    final dateNow = DateTime.now().toString();
    final dateNowCover =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateNow).formatApiListBieuQuyet;
    final dateCover = DateFormat('yyyy/MM/dd HH:mm')
        .parse(dateNowCover)
        .formatYKienChiTietHop;
    return dateCover;
  }

  // danh sách phiên họp - ý kiến cuộc họp
  Future<void> getDanhSachPhienHop(String id) async {
    final result = await hopRp.getTongPhienHop(id);
    result.when(
      success: (res) {
        phienHop.sink.add(res.danhSachPhienHop ?? []);
      },
      error: (err) {
        return;
      },
    );
  }

  void callApiYkienCuocHop() {
    getDanhSachPhienHop(idCuocHop);
    getDanhSachYKien(id: idCuocHop, phienHopId: ' ');
  }
}
