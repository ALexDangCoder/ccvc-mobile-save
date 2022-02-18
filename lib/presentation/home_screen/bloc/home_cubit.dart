import 'dart:async';
import 'dart:developer';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/home/nhiem_vu_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_model.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_hinh_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
import 'package:ccvc_mobile/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/domain/model/home/tong_hop_nhiem_vu_model.dart';
import 'package:ccvc_mobile/domain/model/select_key/select_key_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/home_repository/home_repository.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_state.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(MainStateInitial());
  HomeRepository get homeRep => Get.find();
  final BehaviorSubject<List<WidgetModel>> _getConfigWidget =
      BehaviorSubject<List<WidgetModel>>();
  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();
  final BehaviorSubject<List<TinhHuongKhanCapModel>> _tinhHuongKhanCap =
      BehaviorSubject<List<TinhHuongKhanCapModel>>();
  final BehaviorSubject<DataUser> _userInformation =
      BehaviorSubject<DataUser>();
  final BehaviorSubject<TodoListModel> _getTodoList =
      BehaviorSubject<TodoListModel>();
  final BehaviorSubject<bool> _showAddTag = BehaviorSubject<bool>();

  final BehaviorSubject<DataUser> _getUserInformation =
      BehaviorSubject<DataUser>();
  final BehaviorSubject<DateModel> _getDate = BehaviorSubject<DateModel>();

  Future<void> _getTinhHuongKhanCap() async {
    final result = await homeRep.getTinhHuongKhanCap();
    result.when(
      success: (res) {
        _tinhHuongKhanCap.sink.add(res);
      },
      error: (err) {},
    );
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

  Future<void> loadApi() async {
    final queue = Queue(parallel: 4);

    showLoading();
    unawaited(queue.add(() => getUserInFor()));
    unawaited(queue.add(() => getDate()));
    unawaited(queue.add(() => _getTinhHuongKhanCap()));
    unawaited(queue.add(() => configWidget()));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  void orderWidget(List<WidgetModel> listWidgetConfig) {
    _getConfigWidget.sink.add(listWidgetConfig);
  }

  Future<void> getUserInFor() async {
    final result = await homeRep.getPhamVi();
    result.when(
        success: (res) {
          final dataUser = HiveLocal.getDataUser();
          dataUser?.userInformation?.chucVu = res.chucVu;
          _getUserInformation.sink.add(dataUser ?? DataUser());
        },
        error: (err) {});
  }

  Future<void> getDate() async {
    final now = DateTime.now();
    final result = await homeRep.getLunarDate(now.toString());
    result.when(
      success: (res) {
        _getDate.sink.add(res);
      },
      error: (err) {},
    );
  }

  void dispose() {
    _showDialogSetting.close();
    _tinhHuongKhanCap.close();
    _getTodoList.close();
    _userInformation.close();
    _showAddTag.close();
    _getUserInformation.close();
    _getDate.close();
  }

  Stream<DateModel> get getDateStream => _getDate.stream;
  Stream<DataUser> get getUserInformation => _getUserInformation.stream;
  Stream<List<WidgetModel>> get getConfigWidget => _getConfigWidget.stream;
  Stream<DataUser> get userInformation => _userInformation;
  Stream<List<TinhHuongKhanCapModel>> get tinhHuongKhanCap =>
      _tinhHuongKhanCap.stream;
  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;
  Stream<TodoListModel> get getTodoList => _getTodoList.stream;
}

/// Get Config Widget
extension GetConfigWidget on HomeCubit {
  Future<void> configWidget() async {
    final result = await homeRep.getDashBoardConfig();
    result.when(
      success: (res) {
        _getConfigWidget.sink.add(res);
      },
      error: (err) {},
    );
  }
}

///Báo chí mạng xã hội
class BaoChiMangXaHoiCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<PressNetWorkModel>> _getPressNetWork =
      BehaviorSubject<List<PressNetWorkModel>>();
  final BehaviorSubject<List<TagModel>> _getTag =
      BehaviorSubject<List<TagModel>>();
  void getPress() {
    _getTag.sink.add(FakeData.tag);
    _getPressNetWork.sink.add(FakeData.fakeDataPress);
  }

  void selectTag(TagModel tagModel) {
    final oldSelect = _getTag.value.indexWhere(
      (element) => element.select == true,
    );
    _getTag.value[oldSelect].select = false;
    final newSelect = _getTag.value.indexWhere(
      (element) => element.title == tagModel.title,
    );
    _getTag.value[newSelect].select = true;
    _getTag.sink.add(_getTag.value);
  }

  void showAddTag() {}
  Stream<List<TagModel>> get getTag => _getTag.stream;

  Stream<List<PressNetWorkModel>> get getPressNetWork =>
      _getPressNetWork.stream;
  @override
  void dispose() {
    // TODO: implement dispose
    _getTag.close();
    _getPressNetWork.close();
  }
}

