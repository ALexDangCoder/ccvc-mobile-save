import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:ccvc_mobile/bao_cao_module/utils/constants/api_constants.dart';
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
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'danh_sach_cong_viec_tien_ich_state.dart';

class DanhSachCongViecTienIchCubit
    extends BaseCubit<DanhSachCongViecTienIchState> {
  TienIchRepository get tienIchRep => Get.find();
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

  BehaviorSubject<NguoiThucHienModel> nguoiThucHienSubject =
      BehaviorSubject.seeded(
    NguoiThucHienModel(
      id: '',
      hoten: '',
      donVi: [],
      chucVu: [],
    ),
  );

  NguoiThucHienModel get getDataNguoiThucHienModel =>
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
          pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
          pageIndex: pageIndex ?? ApiConstants.PAGE_BEGIN,
          searchWord: textSearch,
        );
      case DSCVScreen.CVQT:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isImportant: true,
          pageSize: pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
          pageIndex: pageIndex ?? ApiConstants.PAGE_BEGIN,
          searchWord: textSearch,
        );
      case DSCVScreen.DHT:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: true,
          searchWord: textSearch,
          pageIndex: pageIndex ?? ApiConstants.PAGE_BEGIN,
          pageSize: pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
        );
      case DSCVScreen.DG:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          searchWord: textSearch,
          pageIndex: pageIndex ?? ApiConstants.PAGE_BEGIN,
          pageSize: pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
          isGiveOther: true,
        );
      case DSCVScreen.DBX:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: false,
          searchWord: textSearch,
          pageIndex: pageIndex ?? ApiConstants.PAGE_BEGIN,
          pageSize: pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
        );
      case DSCVScreen.NCVM:
        return getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          pageSize: pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
          pageIndex: pageIndex ?? ApiConstants.PAGE_BEGIN,
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

  ///  I HAVE USED IT BUT MY BOSS SAID CHANGE IT
  ///  => I JUST LET IT HERE FOR SOMEONE NEED IT TO FIX BUG OR TODO SOME THING
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
    bool? isGiveOther,
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
      isGiveOther,
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
  Future<void> addTodo({
    required String title,
    String? fileName,
    String? date,
    String? note,
  }) async {
    date ??= DateTime.now().toString();
    if (title.trim().isNotEmpty) {
      showLoading();
      final result = await tienIchRep.createTodo(
        CreateToDoRequest(
          groupId: statusDSCV.value == DSCVScreen.NCVM ? groupId : null,
          label: title.trim(),
          isTicked: false,
          important: false,
          inUsed: true,
          finishDay: checkData(
            defaultData: DateTime.now().formatApi,
            changeData: DateTime.parse(date).formatApi,
          ),
          note: checkData(
            defaultData: null,
            changeData: note?.trim(),
          ),
          performer: checkData(
            defaultData: null,
            changeData: getDataNguoiThucHienModel.id,
          ),
          filePath: checkData(
            defaultData: null,
            changeData: fileName,
          ),
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

  /// check data xem can them moi, sưa, hay xóa
  dynamic checkData({
    dynamic changeData,
    dynamic defaultData,
    bool? isNeedNull,
  }) {
    if (isNeedNull ?? false) {
      return null;
    }
    if (changeData == defaultData || changeData == null || changeData == '') {
      return defaultData;
    } else {
      return changeData;
    }
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

  ///chinh sưa và update công việc
  Future<void> editWork({
    required TodoDSCVModel todo,
    bool? isTicked,
    bool? important,
    bool? inUsed,
    bool? isDeleted,
    String? filePathTodo,
    String? title,
    String? note,
    String? date,
    String? performer,
  }) async {
    bool checkNeedNullOrNot({
      String? defaultData,
      String? changeData,
    }) {
      return ((changeData ?? '').isEmpty) &&
          ((defaultData ?? '').isNotEmpty) &&
          changeData != null;
    }

    showLoading();
    date ??= DateTime.now().toString();
    final result = await tienIchRep.upDateTodo(
      ToDoListRequest(
        id: todo.id,
        inUsed: checkData(
          changeData: inUsed,
          defaultData: todo.inUsed,
        ),
        important: checkData(
          changeData: important,
          defaultData: todo.important,
        ),
        isDeleted: todo.isDeleted,
        createdOn: todo.createdOn,
        createdBy: todo.createdBy,
        isTicked: checkData(
          changeData: isTicked,
          defaultData: todo.isTicked,
        ),
        label: checkData(
          changeData: title?.trim(),
          defaultData: todo.label,
          isNeedNull: checkNeedNullOrNot(
            defaultData: todo.label,
            changeData: title?.trim(),
          ),
        ),
        updatedBy: HiveLocal.getDataUser()?.userInformation?.id ?? '',
        updatedOn: DateTime.now().formatApi,
        note: checkData(
          changeData: note?.trim(),
          defaultData: todo.note,
          isNeedNull: checkNeedNullOrNot(
            defaultData: todo.note,
            changeData: note?.trim(),
          ),
        ),
        finishDay: checkData(
          defaultData: todo.finishDay,
          changeData: DateTime.parse(date).formatApi,
        ),
        performer: checkData(
          changeData: performer,
          defaultData: todo.performer,
          isNeedNull: checkNeedNullOrNot(
            defaultData: todo.performer,
            changeData: performer,
          ),
        ),
        filePath: checkData(
          changeData: filePathTodo,
          defaultData: todo.filePath,
          isNeedNull: checkNeedNullOrNot(
            defaultData: todo.filePath,
            changeData: filePathTodo,
          ),
        ),
      ),
    );
    result.when(
      success: (res) {
        showContent();
        final data = listDSCVStream.valueOrNull ?? [];
        MessageConfig.show(title: S.current.thanh_cong);
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
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
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
      nguoiThucHienSubject.sink.add(
        NguoiThucHienModel(
          id: '',
          hoten: S.current.tim_theo_nguoi,
          donVi: [],
          chucVu: [],
        ),
      );
    } else {
      nguoiThucHienSubject.sink.add(
        NguoiThucHienModel(
          id: todo.performer ?? '',
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

  /// hiển thị icon theo từng màn hình (cần viết lại cho gọn và dễ bảo trì hơn, hiện tại không đủ time. today: 29/07/2022)
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
