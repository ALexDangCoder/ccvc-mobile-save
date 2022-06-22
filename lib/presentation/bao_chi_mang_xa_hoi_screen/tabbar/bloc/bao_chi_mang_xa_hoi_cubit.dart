import 'dart:core';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_resquest.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_state.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class BaoChiMangXaHoiBloc extends BaseCubit<BaoCHiMangXaHoiState> {
  BaoChiMangXaHoiBloc() : super(BaoCHiMangXaHoiStateInitial());

  final BehaviorSubject<List<ChuDeModel>> _listYKienNguoiDan =
      BehaviorSubject<List<ChuDeModel>>();
  final BehaviorSubject<List<ListMenuItemModel>> _dataMenu =
      BehaviorSubject<List<ListMenuItemModel>>();
  final BehaviorSubject<bool> _changeItemMenu = BehaviorSubject.seeded(false);
  final BehaviorSubject<String> titleSubject = BehaviorSubject.seeded(
    S.current.tong_tin,
  );

  Stream<bool> get changeItemMenu => _changeItemMenu.stream;

  final BehaviorSubject<int> _selectColorItem = BehaviorSubject<int>();

  Stream<int> get indexSelectItem => _selectColorItem.stream;

  int topic = 848;

  Stream<List<ChuDeModel>> get listYKienNguoiDan => _listYKienNguoiDan.stream;

  Stream<List<ListMenuItemModel>> get dataMenu => _dataMenu.stream;
  String startDate = DateTime.now().formatApiStartDay;
  String endDate = DateTime.now().formatApiEndDay;
  List<MenuData> listTitleItemMenu = [];
  final menuSubject = BehaviorSubject<List<MenuData>>();
  List<List<MenuItemModel>> listSubMenu = [];
  final menuItemSubject = BehaviorSubject<List<List<MenuItemModel>>>();
  List<ListMenuItemModel> tree = [];
  DashBoardTatCaChuDeRequest dashBoardTatCaChuDeRequest =
      DashBoardTatCaChuDeRequest(
    pageIndex: 1,
    pageSize: 30,
    total: 2220,
    hasNextPage: true,
    fromDate: DateTime.now().formatApiSS,
    toDate: DateTime.now().formatApiSS,
  );
  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();

  Future<void> getListTatCaCuDe(String startDate, String enDate) async {
    final result = await _BCMXHRepo.getDashListChuDe(
      1,
      30,
      233,
      true,
      startDate,
      enDate,
    );
    result.when(
      success: (res) {
        final result = res.getlistChuDe ?? [];
        _listYKienNguoiDan.sink.add(result);
      },
      error: (err) {
        return;
      },
    );
  }

  void changeScreenMenu() {
    _changeItemMenu.sink.add(true);
  }

  void slectColorItem(int index) {
    _selectColorItem.sink.add(index);
  }

  Future<void> getMenu() async {
    showLoading();
    final result = await _BCMXHRepo.getMenuBCMXH();
    result.when(
      success: (res) {
        tree = res;
        listTitleItemMenu =
            res.map((e) => MenuData(nodeId: e.nodeId, title: e.title)).toList();
        menuSubject.sink.add(listTitleItemMenu);
        for (final element in res) {
          listSubMenu.add(element.subMenu);
        }
        menuItemSubject.sink.add(listSubMenu);
      },
      error: (err) {
        return;
      },
    );
    showContent();
  }

  TreeId checkExpand(int id) {
    bool flag = false;
    for (final element in tree) {
      for (final item in element.subMenu) {
        if (item.nodeId == id) {
          return TreeId(true, element.nodeId);
        } else {
          flag = false;
        }
      }
    }
    return TreeId(flag, 848);
  }
}

class TreeId {
  bool expanded;
  int id;

  TreeId(this.expanded, this.id);
}
