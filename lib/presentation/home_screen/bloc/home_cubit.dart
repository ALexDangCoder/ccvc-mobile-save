import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/home/date_model.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/home/press_network_model.dart';
import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';
import 'package:ccvc_mobile/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_state.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

import 'package:rxdart/rxdart.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(MainStateInitial());
  final BehaviorSubject<List<WidgetModel>> _getConfigWidget =
      BehaviorSubject<List<WidgetModel>>();
  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();
  final BehaviorSubject<List<TinhHuongKhanCapModel>> _tinhHuongKhanCap =
      BehaviorSubject<List<TinhHuongKhanCapModel>>();
  final BehaviorSubject<UserInformationModel> _userInformation =
      BehaviorSubject<UserInformationModel>();
  final BehaviorSubject<TodoListModel> _getTodoList =
      BehaviorSubject<TodoListModel>();
  final BehaviorSubject<bool> _showAddTag = BehaviorSubject<bool>();

  final BehaviorSubject<UserInformationModel> _getUserInformation =
      BehaviorSubject<UserInformationModel>();
  final BehaviorSubject<DateModel> _getDate = BehaviorSubject<DateModel>();

  void _getTinhHuongKhanCap() {
    _tinhHuongKhanCap.sink.add(FakeData.tinhKhanCap);
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

  void loadApi() {
    getUserInFor();
    _getTinhHuongKhanCap();
    getDate();
  }

  void orderWidget(List<WidgetModel> listWidgetConfig) {
    _getConfigWidget.sink.add(listWidgetConfig);
  }

  void getUserInFor() {
    _getUserInformation.sink.add(FakeData.userInfo);
  }

  void getDate() {
    _getDate.sink.add(FakeData.dateModel);
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
  Stream<UserInformationModel> get getUserInformation =>
      _getUserInformation.stream;
  Stream<List<WidgetModel>> get getConfigWidget => _getConfigWidget.stream;
  Stream<UserInformationModel> get userInformation => _userInformation;
  Stream<List<TinhHuongKhanCapModel>> get tinhHuongKhanCap =>
      _tinhHuongKhanCap.stream;
  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;
  Stream<TodoListModel> get getTodoList => _getTodoList.stream;
}

/// Get Config Widget
extension GetConfigWidget on HomeCubit {
  Future<void> configWidget() async {
    await Future.delayed(Duration(seconds: 10));
    _getConfigWidget.sink.add(FakeData.listUseWidget);
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
  final BehaviorSubject<List<DashboardSchedule>> _getTongHopNhiemVu =
      BehaviorSubject<List<DashboardSchedule>>();
  void getDataTongHopNhiemVu() {
    _getTongHopNhiemVu.sink.add(FakeData.listCalendarWork);
  }

  Stream<List<DashboardSchedule>> get getTonghopNhiemVu =>
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
  Future<void> getDocument() async {
    await Future.delayed(const Duration(seconds: 10));
    _getDocumentVBDen.sink.add(FakeData.tinhHinhXuLyDocVBDen);
    _getDocumentVBDi.sink.add(FakeData.tinhHinhXuLyDocVBDi);
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
class VanBanCubit extends HomeCubit with SelectKeyDialog {}

///Ý kiến người dân
class YKienNguoiDanCubit extends HomeCubit with SelectKeyDialog {}

///Lịch làm việc
class LichLamViecCubit extends HomeCubit with SelectKeyDialog {}

///Lịch Họp
class LichHopCubit extends HomeCubit with SelectKeyDialog {}

/// SinhNhat
class SinhNhatCubit extends HomeCubit with SelectKeyDialog {}

/// Sự kiện trong ngày
class SuKienTrongNgayCubit extends HomeCubit with SelectKeyDialog {}

///Tình hình xử lý ý kiến người dân
class TinhHinhXuLyYKienCubit extends HomeCubit with SelectKeyDialog {}

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
    selectKeyDialog.sink.add(true);
  }

  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;
    selectKeyDialog.sink.add(true);
  }
}
