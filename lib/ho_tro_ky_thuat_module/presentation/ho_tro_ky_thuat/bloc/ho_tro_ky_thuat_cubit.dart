import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
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
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_dart;
import 'package:rxdart/rxdart.dart';

class HoTroKyThuatCubit extends BaseCubit<BaseState> {
  HoTroKyThuatCubit() : super(HotroKyThuatStateInitial());
  List<File>? filesThemMoiYCHTKT = [];
  static const String rightPath = 'attachments/upload/';

  //color
  List<Color> colorChart = [
    color5A8DEE,
    itemWidgetNotUse,
    itemWidgetUsing,
    canceledColor,
    sideBtnSelected,
    duyetColor,
    kyDuyetColor,
    dangXuLyLuongColor,
    bgButtonDropDown,
    choCapSoColor,
  ];

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

  static const int CLOSE_SEARCH = -1;
  static const int INIT_SEARCH = 0;
  static const int SEARCH = 1;
  static const int POP_SEARCH = 2;
  int checkDataThongTinChung = 0;
  bool flagLoadEditHTKT = false;
  SupportDetail modelEditHTKT = SupportDetail();

  ///variable menu
  BehaviorSubject<TypeHoTroKyThuat> typeHoTroKyThuatSubject =
      BehaviorSubject.seeded(TypeHoTroKyThuat.THONG_TIN_CHUNG);

  Stream<TypeHoTroKyThuat> get typeHoTroKyThuatStream =>
      typeHoTroKyThuatSubject.stream;

  List<bool> listCheckPopupMenu = [];

  BehaviorSubject<SupportDetail> editModelHTKT =
      BehaviorSubject.seeded(SupportDetail());

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
  List<String> listStringKhuVuc = [];

  BehaviorSubject<List<String>> buildingListStream = BehaviorSubject.seeded([]);

  BehaviorSubject<List<String>> issueListStream = BehaviorSubject.seeded([]);

  List<CategoryModel> areaList = [];
  List<CategoryModel> issueList = [];
  List<ChildCategories> buildingList = [];
  String? tempBuildingName;

  List<List<ChartData>> listDataChart = [];
  List<ChartData> listStatusData = [];
  Set<String> listTitle = {};
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

  //status search
  String? statusKeyWord;
  String statusDonVi = S.current.chon;
  String? statusNgayYeuCau;
  String? statusNgayHoanThanh;
  String? statusNguoiTiepNhan;
  String? statusNguoiXuLy;
  String? statusKhuVuc;
  String? statusToaNha;
  String? statusSoPhong;
  String? statusTrangThaiXuLy;

  //
  int countSearch = 0;
  final dataUser = HiveLocal.getDataUser();
  bool? isCheckUser;

  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;

  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();

  HoTroKyThuatRepository get _hoTroKyThuatRepository => get_dart.Get.find();

  void checkFileRemove(int index) {
    if ((editTaskHTKTRequest.lstFileId ?? []).isNotEmpty) {
      (editTaskHTKTRequest.lstFileId ?? []).removeAt(index);
    } else {
      //nothing
    }
  }

  final AddTaskHTKTRequest addTaskHTKTRequest = AddTaskHTKTRequest();
  final AddTaskHTKTRequest editTaskHTKTRequest = AddTaskHTKTRequest();
  final BehaviorSubject<bool> showHintDropDown = BehaviorSubject.seeded(true);
  final BehaviorSubject<bool> showErrorLoaiSuCo = BehaviorSubject();
  final BehaviorSubject<bool> showErrorKhuVuc = BehaviorSubject();
  final BehaviorSubject<bool> showErrorToaNha = BehaviorSubject();
  List<String> loaiSuCoValue = [];

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

  String? nameArea;
  String? nameBuilding;

  String? findNameAreaFeatBuilding({
    bool isArea = true,
    required String id,
  }) {
    if (isArea) {
      for (final area in areaList) {
        if (area.id == id) {
          nameArea = area.name;
          break;
        }
      }
    } else {
      for (final area in areaList) {
        for (final building in area.childCategories ?? []) {
          if (id == building.id) {
            nameBuilding = building.name ?? '';
            break;
          }
        }
      }
    }
    return isArea ? nameArea : nameBuilding;
  }

  final Set<SuCoHTKT> issuesEditHTKT = {};

  void getIssuesEditHTKT() {
    if (issuesEditHTKT.isNotEmpty) {
      issuesEditHTKT.clear();
    }
    for (final defaultIssue in issueList) {
      editModelHTKT.value.danhSachSuCo?.forEach(
        (e) {
          if (e.suCoId == defaultIssue.id) {
            issuesEditHTKT.add(e);
          }
        },
      );
    }
  }

  void disposeEdit() {
    nameBuilding = null;
    nameArea = null;
  }

