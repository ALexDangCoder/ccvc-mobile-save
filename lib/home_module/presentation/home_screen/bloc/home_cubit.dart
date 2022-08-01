import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart' as HiveLc;
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/home_module/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/nguoi_gan_cong_viec_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/van_ban_don_vi_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/weather_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/home_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

import '/home_module/data/request/home/danh_sach_cong_viec_resquest.dart';
import '/home_module/data/request/home/danh_sach_van_ban_den_request.dart';
import '/home_module/data/request/home/lich_hop_request.dart';
import '/home_module/data/request/home/lich_lam_viec_request.dart';
import '/home_module/data/request/home/nhiem_vu_request.dart';
import '/home_module/data/request/home/to_do_list_request.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/calendar_metting_model.dart';
import '/home_module/domain/model/home/date_model.dart';
import '/home_module/domain/model/home/document_dashboard_model.dart';
import '/home_module/domain/model/home/document_model.dart';
import '/home_module/domain/model/home/press_network_model.dart';
import '/home_module/domain/model/home/sinh_nhat_model.dart';
import '/home_module/domain/model/home/su_kien_model.dart';
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
  DataUser? dataUser = HiveLc.HiveLocal.getDataUser();
  String id = '';

  final String code = 'ha-noi';

  final BehaviorSubject<WeatherModel> weatherSubject = BehaviorSubject();

  final BehaviorSubject<UserInformationModel> _getInforUser =
      BehaviorSubject<UserInformationModel>();

  Stream<UserInformationModel> get getInforUser => _getInforUser.stream;
  final BehaviorSubject<List<WidgetModel>> _getConfigWidget =
      BehaviorSubject<List<WidgetModel>>();
  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();
  final BehaviorSubject<List<TinBuonModel>> _tinhHuongKhanCap =
      BehaviorSubject<List<TinBuonModel>>();

  // final BehaviorSubject<DataUser> _userInformation =
  //     BehaviorSubject<DataUser>();
  final BehaviorSubject<bool> _showAddTag = BehaviorSubject<bool>();

  // final BehaviorSubject<DataUser> _getUserInformation =
  //     BehaviorSubject<DataUser>();
  final BehaviorSubject<DateModel> _getDate = BehaviorSubject<DateModel>();
  final PublishSubject<bool> refreshListen = PublishSubject<bool>();

  Future<void> _getTinhHuongKhanCap() async {
    final result = await homeRep.getTinBuon();
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
    final queue = Queue(parallel: 5);

    showLoading();
    unawaited(queue.add(() => getUserInFor()));
    unawaited(queue.add(() => getDate()));
    unawaited(queue.add(() => _getTinhHuongKhanCap()));
    unawaited(queue.add(() => configWidget()));
    unawaited(queue.add(() => getWeather()));
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

  Future<void> getWeather() async {
    final result = await homeRep.getWeather(code);

    result.when(
      success: (success) {
        weatherSubject.add(success);
      },
      error: (error) {
        MessageConfig.show(title: error.toString());
      },
    );
  }

  Future<void> getUserInFor() async {
    final result = await accountRp.getInfo(id);
    result.when(
      success: (res) {
        final dataUser = HiveLc.HiveLocal.getDataUser();

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

  Stream<List<TinBuonModel>> get tinhHuongKhanCap => _tinhHuongKhanCap.stream;

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
  String tagKey = '';
  String nameUser = '';

  BaoChiMangXaHoiCubit() {
    startDate = DateTime(startDate.year, startDate.month, startDate.day - 1);
    final dataUser = HiveLc.HiveLocal.getDataUser();
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
    if (_getTag.value.isNotEmpty) {
      tagKey = _getTag.value.first;
      callApi();
    }
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
      tagKey = value;
      callApi();
    }
  }

  void getPress() async {
    List<String> listTag = HiveLocalHome.getTag();
    if (listTag.isEmpty) {
      final listDataDefault = [nameUser];
      await HiveLocalHome.addTagList([nameUser]);
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
      startDate.formatApiStartDay,
      endDate.formatApiEndDay,
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

  void editSelectDate(SelectKey selectKey) {
    startDate = DateTime.now();
    switch (selectKey) {
      case SelectKey.HOM_NAY:
        startDate =
            DateTime(startDate.year, startDate.month, startDate.day - 1);
        break;
      case SelectKey.TUAN_NAY:
        startDate =
            DateTime(startDate.year, startDate.month, startDate.day - 7);
        break;
      case SelectKey.THANG_NAY:
        startDate =
            DateTime(startDate.year, startDate.month, startDate.day - 30);
        break;
      case SelectKey.NAM_NAY:
        startDate =
            DateTime(startDate.year - 1, startDate.month, startDate.day);
        break;
      default:
        startDate =
            DateTime(startDate.year, startDate.month, startDate.day - 1);
        break;
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
  int pageIndex = 1;
  int totalPage = 1;
  int totalItem = 1;
  bool isSearching = false;
  final List<String> danhSachTenNguoiGan = [];
  Map<String, String> tempName = {};
  final List<TodoModel> danhSachNguoiGan = [];

  DanhSachCongViecCubit() {
    id = HiveLc.HiveLocal.getDataUser()?.userInformation?.id ?? '';
  }

  HomeRepository get homeRepCongViec => Get.find();
  final BehaviorSubject<bool> _isShowListCanBo = BehaviorSubject.seeded(false);

  Stream<bool> get isShowListCanBo => _isShowListCanBo.stream;

  final BehaviorSubject<IconListCanBo> _isShowIcon =
      BehaviorSubject.seeded(IconListCanBo.DOWN);

  final BehaviorSubject<List<ItemRowData>> _danhSachNguoiGan =
      BehaviorSubject.seeded([]);

  Stream<List<ItemRowData>> get getDanhSachNguoiGan => _danhSachNguoiGan.stream;

  Stream<IconListCanBo> get getIcon => _isShowIcon.stream;

  Stream<TodoListModel> get getTodoList => _getTodoList.stream;

  final List<ItemRowData> inforCanBo = [];

  List<ItemNguoiGanModel> listNguoiGan = [];

  static List<ItemNguoiGanModel> listNguoiGanStatic = [];

  void setDisplayListCanBo(bool isShow) {
    _isShowListCanBo.sink.add(isShow);
  }

  void setDisplayIcon(IconListCanBo iconListCanBo) {
    _isShowIcon.sink.add(iconListCanBo);
  }

  Future<void> callApi() async {
    showLoading();
    final queue = Queue(parallel: 2);
    unawaited(
      queue.add(
        () => getListNguoiGan(true, 5),
      ),
    );
    await queue.add(
      () => getToDoList(),
    );
    unawaited(queue.onComplete.then((_) => showContent()));
    queue.dispose();
  }

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
        performer: todo.performer,
      ),
    );
    if (removeDone) {
      _removeInsertImportant(data, todo);
    } else {
      _removeInsertDone(data, todo);
    }
  }

  Future<void> addTodo(String label, String? nguoiGanId) async {
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
        performer: nguoiGanId,
      ),
    );
    showContent();
    await result.when(
      success: (res) async {
        final String nameInsert = await getName(res.performer ?? '');
        final data = _getTodoList.value;
        data.listTodoImportant.insert(
          0,
          res,
        );
        data.listTodoImportant = listSortImportant(data.listTodoImportant);
        danhSachTenNguoiGan.insert(0, nameInsert);
        if (res.id != null) {
          tempName[res.id!] = nameInsert;
        }
        _getTodoList.sink.add(data);
      },
      error: (err) {},
    );
  }

  void _removeInsertImportant(TodoListModel data, TodoModel todo) async {
    if (todo.id != null) {
      danhSachTenNguoiGan.insert(0, tempName[todo.id]!);
    } else {
      danhSachTenNguoiGan.insert(0, '');
    }

    final result = data.listTodoDone.removeAt(
      data.listTodoDone.indexWhere((element) => element.id == todo.id),
    );
    data.listTodoImportant.insert(0, result..isTicked = false);
    final listTodoImportant = listSortImportant(data.listTodoImportant);
    _getTodoList.sink.add(
      TodoListModel(
        listTodoImportant: listTodoImportant,
        listTodoDone: data.listTodoDone,
      ),
    );
  }

  void _removeInsertDone(TodoListModel data, TodoModel todo) {
    danhSachTenNguoiGan.removeAt(
      data.listTodoImportant.indexWhere((element) => element.id == todo.id),
    );
    final result = data.listTodoImportant.removeAt(
      data.listTodoImportant.indexWhere((element) => element.id == todo.id),
    );

    data.listTodoDone.insert(0, result..isTicked = true);
    data.listTodoDone = listSortImportant(data.listTodoDone);
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
        performer: todo.performer,
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
        performer: todo.performer,
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

  Widget setIconLoadMore(int index, Widget itemListView) {
    if (index == inforCanBo.length - 1) {
      if (inforCanBo.length + 1 == totalItem) {
        return const SizedBox();
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemListView,
            Center(
              child: CircularProgressIndicator(
                color: AppTheme.getInstance().primaryColor(),
              ),
            ),
          ],
        );
      }
    } else {
      return itemListView;
    }
  }

  Future<void> getToDoList() async {
    showLoading();
    final result = await homeRep.getListTodo();
    showContent();
    await result.when(
      success: (res) async {
        danhSachNguoiGan.clear();
        danhSachNguoiGan.addAll(res.listTodoImportant);
        danhSachNguoiGan.addAll(res.listTodoDone);
        res.listTodoImportant = listSortImportant(res.listTodoImportant);
        res.listTodoDone = listSortImportant(res.listTodoDone);
        await getListNameCanBo();

        _getTodoList.sink.add(res);
      },
      error: (err) {},
    );
  }

  List<TodoModel> listSortImportant(List<TodoModel> list) {
    final List<TodoModel> listHasStar = [];
    final List<TodoModel> listNoStar = [];
    for (final element in list) {
      if (element.important ?? false) {
        listHasStar.add(element);
      } else {
        listNoStar.add(element);
      }
    }
    listHasStar.addAll(listNoStar);
    return listHasStar;
  }

  IconModdel getIconListCanBo(
      IconListCanBo iconListCanBo, TextEditingController controller) {
    switch (iconListCanBo) {
      case IconListCanBo.UP:
        return IconModdel(
          icon: SvgPicture.asset(ImageAssets.ic_up),
          onTapItem: () {
            _isShowIcon.sink.add(IconListCanBo.DOWN);
            _isShowListCanBo.sink.add(!_isShowListCanBo.value);
          },
        );
      case IconListCanBo.DOWN:
        return IconModdel(
          icon: SvgPicture.asset(ImageAssets.ic_down),
          onTapItem: () {
            _isShowIcon.sink.add(IconListCanBo.UP);
            _isShowListCanBo.sink.add(!_isShowListCanBo.value);
          },
        );
      case IconListCanBo.CLOSE:
        return IconModdel(
          icon: SvgPicture.asset(ImageAssets.ic_close),
          onTapItem: () {
            controller.clear();
            _isShowIcon.sink.add(IconListCanBo.DOWN);
          },
        );
    }
  }

  Future<void> loadMoreListNguoiGan(String keySearch) async {
    if (pageIndex <= totalPage) {
      pageIndex = pageIndex + 1;
      if (isSearching) {
        await getListNguoiGan(
          true,
          5,
          keySearch: keySearch,
        );
      }
      await getListNguoiGan(true, 5);
    }
  }

  Future<void> getListNguoiGan(
    bool isGetAll,
    int pageSize, {
    String? keySearch,
    bool notLoadMore = false,
  }) async {
    showLoading();
    final result = await homeRep.listNguoiGanCongViec(
      isGetAll,
      pageSize,
      pageIndex,
      keySearch ?? '',
    );
    result.when(
      success: (res) {
        isSearching = false;
        if (notLoadMore) {
          listNguoiGan.clear();
          inforCanBo.clear();
          isSearching = true;
        }
        showContent();
        totalPage = res.totalPage ?? 0;
        totalItem = res.totalCount ?? 1;
        listNguoiGan = res.items;
        for (final element in listNguoiGan) {
          final List<String> inforDisPlay = [];
          final String chucVu = element.chucVu.join(',');
          final String donVi = element.donVi.join(',');
          inforDisPlay.add(element.hoTen);
          inforDisPlay.add(donVi);
          inforDisPlay.add(chucVu);
          final String result = inforDisPlay.join('-');
          inforCanBo.add(
            ItemRowData(
              infor: result,
              id: element.id,
            ),
          );
        }
        _danhSachNguoiGan.sink.add(inforCanBo);
      },
      error: (err) {},
    );
  }

  void initListDataCanBo() {
    _danhSachNguoiGan.sink.add(inforCanBo);
  }

  void searchNguoiGan(String key) {
    List<ItemRowData> listDataSearch;
    if (inforCanBo.isEmpty) {
      listDataSearch = [];
    } else {
      listDataSearch = inforCanBo;
    }
    final resultSearch = listDataSearch
        .where(
          (element) => element.infor
              .toLowerCase()
              .vietNameseParse()
              .contains(key.toLowerCase().vietNameseParse()),
        )
        .toList();
    _danhSachNguoiGan.sink.add(resultSearch);
  }

  Future<void> getListNameCanBo() async {
    for (final element in danhSachNguoiGan) {
      String name = '';
      await getName(element.performer ?? '').then((value) => name = value);
      danhSachTenNguoiGan.add(name);
      if (element.id != null) {
        tempName[element.id!] = name;
      }
    }
  }

  Future<String> getName(String id) async {
    String nameCanbo = '';
    if (id.isEmpty) {
      return nameCanbo;
    }
    final result = await homeRep.listNguoiGanCongViec(
      true,
      10,
      1,
      id,
    );
    result.when(
      success: (res) {
        if (res.items.isEmpty) {
          return nameCanbo;
        }
        nameCanbo = res.items.first.hoTen;
      },
      error: (err) {},
    );
    return nameCanbo;
  }
}

