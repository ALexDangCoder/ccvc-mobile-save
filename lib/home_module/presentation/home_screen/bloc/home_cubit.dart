import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

import '/home_module/data/request/home/danh_sach_cong_viec_resquest.dart';
import '/home_module/data/request/home/danh_sach_van_ban_den_request.dart';
import '/home_module/data/request/home/lich_hop_request.dart';
import '/home_module/data/request/home/lich_lam_viec_request.dart';
import '/home_module/data/request/home/nhiem_vu_request.dart';
import '/home_module/data/request/home/to_do_list_request.dart';
import '/home_module/domain/locals/hive_local.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/calendar_metting_model.dart';
import '/home_module/domain/model/home/date_model.dart';
import '/home_module/domain/model/home/document_dashboard_model.dart';
import '/home_module/domain/model/home/document_model.dart';
import '/home_module/domain/model/home/press_network_model.dart';
import '/home_module/domain/model/home/sinh_nhat_model.dart';
import '/home_module/domain/model/home/su_kien_model.dart';
import '/home_module/domain/model/home/tinh_hinh_y_kien_model.dart';
import '/home_module/domain/model/home/tinh_huong_khan_cap_model.dart';
import '/home_module/domain/model/home/todo_model.dart';
import '/home_module/domain/model/home/tong_hop_nhiem_vu_model.dart';
import '/home_module/domain/repository/home_repository/home_repository.dart';
import '/home_module/presentation/home_screen/bloc/home_state.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/extensions/date_time_extension.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(MainStateInitial());

  HomeRepository get homeRep => Get.find();
  AccountRepository get accountRp => Get.find();
  DataUser? dataUser = HiveLocal.getDataUser();
  String id = '';
  final BehaviorSubject<UserInformationModel> _getInforUser =
      BehaviorSubject<UserInformationModel>();
  Stream<UserInformationModel> get getInforUser => _getInforUser.stream;
  final BehaviorSubject<List<WidgetModel>> _getConfigWidget =
      BehaviorSubject<List<WidgetModel>>();
  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();
  final BehaviorSubject<List<TinhHuongKhanCapModel>> _tinhHuongKhanCap =
      BehaviorSubject<List<TinhHuongKhanCapModel>>();
  // final BehaviorSubject<DataUser> _userInformation =
  //     BehaviorSubject<DataUser>();
  final BehaviorSubject<bool> _showAddTag = BehaviorSubject<bool>();
  // final BehaviorSubject<DataUser> _getUserInformation =
  //     BehaviorSubject<DataUser>();
  final BehaviorSubject<DateModel> _getDate = BehaviorSubject<DateModel>();
  final PublishSubject<bool> refreshListen = PublishSubject<bool>();

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
    if (dataUser != null) {
      id = dataUser!.userInformation?.id ?? '';
    }
    final queue = Queue(parallel: 4);

    showLoading();
    unawaited(queue.add(() => getUserInFor()));
    unawaited(queue.add(() => getDate()));
    unawaited(queue.add(() => _getTinhHuongKhanCap()));
    unawaited(queue.add(() => configWidget()));
    await queue.onComplete.catchError((er) {});
    showContent();
    queue.dispose();
  }

  Future<void> refreshData() async {
    final queue = Queue(parallel: 4);

    unawaited(queue.add(() => getUserInFor()));
    unawaited(queue.add(() => getDate()));
    unawaited(queue.add(() => _getTinhHuongKhanCap()));
    unawaited(queue.add(() => configWidget()));
    await queue.onComplete.catchError((er) {});
    refreshListen.sink.add(true);
    queue.dispose();
  }

  void orderWidget(List<WidgetModel> listWidgetConfig) {
    _getConfigWidget.sink.add(listWidgetConfig);
  }

  Future<void> getUserInFor() async {
    final result = await accountRp.getInfo(id);
    result.when(
      success: (res) {
        final dataUser = HiveLocal.getDataUser();

        _getInforUser.sink.add(
          UserInformationModel(
            hoTen: res.hoTen,
            chucVu: dataUser?.userInformation?.chucVu ?? '',
            anhDaiDienFilePath: res.anhDaiDienFilePath,
            ngaySinh: res.ngaySinh,
          ),
        );
      },
      error: (err) {},
    );
  }

  void setNameUser(String name) {
    final value = _getInforUser.value;
    value.hoTen = name;
    _getInforUser.sink.add(value);
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
    _getInforUser.close();
    // _userInformation.close();
    _showAddTag.close();
    // _getUserInformation.close();
    _getDate.close();
    refreshListen.close();
  }

  Stream<DateModel> get getDateStream => _getDate.stream;

  // Stream<DataUser> get getUserInformation => _getUserInformation.stream;

  Stream<List<WidgetModel>> get getConfigWidget => _getConfigWidget.stream;
  //
  // Stream<DataUser> get userInformation => _userInformation;

  Stream<List<TinhHuongKhanCapModel>> get tinhHuongKhanCap =>
      _tinhHuongKhanCap.stream;

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;

  List<WidgetModel> get getListWidget {
    if (_getConfigWidget.hasValue) {
      return _getConfigWidget.value;
    } else {
      return [];
    }
  }
}

