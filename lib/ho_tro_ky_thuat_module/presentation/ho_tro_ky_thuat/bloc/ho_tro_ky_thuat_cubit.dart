import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/request/add_task_request.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_data.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/nguoi_tiep_nhan_yeu_cau_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/create_tech_suport.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_dart;
import 'package:rxdart/rxdart.dart';

class HoTroKyThuatCubit extends BaseCubit<BaseState> {
  HoTroKyThuatCubit() : super(HotroKyThuatStateInitial());
  List<File>? filesThemMoiYCHTKT = [];

//code status
  static const CHUA_XU_LY = 'chua-xu-ly';
  static const DANG_XU_LY = 'dang-xu-ly';
  static const DA_HOAN_THANH = 'da-hoan-thanh';
  static const TU_CHOI_XU_LY = 'tu-choi-xu-ly';

  static const LOAI_SU_CO = 'loai-su-co';
  static const TRANG_THAI = 'trang-thai';
  static const KHU_VUC = 'khu-vuc';
  static const int checkDataThongTinChungSuccess = 3;
  String? areaValue;
  String? buildingValue;

  int checkDataThongTinChung = 0;



  ///variable menu
  BehaviorSubject<TypeHoTroKyThuat> typeHoTroKyThuatSubject =
      BehaviorSubject.seeded(TypeHoTroKyThuat.THONG_TIN_CHUNG);

  Stream<TypeHoTroKyThuat> get typeHoTroKyThuatStream =>
      typeHoTroKyThuatSubject.stream;

  List<bool> listCheckPopupMenu = [];

  BehaviorSubject<List<TongDaiModel>> listTongDai = BehaviorSubject.seeded([]);

  BehaviorSubject<List<NguoiTiepNhanYeuCauModel>> listNguoiTiepNhanYeuCau =
      BehaviorSubject.seeded([]);

  BehaviorSubject<List<ThanhVien>> listCanCoHTKT = BehaviorSubject.seeded([]);

  BehaviorSubject<bool> checkDataChart = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isShowDonVi = BehaviorSubject.seeded(false);

  BehaviorSubject<String> donViSearch = BehaviorSubject.seeded(S.current.chon);

  BehaviorSubject<List<CategoryModel>> listKhuVuc = BehaviorSubject.seeded([]);

  BehaviorSubject<List<CategoryModel>> listLoaiSuCo =
      BehaviorSubject.seeded([]);

  BehaviorSubject<List<CategoryModel>> listTrangThai =
      BehaviorSubject.seeded([]);

  BehaviorSubject<List<ChildCategories>> listToaNha =
      BehaviorSubject.seeded([]);

  BehaviorSubject<List<String>> buildingListStream = BehaviorSubject.seeded([]);

  BehaviorSubject<List<String>> issueListStream = BehaviorSubject.seeded([]);

  List<CategoryModel> areaList = [];
  List<CategoryModel> issueList = [];
  List<ChildCategories> buildingList = [];
  String? tempBuildingName;

  List<List<ChartData>> listDataChart = [];
  List<ChartData> listStatusData = [];
  List<String> listTitle = [];
  String? codeUnit;
  String? createOn;
  String? finishDay;
  String? userRequestId;
  String? userRequestIdName;
  String? districtId;
  String? districtIdName;
  String? buildingId;
  String? buildingIdName;
  String? room;
  String? processingCode;
  String? processingCodeName;
  String? handlerId;
  String? handlerIdName;
  String? keyWord;
  final dataUser = HiveLocal.getDataUser();
  bool? isCheckUser;

  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;

  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();

  HoTroKyThuatRepository get _hoTroKyThuatRepository => get_dart.Get.find();

  void getTree() {
    hopRp.getTreeDonVi().then((value) {
      value.when(
        success: (res) {
          _getTreeDonVi.sink.add(res);
        },
        error: (err) {
          showError();
        },
      );
    });
  }

  void initListCheckPopup(int length) {
    listCheckPopupMenu = List<bool>.filled(
      length,
      false,
      growable: true,
    );
  }

  int getColor(String color) {
    if (color.isNotEmpty) {
      final String value = color.replaceAll('#', '0xFF');
      return int.parse(value);
    }
    return 0xfffffff;
  }

  void onClickPopupMenu(SuCoModel value, int index) {
    listCheckPopupMenu = List<bool>.filled(
      loadMoreList.length,
      false,
      growable: true,
    );
    listCheckPopupMenu[index] = true;
  }

  void onClosePopupMenu() {
    listCheckPopupMenu = List<bool>.filled(
      loadMoreList.length,
      false,
      growable: true,
    );
  }

  List<String> getList(List<ChildCategories> listData) {
    final List<String> list = listData.map((e) => e.name ?? '').toList();
    final Set<String> listSet = {};
    listSet.addAll(list);
    final List<String> listResult = [];
    listResult.addAll(listSet);
    return listResult;
  }

