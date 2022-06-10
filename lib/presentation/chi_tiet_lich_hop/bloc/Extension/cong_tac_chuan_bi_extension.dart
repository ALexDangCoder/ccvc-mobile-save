import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
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
        showContent();
        getListThietBiPhongHop.sink.add(res);
      },
      error: (err) {
        showError();
      },
    );
  }

//TODO
  Future<void> getDanhSachPhongHop() async {
    final ChiTietLichHopModel chiTietLichHopModel =
        chiTietLichLamViecSubject.value;
    final result = await hopRp.getDanhSachPhongHop(
      chiTietLichHopModel.chuTriModel.donViId,
      chiTietLichHopModel.ngayBatDau,
      chiTietLichHopModel.ngayKetThuc,
      chiTietLichHopModel.phongHopMode.bit_TTDH,
    );
    result.when(
      success: (res) {
        phongHopSubject.sink.add(res);
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> huyOrDuyetPhongHop(
    bool isDuyet,
  ) async {
    final result = await hopRp.huyOrDuyetPhongHop(
      idCuocHop,
      isDuyet,
      'ly do',
    );
    result.when(
      success: (res) {
        if (res.succeeded ?? false) {
          initData(boolGetChiTietLichHop: true);
        }
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> thayDoiPhongHop() async {
    ChiTietLichHopModel chiTietLichHopModel = chiTietLichLamViecSubject.value;
    final result = await hopRp.thayDoiPhongHop(
      chiTietLichHopModel.phongHopMode.bit_TTDH,
      idCuocHop,
      chosePhongHop.phongHopId ?? '',
      chosePhongHop.ten ?? '',
    );
    result.when(
      success: (res) {
        if (res.succeeded ?? false) {
          initData(boolGetChiTietLichHop: true);
        }
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

//TODO
  Future<void> duyetOrHuyDuyetThietBi(
    bool isDuyet,
    String thietBiId,
  ) async {
    final result = await hopRp.duyetOrHuyDuyetThietBi(
      isDuyet,
      idCuocHop,
      'ly do',
      thietBiId,
    );
    result.when(
      success: (res) {
        if (res.succeeded ?? false) {
          initData(boolGetChiTietLichHop: true);
        }
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> duyetOrHuyDuyetKyThuat(
    bool isDuyet,
  ) async {
    final result = await hopRp.duyetOrHuyDuyetKyThuat(
      idCuocHop,
      isDuyet,
      'ly do',
    );
    result.when(
      success: (res) {
        if (res.succeeded ?? false) {
          initData(boolGetChiTietLichHop: true);
        }
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> chonPhongHop() async {
    ChiTietLichHopModel chiTietLichHopModel = chiTietLichLamViecSubject.value;

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
        MessageConfig.show(
          title: S.current.tao_thanh_cong,
        );
      },
      error: (error) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.tao_that_bai,
        );
      },
    );
    showContent();
  }
}