/// Get Config Widget
extension GetConfigWidget on HomeCubit {
  Future<void> configWidget() async {
    final result = await homeRep.getDashBoardConfig();
    result.when(
      success: (res) {
        final data =
            res.where((element) => element.widgetType != null).toList();
        _getConfigWidget.sink.add(data);
      },
      error: (err) {},
    );
  }
}

///Báo chí mạng xã hội
class BaoChiMangXaHoiCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<PressNetWorkModel>> _getPressNetWork =
      BehaviorSubject<List<PressNetWorkModel>>();
  final BehaviorSubject<List<String>> _getTag = BehaviorSubject<List<String>>();
  final BehaviorSubject<bool> showAddTagStream = BehaviorSubject.seeded(false);
  bool isShowTag = false;
  String tagKey = 'Covid-19';
  String nameUser = '';

  BaoChiMangXaHoiCubit() {
    final dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      nameUser = dataUser.userInformation?.hoTen ?? '';
    }
  }

  void showAddTag() {
    showAddTagStream.sink.add(true);
  }

  void removeTag(String tag) {
    final value = _getTag.value;
    HiveLocalHome.removeTag(tag);
    value.remove(tag);
    _getTag.sink.add(value);
  }

  void addTag(String value) {
    if (value.trim().isEmpty) {
      return;
    }
    final data = _getTag.value;
    showAddTagStream.sink.add(false);
    if (data
        .where((element) => element.toLowerCase() == value.toLowerCase())
        .isEmpty) {
      HiveLocalHome.addTag(value);

      _getTag.sink.add(data..add(value));
    }
  }

  void getPress() async {
    List<String> listTag = HiveLocalHome.getTag();
    if (listTag.isEmpty) {
      final listDataDefault = ['Covid-19', 'Vaccine', nameUser];
      await HiveLocalHome.addTagList(['Covid-19', 'Vaccine', nameUser]);
      listTag = listDataDefault;
    }
    _getTag.sink.add(listTag);
    await callApi();
  }

  Future<void> callApi() async {
    showLoading();
    final result = await homeRep.getBaoChiMangXaHoi(
      1,
      5,
      startDate.formatApiSS,
      endDate.formatApiSS,
      tagKey,
    );
    showContent();
    result.when(
      success: (res) {
        _getPressNetWork.sink.add(res);
      },
      error: (err) {},
    );
  }

  void selectTag(String tag) {
    tagKey = tag;
    callApi();
    _getTag.sink.add(_getTag.value);
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      callApi();
      selectKeyDialog.sink.add(true);
    }
  }

  Stream<List<String>> get getTag => _getTag.stream;

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
class DanhSachCongViecCubit extends HomeCubit {
  final BehaviorSubject<TodoListModel> _getTodoList =
      BehaviorSubject<TodoListModel>();
  String id = '';

