import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';
import 'detai_doccument_state.dart';
import 'package:file_picker/file_picker.dart';

class DetailDocumentCubit extends BaseCubit<DetailDocumentState> {
  DetailDocumentCubit() : super(DetailDocumentInitial());
  bool expanded = false;
  bool expanded2 = false;
  bool expanded3 = false;
  bool expanded4 = false;
  bool expanded5 = false;
  bool expanded6 = false;

  final QLVBRepository _QLVBRepo = Get.find();

  BehaviorSubject<DetailDocumentModel> detailDocumentSubject =
      BehaviorSubject<DetailDocumentModel>();

  Stream<DetailDocumentModel> get streamDetaiMission =>
      detailDocumentSubject.stream;

  BehaviorSubject<DetailDocumentProfileSend> detailDocumentGuiNhan =
      BehaviorSubject<DetailDocumentProfileSend>();

  Stream<DetailDocumentProfileSend> get streamDetaiGuiNhan =>
      detailDocumentGuiNhan.stream;

  // BehaviorSubject<HistoryDetailDocument> detailDocumentHistorySubject =
  // BehaviorSubject<HistoryDetailDocument>();
  //
  // Stream<HistoryDetailDocument> get streamDetailHistorySubject =>
  //     detailDocumentHistorySubject.stream;

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
  //chi tiet van ban den
  BehaviorSubject<ChiTietVanBanDenModel> chiTietVanBanDenSubject =
  BehaviorSubject();
  ChiTietVanBanDenModel chiTietVanBanDenModel = ChiTietVanBanDenModel();

  final BehaviorSubject<WidgetType?> _showDialogSetting =
  BehaviorSubject<WidgetType?>();

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;
  Future<void> loadDataVanBanDen({required String processId, required String taskId,}) async {
    final queue = Queue(parallel: 1);
    unawaited(queue.add(() => getChiTietVanBanDen(processId,taskId)));

    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  Future<void> getChiTietVanBanDi(String id) async {
    final result = await _QLVBRepo.getDataChiTietVanBanDi(id);
    result.when(
      success: (res) {
        chiTietVanBanDiModel = res;
        chiTietVanBanDiSubject.sink.add(chiTietVanBanDiModel);
      },
      error: (error) {},
    );
  }
  Future<void> getChiTietVanBanDen(String processId, String taskId,) async {
    final result = await _QLVBRepo.getDataChiTietVanBanDen(processId,taskId,false);
    result.when(
      success: (res) {
        chiTietVanBanDenModel = res;
        chiTietVanBanDenSubject.sink.add(chiTietVanBanDenModel);
      },
      error: (error) {},
    );
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

  DetailDocumentProfileSend thongTinGuiNhan = DetailDocumentProfileSend(
      nguoiGui: 'Văn thu bọ',
      donViGui: 'UBND Đồng Nai',
      donViNhan: 'UBND Đồng Nai',
      trangThai: 'Chờ vào sổ',
      nguoiNhan: 'Hà Kiều Anh',
      thoiGian: '10/09/2021 | 17:06:53',
      vaiTro: 'Chủ trì');

  // List<DetailDocumentModel> thongTinGuiNhan = [];

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

  void dispose() {}
}
