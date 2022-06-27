import 'dart:async';
import 'dart:core';
import 'dart:io';

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
import 'package:ccvc_mobile/tien_ich_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
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
  String filePath = '';
  TextEditingController searchControler = TextEditingController();

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
  List<TodoDSCVModel> listDaGan = [];
  List<TodoDSCVModel> listDaBiXoa = [];
  List<TodoDSCVModel> nhomCongViecMoi = [];

  ///Stream
  BehaviorSubject<List<TodoDSCVModel>> listDSCV = BehaviorSubject();

  BehaviorSubject<String> titleAppBar = BehaviorSubject();

  BehaviorSubject<int> statusDSCV = BehaviorSubject.seeded(0);

  DanhSachCongViecTienIchCubit() : super(MainStateInitial());

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

  ///init cac list
  dynamic doDataTheoFilter() {
    // data trả về phụ thuộc vào hai api
    listGop = [
      ...toDoModelGanChoToiDefault,
      ...toDoModelDefault,
    ];
    listCongViecCuaBan = toDoModelGanChoToiDefault
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
    listDaGan = toDoModelGanChoToiDefault
        .where(
          (e) => e.inUsed == true && e.isTicked == false,
        )
        .toList();
    listDaBiXoa = listGop
        .where((e) => e.inUsed == false && e.isDeleted == false)
        .toList();
    dataMenuDefault[DSCVScreen.CVCB].number = listCongViecCuaBan
        .where((element) => element.isTicked == false)
        .toList()
        .length;
    dataMenuDefault[DSCVScreen.CVQT].number = listQuanTrong.length;
    dataMenuDefault[DSCVScreen.DHT].number = listDaHoanThanh.length;
    dataMenuDefault[DSCVScreen.DG].number = listDaGan.length;
    dataMenuDefault[DSCVScreen.DBX].number = listDaBiXoa.length;

    switch (statusDSCV.value) {
      case DSCVScreen.CVCB:
        return listCongViecCuaBan;
      case DSCVScreen.CVQT:
        return listQuanTrong;
      case DSCVScreen.DHT:
        return listDaHoanThanh;
      case DSCVScreen.DG:
        return listDaGan;
      case DSCVScreen.DBX:
        return listDaBiXoa;
      case DSCVScreen.NCVM:
        return toDoModelDefault
            .where((e) => isList(e, groupId) && e.inUsed == true)
            .toList();
    }
  }

  /// khoi tao data
  Future<void> initialData() async {
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
      case DSCVScreen.CVCB:
        return listDSCV.sink.add(listCongViecCuaBan);
      case DSCVScreen.CVQT:
        return listDSCV.sink.add(listQuanTrong);
      case DSCVScreen.DHT:
        return listDSCV.sink.add(listDaHoanThanh);
      case DSCVScreen.DG:
        return listDSCV.sink.add(listDaGan);
      case DSCVScreen.DBX:
        return listDSCV.sink.add(listDaBiXoa);
      case DSCVScreen.NCVM:
        return listDSCV.sink.add(
          toDoModelDefault
              .where((e) => isList(e, groupId) && e.inUsed == true)
              .toList(),
        );
    }
  }

  /// valueViewMenu
  List<MenuDscvModel> dataMenuDefault = [
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
      title: S.current.da_gan,
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
    final dataSearch = doDataTheoFilter();
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
          filePath: filePath,
        ),
      );
      await result.when(
        success: (res) async {
          showContent();
          final data = listDSCV.value;
          data.insert(
            0,
            res,
          );
          listDSCV.sink.add(data);
          await callAndFillApiAuto();
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
        statusDSCV.sink.add(DSCVScreen.CVCB);
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
  Future<void> callAndFillApiAuto() async {
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

  ///chinh sưa và update công việc
  Future<void> editWork({
    bool? isTicked,
    bool? important,
    bool? inUsed,
    bool? isDeleted,
    String? filePathTodo,
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

    dynamic checkDataFile({dynamic changeData, dynamic defaultData}) {
      if (changeData == '') {
        return null;
      } else if (changeData == defaultData) {
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
        filePath: (filePathTodo ?? '').isNotEmpty
            ? checkDataFile(
                changeData: filePathTodo, defaultData: todo.filePath)
            : filePath,
      ),
    );
    result.when(
      success: (res) {
        filePath = '';
        final data = listDSCV.value;
        if (isTicked != null) {
          data.remove(todo);
          data.insert(0, res);
          listDSCV.sink.add(data);
        }
        if (important != null) {
          data.remove(todo);
          data[0] = res;
          listDSCV.sink.add(data);
        }
        if (inUsed != null) {
          data.remove(todo);
          listDSCV.sink.add(data);
        }
        if (isDeleted != null) {}
        if (filePathTodo != null) {
          nameFile.sink.add('');
        }
        callAndFillApiAuto();
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
  Future<void> uploadFilesWithFile(File file) async {
    showLoading();
    final result = await tienIchRep.uploadFileDSCV(file);
    result.when(
      success: (res) {
        filePath = res.data?.filePath ?? '';
      },
      error: (error) {},
    );
    showContent();
  }

  ///xóa cong viec
  Future<void> xoaCongViecVinhVien(
    String idCv,
    TodoDSCVModel todo,
  ) async {
    final result = await tienIchRep.xoaCongViec(idCv);
    result.when(
      success: (res) {
        final data = listDSCV.value;
        data.remove(todo);
        listDSCV.sink.add(data);
        // callAndFillApiAuto();
      },
      error: (error) {
        showError();
      },
    );
  }

  /// hiển thị icon theo từng màn hình
  List<int> showIcon({required int dataType, bool? isListUp}) {
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

  List<int> enableIcon(int dataType) {
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
