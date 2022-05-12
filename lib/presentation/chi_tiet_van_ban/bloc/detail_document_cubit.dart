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

class DetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  DetailDocumentCubit() : super(DetailDocumentInitial()) {
    showContent();
  }

  final QLVBRepository _QLVBRepo = Get.find();

  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listPhieuTrinh =
      BehaviorSubject();
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listDuThao =
      BehaviorSubject();
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listVBBHKemDuTHao =
      BehaviorSubject();
  BehaviorSubject<List<FileDinhKemVanBanDiModel>> listVBLienThong =
      BehaviorSubject();

  BehaviorSubject<DetailDocumentModel> detailDocumentSubject =
      BehaviorSubject<DetailDocumentModel>();

  Stream<DetailDocumentModel> get streamDetaiMission =>
      detailDocumentSubject.stream;

  //thong tin gui nhan
  ThongTinGuiNhanModel thongTinGuiNhanModel = ThongTinGuiNhanModel();
  BehaviorSubject<List<ThongTinGuiNhanModel>> thongTinGuiNhanSubject =
      BehaviorSubject();

  Stream<List<ThongTinGuiNhanModel>> get thongTinGuiNhanStream =>
      thongTinGuiNhanSubject.stream;

  //lich su cap nhat xu ly
  BehaviorSubject<List<LichSuVanBanModel>> lichSuCapNhatXuLySubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuCapNhatXuLyStream =>
      lichSuCapNhatXuLySubject.stream;

  //lich su tra lai
  BehaviorSubject<List<LichSuVanBanModel>> lichSuTraLaiSubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuTraLaiStream =>
      lichSuTraLaiSubject.stream;

  //lich su thu hoi
  BehaviorSubject<List<LichSuVanBanModel>> lichSuThuHoiSubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuThuHoiStream =>
      lichSuThuHoiSubject.stream;

  //lich su van ban lien thong
  BehaviorSubject<List<LichSuVanBanModel>> lichSuVanBanLienThongSubject =
      BehaviorSubject();

  Stream<List<LichSuVanBanModel>> get lichSuVanBanLienThongStream =>
      lichSuVanBanLienThongSubject.stream;

  //danh sach y kien xu ly
  BehaviorSubject<List<DanhSachYKienXuLy>> danhSachYKienXuLySubject =
      BehaviorSubject();

  Stream<List<DanhSachYKienXuLy>> get danhSachYKienXuLyStream =>
      danhSachYKienXuLySubject.stream;

  // DanhSachYKienXuLy inforYkienXuLy=DanhSachYKienXuLy.empty();

  final BehaviorSubject<HistoryProcessPage> _subjectJobPriliesProcess =
      BehaviorSubject<HistoryProcessPage>();

  HistoryProcessPage? process;

  List<HistoryDetailDocument> get listHistory =>
      process == null ? [] : process!.listDetailDocumentHistory;

  Stream<HistoryProcessPage> get screenJobProfilesStream =>
      _subjectJobPriliesProcess.stream;

  //chi tiet van ban di
  BehaviorSubject<ChiTietVanBanDiModel> chiTietVanBanDiSubject =
      BehaviorSubject();
  ChiTietVanBanDiModel chiTietVanBanDiModel = ChiTietVanBanDiModel();

  //nguoi ky duyet vb di
  BehaviorSubject<List<NguoiKyDuyetModel>> nguoiKyDuyetVanBanDiSubject =
      BehaviorSubject();

  //lich su thu hoi vb di
  BehaviorSubject<List<LichSuThuHoiVanBanDi>> lichSuThuHoiVanBanDiSubject =
      BehaviorSubject();

  //lich su cap nhat vb di
  BehaviorSubject<List<LichSuCapNhatVanBanDi>> lichSuCapNhatVanBanDiSubject =
      BehaviorSubject();

  //lich su tra lai vb di
  BehaviorSubject<List<LichSuTraLaiVanBanDi>> lichSuTraLaiVanBanDiSubject =
      BehaviorSubject();

  //lich su ky duyet vb di
  BehaviorSubject<List<LichSuKyDuyetVanBanDi>> lichSuKyDuyetVanBanDiSubject =
      BehaviorSubject();

  //lich su huy duyet vb di
  BehaviorSubject<List<LichSuHuyDuyetVanBanDi>> lichSuHuyDuyetVanBanDiSubject =
      BehaviorSubject();

  //chi tiet van ban den
  BehaviorSubject<ChiTietVanBanDenModel> chiTietVanBanDenSubject =
      BehaviorSubject();
  ChiTietVanBanDenModel chiTietVanBanDenModel = ChiTietVanBanDenModel();

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;


  Future<void> loadDataVanBanDi({
    required String processId,
    required String taskId,
  }) async {
    final queue = Queue(parallel: 5);
    unawaited(queue.add(() => getChiTietVanBanDi(processId)));
    unawaited(queue.add(() => getLichSuThuHoiVanBanDi(processId, taskId)));
    unawaited(queue.add(() => getLichSuTraLaiVanBanDi(processId, taskId)));
    unawaited(queue.add(() => getLichSuKyDuyetVanBanDi(processId, taskId)));
    unawaited(queue.add(() => getLichSuHuyDuyetVanBanDi(processId, taskId)));
    unawaited(queue.add(() => getLichSuCapNhatVanBanDi(processId, taskId)));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  ///
  Future<void> getChiTietVanBanDi(String id) async {
    final result = await _QLVBRepo.getDataChiTietVanBanDi(id);
    result.when(
      success: (res) {
        chiTietVanBanDiModel = res;
        chiTietVanBanDiSubject.sink.add(chiTietVanBanDiModel);
        nguoiKyDuyetVanBanDiSubject.sink.add(res.nguoiKyDuyetResponses ?? []);
        getListDinhKemWithType(res.fileDinhKemVanBanDiResponses ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuThuHoiVanBanDi(
    String id,
    String taskId,
  ) async {
    final result = await _QLVBRepo.getLichSuThuHoiVanBanDi(id, taskId);
    result.when(
      success: (res) {
        lichSuThuHoiVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuTraLaiVanBanDi(
    String id,
    String taskId,
  ) async {
    final result = await _QLVBRepo.getLichSuTraLaiVanBanDi(id, taskId);
    result.when(
      success: (res) {
        lichSuTraLaiVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuKyDuyetVanBanDi(
    String id,
    String taskId,
  ) async {
    final result = await _QLVBRepo.getLichSuKyDuyetVanBanDi(id, taskId);
    result.when(
      success: (res) {
        lichSuKyDuyetVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuHuyDuyetVanBanDi(
    String id,
    String taskId,
  ) async {
    final result = await _QLVBRepo.getLichSuHuyDuyetVanBanDi(id, taskId);
    result.when(
      success: (res) {
        lichSuHuyDuyetVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuCapNhatVanBanDi(
    String id,
    String taskId,
  ) async {
    final result = await _QLVBRepo.getLichSuCapNhatVanBanDi(id, taskId);
    result.when(
      success: (res) {
        lichSuCapNhatVanBanDiSubject.add(res.data ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getChiTietVanBanDen(
    String processId,
    String taskId,
  ) async {
    showLoading();
    final result =
        await _QLVBRepo.getDataChiTietVanBanDen(processId, taskId, false);
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

  Future<void> getThongTinGuiNhan(String id) async {
    showLoading();
    final result = await _QLVBRepo.getDataThongTinGuiNhan(id);
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

  Future<void> getLichSuVanBanLichSuCapNhat(
      String processId, String type) async {
    final result = await _QLVBRepo.getDataLichSuVanBanDen(processId, type);
    result.when(
      success: (res) {
        lichSuCapNhatXuLySubject.add(res.data ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuVanBanLichSuTraLai(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _QLVBRepo.getDataLichSuVanBanDen(processId, type);
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

  Future<void> getLichSuVanBanLichSuThuHoi(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _QLVBRepo.getDataLichSuVanBanDen(processId, type);
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

  Future<void> getLichSuVanBanLichSuLienThong(
    String processId,
    String type,
  ) async {
    showLoading();
    final result = await _QLVBRepo.getDataLichSuVanBanDen(processId, type);
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

  Future<void> getDanhSachYKienXuLy(String vanBanId) async {
    showLoading();
    final result = await _QLVBRepo.getDataDanhSachYKien(vanBanId);
    result.when(success: (res) {
      showContent();
      danhSachYKienXuLySubject.add(res.data ?? []);
    }, error: (error) {
      showError();
    });
  }

  DetailDocumentModel detailDocumentModel = DetailDocumentModel(
      soVanBan: 'M123',
      soDen: 'M123',
      trichYeu: 'Chưa có',
      daNhanBanGiay: true,
      doKhan: 'Bình thường',
      hanXL: '21/07/2021',
      hoiBao: true,
      loaiVanBan: 'Giấy mời',
      ngayBH: '21/07/2021',
      ngayDen: '21/07/2021',
      ngayHanXL: '21/07/2021',
      nguoiKy: 'Hà Kiều Anh',
      noiGui: 'Ban An toàn giao thông - TPHCM',
      phuongThucNhan: 'Điện tử',
      soBan: 200,
      soPhu: 'M123',
      soKyHieu: 'M123',
      soTrang: 56,
      vanBanQlPL: true);

  List<String> listIdFile = [];
  List<String> listIdFileReComment = [];

  void removeFileIndex(int index, bool isReComment) {
    if (isReComment) {
      listIdFileReComment.removeAt(index);
    } else {
      listIdFile.removeAt(index);
    }
  }

  DetailDocumentModel info = DetailDocumentModel.fromDetail();

  Future<void> uploadFileDocument(
      List<PlatformFile> files, bool isReComment) async {
    // service.uploadFileDocument(listFile: files).then((response) {
    //   final listFile = response.data ?? [];
    //   if (isReComment) {
    //     for (var i = 0; i < listFile.length; i++) {
    //       listIdFileReComment.add(listFile[i]);
    //     }
    //   } else {
    //     for (var i = 0; i < listFile.length; i++) {
    //       listIdFile.add(listFile[i]);
    //     }
    //   }
    // });
  }

  /// tep dinh kem

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

  void dispose() {}
}
