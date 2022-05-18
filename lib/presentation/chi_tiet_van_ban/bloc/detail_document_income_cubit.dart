import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_tra_lai_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

import 'detai_doccument_state.dart';

class CommonDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  CommonDetailDocumentCubit() : super(DetailDocumentInitial());
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
  DeliveryNoticeDetailDocumentCubit() : super(DetailDocumentInitial());
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
  CommentsDetailDocumentCubit() : super(DetailDocumentInitial());
  final QLVBRepository _qLVBRepo = Get.find();

  BehaviorSubject<List<DanhSachYKienXuLy>> danhSachYKienXuLySubject =
      BehaviorSubject();

  Stream<List<DanhSachYKienXuLy>> get danhSachYKienXuLyStream =>
      danhSachYKienXuLySubject.stream;

  List<DanhSachYKienXuLy> listComment = [];

  Future<void> getDanhSachYKienXuLy(String vanBanId) async {
    showLoading();
    final result = await _qLVBRepo.getDataDanhSachYKien(vanBanId);
    result.when(
      success: (res) {
        showContent();
        listComment = res.data ?? [];
        danhSachYKienXuLySubject.add(res.data ?? []);
      },
      error: (error) {
        showError();
      },
    );
  }
}

class HistoryUpdateDetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  HistoryUpdateDetailDocumentCubit() : super(DetailDocumentInitial());
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

class HistoryGiveBackDetailDocumentCubit
    extends BaseCubit<DetailDocumentState> {
  HistoryGiveBackDetailDocumentCubit() : super(DetailDocumentInitial());
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
  HistoryRecallDetailDocumentCubit() : super(DetailDocumentInitial());
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
  RelatedDocumentsDetailDocumentCubit() : super(DetailDocumentInitial());
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
