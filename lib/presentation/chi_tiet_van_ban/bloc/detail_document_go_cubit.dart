import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_tra_lai_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'detai_doccument_state.dart';

class CommonDetailDocumentGoCubit extends BaseCubit<DetailDocumentState> {
  CommonDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  //chi tiet van ban di
  BehaviorSubject<ChiTietVanBanDiModel> chiTietVanBanDiSubject =
      BehaviorSubject();

  //nguoi ky duyet vb di
  BehaviorSubject<List<NguoiKyDuyetModel>> nguoiKyDuyetVanBanDiSubject =
      BehaviorSubject();

  // tep dinh kem
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listPhieuTrinh =
      BehaviorSubject();
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listDuThao =
      BehaviorSubject();
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listVBBHKemDuTHao =
      BehaviorSubject();
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listVBLienThong =
      BehaviorSubject();

  Future<void> getChiTietVanBanDi(String id) async {
    showLoading();
    final result = await _qLVBRepo.getDataChiTietVanBanDi(id);
    result.when(
      success: (res) {
        showContent();
        chiTietVanBanDiSubject.sink.add(res);
        nguoiKyDuyetVanBanDiSubject.sink.add(res.nguoiKyDuyetResponses ?? []);
        getListDinhKemWithType(res.fileDinhKemVanBanDiResponses ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }

  void getListDinhKemWithType(List<FileDinhKemVanBanDiModel> list) {
    for (final vl in list) {
      if (vl.loaiFileDinhKem == 1) {
        listPhieuTrinh.sink.add([vl]);
      } else if (vl.loaiFileDinhKem == 2) {
        listDuThao.sink.add([vl]);
      } else if (vl.loaiFileDinhKem == 3) {
        listVBBHKemDuTHao.sink.add([vl]);
      } else {
        listVBLienThong.sink.add([vl]);
      }
    }
  }
}

class HistoryUpdateDetailDocumentGoCubit
    extends BaseCubit<DetailDocumentState> {
  HistoryUpdateDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  //lich su cap nhat vb di
  BehaviorSubject<List<LichSuCapNhatVanBanDi>> lichSuCapNhatVanBanDiSubject =
      BehaviorSubject();

  Future<void> getLichSuCapNhatVanBanDi(
    String id,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getLichSuCapNhatVanBanDi(id, id);
    result.when(
      success: (res) {
        showContent();
        lichSuCapNhatVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class HistoryGiveBackDetailDocumentGoCubit
    extends BaseCubit<DetailDocumentState> {
  HistoryGiveBackDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  //lich su tra lai vb di
  BehaviorSubject<List<LichSuTraLaiVanBanDi>> lichSuTraLaiVanBanDiSubject =
      BehaviorSubject();

  Future<void> getLichSuTraLaiVanBanDi(
    String id,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getLichSuTraLaiVanBanDi(id, id);
    result.when(
      success: (res) {
        showContent();
        lichSuTraLaiVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {
        showLoading();
      },
    );
  }
}

class HistoryRecallDetailDocumentGoCubit
    extends BaseCubit<DetailDocumentState> {
  HistoryRecallDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  //lich su thu hoi vb di
  BehaviorSubject<List<LichSuThuHoiVanBanDi>> lichSuThuHoiVanBanDiSubject =
      BehaviorSubject();

  Future<void> getLichSuThuHoiVanBanDi(
    String id,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getLichSuThuHoiVanBanDi(id, id);
    result.when(
      success: (res) {
        showContent();
        lichSuThuHoiVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class SignForApprovalDetailDocumentGoCubit
    extends BaseCubit<DetailDocumentState> {
  SignForApprovalDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  //lich su ky duyet vb di
  BehaviorSubject<List<LichSuKyDuyetVanBanDi>> lichSuKyDuyetVanBanDiSubject =
      BehaviorSubject();

  Future<void> getLichSuKyDuyetVanBanDi(
    String id,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getLichSuKyDuyetVanBanDi(id, id);
    result.when(
      success: (res) {
        showContent();
        lichSuKyDuyetVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class UnsubscribeDetailDocumentGoCubit extends BaseCubit<DetailDocumentState> {
  UnsubscribeDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  //lich su huy duyet vb di
  BehaviorSubject<List<LichSuHuyDuyetVanBanDi>> lichSuHuyDuyetVanBanDiSubject =
      BehaviorSubject();

  Future<void> getLichSuHuyDuyetVanBanDi(
    String id,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getLichSuHuyDuyetVanBanDi(id, id);
    result.when(
      success: (res) {
        showContent();
        lichSuHuyDuyetVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}