  DanhSachCongViecCubit() {
    id = HiveLocal.getDataUser()?.userInformation?.id ?? '';
  }

  Stream<TodoListModel> get getTodoList => _getTodoList.stream;

  void tickerListWord({required TodoModel todo, bool removeDone = true}) {
    final data = _getTodoList.value;
    homeRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: true,
        important: todo.important,
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: !removeDone,
        label: todo.label,
        updatedBy: id,
        updatedOn: DateTime.now().formatApi,
      ),
    );
    if (removeDone) {
      _removeInsertImportant(data, todo);
    } else {
      _removeInsertDone(data, todo);
    }
  }

  Future<void> addTodo(String label) async {
    if (label.trim().isEmpty) {
      return;
    }
    showLoading();
    final result = await homeRep.createTodo(
      CreateToDoRequest(
        label: label,
        isTicked: false,
        important: false,
        inUsed: true,
      ),
    );
    showContent();
    result.when(
      success: (res) {
        final data = _getTodoList.value;
        data.listTodoImportant.insert(
          0,
          res,
        );
        _getTodoList.sink.add(data);
      },
      error: (err) {},
    );
  }

  void _removeInsertImportant(TodoListModel data, TodoModel todo) {
    final result = data.listTodoDone.removeAt(
      data.listTodoDone.indexWhere((element) => element.id == todo.id),
    );
    data.listTodoImportant.insert(0, result..isTicked = false);
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

    data.listTodoDone.insert(0, result..isTicked = true);
    _getTodoList.sink.add(
      data,
    );
  }

  void changeLabelTodo(String newLabel, TodoModel todo) {
    final data = _getTodoList.value;
    if (newLabel == todo.label) {
      return;
    }
    homeRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: true,
        important: todo.important,
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: todo.isTicked,
        label: newLabel,
        updatedBy: id,
        updatedOn: DateTime.now().formatApi,
      ),
    );
    final index =
        data.listTodoImportant.indexWhere((element) => element.id == todo.id);
    final result = data.listTodoImportant.removeAt(
      index,
    );
    data.listTodoImportant.insert(0, result..label = newLabel);
    _getTodoList.sink.add(
      data,
    );
  }

  void tickerQuanTrongTodo(TodoModel todo, {bool removeDone = true}) {
    final data = _getTodoList.value;
    homeRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: true,
        important: !(todo.important ?? false),
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: todo.isTicked,
        label: todo.label,
        updatedBy: id,
        updatedOn: DateTime.now().formatApi,
      ),
    );
    if (removeDone) {
      final result = data.listTodoDone.removeAt(
        data.listTodoDone.indexWhere((element) => element.id == todo.id),
      );
      data.listTodoDone
          .insert(0, result..important = !(todo.important ?? false));
    } else {
      final result = data.listTodoImportant.removeAt(
        data.listTodoImportant.indexWhere((element) => element.id == todo.id),
      );
      data.listTodoImportant
          .insert(0, result..important = !(todo.important ?? false));
    }
    _getTodoList.sink.add(data);
  }

  void deleteCongViec(TodoModel todoModel, {bool removeDone = true}) {
    final data = _getTodoList.value;
    homeRep.upDateTodo(
      ToDoListRequest(
        id: todoModel.id,
        inUsed: false,
        important: todoModel.important,
        isDeleted: todoModel.isDeleted,
        createdOn: todoModel.createdOn,
        createdBy: todoModel.createdBy,
        isTicked: todoModel.isTicked,
        label: todoModel.label,
        updatedBy: id,
        updatedOn: DateTime.now().formatApi,
      ),
    );
    if (removeDone) {
      data.listTodoDone.removeAt(
        data.listTodoDone.indexWhere((element) => element.id == todoModel.id),
      );
    } else {
      data.listTodoImportant.removeAt(
        data.listTodoImportant
            .indexWhere((element) => element.id == todoModel.id),
      );
    }
    _getTodoList.sink.add(data);
  }

  Future<void> getToDoList() async {
    showLoading();
    final result = await homeRep.getListTodo();
    showContent();
    result.when(
      success: (res) {
        _getTodoList.sink.add(res);
      },
      error: (err) {},
    );
  }
}