  List<String> getListThanhVien(List<ThanhVien> listData) {
    final List<String> list =
        listData.map((e) => e.tenThanhVien ?? '').toList();
    final Set<String> listSet = {};
    listSet.addAll(list);
    final List<String> listResult = [];
    listResult.addAll(listSet);
    return listResult;
  }

  bool checkUser() {
    for (final element in listCanCoHTKT.value) {
      if (element.userId == dataUser?.userId) {
        return true;
      }
    }
    return false;
  }

  Future<void> getListDanhBaCaNhan({
    required int page,
  }) async {
    showLoading();
    await getNguoiXuLy(
      isCheck: false,
    );
    final result = await _hoTroKyThuatRepository.postDanhSachSuCo(
      pageIndex: page,
      pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
      codeUnit: codeUnit,
      createOn: createOn,
      finishDay: finishDay,
      userRequestId: userRequestId,
      districtId: districtId,
      buildingId: buildingId,
      room: room,
      processingCode: processingCode,
      handlerId: handlerId,
      keyWord: keyWord,
    );
    result.when(
      success: (res) {
        if (res.isEmpty) {
          showEmpty();
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
        } else {
          showContent();
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getAllApiThongTinChung() async {
    showLoading();
    await getChartSuCo();
    await getNguoiXuLy();
    await getTongDai();
    if (checkDataThongTinChung == checkDataThongTinChungSuccess) {
      emit(const CompletedLoadMore(CompleteType.ERROR));
      showError();
    } else {
      showContent();
    }
  }

  Future<bool> postDataThemMoiHTKT() async {
    showLoading();
    final result = await _hoTroKyThuatRepository.addTask(
      id: addTaskHTKTRequest.id,
      userRequestId: addTaskHTKTRequest.userRequestId,
      phone: addTaskHTKTRequest.phone,
      description: addTaskHTKTRequest.description,
      districtId: addTaskHTKTRequest.districtId,
      districtName: addTaskHTKTRequest.districtName,
      buildingId: addTaskHTKTRequest.buildingId,
      buildingName: addTaskHTKTRequest.buildingName,
      room: addTaskHTKTRequest.room,
      name: addTaskHTKTRequest.name,
      danhSachSuCo: addTaskHTKTRequest.danhSachSuCo,
      userInUnit: addTaskHTKTRequest.userInUnit,
      fileUpload: addTaskHTKTRequest.fileUpload ?? [],
    );
    result.when(
      success: (success) {
        showContent();
      },
      error: (error) {
        showContent();
      },
    );
    return true;
  }

  Future<void> getNguoiXuLy({
    bool isCheck = true,
  }) async {
    final result = await _hoTroKyThuatRepository.getNguoiXuLy();
    result.when(
      success: (res) {
        listCanCoHTKT.add(res);
        isCheckUser = checkUser();
      },
      error: (error) {
        if (isCheck) {
          checkDataThongTinChung += 1;
        }
      },
    );
  }

  Future<bool> deleteTask({required String id}) async {
    showLoading();
    final result = await _hoTroKyThuatRepository.deleteTask([id]);
    late bool isCheckStatus;
    result.when(
      success: (res) {
        isCheckStatus = res;
        showContent();
      },
      error: (error) {
        isCheckStatus = false;
        showContent();
      },
    );
    return isCheckStatus;
  }

  Future<void> getChartSuCo() async {
    checkDataChart.add(false);
    final Result<List<ChartSuCoModel>> result =
        await _hoTroKyThuatRepository.getChartSuCo();
    result.when(
      success: (res) {
        //clean data chart
        listDataChart = [];
        listStatusData = [];
        listTitle = [];
        //get list title chart
        if (res.isNotEmpty) {
          listTitle = res.first.danhSachSuCo
                  ?.map((e) => e.tenSuCo.toString())
                  .toList() ??
              [];
          //get list status chart
          listStatusData = res
              .map(
                (value) => ChartData(
                  value.tenKhuVuc ?? '',
                  0,
                  getColorChart(value.codeKhuVuc ?? ''),
                ),
              )
              .toList();
          //get list data chart
          for (final title in listTitle) {
            final List<ChartData> listChart = [];
            for (final ChartSuCoModel value in res) {
              for (final DanhSachSuCo valueChild in value.danhSachSuCo ?? []) {
                if (title == valueChild.tenSuCo) {
                  listChart.add(
                    ChartData(
                      valueChild.tenSuCo ?? '',
                      (valueChild.soLuong ?? 0).toDouble(),
                      getColorChart(value.codeKhuVuc ?? ''),
                    ),
                  );
                }
              }
            }
            listDataChart.add(listChart);
          }
          checkDataChart.add(true);
        }
      },
      error: (error) {
        checkDataThongTinChung += 1;
      },
    );
  }

  Color getColorChart(String title) {
    switch (title) {
      case 'HN':
        return const Color(0xff5A8DEE);
      case 'HCM':
        return const Color(0xffFF9F43);
      default: //todo
        return Colors.red;
    }
  }

  Future<void> getTongDai() async {
    final result = await _hoTroKyThuatRepository.getTongDai();
    result.when(
      success: (res) {
        listTongDai.add(res);
      },
      error: (error) {
        checkDataThongTinChung += 1;
      },
    );
  }

  Future<void> getNguoiTiepNhanYeuCau() async {
    final result = await _hoTroKyThuatRepository.getNguoiTiepNhanYeuCau();
    result.when(
      success: (res) {
        listNguoiTiepNhanYeuCau.add(res);
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  String? findLocationAreaFeatBuilding({
    required String id,
    bool isArea = false,
  }) {
    String? result;
    if (isArea) {
      for (final element in areaList) {
        if (element.id == id) {
          result = element.name ?? '';
        }
        break;
      }
    } else {
      for (final area in areaList) {
        for (final building in area.childCategories ?? []) {
          if (id == building.id) {
            result = building.name ?? '';
          }
          break;
        }
      }
    }
    if ((result ?? '').isEmpty) {
      result = null;
    }
    return result;
  }

  bool flagLoadThemMoiYCHT = false;

  Future<void> getCategory({
    required String title,
  }) async {
    final Result<List<CategoryModel>> result =
        await _hoTroKyThuatRepository.getCategory(title);
    result.when(
      success: (res) {
        if (title == KHU_VUC) {
          listKhuVuc.sink.add(res);
          areaList = res;
          buildingList = res.first.childCategories ?? [];
          listToaNha.sink.add(res.first.childCategories ?? []);
          flagLoadThemMoiYCHT = true;
        } else if (title == LOAI_SU_CO) {
          listLoaiSuCo.add(res);
          issueList = res;
          sinkIssue();
          flagLoadThemMoiYCHT = true;
        } else {
          listTrangThai.sink.add(res);
        }
      },
      error: (error) {
        flagLoadThemMoiYCHT = false;
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  String subText(String text) {
    final List<String> listText = text.split(' ');
    final String result =
        listText.first.substring(0, 1) + listText.last.substring(0, 1);
    return result;
  }

  final AddTaskHTKTRequest addTaskHTKTRequest = AddTaskHTKTRequest();
  final BehaviorSubject<bool> showHintDropDown = BehaviorSubject.seeded(true);
  final BehaviorSubject<bool> showErrorLoaiSuCo = BehaviorSubject();
  final BehaviorSubject<bool> showErrorKhuVuc = BehaviorSubject();
  final BehaviorSubject<bool> showErrorToaNha = BehaviorSubject();
  List<String> loaiSuCoValue = [];

  List<String> getIdListLoaiSuCo(List<String> value) {
    final List<String> listIdSuCo = [];
    for (final e in value) {
      for (final element in listLoaiSuCo.value) {
        if (element.name == e) {
          listIdSuCo.add(element.id ?? '');
        } else {}
      }
    }
    return listIdSuCo;
  }

  void init() {
    showErrorLoaiSuCo.add(false);
    showErrorKhuVuc.add(false);
    showErrorToaNha.add(false);
  }

  bool validateAllDropDown = false;

  void checkAllThemMoiYCHoTro() {
    if (addTaskHTKTRequest.buildingName == null) {
      validateAllDropDown = false;
      showErrorToaNha.sink.add(true);
    }
    if (addTaskHTKTRequest.districtName == null) {
      validateAllDropDown = false;
      showErrorKhuVuc.sink.add(true);
    }
    if ((filesThemMoiYCHTKT ?? []).isEmpty) {
      validateAllDropDown = false;
      showErrorLoaiSuCo.sink.add(true);
    }
    if (addTaskHTKTRequest.buildingName != null &&
        addTaskHTKTRequest.districtName != null) {
      validateAllDropDown = true;
      showErrorToaNha.sink.add(false);
      showErrorKhuVuc.sink.add(false);
      showErrorLoaiSuCo.sink.add(false);
    }
  }

  void addLoaiSuCo(List<String> value) {}

  void checkShowHintDropDown(List<String> value) {
    if (value.isEmpty) {
      showErrorLoaiSuCo.sink.add(true);
      showHintDropDown.sink.add(true);
    } else {
      showErrorLoaiSuCo.sink.add(false);
      showHintDropDown.sink.add(false);
    }
  }

  void dispose() {
    showErrorLoaiSuCo.close();
    showErrorKhuVuc.close();
    showErrorToaNha.close();
  }
}
