import 'dart:io';

import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/cu_can_bo_di_thay_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/phan_cong_thu_ky_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';

import '../chi_tiet_lich_hop_cubit.dart';

class CoperativeStatus {
  static const int WaitAccept = 0;
  static const int Accepted = 1;
  static const int Denied = 2;
  static const int Revoked = 4;
}

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
        dataThuKyOrThuHoiDeFault =
            res.where((element) => element.trangThai != 4).toList();
        listThuHoi.sink.add(dataThuKyOrThuHoiDeFault);
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
    showLoading();
    final idPost = dataThuKyOrThuHoiDeFault
        .where((element) => element.trangThai == CoperativeStatus.Revoked)
        .toList();
    for (int i = 0; i < idPost.length; i++) {
      thuHoiHopRequest.add(
        ThuHoiHopRequest(
          id: idPost[i].id,
          scheduleId: scheduleId,
          status: CoperativeStatus.Revoked,
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
        showContent();
        MessageConfig.show(title: S.current.thanh_cong);
        getDanhSachNguoiChuTriPhienHop(idCuocHop);
      },
      error: (error) {
        MessageConfig.show(title: S.current.that_bai);
      },
    );
    showContent();
  }

  Future<void> postPhanCongThuKy(String id) async {
    showLoading();
    final List<String> dataIdPost = dataThuKyOrThuHoiDeFault
        .where((canBo) => canBo.isThuKy ?? false)
        .map((canBo) => canBo.id ?? '')
        .toList();
    final result = await hopRp.postPhanCongThuKy(
      PhanCongThuKyRequest(
        content: '',
        ids: dataIdPost,
        lichHopId: id,
      ),
    );

    result.when(
      success: (value) {
        showContent();
        MessageConfig.show(title: S.current.thanh_cong);
        getDanhSachNguoiChuTriPhienHop(idCuocHop);
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
      },
    );
    showContent();
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

  Future<bool> cuCanBoDiThay({
    required List<CanBoDiThay> canBoDiThay,
  }) async {
    canBoDiThay.insert(
      0,
      CanBoDiThay(
        id: donViModel.id,
        donViId: donViModel.donViId,
        canBoId: donViModel.canBoId,
        taskContent: '',
      ),
    );
    final listCanBo = listDataCanBo
        .map(
          (canBo) =>
          CanBoDiThay(
            id: canBo.id,
            donViId: canBo.donViId,
            canBoId: canBo.canBoId,
            taskContent: '',
          ),
    )
        .toSet();
    canBoDiThay.addAll(listCanBo);
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

  Future<void> postFileTaoLichHop({
    int? entityType = 1,
    String entityName = ENTITY_TAI_LIEU_HOP,
    String? entityId,
    bool isMutil = false,
    required List<File> files,
  }) async {
    if (files.isEmpty) {
      return;
    }
    showLoading();
    final result = await hopRp.postFileTaoLichHop(
      entityType,
      entityName,
      entityId,
      isMutil,
      files,
    );
    await result.when(
      success: (res) async {
        showContent();
        await getChiTietLichHop(idCuocHop);
        MessageConfig.show(title: S.current.thao_tac_thanh_cong);
      },
      error: (err) {
        MessageConfig.show(
            title: S.current.thao_tac_that_bai, messState: MessState.error);
      },
    );
    showContent();
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

  List<CanBoDiThay> mergeCanBoDuocChonVaCuCanBo(List<DonViModel> canBoDuocChon,
      List<DonViModel> cuCanBo,) {
    final List<CanBoDiThay> data = [];
    data.addAll(
      canBoDuocChon
          .map(
            (canBo) =>
            CanBoDiThay(
              id: canBo.id.isEmpty ? null : canBo.id,
              donViId: canBo.donViId.isEmpty ? null : canBo.donViId,
              canBoId: canBo.canBoId.isEmpty ? null : canBo.canBoId,
              taskContent: canBo.noidung,
              isXoa: canBo.isXoa,
            ),
      )
          .toList(),
    );
    data.addAll(
      cuCanBo
          .map(
            (canBo) =>
            CanBoDiThay(
              id: null,
              donViId: canBo.donViId.isEmpty ? null : canBo.donViId,
              canBoId: canBo.canBoId.isEmpty ? null : canBo.canBoId,
              taskContent: canBo.noidung,
            ),
      )
          .toList(),
    );
    return data;
  }

  DonViModel? get canBoThamGia {
    for (final DonViModel canBo in listTPTG) {
      if (canBo.canBoId == (dataUser?.userId ?? '')) {
        return canBo;
      }
    }
  }

  DonViModel? get donViThamGia {
    final donViId =
        HiveLocal
            .getDataUser()
            ?.userInformation
            ?.donViTrucThuoc
            ?.id ?? '';

    for (final DonViModel canBo in listTPTG) {
      if (canBo.donViId.toUpperCase() == donViId.toUpperCase() &&
          canBo.canBoId.isEmpty) {
        return canBo;
      }
    }
  }

  Future<bool> luuCanBoDiThay({
    required ThanhPhanThamGiaCubit cubitThanhPhanTG,
  }) async {
    final donViId =
        HiveLocal
            .getDataUser()
            ?.userInformation
            ?.donViTrucThuoc
            ?.id ?? '';

    final String idChuTri = listTPTG
        .firstWhere(
          (element) => element.donViId == donViId && element.canBoId.isEmpty,
      orElse: () => DonViModel.empty(),
    )
        .id;
        
    final bool isCheckCallApiCuCanBo = await cuCanBo(
      canBoDiThay: mergeCanBoDuocChonVaCuCanBo(
      cubitThanhPhanTG.listCanBoDuocChon,
      cubitThanhPhanTG.listCanBo,
    ),
      id: idChuTri,
    );
    return isCheckCallApiCuCanBo;
  }

  Future<bool> cuCanBo({
    required List<CanBoDiThay> canBoDiThay,
    required String id,
  }) async {
    final CuCanBoDiThayRequest cuCanBoDiThayRequest = CuCanBoDiThayRequest(
      id: id,
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

  void xoaKhachMoiThamGia(DonViModel donViModel,) {
    listDataCanBo.remove(donViModel);
    listDonViModel.sink.add(listDataCanBo);
  }

  Future<void> deleteFileHop({
    required String id,
  }) async {
    showLoading();
    final result = await hopRp.deleteFileHop(
      id,
    );
    await result.when(
      success: (res) async {
        showContent();
        await getChiTietLichHop(idCuocHop);
        MessageConfig.show(title: S.current.thao_tac_thanh_cong);
      },
      error: (err) {
        MessageConfig.show(
            title: S.current.thao_tac_that_bai, messState: MessState.error);
      },
    );
    showContent();
  }
}