/// Tổng hợp nhiệm vụ
class TongHopNhiemVuCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getTongHopNhiemVu =
      BehaviorSubject<DocumentDashboardModel>();
  bool isCaNhan = true;

  // List<String> mangTrangThai = [];
  int? trangThaiHanXuLy;
  String donViId = '';
  String userId = '';
  String canBoId = '';
  String mangTrangThai = '';

  TongHopNhiemVuCubit() {
    dataUser = HiveLc.HiveLocal.getDataUser();
    if (dataUser != null) {
      canBoId = dataUser?.userInformation?.id ?? '';
    }
  }

  Future<void> getDataTongHopNhiemVu() async {
    showLoading();
    String canBoIdDepartment = '';
    if (selectKeyDonVi == SelectKey.DON_VI) {
    } else {
      canBoIdDepartment = canBoId;
    }
    final result = await homeRep.getTongHopNhiemVu(
      //userId,
      canBoIdDepartment,
      // donViId,
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
        mangTrangThai = 'CHO_PHAN_XU_LY';
        break;
      case TongHopNhiemVuType.chuaThucHien:
        mangTrangThai = 'CHUA_THUC_HIEN';
        break;
      case TongHopNhiemVuType.dangThucHien:
        mangTrangThai = 'DANG_THUC_HIEN';
        break;
      case TongHopNhiemVuType.hoanThanhNhiemVu:
        mangTrangThai = 'DA_HOAN_THANH';
        break;
    }
  }

  @override
  void selectDonVi({required SelectKey selectKey}) {
    selectKeyDonVi = selectKey;
    if (selectKeyDonVi == SelectKey.CA_NHAN) {
      isCaNhan = true;
    }
    if (selectKeyDonVi == SelectKey.DON_VI) {
      isCaNhan = false;
    }
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

  Stream<DocumentDashboardModel> get getTonghopNhiemVu =>
      _getTongHopNhiemVu.stream;

  @override
  void dispose() {
    // TODO: implement dispose
    _getTongHopNhiemVu.close();
  }
}

