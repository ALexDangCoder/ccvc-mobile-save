import 'package:ccvc_mobile/bao_cao_module/widget/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/cu_can_bo_di_thay_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/phan_cong_thu_ky_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///chi tiết lịch họp
extension ChiTietLichHop on DetailMeetCalenderCubit {
  Future<bool> deleteChiTietLichHop({bool? isMulti}) async {
    showLoading();
    final result = await hopRp.deleteChiTietLichHop(
      idCuocHop,
      isMulti ?? false,
    );
    result.when(
      success: (res) {
        showContent();
        return true;
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
        return false;
      },
    );
    showContent();
    return true;
  }

  Future<bool> huyChiTietLichHop({
    bool? isMulti,
  }) async {
    showLoading();
    final result = await hopRp.huyChiTietLichHop(
      idCuocHop,
      8,
      isMulti ?? false,
    );
    result.when(
      success: (res) {
        showContent();
        return true;
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
        return false;
      },
    );
    showContent();
    return true;
  }

  Future<void> postSuaLichHop() async {
    showLoading();

    final result = await hopRp.postSuaLichHop(taoLichHopRequest);

    result.when(
      success: (value) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
    showContent();
  }

  Future<void> getDanhSachThuHoiLichHop(String id) async {
    final result = await hopRp.getDanhSachThuHoi(id, true);
    result.when(
      success: (res) {
        dataThuHoi = res.where((element) => element.trangThai != 4).toList();
        listThuHoi.sink.add(dataThuHoi);
      },
      error: (error) {},
    );
  }

  Future<void> getChiTietLichHop(String id) async {
    showLoading();
    final loaiHop = await hopRp
        .getLoaiHop(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    loaiHop.when(
      success: (res) {
        listLoaiHop = res;
      },
      error: (err) {},
    );
    final result = await hopRp.getChiTietLichHop(idCuocHop);
    result.when(
      success: (res) {
        res.loaiHop = _findLoaiHop(res.typeScheduleId)?.name ?? '';
        chiTietLichHopSubject.add(res);
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  Future<void> postThuHoiHop(String scheduleId) async {
    final idPost =
        dataThuHoi.where((element) => element.trangThai == 4).toList();
    for (int i = 0; i < idPost.length; i++) {
      thuHoiHopRequest.add(
        ThuHoiHopRequest(
          id: idPost[i].id,
          scheduleId: scheduleId,
          status: 4,
        ),
      );
    }
    final result = await hopRp.postThuHoiHop(false, thuHoiHopRequest);

    result.when(
      success: (value) {
        if (value.succeeded == true) {
          getDanhSachThuHoiLichHop(scheduleId);
          thuHoiHopRequest.clear();
        }
      },
      error: (error) {},
    );
  }

  Future<void> postPhanCongThuKy(String id) async {
    final List<String> dataIdPost = dataThuKyOrThuHoiDeFault
        .where((e) => e.isThuKy ?? false)
        .map((e) => e.id ?? '')
        .toList();
    final result = await hopRp.postPhanCongThuKy(
      PhanCongThuKyRequest(
        content: '',
        ids: dataIdPost,
        lichHopId: id,
      ),
    );

    result.when(
      success: (value) {},
      error: (error) {},
    );
  }

  LoaiSelectModel? _findLoaiHop(String id) {
    final loaiHopType =
        listLoaiHop.where((element) => element.id == id).toList();
    if (loaiHopType.isNotEmpty) {
      return loaiHopType.first;
    }
  }

  List<int> listNgayChonTuan(String value) {
    final List<String> lSt = value.replaceAll(',', '').split('');
    final List<int> numbers = lSt.map(int.parse).toList();
    return numbers;
  }

  int nhacLai(int nhacLai) {
    switch (nhacLai) {
      case 0:
        return 1;
      case 1:
        return 0;
      case 2:
        return 5;
      case 3:
        return 10;
      case 4:
        return 15;
      case 5:
        return 30;
      case 6:
        return 60;
      case 7:
        return 120;
      case 8:
        return 720;
      case 9:
        return 1140;
      case 10:
        return 10080;
    }
    return 0;
  }

  Future<bool> confirmThamGiaHop({
    required String lichHopId,
    required bool isThamGia,
  }) async {
    bool isSuccess = false;
    final rs = await hopRp.xacNhanThamGiaHop(lichHopId, isThamGia);
    rs.when(
      success: (res) {
        isSuccess = true;
      },
      error: (error) {
        isSuccess = false;
      },
    );
    return isSuccess;
  }

  Future<bool> huyAndDuyetLichHop({
    required bool isDuyet,
  }) async {
    bool isCheck = true;
    final result = await hopRp.huyAndDuyetLichHop(idCuocHop, isDuyet, '');
    result.when(
      success: (res) {
        isCheck = true;
      },
      error: (error) {
        isCheck = false;
      },
    );
    return isCheck;
  }

  Future<bool> cuCanBoDiThay({
    required List<CanBoDiThay>? canBoDiThay,
  }) async {
    final CuCanBoDiThayRequest cuCanBoDiThayRequest = CuCanBoDiThayRequest(
      id: idCanBoDiThay,
      lichHopId: idCuocHop,
      canBoDiThay: canBoDiThay,
    );
    bool isCheck = true;
    showLoading();
    final result = await hopRp.cuCanBoDiThay(cuCanBoDiThayRequest);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.cu_can_bo_thanh_cong,
        );
        isCheck = true;
      },
      error: (error) {
        if (error is TimeoutException || error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.cu_can_bo_khong_thanh_cong,
            messState: MessState.error,
          );
        }
        isCheck = false;
      },
    );
    showContent();
    return isCheck;
  }

  Future<bool> cuCanBo({
    required List<CanBoDiThay>? canBoDiThay,
  }) async {
    final CuCanBoDiThayRequest cuCanBoDiThayRequest = CuCanBoDiThayRequest(
      id: idDanhSachCanBo,
      lichHopId: idCuocHop,
      canBoDiThay: canBoDiThay,
    );
    bool isCheck = true;
    showLoading();
    final result = await hopRp.cuCanBoDiThay(cuCanBoDiThayRequest);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.cu_can_bo_thanh_cong,
        );
        isCheck = true;
      },
      error: (error) {
        if (error is TimeoutException || error is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.cu_can_bo_khong_thanh_cong,
            messState: MessState.error,
          );
        }
        isCheck = false;
      },
    );
    showContent();
    return isCheck;
  }
}
