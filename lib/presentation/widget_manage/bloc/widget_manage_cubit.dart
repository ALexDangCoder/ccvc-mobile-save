import 'dart:convert';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/repository/quan_ly_widget/quan_li_widget_respository.dart';
import 'package:ccvc_mobile/home_module/domain/repository/home_repository/home_repository.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/widget_manage/bloc/widget_manage__state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
  ];

  void _getListWidgetUsing() {
    if (APP_DEVICE == DeviceType.TABLET) {
      listUsing = keyHomeTablet.currentState?.homeCubit.getListWidget ?? [];
    } else {
      listUsing = keyHomeMobile.currentState?.homeCubit.getListWidget ?? [];
    }
    if (listUsing.isNotEmpty) {
      listTitleWidgetUse = listUsing.map((e) => e.name).toList();
      _listWidgetUsing.sink.add(listUsing);
    }
    else{
      _listWidgetUsing.sink.add([]);
    }

  }

  void loadApi() {
    _getListWidgetUsing();
    _getListWidgetNotUse();
    setFullParaNotUse();
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

  Future<void> _getListWidgetNotUse() async {
    listNotUse.clear();
    showLoading();
    final result = await _qlWidgetRepo.getListWidget();
    result.when(
      success: (res) {
        for (final element in res) {
          // ignore: iterable_contains_unrelated_type
          if (!listTitleWidgetUse.contains(element.name) &&
              !removeWidget.contains(element.component)) {
            for (final fullPara in listTempFullPara) {
              if (fullPara.name == element.name) {
                listNotUse.add(fullPara);
              }
            }
          }
        }
        _listWidgetNotUse.sink.add(listNotUse);
        showContent();
      },
      error: (err) {
        return;
      },
    );
  }

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
        listUsing = res;
        listTitleWidgetUse = listUsing.map((e) => e.name).toList();
        for (final element in res) {
          // ignore: iterable_contains_unrelated_type
          if (!listTitleWidgetUse.contains(element.name) &&
              !removeWidget.contains(element.component)) {
            listNotUse.add(element);
          }
        }
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

  Future<void> configWidget() async {
    final result = await homeRep.getDashBoardConfig();
    result.when(
      success: (res) {
        _listWidgetUsing.sink.add(res);
      },
      error: (err) {},
    );
  }

  void setParaUpdateWidget() {
    final listMap = [];
    for (final element in listUsing) {
      listMap.add(widgetModelToJson(element));
    }
    // json.encode(listMap);
    listResponse.clear();
    for (final element in listMap) {
      listResponse.add(json.encode(element));
    }
  }

  Future<void> onRefreshData() async {
    final result = await homeRep.getDashBoardConfig();
    result.when(
      success: (res) {
        listUsing = res;
        final data =
            res.where((element) => element.widgetType != null).toList();
        listTitleWidgetUse = data.map((e) => e.name).toList();
        _listWidgetUsing.sink.add(data);
        _getListWidgetNotUse();
      },
      error: (err) {},
    );
  }
}
