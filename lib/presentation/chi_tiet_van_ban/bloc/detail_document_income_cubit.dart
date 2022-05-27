import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/comment_widget.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

import 'detai_doccument_state.dart';

class CommonDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  CommonDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<ChiTietVanBanDenModel> chiTietVanBanDenSubject =
      BehaviorSubject();
  ChiTietVanBanDenModel chiTietVanBanDenModel = ChiTietVanBanDenModel();

  Future<void> getChiTietVanBanDen(
    String processId,
    String taskId,
  ) async {
    showLoading();
    final result =
        await _qLVBRepo.getDataChiTietVanBanDen(processId, taskId, false);
    result.when(
      success: (res) {
        showContent();
        chiTietVanBanDenModel = res;
        chiTietVanBanDenSubject.sink.add(chiTietVanBanDenModel);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class DeliveryNoticeDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  DeliveryNoticeDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<ThongTinGuiNhanModel>> thongTinGuiNhanSubject =
      BehaviorSubject();

  Stream<List<ThongTinGuiNhanModel>> get thongTinGuiNhanStream =>
      thongTinGuiNhanSubject.stream;

  Future<void> getThongTinGuiNhan(String id) async {
    showLoading();
    final result = await _qLVBRepo.getDataThongTinGuiNhan(id);
    result.when(
      success: (res) {
        showContent();
        thongTinGuiNhanSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class CommentsDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  CommentsDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<DanhSachYKienXuLy>> danhSachYKienXuLySubject =
      BehaviorSubject();

  Stream<List<DanhSachYKienXuLy>> get danhSachYKienXuLyStream =>
      danhSachYKienXuLySubject.stream;

  List<DanhSachYKienXuLy> listComment = [];

  Future<void> getListCommend(String id) async {
    listComment.clear();
    showLoading();
    final Queue queue = Queue(parallel: 2);
    unawaited(queue.add(() => getDanhSachYKienXuLy(id)));
    unawaited(queue.add(() => getLichSuXinYKien(id)));
    await queue.onComplete.whenComplete(() {
      showContent();
    });
  }

  Future<void> comment(
    String comment,
    List<PickImageFileModel> listFile,
  ) async {
    final listIdFile = await postListFile(listFile);
    await postComment(comment, listIdFile);
  }

  Future<void> postComment(String comment, List<String> listIdFile) async {}

  Future<List<String>> postListFile(List<PickImageFileModel> listPath) async {
    final List<String> idFileUpload = [];
    final Queue queue = Queue(parallel: listPath.length);
    for (final element in listPath) {
      unawaited(
        queue.add(
          () => uploadFile(element.path ?? '' , idFileUpload),
        ),
      );
    }
    await queue.onComplete;
    return idFileUpload;
  }

  Future<void> uploadFile(String path,  List<String> idFileUpload) async {
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

  Future<void> getDanhSachYKienXuLy(String vanBanId) async {
    final result = await _qLVBRepo.getDataDanhSachYKien(vanBanId);
    result.when(
      success: (res) {
        listComment.addAll(res.data ?? []);
        danhSachYKienXuLySubject.add(listComment);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuXinYKien(String vanBanId) async {
    showLoading();
    final result = await _qLVBRepo.getLichSuXinYKien(vanBanId);
    result.when(
      success: (res) {
        listComment.addAll(res.data ?? []);
        danhSachYKienXuLySubject.add(listComment);
      },
      error: (error) {},
    );
  }
}

class HistoryUpdateDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  HistoryUpdateDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<LichSuVanBanModel>> lichSuCapNhatXuLySubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuCapNhatXuLyStream =>
      lichSuCapNhatXuLySubject.stream;

  Future<void> getLichSuVanBanLichSuCapNhat(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getDataLichSuVanBanDen(processId, type);
    result.when(
      success: (res) {
        showContent();
        lichSuCapNhatXuLySubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class TrackTextDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  TrackTextDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<dynamic>> theoDoiVanBanSubject = BehaviorSubject();

  Stream<List<dynamic>> get theoDoiVanBanStream => theoDoiVanBanSubject.stream;

  Future<void> getTheoDoiVanBan(
    String id,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getTheoDoiVanBan(id);
    result.when(
      success: (res) {
        showContent();
        theoDoiVanBanSubject.add(res);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class HistoryGiveBackDetailDocumentCubit
    extends BaseCubit<DetailDocumentState> {
  HistoryGiveBackDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<LichSuVanBanModel>> lichSuThuHoiSubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuThuHoiStream =>
      lichSuThuHoiSubject.stream;

  Future<void> getLichSuVanBanLichSuThuHoi(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getDataLichSuVanBanDen(processId, type);
    result.when(
      success: (res) {
        showContent();
        lichSuThuHoiSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class HistoryRecallDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  HistoryRecallDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<LichSuVanBanModel>> lichSuTraLaiSubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuTraLaiStream =>
      lichSuTraLaiSubject.stream;

  Future<void> getLichSuVanBanLichSuTraLai(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getDataLichSuVanBanDen(processId, type);
    result.when(
      success: (res) {
        showContent();
        lichSuTraLaiSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class RelatedDocumentsDetailDocumentCubit
    extends BaseCubit<DetailDocumentState> {
  RelatedDocumentsDetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<LichSuVanBanModel>> lichSuVanBanLienThongSubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuVanBanLienThongStream =>
      lichSuVanBanLienThongSubject.stream;

  Future<void> getLichSuVanBanLichSuLienThong(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _qLVBRepo.getDataLichSuVanBanDen(processId, type);
    result.when(
      success: (res) {
        showContent();
        lichSuVanBanLienThongSubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}