///Danh sách công việc
extension DanhSachCongViec on HomeCubit {
  void tickerListWord({required TodoModel todo, bool removeDone = true}) {
    final data = _getTodoList.value;
    if (removeDone) {
      _removeInsertImportant(data, todo);
    } else {
      _removeInsertDone(data, todo);
    }
  }

  void addTodo(String label) {
    final data = _getTodoList.value;
    data.listTodoImportant.insert(
      0,
      TodoModel(
        important: true,
        inUsed: true,
        isDeleted: false,
        isTicked: false,
        label: label,
      ),
    );
    _getTodoList.sink.add(data);
  }

  void _removeInsertImportant(TodoListModel data, TodoModel todo) {
    final result = data.listTodoDone.removeAt(
      data.listTodoDone.indexWhere((element) => element.id == todo.id),
    );

    data.listTodoImportant.insert(0, result..important = true);
    _getTodoList.sink.add(
      TodoListModel(
        listTodoImportant: data.listTodoImportant,
        listTodoDone: data.listTodoDone,
      ),
    );
  }

  void _removeInsertDone(TodoListModel data, TodoModel todo) {
    final result = data.listTodoImportant.removeAt(
      data.listTodoImportant.indexWhere((element) => element.id == todo.id),
    );

    data.listTodoDone.insert(0, result..important = false);
    _getTodoList.sink.add(
      data,
    );
  }

  String changeLabelTodo(String newLabel, TodoModel todo) {
    final data = _getTodoList.value;
    if (newLabel == todo.label) {
      return newLabel;
    } else if (newLabel.isEmpty) {
      return todo.label.toString();
    }
    final index =
        data.listTodoImportant.indexWhere((element) => element.id == todo.id);
    final result = data.listTodoImportant.removeAt(
      index,
    );
    data.listTodoImportant.insert(0, result..label = newLabel);
    _getTodoList.sink.add(
      data,
    );
    return newLabel;
  }

  void tickerQuanTrongTodo(TodoModel todo, {bool removeDone = true}) {
    final data = _getTodoList.value;
    if (removeDone) {
      final result = data.listTodoDone.removeAt(
        data.listTodoDone.indexWhere((element) => element.id == todo.id),
      );
      data.listTodoDone.insert(0, result..isTicked = !(todo.isTicked ?? false));
    } else {
      final result = data.listTodoImportant.removeAt(
        data.listTodoImportant.indexWhere((element) => element.id == todo.id),
      );
      data.listTodoImportant
          .insert(0, result..isTicked = !(todo.isTicked ?? false));
    }
    _getTodoList.sink.add(data);
  }

  void getToDoList() {
    final data = FakeData.listTodoWork;
    final result = TodoListModel(
      listTodoDone: data
          .where((element) => element.toDoStatus == ToDoStatus.done)
          .toList(),
      listTodoImportant: data
          .where((element) => element.toDoStatus == ToDoStatus.unfinished)
          .toList(),
    );
    _getTodoList.sink.add(result);
  }
}