/// Tổng hợp nhiệm vụ
class TongHopNhiemVuCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<TongHopNhiemVuModel>> _getTongHopNhiemVu =
      BehaviorSubject<List<TongHopNhiemVuModel>>();
  List<String> mangTrangThai = [];
  int? trangThaiHanXuLy;

  TongHopNhiemVuCubit() {}

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

  void clickScreen(TongHopNhiemVuType type) {
    switch (type) {
      //  case TongHopNhiemVuType.tongSoNV:
      //    mangTrangThai = [];
      //    trangThaiHanXuLy = null;
      //    break;
      //  case TongHopNhiemVuType.hoanThanhNhiemVu:
      //   mangTrangThai = ["DA_HOAN_THANH"];
      //   trangThaiHanXuLy = null;
      //    break;
      //  case TongHopNhiemVuType.nhiemVuDangThucHien:
      //   mangTrangThai = ["DANG_THUC_HIEN"];
      //   trangThaiHanXuLy = null;
      //    break;
      //  case TongHopNhiemVuType.hoanThanhQuaHan:
      // mangTrangThai = ["DA_HOAN_THANH"];
      // trangThaiHanXuLy = 2;
      //    break;
      //  case TongHopNhiemVuType.dangThucHienTrongHan:
      //    mangTrangThai = ["DANG_THUC_HIEN"];
      //    trangThaiHanXuLy = 3;
      //    break;
      //  case TongHopNhiemVuType.dangThucHienQuaHan:
      //    mangTrangThai = ["DANG_THUC_HIEN"];
      // trangThaiHanXuLy = 2;
      //    break;
      case TongHopNhiemVuType.choPhanXuLy:
        // TODO: Handle this case.
        break;
      case TongHopNhiemVuType.chuaThucHien:
        // TODO: Handle this case.
        break;
      case TongHopNhiemVuType.dangThucHien:
        // TODO: Handle this case.
        break;
      case TongHopNhiemVuType.hoanThanhNhiemVu:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;

    getDataTongHopNhiemVu();
    selectKeyDialog.sink.add(true);
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
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

/// Văn bản đơn vị
class VanBanDonViCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDen =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDi =
      BehaviorSubject<DocumentDashboardModel>();

  VanBanDonViCubit() {}
  bool isDanhSachDaXuLy = false;
  bool isDanhSachChoTrinhKy = true;
  bool isDanhSachChoXuLy = true;
  List<String> maTrangThaiVBDen = [];
  List<int> trangThaiFilter = [];

  void getDocument() {
    callApi(startDate.toString(), endDate.toString());
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
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

/// Phản ánh kiến nghị đơn vị
class PhanAnhKienNghiCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDen =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDi =
      BehaviorSubject<DocumentDashboardModel>();

  PhanAnhKienNghiCubit() {}
  bool isDanhSachDaXuLy = false;
  bool isDanhSachChoTrinhKy = true;
  bool isDanhSachChoXuLy = true;
  List<String> maTrangThaiVBDen = [];
  List<int> trangThaiFilter = [];

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
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

/// Tình hình xử lý văn bản
class TinhHinhXuLyCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDen =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDi =
      BehaviorSubject<DocumentDashboardModel>();

  TinhHinhXuLyCubit() {}
  bool isDanhSachDaXuLy = false;
  bool isDanhSachChoTrinhKy = true;
  bool isDanhSachChoXuLy = true;
  List<String> maTrangThaiVBDen = [];
  List<int> trangThaiFilter = [];

  void getDocument() {
    callApi(startDate.toString(), endDate.toString());
  }

  void selectTrangThaiVBDen(SelectKey selectKey) {
    switch (selectKey) {
      case SelectKey.CHO_XU_LY:
        maTrangThaiVBDen = ["CHO_XU_LY", "CHO_PHAN_XU_LY"];
        isDanhSachDaXuLy = true;
        break;
      case SelectKey.DANG_XU_LY:
        isDanhSachDaXuLy = false;
        maTrangThaiVBDen = ["DANG_XU_LY"];
        break;
      case SelectKey.DA_XU_LY:
        isDanhSachDaXuLy = false;
        maTrangThaiVBDen = ["DA_XU_LY"];
        break;
      case SelectKey.CHO_VAO_SO:
        isDanhSachDaXuLy = false;
        maTrangThaiVBDen = ["CHO_VAO_SO"];
        break;
      default:
        {}
    }
  }

  void selectTrangThaiVBDi(SelectKey selectKey) {
    switch (selectKey) {
      case SelectKey.CHO_TRINH_KY:
        trangThaiFilter = [1];
        isDanhSachChoTrinhKy = true;
        isDanhSachChoXuLy = false;
        isDanhSachDaXuLy = false;
        break;
      case SelectKey.CHO_XU_LY:
        trangThaiFilter = [2];
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = true;
        isDanhSachDaXuLy = false;
        break;
      case SelectKey.DA_XU_LY:
        trangThaiFilter = [];
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaXuLy = true;
        break;
      case SelectKey.CHO_CAP_SO:
        trangThaiFilter = [5];
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaXuLy = false;
        break;
      case SelectKey.CHO_BAN_HANH:
        trangThaiFilter = [6];
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaXuLy = false;
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
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
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

  VanBanCubit() {}

  Stream<List<DocumentModel>> get getDanhSachVb => _getDanhSachVb.stream;
  int trangThaiFilter = 0;
  List<String> maTrangThai = ['CHO_VAO_SO'];
  bool isDanhSachChoCapSo = false;
  bool isDanhSachChoTrinhKy = false;
  bool isDanhSachChoXuLy = false;
  bool isDanhSachDaBanHanh = true;
  bool isChoYKien = false;
  bool isVanBanDen = true;
  SelectKey? selectKey;

  Future<void> callApiVB() async {
    showLoading();
    final result = await homeRep.getDanhSachVanBan(
      DanhSachVBRequest(
        maTrangThai: maTrangThai,
        index: 1,
        isChoYKien: isChoYKien,
        isSortByDoKhan: true,
        thoiGianStartFilter: startDate.formatApi,
        thoiGianEndFilter: endDate.formatApi,
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
    this.selectKey = selectKey;

    switch (selectKey) {
      case SelectKey.CHO_VAO_SO:
        isChoYKien = false;
        maTrangThai = ['CHO_VAO_SO'];
        isVanBanDen = true;
        callApiVB();
        break;
      case SelectKey.CHO_XU_LY_VB_DI:
        isDanhSachChoCapSo = false;
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = true;
        isDanhSachDaBanHanh = false;
        trangThaiFilter = 2;
        isVanBanDen = false;
        callSearchVB();
        break;
      case SelectKey.CHO_XU_LY_VB_DEN:
        maTrangThai = ['CHO_XU_LY', 'CHO_PHAN_XU_LY'];
        isChoYKien = false;
        isVanBanDen = true;
        callApiVB();
        break;
      case SelectKey.CHO_TRINH_KY:
        isDanhSachChoCapSo = false;
        isDanhSachChoTrinhKy = true;
        isDanhSachChoXuLy = false;
        isDanhSachDaBanHanh = false;
        trangThaiFilter = 1;
        isVanBanDen = false;
        callSearchVB();
        break;
      case SelectKey.CHO_CHO_Y_KIEN_VB_DEN:
        isChoYKien = true;
        maTrangThai = [];
        isVanBanDen = true;
        callApiVB();
        break;
      case SelectKey.CHO_CAP_SO:
        isDanhSachChoCapSo = true;
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaBanHanh = false;
        trangThaiFilter = 5;
        isVanBanDen = false;
        callSearchVB();
        break;
      case SelectKey.CHO_BAN_HANH:
        isDanhSachChoCapSo = false;
        isDanhSachChoTrinhKy = false;
        isDanhSachChoXuLy = false;
        isDanhSachDaBanHanh = true;
        trangThaiFilter = 6;
        isVanBanDen = false;
        callSearchVB();
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
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;

      selectKeyDialog.sink.add(true);
      selectTrangThaiVanBan(
        this.selectKey ?? SelectKey.CHO_VAO_SO,
        filterTime: true,
      );
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
  String trangThai = '1';
  String? loaiMenu;
  SelectKey? selectKeyTrangThai;
  List<SelectKey> selectKeyPermission = [];

  YKienNguoiDanCubit() {
    dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser?.userInformation?.donViTrucThuoc?.id ?? '';
      userId = dataUser?.userId ?? '';
    }
    selectKeyPermission = _permissionKeyCheck();
  }

  Stream<List<DocumentModel>> get getYKien => _getYKien.stream;

  Future<void> callApi() async {
    if (selectKeyTrangThai == null) {
      showContent();
      return;
    }
    showLoading();
    final result = await homeRep.getYKienNguoidan(
      100000,
      1,
      trangThai,
      startDate.toStringWithListFormat,
      endDate.toStringWithListFormat,
      donViId,
      userId,
      loaiMenu,
    );
    showContent();
    result.when(
      success: (res) {
        _getYKien.sink.add(res);
      },
      error: (err) {},
    );
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
        loaiMenu = 'XuLy';
        callApi();
        break;
      case SelectKey.CHO_DUYET_TIEP_NHAN:
        trangThai = '6,13,18';
        loaiMenu = 'TiepNhan';
        callApi();
        break;
      case SelectKey.CHO_PHAN_CONG_XU_LY:
        trangThai = '4,12';
        loaiMenu = 'XuLy';
        callApi();
        break;
      case SelectKey.CHO_XU_LY:
        trangThai = '12';
        loaiMenu = 'XuLy';
        callApi();
        break;
      case SelectKey.DANG_XU_LY:
        trangThai = '3,4,5,12';
        loaiMenu = 'TiepNhan';
        callApi();
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
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;

      selectKeyDialog.sink.add(true);
      callApi();
    }
  }

  List<SelectKey> _permissionKeyCheck() {
    final listSelect = <SelectKey>[];
    if (HiveLocal.checkPermissionApp(
        permissionTxt: 'TiepNhanPAKNChoTiepNhanXem')) {
      listSelect.add(SelectKey.CHO_TIEP_NHAN);
    }
    if (HiveLocal.checkPermissionApp(permissionTxt: 'PhanXuLyXem')) {
      listSelect.add(SelectKey.CHO_PHAN_XU_LY);
    }
    if (HiveLocal.checkPermissionApp(
        permissionTxt: 'TiepNhanPAKNChoDuyetxem')) {
      listSelect.add(SelectKey.CHO_DUYET_XU_LY);
    }
    if (HiveLocal.checkPermissionApp(
        permissionTxt: 'XuLyPAKNChoTiepNhanXuLyCapNhat')) {
      listSelect.add(SelectKey.CHO_DUYET_TIEP_NHAN);
    }
    if (HiveLocal.checkPermissionApp(
        permissionTxt: 'XuLyPAKNChoPhanCongXuLyCapNhat')) {
      listSelect.add(SelectKey.CHO_PHAN_CONG_XU_LY);
    }
    if (HiveLocal.checkPermissionApp(permissionTxt: 'XuLyPAKNCanXuLyXem')) {
      listSelect.add(SelectKey.CHO_XU_LY);
      listSelect.add(SelectKey.DANG_XU_LY);
    }
    if (listSelect.isNotEmpty) {
      selectKeyTrangThai = listSelect.first;
    }
    return listSelect;
  }
}

///Lịch làm việc
class LichLamViecCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<CalendarMeetingModel>> _getListLichLamViec =
      BehaviorSubject<List<CalendarMeetingModel>>();

  Stream<List<CalendarMeetingModel>> get getListLichLamViec =>
      _getListLichLamViec.stream;
  final userId = HiveLocal.getDataUser()?.userId ?? '';

  Future<void> callApi() async {
    showLoading();
    final result = await homeRep.getListLichLamViec(
      LichLamViecRequest(
        dateFrom: startDate.formatApi,
        dateTo: endDate.formatApi,
        isTatCa: true,
      ),
    );
    result.when(
      success: (res) {
        final listResult = <CalendarMeetingModel>[];
        if (isMobile()) {
          int index = 0;
          for (final vl in res) {
            listResult.add(vl);
            index++;
            if (index >= 20) {
              break;
            }
          }
          _getListLichLamViec.sink.add(listResult);
        } else {
          _getListLichLamViec.sink.add(res);
        }
      },
      error: (err) {},
    );
    showContent();
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      selectKeyDialog.sink.add(true);
      callApi();
    }
  }
}

///Lịch Họp
class LichHopCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<CalendarMeetingModel>> _getLichHop =
      BehaviorSubject<List<CalendarMeetingModel>>();

  Stream<List<CalendarMeetingModel>> get getLichHop => _getLichHop.stream;
  SelectKey trangThaiLichHop = SelectKey.LICH_HOP_CUA_TOI;
  bool isLichHopCuaToi = true;
  bool isLichDuocMoi = false;
  bool isDuyetLich = false;
  bool isChoXacNhan = false;
  final userId = HiveLocal.getDataUser()?.userId ?? '';

  Future<void> callApi() async {
    showLoading();
    final result = await homeRep.getLichHop(
      LichHopRequest(
        isChoXacNhan: isChoXacNhan,
        isDuyetLich: isDuyetLich,
        isLichDuocMoi: isLichDuocMoi,
        isLichCuaToi: isLichHopCuaToi,
        dateFrom: startDate.formatApi,
        dateTo: endDate.formatApi,
      ),
    );
    showContent();
    result.when(
        success: (res) {
          if (isMobile()) {
            int index = 0;
            final listResult = <CalendarMeetingModel>[];
            for (final vl in res) {
              listResult.add(vl);
              index++;
              if (index >= 20) {
                break;
              }
            }
            _getLichHop.sink.add(listResult);
          } else {
            _getLichHop.sink.add(res);
          }
        },
        error: (err) {});
  }

  void selectTrangThaiHop(SelectKey selectKey) {
    if (trangThaiLichHop == selectKey) {
      return;
    }
    trangThaiLichHop = selectKey;

    switch (selectKey) {
      case SelectKey.LICH_HOP_CUA_TOI:
        isLichHopCuaToi = true;
        isLichDuocMoi = false;
        isDuyetLich = false;
        isChoXacNhan = false;
        callApi();
        break;
      case SelectKey.LICH_HOP_DUOC_MOI:
        isLichHopCuaToi = false;
        isLichDuocMoi = true;
        isDuyetLich = false;
        isChoXacNhan = false;
        callApi();
        break;
      case SelectKey.LICH_HOP_CAN_DUYET:
        isLichHopCuaToi = false;
        isLichDuocMoi = false;
        isDuyetLich = true;
        isChoXacNhan = true;
        callApi();
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
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      selectKeyDialog.sink.add(true);
      callApi();
    }
  }
}

/// Sinh Nhật
class SinhNhatCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<SinhNhatUserModel>> _getSinhNhat =
      BehaviorSubject<List<SinhNhatUserModel>>();

  Stream<List<SinhNhatUserModel>> get getSinhNhat => _getSinhNhat.stream;

  Future<void> callApi() async {
    showLoading();
    final result = await homeRep.getSinhNhat(
        startDate.formatApiDDMMYYYY, endDate.formatApiDDMMYYYY);
    showContent();
    result.when(
      success: (res) {
        _getSinhNhat.sink.add(res);
      },
      error: (err) {},
    );
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      selectKeyDialog.sink.add(true);
      callApi();
    }
  }
}

/// Sự kiện trong ngày
class SuKienTrongNgayCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<SuKienModel>> _getSuKien =
      BehaviorSubject<List<SuKienModel>>();

  Stream<List<SuKienModel>> get getSuKien => _getSuKien.stream;

  Future<void> callApi() async {
    showLoading();
    final result =
        await homeRep.getSuKien(startDate.formatApi, endDate.formatApi);
    showContent();
    result.when(
      success: (res) {
        _getSuKien.sink.add(res);
      },
      error: (err) {},
    );
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;
      selectKeyDialog.sink.add(true);
      callApi();
    }
  }
}

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
      error: (err) {},
    );
  }

  @override
  void selectDate({
    required SelectKey selectKey,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
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
  NhiemVuCubit() {}
  final BehaviorSubject<List<CalendarMeetingModel>> _getNhiemVu =
      BehaviorSubject<List<CalendarMeetingModel>>();

  Stream<List<CalendarMeetingModel>> get getNhiemVu => _getNhiemVu.stream;
  SelectKey selectTrangThai = SelectKey.CHO_PHAN_XU_LY;
  List<String> mangTrangThai = ['CHUA_THUC_HIEN', 'CHO_PHAN_XU_LY'];
  bool isCongViec = false;

  void selectTrangThaiNhiemVu(SelectKey selectKey) {
    selectTrangThai = selectKey;
    switch (selectKey) {
      case SelectKey.CHO_PHAN_XU_LY:
        mangTrangThai = ['CHUA_THUC_HIEN', 'CHO_PHAN_XU_LY'];
        isCongViec = false;
        callApi();
        break;
      case SelectKey.DANG_THUC_HIEN:
        mangTrangThai = ['DANG_THUC_HIEN'];
        isCongViec = false;
        callApi();
        break;
      case SelectKey.DANH_SACH_CONG_VIEC:
        isCongViec = true;
        callApi();
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
    if (selectKey != selectKeyTime || selectKey == SelectKey.TUY_CHON) {
      selectKeyTime = selectKey;
      this.startDate = startDate;
      this.endDate = endDate;

      callApi();
      selectKeyDialog.sink.add(true);
    }
  }

  @override
  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;
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
    final result = await getDataApi(isCaNhan: isCaNhan);
    showContent();
    result.when(
      success: (res) {
        _getNhiemVu.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<Result<List<CalendarMeetingModel>>> getDataApi(
      {bool isCaNhan = false}) {
    if (isCongViec) {
      return homeRep.getDanhSachCongViec(
        DanhSachCongViecRequest(
            isSortByHanXuLy: true,
            isCaNhan: isCaNhan,
            size: 10,
            index: 1,
            mangTrangThai: ["CHUA_THUC_HIEN", "DANG_THUC_HIEN"],
            trangThaiFilter: ["DANH_SACH_CONG_VIEC"],
            hanXuLy: HanXuLy(
                fromDate: startDate.formatApi, toDate: endDate.formatApi)),
      );
    }
    return homeRep.getNhiemVu(
      NhiemVuRequest(
        size: 10,
        index: 1,
        isNhiemVuCaNhan: isCaNhan,
        mangTrangThai: mangTrangThai,
        isSortByHanXuLy: true,
        ngayTaoNhiemVu: NgayTaoNhiemVu(
          fromDate: startDate.toString(),
          toDate: endDate.toString(),
        ),
      ),
    );
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
