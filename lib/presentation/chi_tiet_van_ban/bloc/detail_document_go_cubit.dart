import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/cho_y_kien_request.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_tra_lai_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detai_doccument_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

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
    final List<FileDinhKemVanBanDiModel> phieuTrinh = [];
    final List<FileDinhKemVanBanDiModel> duThao = [];
    final List<FileDinhKemVanBanDiModel> vBBHKemDuTHao = [];
    final List<FileDinhKemVanBanDiModel> vBLienThong = [];
    for (final vl in list) {
      if (vl.loaiFileDinhKem == 1) {
        phieuTrinh.add(vl);
      } else if (vl.loaiFileDinhKem == 2) {
        duThao.add(vl);
      } else if (vl.loaiFileDinhKem == 3) {
        vBBHKemDuTHao.add(vl);
      } else {
        vBLienThong.add(vl);
      }
    }
    listPhieuTrinh.sink.add(phieuTrinh);
    listDuThao.sink.add(duThao);
    listVBBHKemDuTHao.sink.add(vBBHKemDuTHao);
    listVBLienThong.sink.add(vBLienThong);
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

class CommentDetailDocumentGoCubit extends BaseCubit<DetailDocumentState> {
  CommentDetailDocumentGoCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<DanhSachChoYKien>> yKienXuLYSubject = BehaviorSubject();

  Future<void> getDanhSachYKien(String id) async {
    showLoading();
    final result = await _qLVBRepo.getYKienXuLyVBDi(id);
    result.when(
      success: (data) {
        yKienXuLYSubject.sink.add(data);
      },
      error: (_) {},
    );
    showContent();
  }

  Future<void> comment({
    required String comment,
    required List<PickImageFileModel> listData,
    required String processId,
    String? idParent,
  }) async {
    showLoading();
    final listIdFile = await postListFile(listData);
    final isSuccess = await postComment(
      comment.trim(),
      listIdFile,
      processId,
      idParent,
    );
    showContent();
    if (isSuccess) {
      showSuccessComment();
      showLoading();
      await getDanhSachYKien(processId);
      showContent();
    } else {
      showFailComment();
    }
  }

  Future<bool> postComment(
    String comment,
    List<String> listIdFile,
    String documentId,
    String? idParent,
  ) async {
    bool dataReturn = false;
    final request = GiveCommentRequest(
      files: listIdFile,
      idProcess: documentId,
      noiDung: comment.trim(),
    );
    if (idParent == null) {
      request.hashValue = 'SHA256';
    } else {
      request.idParent = idParent;
    }
    final result = await _qLVBRepo.giveComment(request);
    result.when(
      success: (isSuccess) {
        dataReturn = isSuccess;
      },
      error: (e) {
        dataReturn = false;
      },
    );
    return dataReturn;
  }

  Future<List<String>> postListFile(List<PickImageFileModel> listPath) async {
    if (listPath.isEmpty) return [];
    final List<String> idFileUpload = [];
    final Queue queue = Queue(parallel: listPath.length);
    for (final element in listPath) {
      unawaited(
        queue.add(
          () => uploadFile(element.path ?? '', idFileUpload),
        ),
      );
    }
    await queue.onComplete;
    return idFileUpload;
  }

  Future<void> uploadFile(String path, List<String> idFileUpload) async {
    final result = await _qLVBRepo.postFile(
      path: File(path),
    );
    result.when(
      success: (data) {
        if (data != 'false') {
          idFileUpload.add(data);
        }
      },
      error: (error) {},
    );
  }

  void showSuccessComment() {
    MessageConfig.show(
      title: S.current.cho_y_kien_thanh_cong,
    );
  }

  void showFailComment() {
    MessageConfig.show(
      title: S.current.cho_y_kien_that_bai,
      messState: MessState.error,
    );
  }
}