/// Tổng hợp nhiệm vụ
class TongHopNhiemVuCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<TongHopNhiemVuModel>> _getTongHopNhiemVu =
      BehaviorSubject<List<TongHopNhiemVuModel>>();
  TongHopNhiemVuCubit() {
    _getKey();
  }
  void _getKey() {
    final data = HiveLocal.getSelect(SelectKeyPath.KEY_DASHBOARDNV_TIME);
    final type =
        HiveLocal.getSelect(SelectKeyPath.KEY_DASHBOARD_TONGHOPNV_TYPE);
    if (data != null) {
      startDate = DateTime.parse(data.startDate);
      endDate = DateTime.parse(data.endDate);
      selectKeyTime = data.selectKey;
    }
    if (type != null) {
      selectKeyDonVi = type.selectKey;
    }
  }

  Future<void> getDataTongHopNhiemVu() async {
    showLoading();
    bool isCaNhan = false;
    if (selectKeyDonVi == SelectKey.DON_VI) {
      isCaNhan = false;
    } else {
      isCaNhan = true;
    }
    final result = await homeRep.getTongHopNhiemVu(
      isCaNhan,
      startDate.toString(),
      endDate.toString(),
    );
    showContent();
    result.when(
      success: (res) {
        _getTongHopNhiemVu.sink.add(res);
      },
      error: (err) {},
    );
  }

  @override
  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;

    HiveLocal.setSelect(
      path: SelectKeyPath.KEY_DASHBOARD_TONGHOPNV_TYPE,
      selectkeyModel: SelectkeyModel(key: selectKeyDonVi.toString()),
    );
    getDataTongHopNhiemVu();
    selectKeyDialog.sink.add(true);
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      HiveLocal.setSelect(
        path: SelectKeyPath.KEY_DASHBOARDNV_TIME,
        selectkeyModel: SelectkeyModel(
          key: selectKeyTime.toString(),
          startDate: startDate.toString(),
          endDate: endDate.toString(),
        ),
      );
      getDataTongHopNhiemVu();
    }
    selectKeyDialog.sink.add(true);
  }

  Stream<List<TongHopNhiemVuModel>> get getTonghopNhiemVu =>
      _getTongHopNhiemVu.stream;
  @override
  void dispose() {
    // TODO: implement dispose
    _getTongHopNhiemVu.close();
  }
}

/// Tình hình xử lý văn bản
class TinhHinhXuLyCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDen =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDi =
      BehaviorSubject<DocumentDashboardModel>();
  void getDocument() {
    final data = HiveLocal.getSelect(SelectKeyPath.KEY_DASH_BOARD_TONG_HOP_NV);
    if (data != null) {
      startDate = DateTime.parse(data.startDate);
      endDate = DateTime.parse(data.endDate);
      selectKeyTime = data.selectKey;
    }

    callApi(startDate.toString(), endDate.toString());
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      HiveLocal.setSelect(
        path: SelectKeyPath.KEY_DASH_BOARD_TONG_HOP_NV,
        selectkeyModel: SelectkeyModel(
          key: selectKeyTime.toString(),
          startDate: startDate.toString(),
          endDate: endDate.toString(),
        ),
      );
      callApi(startDate.toString(), endDate.toString());
    }
    selectKeyDialog.sink.add(true);
  }

  Future<void> callApi(String startDate, String endDate) async {
    showLoading();
    final queue = Queue(parallel: 2);
    unawaited(
      queue.add(
        () => homeRep.getVBden(startDate, endDate).then(
          (value) {
            value.when(
              success: (res) {
                _getDocumentVBDen.sink.add(res);
              },
              error: (err) {},
            );
          },
        ),
      ),
    );
    unawaited(
      queue.add(
        () => homeRep.getVBdi(startDate, endDate).then(
          (value) {
            value.when(
              success: (res) {
                _getDocumentVBDi.sink.add(res);
              },
              error: (err) {},
            );
          },
        ),
      ),
    );
    await queue.onComplete;
    showContent();
  }

  Stream<DocumentDashboardModel> get getDocumentVBDi => _getDocumentVBDi.stream;
  Stream<DocumentDashboardModel> get getDocumentVBDen =>
      _getDocumentVBDen.stream;
  @override
  void dispose() {
    _getDocumentVBDen.close();
    _getDocumentVBDi.close();
  }
}