/// Văn bản đơn vị
class VanBanDonViCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<VanBanDonViModel> _getVanBanDonVi =
      BehaviorSubject<VanBanDonViModel>();
  List<String> mangTrangThai = [];
  int? trangThaiHanXuLy;
  String donViId = '';
  String canBoId = '';

  VanBanDonViCubit() {
    dataUser = HiveLc.HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser?.userInformation?.donViTrucThuoc?.id ?? '';
      canBoId = dataUser?.userInformation?.canBoDepartmentId ?? '';
    }
  }

  void getDocument() {
    callApi(
      canBoId: canBoId,
      donViId: donViId,
      startDate: '',
      endDate: '',
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
      // callApi(startDate.toString(), endDate.toString());
    }
    selectKeyDialog.sink.add(true);
  }

  Future<void> callApi({
    String canBoId = '',
    required String donViId,
    required String startDate,
    required String endDate,
  }) async {
    showLoading();
    String canBoIdDepartment = '';
    if (selectKeyDonVi == SelectKey.DON_VI) {
    } else {
      canBoIdDepartment = canBoId;
    }
    final result = await homeRep.getTinhHinhXuLyVanBan(
      canBoIdDepartment,
      donViId,
      startDate,
      endDate,
    );
    showContent();
    result.when(
      success: (res) {
        _getVanBanDonVi.sink.add(res);
      },
      error: (err) {},
    );
  }

  Stream<VanBanDonViModel> get getVanBanDonVi => _getVanBanDonVi.stream;

  @override
  void dispose() {
    _getVanBanDonVi.close();
  }
}

