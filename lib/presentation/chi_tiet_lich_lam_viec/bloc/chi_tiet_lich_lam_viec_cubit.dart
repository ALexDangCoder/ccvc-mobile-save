import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/confirm_officer_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_di_thay_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/thu_hoi_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/them_y_kien_repuest/them_y_kien_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/share_key.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/trang_thai_lv.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/calendar_work_repository.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/views/show_loading_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChiTietLichLamViecCubit extends BaseCubit<ChiTietLichLamViecState> {
  BehaviorSubject<ChiTietLichLamViecModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  // chi tiet lich lam viec

  ChiTietLichLamViecCubit() : super(DetailDocumentInitial());
  List<TinhTrangBaoCaoModel> listTinhTrang = [];

  Stream<ChiTietLichLamViecModel> get chiTietLichLamViecStream =>
      chiTietLichLamViecSubject.stream;
  ChiTietLichLamViecModel chiTietLichLamViecModel = ChiTietLichLamViecModel();
  final BehaviorSubject<List<BaoCaoModel>> _listBaoCaoKetQua =
      BehaviorSubject<List<BaoCaoModel>>();
  final BehaviorSubject<List<YKienModel>> _listYKien =
      BehaviorSubject<List<YKienModel>>();

  ThanhPhanThamGiaReponsitory get dataRepo => Get.find();

  Stream<List<YKienModel>> get listYKien => _listYKien.stream;
  List<Officer> dataRecall = [];
  List<Officer> officersTmp = [];

  Stream<List<BaoCaoModel>> get listBaoCaoKetQua => _listBaoCaoKetQua.stream;

  CalendarWorkRepository get detailLichLamViec => Get.find();
  String idLichLamViec = '';
  final showButtonAddOpinion = BehaviorSubject.seeded(false);
  final showButtonApprove = BehaviorSubject.seeded(false);
  final currentUserId = HiveLocal.getDataUser()?.userId ?? '';
  String createUserId = '';

  Future<void> dataChiTietLichLamViec(String id) async {
    final rs = await detailLichLamViec.detailCalenderWork(id);
    rs.when(
      success: (data) {
        if ((data.id?.isEmpty ?? true) || data.id == null) {
          chiTietLichLamViecSubject.sink.add(ChiTietLichLamViecModel());
        }
        chiTietLichLamViecModel = data;
        chiTietLichLamViecSubject.sink.add(chiTietLichLamViecModel);
        createUserId = data.canBoChuTri?.id ?? '';
      },
      error: (error) {
        chiTietLichLamViecSubject.sink.add(ChiTietLichLamViecModel());
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
        );
      },
    );
  }

  BehaviorSubject<List<TrangThaiLvModel>> listTrangThaiSubject =
      BehaviorSubject();

  Stream<List<TrangThaiLvModel>> get streamListTrangThai =>
      listTrangThaiSubject.stream;
  List<TrangThaiLvModel> listTrangThai = [];

  List<String> nameTrangThai = [];

  Future<void> dataTrangThai() async {
    final rs = await detailLichLamViec.trangThaiLV();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    rs.when(
      success: (data) {
        listTrangThai = data;
        listTrangThaiSubject.sink.add(listTrangThai);
        for (final name in listTrangThai) {
          nameTrangThai.add(name.displayName ?? '');
        }
        prefs.setStringList(ShareKey.shareKey, nameTrangThai);
      },
      error: (error) {},
    );
  }

  // xoa lich lam viec
  CalendarWorkRepository get deleteLichLamViec => Get.find();

  Future<void> deleteCalendarWork(
    String id, {
    bool? only,
  }) async {
    ShowLoadingScreen.show();
    final rs = await detailLichLamViec.deleteCalenderWork(id, only ?? true);
    rs.when(
      success: (data) {
        MessageConfig.show(title: S.current.xoa_thanh_cong);
        eventBus.fire(RefreshCalendar());
        Get.back(result: true);
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.xoa_that_bai,
          messState: MessState.error,
        );
      },
    );
    ShowLoadingScreen.dismiss();
  }

  // huy lich lam viec
  CalendarWorkRepository get cancelLichLamViec => Get.find();

  Future<void> cancelCalendarWork(
    String id, {
    int statusId = 8,
    bool? isMulti,
  }) async {
    ShowLoadingScreen.show();
    final rs = await detailLichLamViec.cancelCalenderWork(
        id, statusId, isMulti ?? false);
    rs.when(
      success: (data) {
        if (data.succeeded ?? false) {
          MessageConfig.show(title: S.current.huy_thanh_cong);
          Get.back(result: true);
          eventBus.fire(RefreshCalendar());
        }
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.huy_that_bai,
          messState: MessState.error,
        );
      },
    );
    ShowLoadingScreen.dismiss();
  }

  Future<void> getListTinhTrang() async {
    await detailLichLamViec.getListTinhTrangBaoCao().then((value) {
      value.when(
        success: (res) {
          listTinhTrang = res;
        },
        error: (err) {},
      );
    });
  }

  final listOfficer = BehaviorSubject<List<Officer>>();
  List<Officer> listOfficerSelected = [];
  final listRecall = BehaviorSubject<List<Officer>>();

  Future<void> getOfficer(String id) async {
    final rs = await dataRepo.getOfficerJoin(id);
    rs.when(
      success: (data) {
        listOfficer.sink.add(data);
        getListStatusKhacThuHoi(data);
        listRecall.sink
            .add(data.where((element) => element.status == 0).toList());
        dataRecall = data.where((element) => element.status == 0).toList();
        officersTmp = data;
      },
      error: (error) {},
    );
  }

  void getListStatusKhacThuHoi(List<Officer> listOfficer) {
    final List<Officer> list = [];
    for (final value in listOfficer) {
      if (value.status != StatusOfficersConst.STATUS_THU_HOI) {
        list.add(value);
      }
    }
    listOfficerSelected = list;
  }

  Future<void> loadApi(String id) async {
    final queue = Queue(parallel: 5);
    showLoading();
    idLichLamViec = id;
    unawaited(queue.add(() => dataChiTietLichLamViec(id)));
    unawaited(queue.add(() => getDanhSachBaoCaoKetQua(id)));
    unawaited(queue.add(() => getDanhSachYKien(id)));
    unawaited(queue.add(() => getListTinhTrang()));
    unawaited(queue.add(() => getOfficer(id)));
    unawaited(dataTrangThai());
    await queue.onComplete;

    bool? isThamGia;
    for (final element in officersTmp) {
      if (element.userId == currentUserId &&
          (element.userId?.isNotEmpty ?? false) &&
          currentUserId.isNotEmpty) {
        showButtonAddOpinion.sink.add(true);
      } else {
        showButtonAddOpinion.sink.add(false);
      }
      if (element.canBoId == currentUserId) {
        isThamGia = element.status == StatusOfficersConst.STATUS_CHO_XAC_NHAN &&
            element.isThamGia == true;
      }
    }
    showButtonApprove.sink.add(isThamGia ?? false);
    showContent();
  }

  Future<void> getDanhSachBaoCaoKetQua(
    String id, {
    bool isReload = false,
  }) async {
    if (isReload) {
      showLoading();
    }
    final result = await detailLichLamViec.getDanhSachBaoCao(id);
    if (isReload) {
      showContent();
    }
    result.when(
      success: (res) {
        _listBaoCaoKetQua.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<bool> confirmOfficerOrDismissconfirmOfficer(
    ConfirmOfficerRequest request,
  ) async {
    bool isSucess = false;
    showLoading();
    final result = await dataRepo.confirmOfficer(request);
    showContent();
    result.when(
      success: (res) {
        isSucess = true;
      },
      error: (err) {
        isSucess = false;
      },
    );
    if (isSucess) eventBus.fire(RefreshCalendar());
    return isSucess;
  }

  Future<void> confirmOfficer(ConfirmOfficerRequest request) async {
    ShowLoadingScreen.show();
    final result = await dataRepo.confirmOfficer(request);
    result.when(
      success: (res) {
        showButtonApprove.sink.add(false);
        eventBus.fire(RefreshCalendar());
        MessageConfig.show(
          title: S.current.thanh_cong,
        );
      },
      error: (err) {
        if (err is NoNetworkException || err is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.that_bai,
            messState: MessState.error,
          );
        }
      },
    );
    ShowLoadingScreen.dismiss();
  }

  Future<void> getDanhSachYKien(String id) async {
    final result = await detailLichLamViec.getDanhSachYKien(id);
    result.when(
      success: (res) {
        _listYKien.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> xoaBaoCaoKetQua(String id) async {
    showLoading();
    final result = await detailLichLamViec.deleteBaoCaoKetQua(id);
    result.when(
      success: (res) {
        if (res.succeeded ?? false) {
          getDanhSachBaoCaoKetQua(idLichLamViec).whenComplete(() {
            showContent();
            MessageConfig.show(title: S.current.xoa_thanh_cong);
          });
        } else {
          showContent();
        }
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        }
      },
    );
  }

  String parseDate(String date) {
    final dateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date);

    // ignore: lines_longer_than_80_chars
    return '${dateTime.day} ${S.current.thang} ${dateTime.month},${dateTime.year}';
  }

  Future<void> updateBaoCaoKetQua({
    required String reportStatusId,
    required String scheduleId,
    required String content,
    required List<File> files,
    required List<String> filesDelete,
    required String id,
  }) async {
    showLoading();
    await detailLichLamViec
        .updateBaoCaoKetQua(
      reportStatusId,
      scheduleId,
      content,
      files,
      filesDelete,
      id,
    )
        .then((value) {
      value.when(
        success: (res) {
          if (res.succeeded ?? false) {
            getDanhSachBaoCaoKetQua(idLichLamViec).whenComplete(() {
              showContent();
              MessageConfig.show(title: S.current.sua_thanh_cong);
            });
          } else {
            showContent();
          }
        },
        error: (error) {
          if (error is NoNetworkException || error is TimeoutException) {
            MessageConfig.show(
              title: S.current.no_internet,
              messState: MessState.error,
            );
          }
        },
      );
    });
  }

  Future<void> themYKien({
    required String content,
    required String? phienHopId,
    required String scheduleId,
    required String? scheduleOpinionId,
  }) async {
    ShowLoadingScreen.show();
    final ThemYKienRequest themYKienRequest = ThemYKienRequest(
      content: content,
      phienHopId: phienHopId,
      scheduleId: scheduleId,
      scheduleOpinionId: scheduleOpinionId,
    );
    await detailLichLamViec.themYKien(themYKienRequest);
    ShowLoadingScreen.dismiss();
  }

  Future<void> recallCalendar({
    bool? isMulti,
  }) async {
    ShowLoadingScreen.show();
    final List<Officer> tmp = List.from(
      dataRecall.where((element) => element.status == 4),
    );
    final request = tmp
        .map(
          (e) => RecallRequest(
            id: e.id,
            status: e.status ?? 4,
            canBoId: e.canBoId,
            donViId: e.donViId,
            scheduleId: e.scheduleId,
          ),
        )
        .toList();
    final result =
        await detailLichLamViec.recallWorkCalendar(isMulti ?? false, request);
    result.when(
      success: (success) {
        //eventBus.fire(RefreshCalendar());
        MessageConfig.show(title: S.current.thu_hoi_lich_thanh_cong);
        Get.back(result: true);
        emit(SuccessChiTietLichLamViecState());
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.thu_hoi_lich_that_bai,
          messState: MessState.error,
        );
      },
    );
    ShowLoadingScreen.dismiss();
  }

  // check hiển thị popup
  int checkXoa(ChiTietLichLamViecModel dataModel) {
    return dataModel.scheduleCoperatives?.indexWhere(
          (element) => element.status == StatusOfficersConst.STATUS_THAM_GIA,
        ) ??
        StatusOfficersConst.STATUS_DEFAULT;
  }

  int checkThuHoi(ChiTietLichLamViecModel dataModel) {
    return dataModel.scheduleCoperatives?.indexWhere(
          (element) =>
              element.status == StatusOfficersConst.STATUS_CHO_XAC_NHAN,
        ) ??
        StatusOfficersConst.STATUS_DEFAULT;
  }

  String nguoiDuocMoi(ChiTietLichLamViecModel dataModel) {
    return dataModel.scheduleCoperatives
            ?.firstWhere(
              (element) => element.canBoId == currentUserId,
              orElse: () => ScheduleCoperatives(),
            )
            .canBoId ??
        '';
  }

  //checkMenuLichHuy,LichThuHoi
  int checkNguoiThamGiaLichThuHoi(ChiTietLichLamViecModel dataModel) {
    return dataModel.scheduleCoperatives?.indexWhere(
          (element) =>
              element.status == StatusOfficersConst.STATUS_THU_HOI &&
              element.canBoId == currentUserId,
        ) ??
        StatusOfficersConst.STATUS_DEFAULT;
  }

  bool checkMenuLichThuHoi(ChiTietLichLamViecModel dataModel) {
    return checkNguoiThamGiaLichThuHoi(dataModel) >=
        StatusOfficersConst.STATUS_CHO_XAC_NHAN;
  }

  String canBoChuTri(ChiTietLichLamViecModel dataModel) {
    return dataModel.canBoChuTri?.id ?? '';
  }

  String nguoiTaoId(ChiTietLichLamViecModel dataModel) {
    return dataModel.createBy?.id ?? '';
  }

  int checkHuyXacNhan(ChiTietLichLamViecModel dataModel) {
    return dataModel.scheduleCoperatives?.indexWhere(
          (element) =>
              element.status == StatusOfficersConst.STATUS_THAM_GIA &&
              element.canBoId == currentUserId,
        ) ??
        StatusOfficersConst.STATUS_DEFAULT;
  }

  int checkXacNhanLai(ChiTietLichLamViecModel dataModel) {
    return dataModel.scheduleCoperatives?.indexWhere(
          (element) =>
              element.status == StatusOfficersConst.STATUS_TU_CHOI &&
              element.canBoId == currentUserId,
        ) ??
        StatusOfficersConst.STATUS_DEFAULT;
  }

  bool checkChoSuaLich(ChiTietLichLamViecModel dataModel) {
    return canBoChuTri(dataModel) == currentUserId ||
        nguoiTaoId(dataModel) == currentUserId; //===sualich===huylich
  }

  bool checkChoThuHoi(ChiTietLichLamViecModel dataModel) {
    return checkThuHoi(dataModel) != StatusOfficersConst.STATUS_DEFAULT &&
        (canBoChuTri(dataModel) == currentUserId ||
            nguoiTaoId(dataModel) == currentUserId);
  }

  bool checkChoYKien(ChiTietLichLamViecModel dataModel) {
    return nguoiTaoId(dataModel) == currentUserId ||
        nguoiDuocMoi(dataModel) == currentUserId ||
        canBoChuTri(dataModel) == currentUserId;
  }

  bool checkChoBaoCaoKetQua(ChiTietLichLamViecModel dataModel) {
    final validTime = DateTime.parse(
      dataModel.dateTimeTo ?? DateTime.now().toString(),
    ).isBefore(DateTime.now());
    final validPerson = (dataModel.createBy?.id ?? '') == currentUserId ||
        nguoiDuocMoi(dataModel) == currentUserId ||
        dataModel.canBoChuTri?.id == currentUserId;
    return validTime && validPerson;
  }

  bool checkChoxoa(ChiTietLichLamViecModel dataModel) {
    return (checkXoa(dataModel) == StatusOfficersConst.STATUS_DEFAULT) &&
        checkChoSuaLich(dataModel); //=
  }

  bool checkChoHuyXacNhan(ChiTietLichLamViecModel dataModel) {
    return checkHuyXacNhan(dataModel) >=
        StatusOfficersConst.STATUS_CHO_XAC_NHAN;
  }

  bool checkChoXacNhanLai(ChiTietLichLamViecModel dataModel) {
    return checkXacNhanLai(dataModel) >=
        StatusOfficersConst.STATUS_CHO_XAC_NHAN;
  }

  void dispose() {
    _listBaoCaoKetQua.close();
    chiTietLichLamViecSubject.close();
    _listYKien.close();
  }
}

///Báo cáo kết quả
class BaoCaoKetQuaCubit extends ChiTietLichLamViecCubit {
  String reportStatusId = '';
  Set<File> files = {};
  List<FileModel> fileInit = [];
  List<FileModel> fileDelete = [];
  String content = '';
  TinhTrangBaoCaoModel? tinhTrangBaoCaoModel;
  final BehaviorSubject<bool> updateFilePicker = BehaviorSubject<bool>();
  final BehaviorSubject<bool> deleteFileInit = BehaviorSubject<bool>();

  BaoCaoKetQuaCubit({
    this.content = '',
    this.tinhTrangBaoCaoModel,
    this.fileInit = const [],
  }) {
    reportStatusId = tinhTrangBaoCaoModel?.id ?? '';
  }

  Future<void> createScheduleReport(String scheduleId, String content) async {
    ShowLoadingScreen.show();
    final result = await detailLichLamViec.taoBaoCaoKetQua(
      reportStatusId,
      scheduleId,
      content,
      files.toList(),
    );
    ShowLoadingScreen.dismiss();
    result.when(
      success: (res) {
        MessageConfig.show(title: S.current.bao_cao_ket_qua_thanh_cong);
        emit(SuccessChiTietLichLamViecState());
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.bao_cao_ket_qua_that_bai,
            messState: MessState.error,
          );
        }
      },
    );
  }

  Future<void> editScheduleReport({
    required String scheduleId,
    required String content,
    required String id,
  }) async {
    ShowLoadingScreen.show();
    final result = await detailLichLamViec.suaBaoCaoKetQua(
      id: id,
      scheduleId: scheduleId,
      content: content,
      files: files.toList(),
      idFileDelele: fileDelete.map((e) => e.id ?? '').toList(),
      reportStatusId: reportStatusId,
    );
    ShowLoadingScreen.dismiss();
    result.when(
      success: (res) {
        MessageConfig.show(title: S.current.sua_bao_cao_ket_qua_thanh_cong);
        emit(SuccessChiTietLichLamViecState());
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else {
          MessageConfig.show(
            title: S.current.sua_bao_cao_ket_qua_that_bai,
            messState: MessState.error,
          );
        }
      },
    );
  }

  //cu can bo di thay
  Future<bool> cuCanBoDiThayLichLamViec({
    required List<CuCanBoDiThayLichLamViecRequest> canBoDiThay,
  }) async {
    final DataCuCanBoDiThayLichLamViecRequest
        dataCuCanBoDiThayLichLamViecRequest =
        DataCuCanBoDiThayLichLamViecRequest(
            scheduleId: "", scheduleOperativeId: '', canBoDiThay: canBoDiThay);
    final result = await detailLichLamViec
        .cuCanBoDiThayLichLamViec(dataCuCanBoDiThayLichLamViecRequest);
    result.when(success: (res) {}, error: (error) {});
    return true;
  }

  //cu can bo
  Future<bool> cuCanBoLichLamViec({
    required List<CuCanBoLichLamViecRequest> cuCanBo,
  }) async {
    final DataCuCanBoLichLamViecRequest dataCuCanBoLichLamViecRequest =
        DataCuCanBoLichLamViecRequest(scheduleId: '', canBoDiThay: cuCanBo);
    final result = await detailLichLamViec
        .cuCanBoLichLamViec(dataCuCanBoLichLamViecRequest);
    result.when(success: (res) {}, error: (error) {});
    return true;
  }

  bool checkLenghtFile() {
    int sum = 0;
    for (final element in files) {
      sum = sum + element.lengthSync();
    }
    for (final element in fileInit) {
      sum += element.fileLength?.toInt() ?? 0;
    }
    if (sum > MaxSizeFile.MAX_SIZE_30MB) {
      return false;
    }
    return true;
  }
}