///Văn bản
class VanBanCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<DocumentModel>> _getDanhSachVb =
      BehaviorSubject<List<DocumentModel>>();
  VanBanCubit() {
    getKey();
  }
  Stream<List<DocumentModel>> get getDanhSachVb => _getDanhSachVb.stream;
  int trangThaiFilter = 0;
  List<String> maTrangThai = ['CHO_VAO_SO'];
  bool isDanhSachChoCapSo = false;
  bool isDanhSachChoTrinhKy = false;
  bool isDanhSachChoXuLy = false;
  bool isDanhSachDaBanHanh = true;
  bool isChoYKien = false;
  SelectKey? selectKey;
  Future<void> callApiVB() async {
    showLoading();
    final result = await homeRep.getDanhSachVanBan(
      DanhSachVBRequest(
        maTrangThai: maTrangThai,
        index: 1,
        isChoYKien: isChoYKien,
        isSortByDoKhan: true,
        thoiGianStartFilter: startDate.toString(),
        thoiGianEndFilter: endDate.toString(),
        size: 10,
      ),
    );
    showContent();
    result.when(
      success: (res) {
        _getDanhSachVb.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> callSearchVB() async {
    showLoading();
    final result = await homeRep.searchDanhSachVanBan(
      SearchVBRequest(
        trangThaiFilter: [trangThaiFilter],
        index: 1,
        isDanhSachChoCapSo: isDanhSachChoCapSo,
        isDanhSachChoTrinhKy: isDanhSachChoTrinhKy,
        isDanhSachChoXuLy: isDanhSachChoXuLy,
        isDanhSachDaBanHanh: isDanhSachDaBanHanh,
        isSortByDoKhan: true,
        ngayTaoEndSearch: endDate.toString(),
        ngayTaoStartSearch: startDate.toString(),
        size: 10,
      ),
    );
    showContent();
    result.when(
      success: (res) {
        _getDanhSachVb.sink.add(res);
      },
      error: (err) {},
    );
  }

  void selectTrangThaiVanBan(SelectKey selectKey, {bool filterTime = false}) {
    if (this.selectKey == selectKey && !filterTime) {
      return;
    }
    this.selectKey = selectKey;

    switch (selectKey) {
      case SelectKey.CHO_VAO_SO:
        isChoYKien = false;
        maTrangThai = ['CHO_VAO_SO'];
        callApiVB();
        break;
      case SelectKey.CHO_XU_LY_VB_DI:
        isDanhSachChoCapSo = false;
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = true;
        isDanhSachDaBanHanh = false;
        trangThaiFilter = 2;
        callSearchVB();
        break;
      case SelectKey.CHO_XU_LY_VB_DEN:
        maTrangThai = ["CHO_XU_LY", "CHO_PHAN_XU_LY"];
        isChoYKien = false;
        callApiVB();
        break;
      case SelectKey.CHO_TRINH_KY:
        isDanhSachChoCapSo = false;
        isDanhSachChoTrinhKy = true;
        isDanhSachChoXuLy = false;
        isDanhSachDaBanHanh = false;
        trangThaiFilter = 1;
        callSearchVB();
        break;
      case SelectKey.CHO_CHO_Y_KIEN_VB_DEN:
        isChoYKien = true;
        maTrangThai = [];
        callApiVB();
        break;
      case SelectKey.CHO_CAP_SO:
        isDanhSachChoCapSo = true;
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaBanHanh = false;
        trangThaiFilter = 5;
        callSearchVB();
        break;
      case SelectKey.CHO_BAN_HANH:
        isDanhSachChoCapSo = false;
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaBanHanh = true;
        trangThaiFilter = 6;
        callSearchVB();
        break;
      default:
        {}
    }
  }

  @override
  void selectDate(
      {required SelectKey selectKey,
      required DateTime startDate,
      required DateTime endDate}) {
    if (selectKey != selectKeyTime) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      HiveLocal.setSelect(
        path: SelectKeyPath.KEY_DASHBOARDVB,
        selectkeyModel: SelectkeyModel(
          key: selectKeyTime.toString(),
          startDate: startDate.toString(),
          endDate: endDate.toString(),
        ),
      );
      selectKeyDialog.sink.add(true);
      selectTrangThaiVanBan(this.selectKey ?? SelectKey.CHO_VAO_SO,
          filterTime: true);
    }
  }

  void getKey() {
    final data = HiveLocal.getSelect(SelectKeyPath.KEY_DASHBOARDVB);
    if (data != null) {
      startDate = DateTime.parse(data.startDate);
      endDate = DateTime.parse(data.endDate);
      selectKeyTime = data.selectKey;
    }
  }
}

///Ý kiến người dân
class YKienNguoiDanCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<DocumentModel>> _getYKien =
      BehaviorSubject<List<DocumentModel>>();
  DataUser? dataUser;
  String donViId = '';
  String userId = '';
  String trangThai = "1";
  String? loaiMenu;
  SelectKey selectKeyTrangThai = SelectKey.CHO_TIEP_NHAN;
  YKienNguoiDanCubit() {
    dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser?.userInformation?.donViTrucThuoc?.id ?? '';
      userId = dataUser?.userId ?? '';
    }
  }
  Stream<List<DocumentModel>> get getYKien => _getYKien.stream;
  Future<void> callApi() async {
    showLoading();
    final result = await homeRep.getYKienNguoidan(
        100000,
        1,
        trangThai,
        startDate.toStringWithListFormat,
        endDate.toStringWithListFormat,
        donViId,
        userId,
        loaiMenu);
    showContent();
    result.when(
        success: (res) {
          _getYKien.sink.add(res);
        },
        error: (err) {});
  }

  void selectTrangThaiApi(SelectKey selectKey) {
    selectKeyTrangThai = selectKey;
    switch (selectKeyTrangThai) {
      case SelectKey.CHO_TIEP_NHAN:
        trangThai = '1';
        loaiMenu = null;
        callApi();
        break;
      case SelectKey.CHO_PHAN_XU_LY:
        trangThai = '21';
        loaiMenu = null;
        callApi();
        break;
      case SelectKey.CHO_DUYET_XU_LY:
        trangThai = '6,13,18';
        loaiMenu = "XuLy";
        callApi();
        break;
      case SelectKey.CHO_DUYET_TIEP_NHAN:
        trangThai = '6,13,18';
        loaiMenu = 'TiepNhan';
        callApi();
        break;

      default:
        {}
    }
  }

  @override
  void selectDate(
      {required SelectKey selectKey,
      required DateTime startDate,
      required DateTime endDate}) {
    if (selectKey != selectKeyTime) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;

      selectKeyDialog.sink.add(true);
      callApi();
    }
  }
}

