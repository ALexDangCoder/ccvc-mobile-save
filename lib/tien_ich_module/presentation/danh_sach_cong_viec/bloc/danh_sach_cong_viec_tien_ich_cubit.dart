import 'dart:core';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/menu_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'danh_sach_cong_viec_tien_ich_state.dart';
import 'extension.dart';

const int CVCB = 0;
const int CVQT = 1;
const int DHT = 2;
const int GCT = 3;
const int DBX = 4;
const int NCXM = 5;

class DanhSachCongViecTienIchCubit
    extends BaseCubit<DanhSachCongViecTienIchState> {
  Map<String, ItemMissionMenu> mapData = {};
  List<String> listKey = [];
  List<TodoDSCVModel> importance = [];
  List<TodoDSCVModel> toDoModelDefault = [];
  List<TodoDSCVModel> toDoModelGanChoToiDefault = [];

  String groupIdGet = '';
  final BehaviorSubject<TodoListModelTwo> todoListGroup =
      BehaviorSubject<TodoListModelTwo>();
  BehaviorSubject<List<TodoDSCVModel>> listDSCV = BehaviorSubject();
  BehaviorSubject<List<TodoDSCVModel>> listGanChoToi = BehaviorSubject();
  BehaviorSubject<List<TodoDSCVModel>> listDaXoa = BehaviorSubject();
  BehaviorSubject<List<TodoDSCVModel>> listGanChoToiDaXoa = BehaviorSubject();
  BehaviorSubject<String> titleAppBar = BehaviorSubject();
  BehaviorSubject<int> statusDSCV = BehaviorSubject.seeded(0);

  BehaviorSubject<List<bool>> selectTypeCalendarSubject =
      BehaviorSubject.seeded([true, false, false, false, false, false]);

  DanhSachCongViecTienIchCubit() : super(MainStateInitial());
  BehaviorSubject<bool> enabled = BehaviorSubject.seeded(true);

  Stream<bool> get getEnabled => enabled.stream;

  Future<void> initialData() async {
    showLoading();
    await getToDoList();
    // await listNguoiThucHien();
    await getNHomCVMoi();
    await getToDoListDSCVTung();
    await getDSCVGanCHoToi();
    final List<TodoDSCVModel> listGop = [
      ...toDoModelGanChoToiDefault,
      ...toDoModelDefault,
    ];
    listDSCV.sink
        .add(listGop.where((element) => element.inUsed == true).toList());
  }

  List<MenuDscvModel> vlMenuDf = [
    MenuDscvModel(
      icon: ImageAssets.icCVCuaBan,
      title: S.current.cong_viec_cua_ban,
    ),
    MenuDscvModel(
      icon: ImageAssets.icCVQT,
      title: S.current.cong_viec_quan_trong,
    ),
    MenuDscvModel(
      icon: ImageAssets.icHT,
      title: S.current.da_hoan_thanh,
    ),
    MenuDscvModel(
      icon: ImageAssets.icGanChoToi,
      title: S.current.gan_cho_toi,
    ),
    MenuDscvModel(
      icon: ImageAssets.icXoa,
      title: S.current.da_bi_xoa,
    ),
  ];

  TienIchRepository get tienIchRep => Get.find();

  final BehaviorSubject<List<NguoiThucHienModel>> nguoiThucHien =
      BehaviorSubject<List<NguoiThucHienModel>>();

  final BehaviorSubject<List<NhomCVMoiModel>> nhomCVMoiSubject =
      BehaviorSubject<List<NhomCVMoiModel>>();

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  final BehaviorSubject<TodoListModelTwo> _getTodoList =
      BehaviorSubject<TodoListModelTwo>();

  Stream<TodoListModelTwo> get getTodoList => _getTodoList.stream;

  void closeDialog() {
    _showDialogSetting.add(null);
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

  Future<void> addTodo(String label) async {
    if (label.trim().isEmpty) {
      return;
    }
    showLoading();
    final result = await tienIchRep.createTodo(
      CreateToDoRequest(
        label: label,
        isTicked: false,
        important: false,
        inUsed: true,
      ),
    );
    // await getToDoList();
    showContent();
    result.when(
      success: (res) {
        final data = _getTodoList.value;
        data.listTodoImportant.insert(
          0,
          res,
        );
        _getTodoList.sink.add(data);
        closeDialog();
      },
      error: (err) {},
    );
  }

  void tickerListWord({required TodoDSCVModel todo, bool removeDone = true}) {
    final data = _getTodoList.value;
    tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: true,
        important: todo.important,
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: !removeDone,
        label: todo.label,
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
        updatedOn: DateTime.now().formatApi,
      ),
    );
    if (removeDone) {
      _removeInsertImportant(data, todo);
    } else {
      _removeInsertDone(data, todo);
    }
  }

  void _removeInsertImportant(TodoListModelTwo data, TodoDSCVModel todo) {
    final result = data.listTodoDone.removeAt(
      data.listTodoDone.indexWhere((element) => element.id == todo.id),
    );
    data.listTodoImportant.insert(0, result..isTicked = false);
    _getTodoList.sink.add(
      TodoListModelTwo(
        listTodoImportant: data.listTodoImportant,
        listTodoDone: data.listTodoDone,
      ),
    );
  }

  void _removeInsertDone(TodoListModelTwo data, TodoDSCVModel todo) {
    final result = data.listTodoImportant.removeAt(
      data.listTodoImportant.indexWhere((element) => element.id == todo.id),
    );

    data.listTodoDone.insert(0, result..isTicked = true);
    _getTodoList.sink.add(
      data,
    );
  }

  void deleteCongViec(TodoDSCVModel todoModel, {bool removeDone = true}) {
    final data = _getTodoList.value;
    tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todoModel.id,
        inUsed: false,
        important: todoModel.important,
        isDeleted: todoModel.isDeleted,
        createdOn: todoModel.createdOn,
        createdBy: todoModel.createdBy,
        isTicked: todoModel.isTicked,
        label: todoModel.label,
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
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

  void tickerQuanTrongTodo(TodoDSCVModel todo, {bool removeDone = true}) {
    final data = _getTodoList.value;
    tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: true,
        important: !(todo.important ?? false),
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: todo.isTicked,
        label: todo.label,
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
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

  void changeLabelTodo(String newLabel, TodoDSCVModel todo) {
    final data = _getTodoList.value;
    if (newLabel == todo.label) {
      return;
    }
    tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: true,
        important: todo.important,
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: todo.isTicked,
        label: newLabel,
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
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

  late TodoListModelTwo dataListDefault;

  bool isList(TodoDSCVModel toDo, String idGr) {
    if (toDo.groupId != null) {
      return toDo.groupId!.contains(idGr);
    }
    return false;
  }

  Future<void> getToDoList() async {
    showLoading();
    final result = await tienIchRep.getListTodo();
    showContent();
    result.when(
      success: (res) {
        listDSCV.sink.add(res.listTodoImportant
            .where((element) => element.important == true)
            .toList());
        _getTodoList.sink.add(res);
        dataListDefault = res;
        vlMenuDf[CVCB].number = res.listTodoImportant.length;
        vlMenuDf[DHT].number = res.listTodoDone.length;
        vlMenuDf[CVQT].number = listDSCV.value.length;
      },
      error: (err) {},
    );
  }

  void addValueToTypeDSCV(int type) {
    final List<TodoDSCVModel> listGop = [
      ...toDoModelGanChoToiDefault,
      ...toDoModelDefault
    ];
    switch (type) {
      case CVCB:
        return listDSCV.sink.add(
          listGop
              .where(
                (element) => element.inUsed == true,
              )
              .toList(),
        );
      case CVQT:
        return listDSCV.sink.add(
          listGop
              .where(
                (e) =>
                    e.inUsed == true &&
                    e.isTicked == false &&
                    e.important == true,
              )
              .toList(),
        );
      case DHT:
        return listDSCV.sink.add(
          listGop
              .where(
                (e) => e.inUsed == true && e.isTicked == true,
              )
              .toList(),
        );
      case GCT:
        return listDSCV.sink.add(
          toDoModelGanChoToiDefault
              .where(
                (e) => e.inUsed == true && e.isTicked == false,
              )
              .toList(),
        );
      case DBX:
        return listDSCV.sink.add(
          listGop
              .where(
                (e) => e.inUsed == false,
              )
              .toList(),
        );
    }
  }

  Future<void> getListNhomCVMoi(String idGr) async {
    showLoading();
    final result = await tienIchRep.getListTodo();
    result.when(
      success: (res) {
        todoListGroup.sink.add(
          TodoListModelTwo(
            listTodoDone: res.listTodoDone
                .where((element) => isList(element, idGr))
                .toList(),
            listTodoImportant: res.listTodoImportant
                .where((element) => isList(element, idGr))
                .toList(),
          ),
        );
      },
      error: (err) {},
    );
  }

  Future<void> getToDoListDSCVTung() async {
    showLoading();
    final result = await tienIchRep.getListTodoDSCV();
    showContent();
    result.when(
      success: (res) {
        createData(res);
        listDaXoa.sink
            .add(res.where((element) => element.inUsed == false).toList());
        toDoModelDefault = res;
      },
      error: (err) {},
    );
  }

  Future<void> getDSCVGanCHoToi() async {
    showLoading();
    final result = await tienIchRep.getListDSCVGanChoToi();
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          listGanChoToi.sink
              .add(res.where((element) => element.inUsed == true).toList());
          listGanChoToiDaXoa.sink
              .add(res.where((element) => element.inUsed == false).toList());
          vlMenuDf[DBX].number =
              listDaXoa.value.length + listGanChoToiDaXoa.value.length;
          vlMenuDf[GCT].number = listGanChoToi.value.length;
          toDoModelGanChoToiDefault = res;
        }
      },
      error: (err) {},
    );
  }

  Future<void> getNHomCVMoi() async {
    showLoading();
    final result = await tienIchRep.NhomCVMoi();
    showContent();
    result.when(
      success: (res) {
        createMap(res);
        nhomCVMoiSubject.sink.add(res);
      },
      error: (err) {},
    );
  }

  String dateChange = '';

  String getDate(String date) {
    dateChange = date;
    return date;
  }

  String noteChange = '';

  String getnote(String note) {
    noteChange = note;
    return note;
  }

  String titleChange = '';

  String getTitle(String title) {
    titleChange = title;
    return title;
  }

  String person = '';
  String idPerson = '';

  void getPersontodo({required String person, required String idPerson}) {
    this.person = person;
    this.idPerson = idPerson;
  }

  Future<void> editWork(TodoDSCVModel todo) async {
    await tienIchRep.upDateTodo(
      ToDoListRequest(
          id: todo.id,
          inUsed: true,
          important: todo.important,
          isDeleted: todo.isDeleted,
          createdOn: todo.createdOn,
          createdBy: todo.createdBy,
          isTicked: todo.isTicked,
          label: titleChange.isEmpty ? todo.label : titleChange,
          updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
          updatedOn: DateTime.now().formatApi,
          note: noteChange.isNotEmpty ? todo.note : noteChange,
          finishDay: dateChange.isEmpty
              ? DateTime.now().formatApi
              : DateTime.parse(dateChange).formatDayCalendar,
          performer: idPerson),
    );
    await getToDoList();
  }

  void search(String text) {
    final data = _getTodoList.value;
    if (text != '') {
      final searchTxt = text.trim().toLowerCase().vietNameseParse();
      bool isListCanBo(TodoDSCVModel toDo) {
        return toDo.label!.toLowerCase().vietNameseParse().contains(searchTxt);
      }

      final vl = data.listTodoImportant
          .where((element) => isListCanBo(element))
          .toList();
      final TodoListModelTwo todoListModel = TodoListModelTwo(
          listTodoImportant: vl, listTodoDone: data.listTodoDone);
      _getTodoList.sink.add(todoListModel);
    } else {
      _getTodoList.sink.add(dataListDefault);
    }
  }

  late ItemChonBienBanCuocHopModel dataListNguoiThucHienModelDefault;

  Future<void> listNguoiThucHien() async {
    showLoading();
    final result = await tienIchRep.getListNguoiThucHien(true, 999, 1);
    result.when(
      success: (res) {
        nguoiThucHien.sink.add(res.items);
        dataListNguoiThucHienModelDefault = res;
      },
      error: (err) {},
    );
  }

  void timNguoiTHucHien(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(NguoiThucHienModel person) {
      return person.data().toLowerCase().vietNameseParse().contains(searchTxt);
    }

    final vl = dataListNguoiThucHienModelDefault.items
        .where((element) => isListCanBo(element))
        .toList();
    nguoiThucHien.sink.add(vl);
  }

  String personWithId = '';

  String convertIdToPerson(String vl) {
    for (final e in dataListNguoiThucHienModelDefault.items) {
      if (e.id == vl) {
        personWithId = e.data();
      }
    }
    return personWithId;
  }
}
