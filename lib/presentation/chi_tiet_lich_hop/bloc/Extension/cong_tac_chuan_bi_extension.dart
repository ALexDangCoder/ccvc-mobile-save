import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///Công tác chuẩn bị
extension CongTacChuanBi on DetailMeetCalenderCubit {
  Future<void> getThongTinPhongHopApi() async {
    final result = await hopRp.getListThongTinPhongHop(idCuocHop);
    result.when(
      success: (res) {
        getThongTinPhongHopSb.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> getDanhSachThietBi() async {
    final result = await hopRp.getListThietBiPhongHop(idCuocHop);
    result.when(
      success: (res) {
        getListThietBiPhongHop.sink.add(res);
      },
      error: (err) {},
    );
  }

  ///lấy danh sách phòng họp theo chi tiết họp
  Future<void> getDanhSachPhongHop() async {
    showLoading();
    final ChiTietLichHopModel chiTietLichHopModel = chiTietLichHopSubject.value;
    final result = await hopRp.getDanhSachPhongHop(
      chiTietLichHopModel.chuTriModel.donViId,
      chiTietLichHopModel.ngayBatDau,
      chiTietLichHopModel.ngayKetThuc,
      chiTietLichHopModel.phongHopMode.bit_TTDH,
    );
    result.when(
      success: (res) {
        showContent();
        phongHopSubject.sink.add(res);
      },
      error: (err) {},
    );
    showContent();
  }

  ///hủy hoặc duyệt phòng họp
  Future<void> huyOrDuyetPhongHop(
    bool isDuyet,
  ) async {
    showLoading();
    final result = await hopRp.huyOrDuyetPhongHop(
      idCuocHop,
      isDuyet,
      '',
    );
    result.when(
      success: (res) {
        showContent();
        if (res.succeeded ?? false) {
          initDataChiTiet();
          MessageConfig.show(
            title: S.current.tao_thanh_cong,
          );
        }
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.tao_that_bai,
        );
      },
    );
    showContent();
  }

  /// chọn phòng họp mới
  Future<void> thayDoiPhongHop() async {
    showLoading();
    final ChiTietLichHopModel chiTietLichHopModel = chiTietLichHopSubject.value;
    final result = await hopRp.thayDoiPhongHop(
      chiTietLichHopModel.phongHopMode.bit_TTDH,
      idCuocHop,
      chosePhongHop.phongHopId ?? '',
      chosePhongHop.ten ?? '',
    );
    result.when(
      success: (res) {
        showContent();
        if (res.succeeded ?? false) {
          initDataChiTiet();
        }
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.tao_that_bai,
        );
      },
    );
    showContent();
  }

  /// duyệt hoặc hủy duyệt thiết bị
  Future<bool> duyetOrHuyDuyetThietBi(
    bool isDuyet,
    String thietBiId,
  ) async {
    final result = await hopRp.duyetOrHuyDuyetThietBi(
      isDuyet,
      idCuocHop,
      '',
      thietBiId,
    );
    result.when(
      success: (res) {
        if (res.succeeded ?? false) {
          return true;
        }
      },
      error: (err) {
        return false;
      },
    );
    return false;
  }

  Future<void> forToduyetOrHuyDuyetThietBi({
    required List<ThietBiPhongHopModel> listTHietBiDuocChon,
    required bool isDuyet,
  }) async {
    showLoading();
    final List<bool> checkAllFinal = [];
    if (listTHietBiDuocChon.isNotEmpty) {
      for (int i = 0; i < listTHietBiDuocChon.length; i++) {
        await duyetOrHuyDuyetThietBi(isDuyet, listTHietBiDuocChon[i].id).then(
          (vl) => checkAllFinal.add(vl),
        );
      }
    }

    if (!checkAllFinal.contains(false)) {
      await getDanhSachThietBi();
      MessageConfig.show(
        title: S.current.tao_that_bai,
      );
    }
    showContent();
  }

  /// duyệt hoặc hủy duyệt kỹ thuât
  Future<void> duyetOrHuyDuyetKyThuat(
    bool isDuyet,
  ) async {
    showLoading();
    final result = await hopRp.duyetOrHuyDuyetKyThuat(
      idCuocHop,
      isDuyet,
      '',
    );
    result.when(
      success: (res) {
        showContent();
        if (res.succeeded ?? false) {
          initDataChiTiet();
          MessageConfig.show(
            title: S.current.tao_thanh_cong,
          );
        }
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.tao_that_bai,
        );
      },
    );
    showContent();
  }

  /// chọn phong họp khi chưa có phòng họp nào
  Future<void> chonPhongHop() async {
    ChiTietLichHopModel chiTietLichHopModel = chiTietLichHopSubject.value;

    taoLichHopRequest.typeScheduleId = chiTietLichHopModel.typeScheduleId;
    taoLichHopRequest.linhVucId = chiTietLichHopModel.linhVuc;
    taoLichHopRequest.timeTo = chiTietLichHopModel.timeTo;
    taoLichHopRequest.timeStart = chiTietLichHopModel.timeStart;
    taoLichHopRequest.diaDiemHop = chiTietLichHopModel.diaDiemHop;
    taoLichHopRequest.chuTri?.donViId = chiTietLichHopModel.chuTriModel.donViId;
    taoLichHopRequest.chuTri?.canBoId = chiTietLichHopModel.chuTriModel.canBoId;
    taoLichHopRequest.chuTri?.tenCanBo =
        chiTietLichHopModel.chuTriModel.tenCanBo;
    taoLichHopRequest.days = chiTietLichHopModel.days;

    showLoading();
    final result = await hopRp.taoLichHop(taoLichHopRequest);
    result.when(
      success: (res) {
        showContent();
        MessageConfig.show(
          title: S.current.tao_thanh_cong,
        );
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.tao_that_bai,
        );
      },
    );
    showContent();
  }

  Future<void> callApiCongTacChuanBi() async {
    await getThongTinPhongHopApi();
    await getDanhSachThietBi();
    await getDanhSachPhongHop();
  }
}