///Lịch làm việc
class LichLamViecCubit extends HomeCubit with SelectKeyDialog {}

///Lịch Họp
class LichHopCubit extends HomeCubit with SelectKeyDialog {}

/// SinhNhat
class SinhNhatCubit extends HomeCubit with SelectKeyDialog {}

/// Sự kiện trong ngày
class SuKienTrongNgayCubit extends HomeCubit with SelectKeyDialog {}

///Tình hình xử lý ý kiến người dân
class TinhHinhXuLyYKienCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<TinhHinhYKienModel>> _getTinhHinhXuLy =
      BehaviorSubject<List<TinhHinhYKienModel>>();
  String donViId = '';
  Stream<List<TinhHinhYKienModel>> get getTinhHinhXuLy =>
      _getTinhHinhXuLy.stream;
  TinhHinhXuLyYKienCubit() {
    final dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser.userInformation?.donViTrucThuoc?.id ?? '';
    }
  }
  Future<void> callApi() async {
    showLoading();
    final result = await homeRep.getTinhHinhYKienNguoiDan(
      donViId,
      startDate.toStringWithListFormat,
      endDate.toStringWithListFormat,
    );
    showContent();
    result.when(
        success: (res) {
          _getTinhHinhXuLy.sink.add(res);
        },
        error: (err) {});
  }

  @override
  void selectDate(
      {required SelectKey selectKey,
      required DateTime startDate,
      required DateTime endDate}) {
    if (selectKey != selectKeyTime) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      selectKeyDialog.sink.add(true);
      callApi();
    }
  }
}

