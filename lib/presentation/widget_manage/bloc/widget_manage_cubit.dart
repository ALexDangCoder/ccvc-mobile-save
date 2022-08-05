import 'dart:convert';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/repository/quan_ly_widget/quan_li_widget_respository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/repository/home_repository/home_repository.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage__state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/subjects.dart';

import '/home_module/domain/model/home/WidgetType.dart';

class WidgetManageCubit extends BaseCubit<WidgetManageState> {
  final BehaviorSubject<List<WidgetModel>> _listWidgetUsing =
      BehaviorSubject<List<WidgetModel>>();
  final BehaviorSubject<List<WidgetModel>> _listWidgetNotUse =
      BehaviorSubject<List<WidgetModel>>();
  final BehaviorSubject<List<WidgetModel>> _listUpdate =
      BehaviorSubject<List<WidgetModel>>();

  WidgetManageCubit() : super(WidgetManagerStateInitial());

  Stream<List<WidgetModel>> get listWidgetUsing => _listWidgetUsing.stream;

  Stream<List<WidgetModel>> get listWidgetNotUse => _listWidgetNotUse.stream;

  Stream<List<WidgetModel>> get listUpdate => _listUpdate.stream;
  List<WidgetModel> listUsing = [];
  List<WidgetModel> listNotUse = [];
  List<WidgetModel> listTempFullPara = [];
  List<String> listTitleWidgetUse = [];
  final List<String> listResponse = [];
  final List<String> removeWidget = [
    WidgetTypeConstant.HANH_CHINH_CONG,
    WidgetTypeConstant.LICH_LAM_VIEC_LICH_HOP,
    WidgetTypeConstant.TONG_HOP_HCC,
    WidgetTypeConstant.TIN_BUON,
    WidgetTypeConstant.TINH_HINH_XU_LY_HO_SO_CA_NHAN,
    WidgetTypeConstant.TiNH_HINH_XU_LY_HO_SO_DON_VI,
    WidgetTypeConstant.DANH_SACH_DICH_VU_CONG,
  ];

  Future<void> _getListWidgetNotUse() async {
    listNotUse.clear();
    final result = await _qlWidgetRepo.getListWidget();
    result.when(
      success: (res) {
        for (final element in res) {
          if (!listTitleWidgetUse.contains(element.component) &&
              !removeWidget.contains(element.component)) {
            for (final fullPara in listTempFullPara) {
              if (fullPara.component == element.component) {
                listNotUse.add(fullPara);
              }
            }
          }
        }
        _listWidgetNotUse.sink.add(listNotUse);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> loadApi() async {
    final queue = Queue(parallel: 3);
    await queue.add(() => _getListWidgetUsing());
    await queue.add(() => setFullParaNotUse());
    await queue.add(() => _getListWidgetNotUse());
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  void insertItemUsing(
    WidgetModel widgetItem,
    int index,
  ) {
    listUsing.insert(listUsing.length, widgetItem);
    listNotUse.removeAt(index);
    _listWidgetUsing.sink.add(listUsing);
    orderWidgetHome(listUsing);
    _listWidgetNotUse.sink.add(listNotUse);
  }

  void insertItemNotUse(
    WidgetModel widgetItem,
    int index,
  ) {
    listNotUse.insert(0, widgetItem);
    listUsing.removeAt(index);
    _listWidgetUsing.sink.add(listUsing);
    orderWidgetHome(listUsing);
    _listWidgetNotUse.sink.add(listNotUse);
  }

  void dispose() {
    _listWidgetUsing.close();
    _listWidgetNotUse.close();
  }

  void sortListWidget(
    int oldIndex,
    int newIndex,
  ) {
    final List<WidgetModel> listUpdate = _listWidgetUsing.value;
    final element = listUpdate.removeAt(oldIndex);
    listUpdate.insert(newIndex, element);
    listUsing = listUpdate;
    setFullParaNotUse();
    if (APP_DEVICE == DeviceType.TABLET) {
      keyHomeTablet.currentState?.homeCubit.orderWidget(listUpdate);
    } else {
      keyHomeMobile.currentState?.homeCubit.orderWidget(listUpdate);
    }
    _listUpdate.sink.add(listUpdate);
  }

  void orderWidgetHome(List<WidgetModel> listUpdate) {
    if (APP_DEVICE == DeviceType.TABLET) {
      keyHomeTablet.currentState?.homeCubit.orderWidget(listUpdate);
    } else {
      keyHomeMobile.currentState?.homeCubit.orderWidget(listUpdate);
    }
  }

  final QuanLyWidgetRepository _qlWidgetRepo = Get.find();

  Future<void> setFullParaNotUse() async {
    final result = await _qlWidgetRepo.resetListWidget();
    result.when(
      success: (res) {
        listTempFullPara = res;
        setParaUpdateWidget();
        updateListWidget(listResponse.toString());
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> resetListWidget() async {
    showLoading();
    final result = await _qlWidgetRepo.resetListWidget();
    showContent();
    result.when(
      success: (res) {
        listUsing.clear();
        listNotUse.clear();
        res.removeWhere((element) => removeWidget.contains(element.component));
        listUsing = res;
        _listWidgetUsing.sink.add(listUsing);
        _listWidgetNotUse.sink.add(listNotUse);
        orderWidgetHome(_listWidgetUsing.value);
        showContent();
      },
      error: (err) {},
    );
  }

  Future<void> updateListWidget(String request) async {
    final result = await _qlWidgetRepo.updateListWidget(request);
    result.when(
      success: (res) {
        showContent();
      },
      error: (err) {
        throw err;
      },
    );
  }

  HomeRepository get homeRep => Get.find();

  Future<void> _getListWidgetUsing() async {
    final result = await homeRep.getDashBoardConfig();
    result.when(
      success: (res) {
        res.removeWhere((element) => removeWidget.contains(element.component));
        listUsing = res;
        listTitleWidgetUse = listUsing.map((e) {
          return e.component;
        }).toList();
        _listWidgetUsing.sink.add(listUsing);
      },
      error: (err) {},
    );
  }

  void setParaUpdateWidget() {
    final listMap = [];
    for (final element in listUsing) {
      listMap.add(widgetModelToJson(element));
    }
    listResponse.clear();
    for (final element in listMap) {
      listResponse.add(json.encode(element));
    }
  }

  Future<void> onRefreshData() async {
    await loadApi();
  }

  String getNameWidget(WidgetModel widgetModel) {
    String widgetName = '';
    switch (widgetModel.component) {
      case WidgetTypeConstant.DANH_SACH_PAKN:
        widgetName = S.current.danh_sach_pakn;
        break;
      case WidgetTypeConstant.TiNH_HINH_PAKN_CA_NHAN:
        widgetName = S.current.tinh_hinh_pakn_ca_nhan;
        break;
      case WidgetTypeConstant.TiNH_HINH_PAKN_DON_VI:
        widgetName = S.current.tinh_hinh_pakn_don_vi;
        break;
      case WidgetTypeConstant.BAO_CHI:
        widgetName = S.current.bao_chi_mxh;
        break;
      default:
        widgetName = widgetModel.name;
    }
    return widgetName;
  }
}
