import 'dart:async';
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
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'danh_sach_cong_viec_tien_ich_state.dart';

const int CVCB = 0;
const int CVQT = 1;
const int DHT = 2;
const int GCT = 3;
const int DBX = 4;
const int NCVM = 5;

class DanhSachCongViecTienIchCubit
    extends BaseCubit<DanhSachCongViecTienIchState> {
  TienIchRepository get tienIchRep => Get.find();
  String dateChange = '';
  String? noteChange;
  String? titleChange;

  ///id nhom nhiem vu
  String groupId = '';

  List<TodoDSCVModel> toDoModelDefault = [];
  List<TodoDSCVModel> toDoModelGanChoToiDefault = [];

  ///gop cua hai list ben tren
  List<TodoDSCVModel> listGop = [];

  ///filter
  List<TodoDSCVModel> listCongViecCuaBan = [];
  List<TodoDSCVModel> listQuanTrong = [];
  List<TodoDSCVModel> listDaHoanThanh = [];
  List<TodoDSCVModel> listGanChoToi = [];
  List<TodoDSCVModel> listDaBiXoa = [];
  List<TodoDSCVModel> nhomCongViecMoi = [];

  ///Request
  ToDoListRequest toDoListRequest = ToDoListRequest();

  ///Stream
  BehaviorSubject<List<TodoDSCVModel>> listDSCV = BehaviorSubject();

  BehaviorSubject<String> titleAppBar = BehaviorSubject();

  BehaviorSubject<int> statusDSCV = BehaviorSubject.seeded(0);

  DanhSachCongViecTienIchCubit() : super(MainStateInitial());

  BehaviorSubject<bool> enabled = BehaviorSubject.seeded(true);

  final BehaviorSubject<List<NguoiThucHienModel>> listNguoiThucHienSubject =
      BehaviorSubject<List<NguoiThucHienModel>>();

  BehaviorSubject<NguoiThucHienModel> nguoiThucHienSubject = BehaviorSubject();

  BehaviorSubject<List<NhomCVMoiModel>> nhomCVMoiSubject =
      BehaviorSubject<List<NhomCVMoiModel>>();

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  ///init cac list
  void doDataTheoFilter() {
    listGop = [
      ...toDoModelGanChoToiDefault,
      ...toDoModelDefault,
    ];
    listCongViecCuaBan = listGop
        .where(
          (element) => element.inUsed == true,
        )
        .toList();
    listQuanTrong = listGop
        .where(
          (e) => e.inUsed == true && e.isTicked == false && e.important == true,
        )
        .toList();
    listDaHoanThanh = listGop
        .where(
          (e) => e.inUsed == true && e.isTicked == true,
        )
        .toList();
    listGanChoToi = toDoModelGanChoToiDefault
        .where(
          (e) => e.inUsed == true && e.isTicked == false,
        )
        .toList();
    listDaBiXoa = listGop
        .where((e) => e.inUsed == false && e.isDeleted == false)
        .toList();
    vlMenuDf[CVCB].number = listCongViecCuaBan
        .where((element) => element.isTicked == false)
        .toList()
        .length;
    vlMenuDf[CVQT].number = listQuanTrong.length;
    vlMenuDf[DHT].number = listDaHoanThanh.length;
    vlMenuDf[GCT].number = listGanChoToi.length;
    vlMenuDf[DBX].number = listDaBiXoa.length;
  }

  /// khoi tao data
  Future<void> initialData() async {
    showLoading();
    await getToDoListDSCV();
    await getDSCVGanCHoToi();
    unawaited(listNguoiThucHien());
    unawaited(getNHomCVMoi());
    doDataTheoFilter();
    addValueWithTypeToDSCV();
    showContent();
  }

  /// Cac danh Sach APi
  Future<void> getToDoListDSCV() async {
    final result = await tienIchRep.getListTodoDSCV();
    showContent();
    result.when(
      success: (res) {
        toDoModelDefault = res;
      },
      error: (err) {},
    );
  }

  Future<void> getDSCVGanCHoToi() async {
    final result = await tienIchRep.getListDSCVGanChoToi();
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          toDoModelGanChoToiDefault = res;
        }
      },
      error: (err) {},
    );
  }

  Future<void> getNHomCVMoi() async {
    final result = await tienIchRep.nhomCVMoi();
    result.when(
      success: (res) {
        nhomCVMoiSubject.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> listNguoiThucHien() async {
    showLoading();
    final result = await tienIchRep.getListNguoiThucHien(true, 999, 1);
    result.when(
      success: (res) {
        showContent();
        listNguoiThucHienSubject.sink.add(res.items);
        dataListNguoiThucHienModelDefault = res;
      },
      error: (err) {
        showError();
      },
    );
  }

  /// set filter data
  void addValueWithTypeToDSCV() {
    switch (statusDSCV.value) {
      case CVCB:
        return listDSCV.sink.add(listCongViecCuaBan);
      case CVQT:
        return listDSCV.sink.add(listQuanTrong);
      case DHT:
        return listDSCV.sink.add(listDaHoanThanh);
      case GCT:
        return listDSCV.sink.add(listGanChoToi);
      case DBX:
        return listDSCV.sink.add(listDaBiXoa);
      case NCVM:
        return listDSCV.sink.add(
          toDoModelDefault
              .where((e) => isList(e, groupId) && e.inUsed == true)
              .toList(),
        );
    }
  }

  /// valueViewMenu
  List<MenuDscvModel> vlMenuDf = [
    MenuDscvModel(
      icon: isMobile() ? ImageAssets.icCVCuaBan : ImageAssets.ic01,
      title: S.current.cong_viec_cua_ban,
    ),
    MenuDscvModel(
      icon: isMobile() ? ImageAssets.icCVQT : ImageAssets.ic02,
      title: S.current.cong_viec_quan_trong,
    ),
    MenuDscvModel(
      icon: isMobile() ? ImageAssets.icHT : ImageAssets.ic03,
      title: S.current.da_hoan_thanh,
    ),
    MenuDscvModel(
      icon: isMobile() ? ImageAssets.icGanChoToi : ImageAssets.ic04,
      title: S.current.gan_cho_toi,
    ),
    MenuDscvModel(
      icon: isMobile() ? ImageAssets.icXoa : ImageAssets.ic05,
      title: S.current.da_bi_xoa,
    ),
  ];

  void closeDialog() {
    _showDialogSetting.add(null);
  }

  ///So luong nhom cong viec moi
  int soLuongNhomCvMoi({required String groupId}) {
    final dataCount = toDoModelDefault.where(
      (element) => element.inUsed == true && element.isTicked == false,
    );
    return dataCount
        .where((element) => isList(element, groupId))
        .toList()
        .length;
  }

  ///tim kiem
  void search(String text) {
    final dataSearch = listDSCV.value;
    if (text != '') {
      final searchTxt = text.trim().toLowerCase().vietNameseParse();
      bool isListCanBo(TodoDSCVModel toDo) {
        return toDo.label!.toLowerCase().vietNameseParse().contains(searchTxt);
      }

      final vl = dataSearch.where((element) => isListCanBo(element)).toList();
      listDSCV.sink.add(vl);
    } else {
      addValueWithTypeToDSCV();
    }
  }

  /// them moi cong viec

  Future<void> addTodo() async {
    if (titleChange != '') {
      showLoading();
      final result = await tienIchRep.createTodo(
        CreateToDoRequest(
          groupId: statusDSCV.value == NCVM ? groupId : null,
          label: titleChange,
          isTicked: false,
          important: false,
          inUsed: true,
          finishDay: dateChange == '' ? null : dateChange,
          note: noteChange == '' ? null : noteChange,
          performer: nguoiThucHienSubject.value.id == ''
              ? null
              : nguoiThucHienSubject.value.id,
        ),
      );
      result.when(
        success: (res) {
          showContent();
          final data = listDSCV.value;
          data.insert(
            0,
            res,
          );
          listDSCV.sink.add(data);
          callAndFillApiAutu();
          closeDialog();
        },
        error: (err) {
          showError();
        },
      );
    }
  }

  /// them nhóm công việc
  Future<void> addGroupTodo(String label) async {
    if (label.trim().isEmpty) {
      return;
    }
    showLoading();
    final result = await tienIchRep.createNhomCongViecMoi(label);
    result.when(
      success: (res) {
        showContent();
        final List<NhomCVMoiModel> data = nhomCVMoiSubject.value;
        data.insert(0, res);
        nhomCVMoiSubject.sink.add(data);
      },
      error: (err) {
        showError();
      },
    );
  }

  /// sửa tên nhóm công việc
  Future<void> updateLabelTodoList(String label) async {
    if (label.trim().isEmpty) {
      return;
    }
    showLoading();
    final result = await tienIchRep.updateLabelTodoList(groupId, label);
    result.when(
      success: (res) {
        showContent();
        titleAppBar.sink.add(res.label);
      },
      error: (err) {
        showError();
      },
    );
  }

  /// xóa nhóm công việc
  Future<void> deleteGroupTodoList() async {
    showLoading();
    final result = await tienIchRep.deleteGroupTodoList(groupId);
    result.when(
      success: (res) {
        showContent();
        titleAppBar.sink.add(S.current.cong_viec_cua_ban);
        statusDSCV.sink.add(CVCB);
        doDataTheoFilter();
        addValueWithTypeToDSCV();
        getNHomCVMoi();
      },
      error: (err) {
        showError();
      },
    );
  }

  ///call and fill api autu
  void callAndFillApiAutu() async {
    await getToDoListDSCV();
    await getDSCVGanCHoToi();
    doDataTheoFilter();
    addValueWithTypeToDSCV();
  }

  /// tìm kiếm cong việc theo nhóm cong việc
  bool isList(TodoDSCVModel toDo, String idGr) {
    if (toDo.groupId != null) {
      return toDo.groupId!.contains(idGr);
    }
    return false;
  }

  String person = '';

  ///chinh sưa và update công việc
  Future<void> editWork({
    bool? isTicked,
    bool? important,
    bool? inUsed,
    bool? isDeleted,
    required TodoDSCVModel todo,
  }) async {
    final result = await tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: inUsed ?? todo.inUsed,
        important: important ?? todo.important,
        isDeleted: isDeleted ?? todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: isTicked ?? todo.isTicked,
        label: titleChange ?? todo.label,
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
        updatedOn: DateTime.now().formatApi,
        note: noteChange ?? todo.note,
        finishDay: dateChange.isEmpty
            ? DateTime.now().formatApi
            : DateTime.parse(dateChange).formatDayCalendar,
        performer: toDoListRequest.performer ?? todo.performer,
      ),
    );
    result.when(
      success: (res) {
        final data = listDSCV.value;
        if (isTicked != null) {
          data.insert(0, res);
          data.remove(todo);
          listDSCV.sink.add(data);
        }
        if (important != null) {
          data.insert(data.indexOf(todo), res);
          listDSCV.sink.add(data);
        }
        if (inUsed != null) {
          data.remove(todo);
          listDSCV.sink.add(data);
        }
        if (isDeleted != null) {}
        callAndFillApiAutu();
      },
      error: (err) {},
    );
  }

  late ItemChonBienBanCuocHopModel dataListNguoiThucHienModelDefault;

  ///tim nguoi thuc hien
  void timNguoiTHucHien(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(NguoiThucHienModel person) {
      return person.data().toLowerCase().vietNameseParse().contains(searchTxt);
    }

    final vl = dataListNguoiThucHienModelDefault.items
        .where((element) => isListCanBo(element))
        .toList();
    listNguoiThucHienSubject.sink.add(vl);
  }

  /// tim nguoi thuc hien theo id
  String convertIdToPerson(String vl) {
    for (final e in dataListNguoiThucHienModelDefault.items) {
      if (e.id == vl) {
        return e.data();
      }
    }
    return '';
  }

  ///init data nguoi thuc hien
  void initDataNguoiTHucHienTextFild(TodoDSCVModel todo) {
    if (todo.performer == '' || todo.performer == null) {
      nguoiThucHienSubject.add(
        NguoiThucHienModel(
          id: '',
          hoten: S.current.tim_theo_nguoi,
          donVi: [],
          chucVu: [],
        ),
      );
    } else {
      nguoiThucHienSubject.add(
        NguoiThucHienModel(
          id: '',
          hoten: convertIdToPerson(todo.performer ?? ''),
          donVi: [],
          chucVu: [],
        ),
      );
    }
  }
}