/// Nhiệm vụ
class NhiemVuCubit extends HomeCubit with SelectKeyDialog {
  NhiemVuCubit() {
    _getKey();
  }
  final BehaviorSubject<List<CalendarMeetingModel>> _getNhiemVu =
      BehaviorSubject<List<CalendarMeetingModel>>();

  Stream<List<CalendarMeetingModel>> get getNhiemVu => _getNhiemVu.stream;
  SelectKey selectTrangThai = SelectKey.CHO_PHAN_XU_LY;
  List<String> mangTrangThai = ["CHUA_THUC_HIEN", "CHO_PHAN_XU_LY"];
  void selectTrangThaiNhiemVu(SelectKey selectKey) {
    selectTrangThai = selectKey;
    switch (selectKey) {
      case SelectKey.CHO_PHAN_XU_LY:
        mangTrangThai = ["CHUA_THUC_HIEN", "CHO_PHAN_XU_LY"];
        callApi();
        break;
      case SelectKey.DANG_THUC_HIEN:
        mangTrangThai = ["DANG_THUC_HIEN"];
        callApi();
        break;
      case SelectKey.DANH_SACH_CONG_VIEC:
        break;
      default:
        {}
    }
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      HiveLocal.setSelect(
        path: SelectKeyPath.KEY_DASHBOARD_NHIEM_VU_TIME,
        selectkeyModel: SelectkeyModel(
          key: selectKeyTime.toString(),
          startDate: startDate.toString(),
          endDate: endDate.toString(),
        ),
      );
      callApi();
      selectKeyDialog.sink.add(true);
    }
  }

  @override
  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;
    HiveLocal.setSelect(
      path: SelectKeyPath.KEY_DASHBOARD_NHIEM_VU_TYPE,
      selectkeyModel: SelectkeyModel(key: selectKeyDonVi.toString()),
    );
    callApi();
    selectKeyDialog.sink.add(true);
  }

  Future<void> callApi() async {
    showLoading();
    bool isCaNhan = false;
    if (selectKeyDonVi == SelectKey.DON_VI) {
      isCaNhan = false;
    } else {
      isCaNhan = true;
    }
    final result = await homeRep.getNhiemVu(NhiemVuRequest(
        size: 10,
        index: 1,
        isNhiemVuCaNhan: isCaNhan,
        mangTrangThai: mangTrangThai,
        isSortByHanXuLy: true,
        ngayTaoNhiemVu: NgayTaoNhiemVu(
            fromDate: startDate.toString(), toDate: endDate.toString())));
    showContent();
    result.when(
      success: (res) {
        _getNhiemVu.sink.add(res);
      },
      error: (err) {},
    );
  }

  void _getKey() {
    final data = HiveLocal.getSelect(SelectKeyPath.KEY_DASHBOARD_NHIEM_VU_TIME);
    final type = HiveLocal.getSelect(SelectKeyPath.KEY_DASHBOARD_NHIEM_VU_TYPE);
    if (data != null) {
      startDate = DateTime.parse(data.startDate);
      endDate = DateTime.parse(data.endDate);
      selectKeyTime = data.selectKey;
    }
    if (type != null) {
      selectKeyDonVi = type.selectKey;
    }
  }
}

///Mixin SelectKey Dialog
mixin SelectKeyDialog {
  SelectKey selectKeyTime = SelectKey.HOM_NAY;
  SelectKey selectKeyDonVi = SelectKey.CA_NHAN;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final BehaviorSubject<bool> selectKeyDialog = BehaviorSubject();
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    selectKeyTime = selectKey;
    this.startDate = startDate;
    this.endDate = endDate;
    selectKeyDialog.sink.add(true);
  }

  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;
    selectKeyDialog.sink.add(true);
  }
}