/// Phản ánh kiến nghị đơn vị
class PhanAnhKienNghiCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDen =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<DocumentDashboardModel> _getDocumentVBDi =
      BehaviorSubject<DocumentDashboardModel>();

  PhanAnhKienNghiCubit();

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

  TinhHinhXuLyCubit();

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
        () => homeRep.getVBden('', '').then(
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
        () => homeRep.getVBdi('', '').then(
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
  List<SelectKey> listKey = [];

  VanBanCubit() {
    listKey = listSelectKey();
    selectKey = listKey.first;
  }

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
        thoiGianStartFilter: '',
        thoiGianEndFilter: '',
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
        ngayTaoEndSearch: '',
        ngayTaoStartSearch: '',
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
        this.selectKey ?? listKey.first,
        filterTime: true,
      );
    }
  }

  List<SelectKey> listSelectKey() {
    final List<SelectKey> list = [];
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: PermissionConst.VB_DEN_VAO_SO_VAN_BAN,
        permissionType: HiveLc.PermissionType.QLVB)) {
      list.add(SelectKey.CHO_VAO_SO);
    }
    list.addAll([
      SelectKey.CHO_XU_LY_VB_DEN,
      SelectKey.CHO_CHO_Y_KIEN_VB_DEN,
      SelectKey.CHO_TRINH_KY,
      SelectKey.CHO_XU_LY_VB_DI,
      SelectKey.CHO_CAP_SO,
      SelectKey.CHO_BAN_HANH
    ]);
    return list;
  }
}

