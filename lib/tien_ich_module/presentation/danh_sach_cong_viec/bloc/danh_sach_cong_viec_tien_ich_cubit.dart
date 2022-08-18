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
import 'package:ccvc_mobile/tien_ich_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

import 'danh_sach_cong_viec_tien_ich_state.dart';

class DanhSachCongViecTienIchCubit
    extends BaseCubit<DanhSachCongViecTienIchState> {
  TienIchRepository get tienIchRep => Get.find();
  int countLoadMore = ApiConstants.PAGE_BEGIN;
  int indexNguoiThucHien = ApiConstants.PAGE_BEGIN;
  bool canLoadMore = true;
  bool canLoadMoreNguoiThucHien = true;
  TextEditingController searchControler = TextEditingController();
  Timer? _debounce;
  final int maxSizeFile = MaxSizeFile.MAX_SIZE_20MB.toInt();

  ///id nhom nhiem vu
  String groupId = '';

  ///Stream
  BehaviorSubject<List<TodoDSCVModel>> listDSCVStream = BehaviorSubject();

  BehaviorSubject<String> titleAppBar = BehaviorSubject();

  BehaviorSubject<String> statusDSCV = BehaviorSubject.seeded(DSCVScreen.CVCB);

  DanhSachCongViecTienIchCubit() : super(MainStateInitial());

  BehaviorSubject<List<CountTodoModel>> countTodoModelSubject =
      BehaviorSubject();

  BehaviorSubject<bool> inLoadmore = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> showLoadNguoiThucHien = BehaviorSubject.seeded(false);

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
    bool isLoadmore = false,
  }) async {
    if (isLoadmore) {
      inLoadmore.sink.add(true);
    } else {
      showLoading();
    }
    bool result = false;
    switch (statusDSCV.value) {
      case DSCVScreen.CVCB:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: false,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
          pageIndex: countLoadMore,
          searchWord: textSearch?.trim(),
        );
        break;
      case DSCVScreen.CVQT:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: false,
          isImportant: true,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
          pageIndex: countLoadMore,
          searchWord: textSearch?.trim(),
        );
        break;
      case DSCVScreen.DHT:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: true,
          searchWord: textSearch?.trim(),
          pageIndex: countLoadMore,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
        );
        break;
      case DSCVScreen.DG:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: false,
          searchWord: textSearch?.trim(),
          pageIndex: countLoadMore,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
          isGiveOther: true,
        );
        break;
      case DSCVScreen.GCT:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: false,
          searchWord: textSearch?.trim(),
          pageIndex: countLoadMore,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
          isForMe: true,
        );
        break;
      case DSCVScreen.DBX:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: false,
          searchWord: textSearch?.trim(),
          pageIndex: countLoadMore,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
        );
        break;
      case DSCVScreen.NCVM:
        result = await getAllListDSCVWithFilter(
          isLoadmore: isLoadmore,
          inUsed: true,
          isTicked: false,
          pageSize: ApiConstants.LONG_PAGE_SIZE,
          pageIndex: countLoadMore,
          groupId: groupId ?? this.groupId,
          searchWord: textSearch?.trim(),
        );
        break;
    }
    if (isLoadmore) {
      inLoadmore.sink.add(false);
    } else {
      showContent();
    }
    return result;
  }

  /// khoi tao data
  Future<void> initialData() async {
    final queue = Queue(parallel: 3);
    unawaited(queue.add(() => callAPITheoFilter()));
    unawaited(queue.add(() => getCountTodoAndMenu()));
    await queue.onComplete;
    showContent();
  }



  ///các danh sach api
  Future<void> listNguoiThucHien(String keySearch) async {
    showLoadNguoiThucHien.sink.add(true);
    final result = await tienIchRep.getListNguoiThucHien(
      keySearch,
      ApiConstants.MAX_PAGE_SIZE,
      indexNguoiThucHien,
    );
    result.when(
      success: (res) {
        canLoadMoreNguoiThucHien = res.items.length >= ApiConstants.MAX_PAGE_SIZE;
        if (indexNguoiThucHien == ApiConstants.PAGE_BEGIN){
          listNguoiThucHienSubject.sink.add(res.items);
        }else{
          final currentData = listNguoiThucHienSubject.valueOrNull ?? [];
          listNguoiThucHienSubject.sink.add([...currentData,...res.items]);
        }
      },
      error: (_) {},
    );
    showLoadNguoiThucHien.sink.add(false);
  }

  Future<bool> getAllListDSCVWithFilter({
    int? pageIndex,
    int? pageSize,
    String? searchWord,
    bool? isImportant,
    bool? inUsed,
    bool? isTicked,
    bool? isForMe,
    String? groupId,
    bool? isGiveOther,
    required bool isLoadmore,
  }) async {
    final result = await tienIchRep.getAllListDSCVWithFilter(
      pageIndex,
      pageSize ?? 10,
      searchWord?.trim(),
      isImportant,
      isForMe,
      inUsed,
      isTicked,
      groupId,
      isGiveOther,
    );
    result.when(
      success: (res) {
        final List<TodoDSCVModel> data = listDSCVStream.valueOrNull ?? [];
        if (!isLoadmore) {
          data.clear();
        }
        data.addAll(res);
        canLoadMore = res.length >= ApiConstants.LONG_PAGE_SIZE;
        listDSCVStream.sink.add(data);
        return true;
      },
      error: (err) {
        showError();
        return false;
      },
    );
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
          important: statusDSCV.value == DSCVScreen.CVQT,
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



  ///init data nguoi thuc hien
  Future<void> initDataNguoiTHucHienTextFild(TodoDSCVModel? todo) async {
    if ((todo?.performer ??  '').isEmpty) {
      addNguoiThucHienNull();
    } else {
      final result = await tienIchRep.getCanBo(
        todo?.performer ?? '',
      );
      result.when(
        success: (res) {
          if(res.items.isNotEmpty){
            nguoiThucHienSubject.sink.add(
              NguoiThucHienModel(
                id: todo?.performer ?? '',
                hoten: res.items.first.hoten,
                donVi: res.items.first.donVi,
                chucVu: res.items.first.chucVu,
              ),
            );
          }
          else{
            addNguoiThucHienNull();
          }
        },
        error: (_) {},
      );
    }
  }
  void addNguoiThucHienNull(){
    nguoiThucHienSubject.sink.add(
      NguoiThucHienModel(
        id: '',
        hoten: S.current.tim_theo_nguoi,
        donVi: [],
        chucVu: [],
      ),
    );
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
    showLoading();
    final result = await tienIchRep.xoaCongViec(idCv);
    result.when(
      success: (res) {
        MessageConfig.show(
          title: S.current.thanh_cong,
        );
        final data = listDSCVStream.value;
        data.remove(todo);
        listDSCVStream.sink.add(data);
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.that_bai,
          messState: MessState.error,
        );
      },
    );
    showContent();
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
        case DSCVScreen.GCT:
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
        case DSCVScreen.GCT:
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

  void dispose() {
    showLoadNguoiThucHien.close();
    inLoadmore.close();
    titleAppBar.close();
    listDSCVStream.close();
    nguoiThucHienSubject.close();
    statusDSCV.close();
    countTodoModelSubject.close();
    listNguoiThucHienSubject.close();
    nguoiThucHienSubject.close();
  }
}