  List<String> getListThanhVien(List<ThanhVien> listData) {
    return listData
        .map((e) => '${e.tenThanhVien.toString()} (${e.userId.toString()})')
        .toList();
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
    final result = await _hoTroKyThuatRepository.postDanhSachSuCo(
      pageIndex: page,
      pageSize: ApiConstants.DEFAULT_PAGE_SIZE,
      codeUnit: codeUnit,
      createOn: createOn?.isNotEmpty ?? false
          ? DateTime.parse(createOn ?? '').formatApiDDMMYYYY
          : null,
      finishDay: finishDay?.isNotEmpty ?? false
          ? DateTime.parse(finishDay ?? '').formatApiDDMMYYYY
          : null,
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
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
          showEmpty();
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
          showContent();
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
    await getTongDai();
    await getNguoiXuLy();
    if (checkDataThongTinChung == checkDataThongTinChungSuccess) {
      emit(const CompletedLoadMore(CompleteType.ERROR));
      showError();
    } else {
      showContent();
    }
  }

  Future<void> geiApiSearch() async {
    getTree();
    await getNguoiTiepNhanYeuCau();
    await getNguoiXuLy(isCheck: false);
    await getCategory(title: KHU_VUC);
    await getCategory(title: LOAI_SU_CO);
    await getCategory(title: TRANG_THAI);
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

  Future<bool> postEditHTKT() async {
    showLoading();
    final result = await _hoTroKyThuatRepository.editTaskHTKT(
      id: editTaskHTKTRequest.id,
      userRequestId: editTaskHTKTRequest.userRequestId,
      phone: editTaskHTKTRequest.phone,
      description: editTaskHTKTRequest.description,
      districtId: editTaskHTKTRequest.districtId,
      districtName: editTaskHTKTRequest.districtName,
      buildingId: editTaskHTKTRequest.buildingId,
      buildingName: editTaskHTKTRequest.buildingName,
      room: editTaskHTKTRequest.room,
      name: editTaskHTKTRequest.name,
      danhSachSuCo: editTaskHTKTRequest.danhSachSuCo,
      userInUnit: editTaskHTKTRequest.userInUnit,
      fileUpload: editTaskHTKTRequest.fileUpload ?? [],
      lstFileId: editTaskHTKTRequest.lstFileId,
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
        listStringKhuVuc = res.map((e) => e.codeKhuVuc.toString()).toList();
        //clean data chart
        listDataChart = [];
        listStatusData = [];
        listTitle = {};
        //get list title chart
        if (res.isNotEmpty) {
          for (final ChartSuCoModel chartSuCoModel in res) {
            for (final DanhSachSuCo value
                in chartSuCoModel.danhSachSuCo ?? []) {
              listTitle.add(value.tenSuCo ?? '');
            }
          }
          //get list status chart
          listStatusData = res
              .map(
                (value) => ChartData(
                  value.tenKhuVuc ?? '',
                  0,
                  getColorChart(
                    codeKhuVuc: value.codeKhuVuc.toString(),
                  ),
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
                      getColorChart(
                        codeKhuVuc: value.codeKhuVuc.toString(),
                      ),
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

  Color getColorChart({
    required String codeKhuVuc,
  }) {
    return colorChart[listStringKhuVuc.indexWhere(
      (element) => element == codeKhuVuc,
    )];
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
      error: (error) {},
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
          buildingListStream.sink
              .add([S.current.khong_co_du_lieu]);
          addTaskHTKTRequest.buildingName =  S.current.khong_co_du_lieu;
          listToaNha.sink.add(res.first.childCategories ?? []);
          flagLoadThemMoiYCHT = true;
          flagLoadEditHTKT = true;
        } else if (title == LOAI_SU_CO) {
          listLoaiSuCo.add(res);
          issueList = res;
          sinkIssue();
          flagLoadThemMoiYCHT = true;
          flagLoadEditHTKT = true;
        } else {
          listTrangThai.sink.add(res);
        }
      },
      error: (error) {
        flagLoadThemMoiYCHT = false;
        flagLoadEditHTKT = false;
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
    if (addTaskHTKTRequest.buildingId == null) {
      validateAllDropDown = false;
      showErrorToaNha.sink.add(true);
    }
    if (addTaskHTKTRequest.districtName == null) {
      validateAllDropDown = false;
      showErrorKhuVuc.sink.add(true);
    }
    if ((addTaskHTKTRequest.danhSachSuCo ?? []).isEmpty) {
      validateAllDropDown = false;
      showErrorLoaiSuCo.sink.add(true);
    }
    if (addTaskHTKTRequest.buildingId != null &&
        addTaskHTKTRequest.districtId != null &&
        (addTaskHTKTRequest.danhSachSuCo ?? []).isNotEmpty) {
      validateAllDropDown = true;
      showErrorToaNha.sink.add(false);
      showErrorKhuVuc.sink.add(false);
      showErrorLoaiSuCo.sink.add(false);
    }
  }

  void checkAllEditYCHT() {
    if (editTaskHTKTRequest.buildingId == null) {
      validateAllDropDown = false;
      showErrorToaNha.sink.add(true);
    }
    if (editTaskHTKTRequest.districtId == null) {
      validateAllDropDown = false;
      showErrorKhuVuc.sink.add(true);
    }
    if ((editTaskHTKTRequest.danhSachSuCo ?? []).isEmpty) {
      validateAllDropDown = false;
      showErrorLoaiSuCo.sink.add(true);
    }
    if (editTaskHTKTRequest.buildingId != null &&
        editTaskHTKTRequest.districtId != null &&
        (editTaskHTKTRequest.danhSachSuCo ?? []).isNotEmpty) {
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
    addTaskHTKTRequest.districtName = null;
    addTaskHTKTRequest.buildingName = null;
    nameBuilding = null;
    nameArea = null;
  }
}