///Ý kiến người dân
class YKienNguoiDanCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<List<YKienNguoiDanModel>> _getYKien =
      BehaviorSubject<List<YKienNguoiDanModel>>();
  DataUser? dataUser;
  String donViId = '';
  String userId = '';
  String trangThai = '1';
  String? loaiMenu;
  SelectKey? selectKeyTrangThai;
  List<SelectKey> selectKeyPermission = [];

  YKienNguoiDanCubit() {
    dataUser = HiveLc.HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser?.userInformation?.donViTrucThuoc?.id ?? '';
      userId = dataUser?.userId ?? '';
    }
    selectKeyPermission = _permissionKeyCheck();
  }

  Stream<List<YKienNguoiDanModel>> get getYKien => _getYKien.stream;

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
      case SelectKey.CHO_TIEP_NHAN_XU_LY:
        trangThai = '3';
        loaiMenu = 'XuLy';
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
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: 'TiepNhanPAKNChoTiepNhanXem')) {
      listSelect.add(SelectKey.CHO_TIEP_NHAN);
    }
    if (HiveLc.HiveLocal.checkPermissionApp(permissionTxt: 'PhanXuLyXem')) {
      listSelect.add(SelectKey.CHO_PHAN_XU_LY);
    }
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: 'TiepNhanPAKNChoDuyetxem')) {
      listSelect.add(SelectKey.CHO_DUYET_XU_LY);
    }
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: 'XuLyPAKNChoTiepNhanXuLyCapNhat')) {
      listSelect.add(SelectKey.CHO_DUYET_TIEP_NHAN);
    }
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: 'XuLyPAKNChoTiepNhanXuLyXem')) {
      listSelect.add(SelectKey.CHO_TIEP_NHAN_XU_LY);
    }
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: 'XuLyPAKNChoPhanCongXuLyCapNhat')) {
      listSelect.add(SelectKey.CHO_PHAN_CONG_XU_LY);
    }
    if (HiveLc.HiveLocal.checkPermissionApp(
        permissionTxt: 'XuLyPAKNCanXuLyXem')) {
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
  final userId = HiveLc.HiveLocal.getDataUser()?.userId ?? '';
  SelectKey selectKey = SelectKey.LICH_CUA_TOI;

  void setChangeKey(SelectKey key) {
    selectKey = key;
    switch (key) {
      case SelectKey.LICH_CUA_TOI:
        final data = LichLamViecRequest(
          dateFrom: startDate.formatApi,
          dateTo: endDate.formatApi,
          isLichCuaToi: true,
        );
        callApi(data);
        break;
      case SelectKey.LICH_CHO_XAC_NHAN:
        final data = LichLamViecRequest(
          dateFrom: startDate.formatApi,
          dateTo: endDate.formatApi,
          isLichDuocMoi: true,
          isChoXacNhan: true,
        );
        callApi(data);
        break;
      default:
        {}
    }
  }

  Future<void> callApi(LichLamViecRequest lamViecRequest) async {
    showLoading();
    final result = await homeRep.getListLichLamViec(
      lamViecRequest,
    );
    result.when(
      success: (res) {
        final listResult = <CalendarMeetingModel>[];
        int index = 0;
        for (final vl in res) {
          listResult.add(vl);
          index++;
          if (index >= 20) {
            break;
          }
        }
        _getListLichLamViec.sink.add(listResult.reversed.toList());
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
      setChangeKey(this.selectKey);
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
  final userId = HiveLc.HiveLocal.getDataUser()?.userId ?? '';

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
      case SelectKey.LICH_CHO_XAC_NHAN:
        isLichHopCuaToi = false;
        isLichDuocMoi = true;
        isDuyetLich = false;
        isChoXacNhan = true;
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
  final BehaviorSubject<SelectKey> _getSelectkey =
      BehaviorSubject.seeded(SelectKey.HOM_NAY);

  Stream<List<SuKienModel>> get getSuKien => _getSuKien.stream;

  Stream<SelectKey> get getSelectkey => _getSelectkey.stream;

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

  void changeSelectKey(SelectKey key) {
    _getSelectkey.sink.add(key);
  }

  String changeTitle(SelectKey key) {
    switch (key) {
      case SelectKey.NAM_NAY:
        return S.current.su_kien_trong_nam;
      case SelectKey.THANG_NAY:
        return S.current.su_kien_trong_thang;
      case SelectKey.TUAN_NAY:
        return S.current.su_kien_trong_tuan;
      case SelectKey.HOM_NAY:
        return S.current.su_kien_trong_ngay;
      default:
        return S.current.su_kien_trong_ngay;
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

///Tình hình xử lý PAKN
class TinhHinhXuLyPAKNCubit extends HomeCubit with SelectKeyDialog {
  final BehaviorSubject<DocumentDashboardModel> _getTinhHinhXuLy =
      BehaviorSubject<DocumentDashboardModel>();
  String donViId = '';

  Stream<DocumentDashboardModel> get getTinhHinhXuLy => _getTinhHinhXuLy.stream;

  TinhHinhXuLyPAKNCubit() {
    final dataUser = HiveLc.HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser.userInformation?.donViTrucThuoc?.id ?? '';
    }
  }

  Future<void> callApi(bool isDonVi) async {
    if (!isDonVi) {
      showLoading();
      final result = await homeRep.getDashboardTinhHinhXuLyPAKNCaNhan();
      showContent();
      result.when(
        success: (res) {
          _getTinhHinhXuLy.sink.add(res);
        },
        error: (err) {},
      );
    } else {
      showLoading();
      final result = await homeRep.getDashboardTinhHinhXuLyPAKN(isDonVi);
      showContent();
      result.when(
        success: (res) {
          _getTinhHinhXuLy.sink.add(res);
        },
        error: (err) {},
      );
    }
  }
}

/// Nhiệm vụ
class NhiemVuCubit extends HomeCubit with SelectKeyDialog {
  NhiemVuCubit();

  final BehaviorSubject<List<CalendarMeetingModel>> _getNhiemVu =
      BehaviorSubject<List<CalendarMeetingModel>>();

  Stream<List<CalendarMeetingModel>> get getNhiemVu => _getNhiemVu.stream;
  SelectKey selectTrangThai = SelectKey.CHO_PHAN_XU_LY;
  List<String> mangTrangThai = ['CHO_PHAN_XU_LY'];
  bool isCongViec = false;

  void selectTrangThaiNhiemVu(SelectKey selectKey) {
    selectTrangThai = selectKey;
    switch (selectKey) {
      case SelectKey.CHO_PHAN_XU_LY:
        mangTrangThai = ['CHO_PHAN_XU_LY'];
        isCongViec = false;
        callApi();
        break;
      case SelectKey.DANG_THUC_HIEN:
        mangTrangThai = ['DANG_THUC_HIEN'];
        isCongViec = false;
        callApi();
        break;
      case SelectKey.CHUA_THUC_HIEN:
        mangTrangThai = ['CHUA_THUC_HIEN'];
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
          size: 20,
          index: 1,
          mangTrangThai: ["CHUA_THUC_HIEN", "DANG_THUC_HIEN"],
          trangThaiFilter: ["DANH_SACH_CONG_VIEC"],
        ),
      );
    }
    return homeRep.getNhiemVu(
      NhiemVuRequest(
        size: 20,
        index: 1,
        isNhiemVuCaNhan: isCaNhan,
        mangTrangThai: mangTrangThai,
        isSortByHanXuLy: true,
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
