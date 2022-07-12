import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'danh_sach_cong_viec_tien_ich_state.dart';

class DanhSachCongViecTienIchCubit
    extends BaseCubit<DanhSachCongViecTienIchState> {
  TienIchRepository get tienIchRep => Get.find();
  String dateChange = '';
  String? noteChange;
  String? titleChange;
  int countLoadMore = 1;
  TextEditingController searchControler = TextEditingController();
  Timer? _debounce;
  final int maxSizeFile = 31457280;

  ///id nhom nhiem vu
  String groupId = '';

  ///Stream
  BehaviorSubject<List<TodoDSCVModel>> listDSCVStream = BehaviorSubject();

  BehaviorSubject<String> titleAppBar = BehaviorSubject();

  BehaviorSubject<String> statusDSCV = BehaviorSubject.seeded(DSCVScreen.CVCB);

  DanhSachCongViecTienIchCubit() : super(MainStateInitial());

  BehaviorSubject<List<CountTodoModel>> countTodoModelSubject =
      BehaviorSubject();

  final BehaviorSubject<List<NguoiThucHienModel>> listNguoiThucHienSubject =
      BehaviorSubject<List<NguoiThucHienModel>>();

  BehaviorSubject<NguoiThucHienModel> nguoiThucHienSubject = BehaviorSubject();

  NguoiThucHienModel get dataNguoiThucHienModel =>
      nguoiThucHienSubject.valueOrNull ??
      NguoiThucHienModel(
        id: '',
        hoten: '',
        donVi: [],
        chucVu: [],
      );

  BehaviorSubject<List<NhomCVMoiModel>> nhomCVMoiSubject =
      BehaviorSubject<List<NhomCVMoiModel>>();

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  BehaviorSubject<String> nameFile = BehaviorSubject();

  ///call api va do data theo trạng thái màn hình
  Future<bool> callAPITheoFilter({
    String? textSearch,
    String? groupId,
    int? pageIndex,
    int? pageSize,
    bool? isLoadmore,
  }) async {
    switch (statusDSCV.value) {
      case DSCVScreen.CVCB:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          pageSize: 10,
          pageIndex: pageIndex ?? 1,
          searchWord: textSearch,
        );
      case DSCVScreen.CVQT:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isImportant: true,
          pageSize: pageSize ?? 10,
          pageIndex: pageIndex ?? 1,
          searchWord: textSearch,
        );
      case DSCVScreen.DHT:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: true,
          searchWord: textSearch,
          pageIndex: pageIndex ?? 1,
          pageSize: pageSize ?? 10,
        );
      case DSCVScreen.DG:
        return getListDSCVGanChoNguoiKhac();
      case DSCVScreen.DBX:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: false,
          searchWord: textSearch,
          pageIndex: pageIndex ?? 1,
          pageSize: pageSize ?? 10,
        );
      case DSCVScreen.NCVM:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          pageSize: pageSize ?? 10,
          pageIndex: pageIndex ?? 1,
          groupId: groupId ?? this.groupId,
          searchWord: textSearch,
        );
    }
    return false;
  }

  /// khoi tao data
  Future<void> initialData() async {
    await callAPITheoFilter();
    await getCountTodoAndMenu();
    unawaited(listNguoiThucHien());
    showContent();
  }

  ///  I HAVE USED IT BUT MY BOSS SAID CHANGE IT
  ///  => I JUST LET IT HERE FOR SOMEONE NEED IT TO FIX BUG OR TODO SOME THING
  Future<void> getToDoListDSCV() async {
    final result = await tienIchRep.getListTodoDSCV();
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  ///  I HAVE USED IT BUT MY BOSS SAID CHANGE IT
  ///  => I JUST LET IT HERE FOR SOMEONE NEED IT TO FIX BUG OR TODO SOME THING
  Future<void> getDSCVGanCHoToi() async {
    final result = await tienIchRep.getListDSCVGanChoToi();
    result.when(
      success: (res) {
        if (res.isNotEmpty) {}
      },
      error: (err) {},
    );
  }

  ///  I HAVE USED IT BUT MY BOSS SAID CHANGE IT
  ///  => I JUST LET IT HERE FOR SOMEONE NEED IT TO FIX BUG OR TODO SOME THING
  Future<void> getNHomCVMoi() async {
    final result = await tienIchRep.nhomCVMoi();
    result.when(
      success: (res) {
        nhomCVMoiSubject.sink.add(res);
      },
      error: (err) {},
    );
  }

  ///các danh sach api
  Future<void> listNguoiThucHien() async {
    showLoading();
    final result = await tienIchRep.getListNguoiThucHien(true, 99, 1);
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

  Future<bool> getListDSCVGanChoNguoiKhac() async {
    showLoading();
    final result = await tienIchRep.getListDSCVGanChoNguoiKhac();
    result.when(
      success: (res) {
        showContent();
        if (res.isNotEmpty) {
          listDSCVStream.sink.add(res);
        }
      },
      error: (err) {
        showError();
        return false;
      },
    );
    showContent();
    return true;
  }

  Future<bool> getAllListDSCVWithFilter({
    int? pageIndex,
    int? pageSize,
    String? searchWord,
    bool? isImportant,
    bool? inUsed,
    bool? isTicked,
    String? groupId,
    bool? isLoadmore,
  }) async {
    showLoading();
    final result = await tienIchRep.getAllListDSCVWithFilter(
      pageIndex,
      pageSize ?? 10,
      searchWord,
      isImportant,
      inUsed,
      isTicked,
      groupId,
    );
    result.when(
      success: (res) {
        showContent();
        final List<TodoDSCVModel> data = listDSCVStream.valueOrNull ?? [];
        if (isLoadmore == true) {
          data.addAll(res);
        } else {
          listDSCVStream.sink.add(res);
          return true;
        }
        listDSCVStream.sink.add(data);
        return true;
      },
      error: (err) {
        showError();
        return false;
      },
    );
    showContent();
    return true;
  }

  Future<void> getCountTodoAndMenu() async {
    showLoading();
    final result = await tienIchRep.getCountTodo();
    result.when(
      success: (res) {
        showContent();
        countTodoModelSubject.sink.add(res);
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  void closeDialog() {
    _showDialogSetting.add(null);
  }

  /// them moi cong viec
  Future<void> addTodo({String? fileName}) async {
    if (titleChange != '') {
      showLoading();
      final result = await tienIchRep.createTodo(
        CreateToDoRequest(
          groupId: statusDSCV.value == DSCVScreen.NCVM ? groupId : null,
          label: titleChange,
          isTicked: false,
          important: false,
          inUsed: true,
          finishDay:
              dateChange == '' ? null : DateTime.parse(dateChange).formatApi,
          note: noteChange == '' ? null : noteChange,
          performer: dataNguoiThucHienModel.id == ''
              ? null
              : nguoiThucHienSubject.value.id,
          filePath: fileName,
        ),
      );
      result.when(
        success: (res) {
          showContent();
          final data = listDSCVStream.value;
          data.insert(
            0,
            res,
          );
          listDSCVStream.sink.add(data);
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
        getCountTodoAndMenu();
        showContent();
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
        statusDSCV.sink.add(DSCVScreen.CVCB);
      },
      error: (err) {
        showError();
      },
    );
  }

  ///call and fill api autu
  Future<void> callAndFillApiAuto() async {
    await getCountTodoAndMenu();
    await callAPITheoFilter(pageIndex: 10 * countLoadMore);
  }

  ///chinh sưa và update công việc
  Future<void> editWork({
    bool? isTicked,
    bool? important,
    bool? inUsed,
    bool? isDeleted,
    String? filePathTodo,
    bool? isDeleteFile,
    required TodoDSCVModel todo,
  }) async {
    showLoading();
    dynamic checkData({dynamic changeData, dynamic defaultData}) {
      if (changeData == '' || changeData == null || changeData == defaultData) {
        return defaultData;
      } else {
        return changeData;
      }
    }

    final result = await tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: checkData(changeData: inUsed, defaultData: todo.inUsed),
        important:
            checkData(changeData: important, defaultData: todo.important),
        isDeleted:
            checkData(changeData: isDeleted, defaultData: todo.isDeleted),
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: checkData(changeData: isTicked, defaultData: todo.isTicked),
        label: checkData(changeData: titleChange, defaultData: todo.label),
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
        updatedOn: DateTime.now().formatApi,
        note: checkData(changeData: noteChange, defaultData: todo.note),
        finishDay: dateChange.isEmpty
            ? DateTime.now().formatApi
            : DateTime.parse(dateChange).formatApi,
        performer: dataNguoiThucHienModel.id == ''
            ? null
            : nguoiThucHienSubject.value.id,
        filePath: (isDeleteFile ?? false)
            ? null
            : checkData(changeData: filePathTodo, defaultData: todo.filePath),
      ),
    );
    result.when(
      success: (res) {
        final data = listDSCVStream.valueOrNull ?? [];
        if (isTicked != null) {
          data.insert(0, res);
          data.remove(todo);
          listDSCVStream.sink.add(data);
        }
        if (important != null) {
          data[data.lastIndexOf(todo)] = res;
          listDSCVStream.sink.add(data);
        }
        if (inUsed != null) {
          data.remove(todo);
          listDSCVStream.sink.add(data);
        }
        if (isDeleted != null) {}
        if (filePathTodo != null) {
          data[data.lastIndexOf(todo)] = res;
          listDSCVStream.sink.add(data);
        }
      },
      error: (err) {
        showError();
      },
    );
    showContent();
  }

  ItemChonBienBanCuocHopModel dataListNguoiThucHienModelDefault =
      ItemChonBienBanCuocHopModel(items: []);

  ///tim nguoi thuc hien
  void timNguoiTHucHien(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(NguoiThucHienModel person) {
      return person
          .dataAll()
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final vl = dataListNguoiThucHienModelDefault.items
        .where((element) => isListCanBo(element))
        .toList();
    listNguoiThucHienSubject.sink.add(vl);
  }

  /// tim nguoi thuc hien theo id
  String convertIdToPerson({required String vl, bool? hasChucVu}) {
    if (hasChucVu ?? true) {
      for (final e in listNguoiThucHienSubject.value) {
        if (vl == e.id) {
          return e.dataAll();
        }
      }
    } else {
      for (final e in listNguoiThucHienSubject.value) {
        if (vl == e.id) {
          return e.dataWithChucVu();
        }
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
          hoten: convertIdToPerson(vl: todo.performer ?? ''),
          donVi: [],
          chucVu: [],
        ),
      );
    }
  }

  ///up file
  Future<String> uploadFilesWithFile(File file) async {
    String filePath = '';
    showLoading();
    final result = await tienIchRep.uploadFileDSCV(file);
    result.when(
      success: (res) {
        nameFile.sink.add(res.data?.filePath ?? '');
        filePath = res.data?.filePath ?? '';
      },
      error: (error) {},
    );
    showContent();
    return filePath;
  }

  ///xóa cong viec vinh vien
  Future<void> xoaCongViecVinhVien(
    String idCv,
    TodoDSCVModel todo,
  ) async {
    final result = await tienIchRep.xoaCongViec(idCv);
    result.when(
      success: (res) {
        final data = listDSCVStream.value;
        data.remove(todo);
        listDSCVStream.sink.add(data);
      },
      error: (error) {
        showError();
      },
    );
  }

  /// hiển thị icon theo từng màn hình
  List<int> showIcon({required String dataType, bool? isListUp}) {
    if (isListUp ?? true) {
      switch (dataType) {
        case DSCVScreen.CVCB:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icEdit,
            IconDSCV.icImportant,
            IconDSCV.icClose
          ];
        case DSCVScreen.CVQT:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icClose,
          ];
        case DSCVScreen.DHT:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icClose,
          ];
        case DSCVScreen.DG:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
          ];
        case DSCVScreen.DBX:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icHoanTac,
            IconDSCV.icXoaVinhVien,
          ];
        case DSCVScreen.NCVM:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icEdit,
            IconDSCV.icImportant,
            IconDSCV.icClose
          ];
      }
    } else {
      switch (dataType) {
        case DSCVScreen.CVCB:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icClose,
          ];
        case DSCVScreen.CVQT:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icClose,
          ];
        case DSCVScreen.DHT:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icClose,
          ];
        case DSCVScreen.DG:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icClose,
          ];
        case DSCVScreen.DBX:
          return [
            IconDSCV.icCheckBox,
            IconDSCV.icImportant,
            IconDSCV.icHoanTac,
            IconDSCV.icXoaVinhVien,
          ];
        case DSCVScreen.NCVM:
          return [IconDSCV.icCheckBox, IconDSCV.icImportant, IconDSCV.icClose];
      }
    }

    return [];
  }

  List<int> enableIcon(String dataType) {
    switch (dataType) {
      case DSCVScreen.CVCB:
        return [];
      case DSCVScreen.CVQT:
        return [];
      case DSCVScreen.DHT:
        return [];
      case DSCVScreen.DG:
        return [];
      case DSCVScreen.DBX:
        return [IconDSCV.icCheckBox, IconDSCV.icImportant];
      case DSCVScreen.NCVM:
        return [];
    }
    return [];
  }

  /// funtion delay
  Future<void> waitToDelay({
    required Function actionNeedDelay,
    required int timeSecond,
  }) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
        Duration(
          milliseconds: timeSecond * 1000,
        ), () {
      actionNeedDelay();
    });
  }

  void disposs() {
    dateChange = '';
    noteChange = '';
    titleChange = '';
    nguoiThucHienSubject.sink.add(
      NguoiThucHienModel(
        id: '',
        hoten: '',
        donVi: [],
        chucVu: [],
      ),
    );
  }
}
