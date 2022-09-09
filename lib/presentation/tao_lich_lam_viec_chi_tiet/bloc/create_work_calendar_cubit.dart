import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/check_trung_lich_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tinh_huyen_xa_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lap_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/nhac_lai_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/calendar_work_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class CreateWorkCalCubit extends BaseCubit<CreateWorkCalState> {
  CreateWorkCalCubit() : super(TaoLichLVStateInitial());

  CalendarWorkRepository get _workCal => Get.find();

  TaoMoiBanGhiRequest requestBanGhi = TaoMoiBanGhiRequest(
    content: '<p>ưq</p>',
    scheduleId: '7765603d-4493-4f7c-8a06-2d2b7511eedb',
  );
  String selectedCountry = '';
  String selectedCountryID = '';
  BehaviorSubject<bool> lichLapTuyChinhSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> lichLapKhongLapLaiSubject =
      BehaviorSubject.seeded(false);

  BehaviorSubject<DateTime> startDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );
  BehaviorSubject<String> changeOption = BehaviorSubject();
  BehaviorSubject<bool> checkTrongNuoc = BehaviorSubject();
  BehaviorSubject<MessageModel> taoMoiBanGhiSubject = BehaviorSubject();

  BehaviorSubject<DateTime> endDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );
  BehaviorSubject<bool> isCheckAllDaySubject = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> checkChooseTypeCal = BehaviorSubject();

  Stream<bool> get isCheckAllDayStream => isCheckAllDaySubject.stream;

  BehaviorSubject<List<String>> listItemPersonSubject =
      BehaviorSubject.seeded(listPerson);

  BehaviorSubject<List<ItemSelectModel>> listColorDefaultSubject =
      BehaviorSubject();

  Stream<List<ItemSelectModel>> get listColorDefaultStream =>
      listColorDefaultSubject.stream;

  Stream<MessageModel> get taoMoiBanGhiStream => taoMoiBanGhiSubject.stream;

  Stream<DateTime> get startDateStream => startDateSubject.stream;

  Stream<DateTime> get endDateStream => endDateSubject.stream;

  Stream<List<String>> get listItemPersonStream => listItemPersonSubject.stream;
  final BehaviorSubject<List<LoaiSelectModel>> _loaiLich1 = BehaviorSubject();

  final BehaviorSubject<List<NguoiChutriModel>> _nguoiChuTri =
      BehaviorSubject();
  final BehaviorSubject<List<LoaiSelectModel>> _linhVuc = BehaviorSubject();

  final BehaviorSubject<List<NhacLaiModel>> _nhacLai =
      BehaviorSubject.seeded(listNhacLai);
  final BehaviorSubject<List<LichLapModel>> lichLapModelSubject =
      BehaviorSubject.seeded(listLichLap);

  final BehaviorSubject<List<TinhSelectModel>> tinhSelectSubject =
      BehaviorSubject();
  final BehaviorSubject<List<HuyenSelectModel>> disSubject = BehaviorSubject();
  final BehaviorSubject<List<WardModel>> wardSubject = BehaviorSubject();
  final BehaviorSubject<List<DatNuocSelectModel>> countrySubject =
      BehaviorSubject();
  final BehaviorSubject<bool> showButton = BehaviorSubject();

  Stream<List<TinhSelectModel>> get tinhSelect => tinhSelectSubject.stream;

  Stream<List<HuyenSelectModel>> get huyenSelect => disSubject.stream;

  Stream<List<WardModel>> get xaSelect => wardSubject.stream;

  Stream<List<DatNuocSelectModel>> get datNuocSelect => countrySubject.stream;

  Set<int> lichLapItem = {};
  List<int> lichLapItem1 = <int>[];

  List<int> listNgayChonTuan(String vl) {
    final List<String> lSt = vl.replaceAll(',', '').split('');
    final List<int> numbers = lSt.map(int.parse).toList();
    return numbers;
  }

  DateTime dateTimeLapDenNgay = DateTime.now();
  BehaviorSubject<DateTime> changeDateTimeSubject = BehaviorSubject();
  BehaviorSubject<bool> btnSubject = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get linhVuc => _linhVuc.stream;

  Stream<List<NhacLaiModel>> get nhacLai => _nhacLai.stream;

  Stream<List<LichLapModel>> get lichLap => lichLapModelSubject.stream;

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;

  Stream<List<LoaiSelectModel>> get loaiLich => _loaiLich1.stream;
  LoaiSelectModel? selectLoaiLich;
  String? selectLoaiLichId = 'a0602d4e-d4cb-4259-a7ea-0260360852f3';
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;
  NhacLaiModel selectNhacLai = NhacLaiModel.seeded();
  LichLapModel selectLichLap = LichLapModel.seeded();
  List<DonViModel>? donviModel;

  TinhSelectModel? tinhSelectModel = TinhSelectModel();
  HuyenSelectModel? huyenSelectModel = HuyenSelectModel();
  WardModel? wardModel = WardModel();
  DatNuocSelectModel? datNuocSelectModel = DatNuocSelectModel();
  String? dateFrom;
  String? timeFrom;
  String? dateEnd;
  String? timeEnd;
  String? typeScheduleName = '';
  String? typeScheduleId = '';
  String? dateTimeFrom;
  String? dateTimeTo;
  String? linhVucString;
  String? lichLapString;
  String? nguoiChuTriString;
  String? days;
  int? typeRepeat;
  String? dateRepeat;
  ScheduleReminder? scheduleReminder;
  bool? publishSchedule;
  List<Files>? files;
  List<File>? filesTaoLich;
  List<String> filesDelete = [];
  String? id;
  ChiTietLichLamViecModel detailCalendarWorkModel = ChiTietLichLamViecModel();
  final toast = FToast();

  bool allDay = true;

  void listeningStartDataTime(DateTime dateAndTime) {
    dateFrom = dateAndTime.formatApi;

    timeFrom = dateAndTime.formatApiFixMeet;

    startDateSubject.add(dateAndTime);
  }

  void listeningEndDataTime(DateTime dateAndTime) {
    dateEnd = dateAndTime.formatApi;
    timeEnd = dateAndTime.formatApiFixMeet;
    endDateSubject.add(dateAndTime);
  }

  Future<void> taoMoiBanGhi(TaoMoiBanGhiRequest request) async {
    final result = await _workCal.postTaoMoiBanGhi(request);
    result.when(
      success: (value) {
        taoMoiBanGhiSubject.add(value);
      },
      error: (error) {},
    );
  }

  bool checkValidateTime() {
    if (endDateSubject.value.isBefore(startDateSubject.value)) {
      return false;
    }
    return true;
  }

  String? validateInputText(String inputText) {
    if (inputText.isEmpty) {
      return S.current.khong_the_bo_trong;
    }
    return null;
  }

  Future<void> deleteFile(File deleteFile, List<File> list) async {
    list.remove(deleteFile);
  }

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;

  Future<void> loadData() async {
    showLoading();
    final queue = Queue(parallel: 6);
    unawaited(queue.add(() => _getLinhVuc()));
    unawaited(queue.add(() => _dataTypeCalendar()));
    unawaited(queue.add(() => _getLeader()));
    unawaited(queue.add(() => getDataProvince()));
    unawaited(queue.add(() => getCountry()));
    unawaited(queue.add(() => getTimeConfig()));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  void selectColor(ItemSelectModel item) {
    for (final element in listColorDefault) {
      if (element == item) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    }

    listColorDefaultSubject.add(listColorDefault);
  }

  Future<void> _dataTypeCalendar() async {
    final result = await _workCal
        .getLoaiLich(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 0));
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          selectLoaiLich = res.first;
        }
        _loaiLich1.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
    showContent();
  }

  Future<void> _getLinhVuc() async {
    final result = await _workCal
        .getLinhVuc(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          selectLinhVuc = res.first;
        }
        _linhVuc.sink.add(res);
      },
      error: (err) {},
    );
  }

  String userId = '';

  Future<void> _getLeader() async {
    final dataUser = HiveLocal.getDataUser();

    final result = await _workCal.getNguoiChuTri(
      NguoiChuTriRequest(
        isTaoHo: true,
        pageIndex: 1,
        pageSize: 100,
        userId: dataUser?.userId ?? '',
      ),
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          userId = HiveLocal.getDataUser()?.userId ?? '';
          for (final element in res) {
            if (element.userId.toString() == userId) {
              selectNguoiChuTri = element;
              break;
            }
          }
        }
        _nguoiChuTri.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> checkDuplicate({
    required BuildContext context,
    required String title,
    required String content,
    required String location,
    String? scheduleId,
    bool isEdit = false,
    bool isInside = true,
    bool? isOnly,
  }) async {
    showLoading();
    final result = await _workCal.checkDuplicate(
      CheckTrungLichRequest(
        dateFrom:
            DateTime.parse(dateFrom ?? DateTime.now().formatApi).formatApi,
        dateTo: DateTime.parse(dateEnd ?? DateTime.now().formatApi).formatApi,
        timeFrom: timeFrom ?? DateTime.now().formatApiFixMeet,
        timeTo: timeEnd ??
            (DateTime.now().add(const Duration(minutes: 30))).formatApiFixMeet,
        donViId: selectNguoiChuTri?.donViId,
        userId: selectNguoiChuTri?.userId,
        scheduleId: scheduleId,
      ),
    );
    result.when(
      success: (res) {
        showContent();
        if (res.data == true) {
          showDiaLog(
            context,
            isCenterTitle: true,
            textContent: S.current.ban_co_muon_tiep_tuc_khong,
            btnLeftTxt: S.current.khong,
            funcBtnRight: () async {
              if (!isEdit) {
                await createWorkCalendar(
                  title: title,
                  content: content,
                  location: location,
                );
              } else if (isEdit && isInside) {
                await editWorkCalendar(
                  title: title,
                  content: content,
                  location: location,
                  only: isOnly,
                );
              } else {
                await editWorkCalendarAboard(
                  title: title,
                  content: content,
                  location: location,
                  only: isOnly,
                );
              }
              //Navigator.pop(context);
            },
            title: res.code ?? '',
            btnRightTxt: S.current.dong_y,
            icon: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().colorField().withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SvgPicture.asset(
                ImageAssets.icUserMeeting,
                color: AppTheme.getInstance().colorField(),
              ),
            ),
          );
        } else {
          if (!isEdit) {
            createWorkCalendar(
              title: title,
              content: content,
              location: location,
            );
          } else if (isEdit && isInside) {
            editWorkCalendar(
              title: title,
              content: content,
              location: location,
              only: isOnly,
            );
          } else {
            editWorkCalendarAboard(
              title: title,
              content: content,
              location: location,
              only: isOnly,
            );
          }
        }
      },
      error: (error) {
        MessageConfig.show(title: S.current.error, messState: MessState.error);
      },
    );
  }

  Future<void> createWorkCalendar({
    required String title,
    required String content,
    required String location,
  }) async {
    showLoading();
    if (selectLoaiLichId == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
      tinhSelectModel?.tenTinhThanh = '';
      tinhSelectModel?.id = '';
      huyenSelectModel?.tenQuanHuyen = '';
      huyenSelectModel?.id = '';
      wardModel?.tenXaPhuong = '';
      wardModel?.id = '';
    } else {
      datNuocSelectModel?.name = '';
      datNuocSelectModel?.id = '';
    }
    final result = await _workCal.createWorkCalendar(
      title: title,
      typeScheduleId: selectLoaiLichId ?? '',
      linhVucId: selectLinhVuc?.id ?? '',
      tinhId: tinhSelectModel?.id ?? '',
      TenTinh: tinhSelectModel?.tenTinhThanh ?? '',
      huyenId: huyenSelectModel?.id ?? '',
      TenHuyen: huyenSelectModel?.tenQuanHuyen ?? '',
      xaId: wardModel?.id ?? '',
      TenXa: wardModel?.tenXaPhuong ?? '',
      country: datNuocSelectModel?.name ?? '',
      countryId: datNuocSelectModel?.id ?? '',
      dateFrom: DateTime.parse(dateFrom ?? DateTime.now().formatApi).formatApi,
      timeFrom: timeFrom ?? DateTime.now().formatApiFixMeet,
      dateTo: DateTime.parse(dateEnd ?? DateTime.now().formatApi).formatApi,
      timeTo: timeEnd ??
          (DateTime.now().add(const Duration(minutes: 30))).formatApiFixMeet,
      content: content,
      location: location,
      vehicle: '',
      expectedResults: '',
      results: '',
      status: 2,
      rejectReason: '',
      publishSchedule: publishSchedule ?? false,
      tags: '',
      isLichDonVi: false,
      isLichLanhDao: true,
      canBoChuTriId: selectNguoiChuTri?.userId ?? '',
      donViId: selectNguoiChuTri?.donViId ?? '',
      note: '',
      isAllDay: isCheckAllDaySubject.value,
      isSendMail: true,
      files: filesTaoLich,
      scheduleCoperativeRequest: donviModel ?? [],
      typeRemider: selectNhacLai.value ?? 1,
      typeRepeat: selectLichLap.id ?? 0,
      dateRepeat:
          DateTime.parse(dateFrom ?? DateTime.now().formatApi).formatApi,
      dateRepeat1: dateTimeLapDenNgay.formatApi,
      only: true,
      days: lichLapItem1,
    );
    result.when(
      success: (res) {
        emit(CreateSuccess());
        eventBus.fire(RefreshCalendar());
      },
      error: (error) {
        MessageConfig.show(title: S.current.error, messState: MessState.error);
      },
    );
    showContent();
  }

  Future<void> editWorkCalendar({
    required String title,
    required String content,
    required String location,
    bool? only,
  }) async {
    showLoading();
    final result = await _workCal.suaLichLamViec(
      title: title,
      typeScheduleId: selectLoaiLichId ?? '',
      linhVucId: selectLinhVuc?.id ?? '',
      TenTinh: tinhSelectModel?.tenTinhThanh ?? '',
      TenHuyen: huyenSelectModel?.tenQuanHuyen ?? '',
      TenXa: wardModel?.tenXaPhuong ?? '',
      dateFrom: dateFrom ?? DateTime.now().formatApi,
      timeFrom: timeFrom ?? DateTime.now().formatApiFixMeet,
      dateTo: dateEnd ?? DateTime.now().formatApi,
      timeTo: timeEnd ??
          (DateTime.now().add(const Duration(minutes: 30))).formatApiFixMeet,
      content: content,
      location: location,
      vehicle: '',
      expectedResults: '',
      results: '',
      status: 2,
      rejectReason: '',
      publishSchedule: publishSchedule ?? false,
      tags: '',
      isLichDonVi: false,
      canBoChuTriId: selectNguoiChuTri?.userId ?? '',
      donViId: selectNguoiChuTri?.donViId ?? '',
      note: '',
      id: id ?? '',
      isAllDay: isCheckAllDaySubject.value,
      isSendMail: true,
      files: filesTaoLich,
      filesDelete: filesDelete,
      scheduleCoperativeRequest: getListDonVi(donviModel ?? []),
      typeRemider: selectNhacLai.value ?? 1,
      typeRepeat: selectLichLap.id ?? 0,
      dateRepeat: dateFrom ?? DateTime.now().formatApi,
      dateRepeat1: dateTimeLapDenNgay.formatApi,
      only: only ?? true,
      days: lichLapItem1,
    );
    result.when(
      success: (res) {
        emit(CreateSuccess());
        eventBus.fire(RefreshCalendar());
      },
      error: (error) {
        MessageConfig.show(title: S.current.error, messState: MessState.error);
      },
    );
    showContent();
  }

  Future<void> editWorkCalendarAboard({
    required String title,
    required String content,
    required String location,
    bool? only,
  }) async {
    showLoading();
    final result = await _workCal.editWorkCalendarWorkAboard(
      title: title,
      typeScheduleId: selectLoaiLichId ?? '',
      linhVucId: selectLinhVuc?.id ?? '',
      TenTinh: tinhSelectModel?.tenTinhThanh ?? '',
      TenHuyen: huyenSelectModel?.tenQuanHuyen ?? '',
      TenXa: wardModel?.tenXaPhuong ?? '',
      countryId: selectedCountryID,
      dateFrom: dateFrom ?? DateTime.now().formatApi,
      timeFrom: timeFrom ?? DateTime.now().formatApiFixMeet,
      dateTo: dateEnd ?? DateTime.now().formatApi,
      timeTo: timeEnd ??
          (DateTime.now().add(const Duration(minutes: 30))).formatApiFixMeet,
      content: content,
      location: location,
      vehicle: '',
      expectedResults: '',
      results: '',
      status: 2,
      rejectReason: '',
      publishSchedule: false,
      tags: '',
      isLichDonVi: false,
      canBoChuTriId: selectNguoiChuTri?.userId ?? '',
      donViId: selectNguoiChuTri?.donViId ?? '',
      note: '',
      id: id ?? '',
      isAllDay: isCheckAllDaySubject.value,
      isSendMail: true,
      files: filesTaoLich,
      filesDelete: filesDelete,
      scheduleCoperativeRequest: getListDonVi(donviModel ?? []),
      typeRemider: selectNhacLai.value ?? 1,
      typeRepeat: selectLichLap.id ?? 0,
      dateRepeat: dateFrom ?? DateTime.now().formatApi,
      dateRepeat1: dateTimeLapDenNgay.formatApi,
      only: only ?? true,
      days: lichLapItem1,
    );
    result.when(
      success: (res) {
        emit(CreateSuccess());
        eventBus.fire(RefreshCalendar());
      },
      error: (error) {
        MessageConfig.show(title: S.current.error, messState: MessState.error);
      },
    );
    showContent();
  }

  List<DonViModel> getListDonVi(List<DonViModel> list) {
    final List<DonViModel> listResult = [];
    for (final DonViModel value in list) {
      if (value.status != StatusOfficersConst.STATUS_THU_HOI) {
        listResult.add(value);
      }
    }
    return listResult;
  }

  Future<void> getDataProvince() async {
    final result = await _workCal.tinhSelect(
      TinhSelectRequest(pageIndex: 1, pageSize: 100),
    );
    result.when(
      success: (res) {
        tinhSelectSubject.sink.add(res.items ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getDataDistrict(String provinceId) async {
    final result = await _workCal.getDistrict(
      HuyenSelectRequest(pageIndex: 1, pageSize: 100, provinceId: provinceId),
    );
    result.when(
      success: (res) {
        disSubject.sink.add(res.items ?? []);
        wardSubject.sink.add([]);
        wardModel = WardModel();
      },
      error: (error) {},
    );
  }

  Future<void> getDataWard(String districtId) async {
    final result = await _workCal.getWard(
      WardRequest(pageIndex: 1, pageSize: 100, disytrictId: districtId),
    );
    result.when(
      success: (res) {
        wardSubject.sink.add(res.items ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> getCountry() async {
    final result = await _workCal.getCountry(
      DatNuocSelectRequest(pageIndex: 1, pageSize: 100),
    );
    result.when(
      success: (res) {
        countrySubject.sink.add(res.items ?? []);
      },
      error: (error) {},
    );
  }

  void dispose() {
    _nguoiChuTri.close();
  }

  void showDialog(WidgetType type) {
    if (_showDialogSetting.hasValue) {
      if (_showDialogSetting.value == type) {
        closeDialog();
      } else {
        _showDialogSetting.add(type);
      }
    } else {
      _showDialogSetting.add(type);
    }
  }

  void closeDialog() {
    _showDialogSetting.add(null);
  }

  final timeConfigSubject = BehaviorSubject<Map<String, String>>();

  Future<void> getTimeConfig() async {
    final result = await _workCal.getConfigTime();
    result.when(
      success: (res) {
        final timeStartConfigSystem = res.timeStart ?? '00:00';
        final timeEndConfigSystem = res.timeEnd ?? '00:00';
        timeConfigSubject.sink.add({
          'timeStart': timeStartConfigSystem,
          'timeEnd': timeEndConfigSystem,
        });
      },
      error: (error) {},
    );
    showContent();
  }
}
