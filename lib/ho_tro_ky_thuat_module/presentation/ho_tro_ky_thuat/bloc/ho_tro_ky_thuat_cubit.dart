import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/request/add_task_request.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_data.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/type_ho_tro_ky_thuat.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class HoTroKyThuatCubit extends BaseCubit<BaseState> {
  HoTroKyThuatCubit() : super(HotroKyThuatStateInitial());

  static const DANG_CHO_XU_LY = 'Đang chờ xử lý';
  static const DANG_XU_LY = 'Đang xử lý';
  static const DA_XU_LY = 'Đã xử lý';
  static const TU_CHOI_XU_LY = 'Từ chối xử lý';

  ///variable menu
  BehaviorSubject<TypeHoTroKyThuat> typeHoTroKyThuatSubject =
      BehaviorSubject.seeded(TypeHoTroKyThuat.THONG_TIN_CHUNG);

  Stream<TypeHoTroKyThuat> get typeHoTroKyThuatStream =>
      typeHoTroKyThuatSubject.stream;
  List<bool> listCheckPopupMenu = [];
  BehaviorSubject<List<TongDaiModel>> listTongDai = BehaviorSubject.seeded([]);
  BehaviorSubject<List<ThanhVien>> listCanCoHTKT = BehaviorSubject.seeded([]);
  BehaviorSubject<bool> checkDataChart = BehaviorSubject.seeded(false);
  BehaviorSubject<List<CategoryModel>> listKhuVuc = BehaviorSubject.seeded([]);
  BehaviorSubject<List<CategoryModel>> listLoaiSuCo =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<ChildCategories>> listToaNha =
      BehaviorSubject.seeded([]);
  List<List<ChartData>> listDataChart = [];
  List<ChartData> listStatusData = [];
  List<String> listTitle = [];

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

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

  void onClickPopupMenu(DanhSachSuCoModel value, int index) {
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

  Future<void> getListDanhBaCaNhan({
    required int page,
  }) async {
    showLoading();
    final result = await _hoTroKyThuatRepository.postDanhSachSuCo(
      page,
      ApiConstants.DEFAULT_PAGE_SIZE,
    );
    result.when(
      success: (res) {
        if (res.isEmpty) {
          showContent();
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
    checkDataChart.add(false);
    showLoading();
    await getChartSuCo();
    await getNguoiXuLy();
    await getTongDai();
    await getCategory(query: 'loai-su-co');
    await getCategory();
    showContent();
  }

  Future<void> getNguoiXuLy() async {
    final result = await _hoTroKyThuatRepository.getNguoiXuLy();
    result.when(
      success: (res) {
        listCanCoHTKT.add(res);
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getChartSuCo() async {
    final Result<ChartSuCoModel> result =
        await _hoTroKyThuatRepository.getChartSuCo();
    result.when(
      success: (res) {
        //get list title chart
        listTitle =
            res.chartSuCoChild?.map((e) => e.tenSuCo ?? '').toList() ?? [];
        //get list status chart
        listStatusData = res.chartSuCoChild?.first.danhSachKhuVuc
                ?.map(
                  (value) => ChartData(
                    value.khuVuc ?? '',
                    (value.soLuong ?? 0).toDouble(),
                    getColorChart(value.khuVuc ?? ''),
                  ),
                )
                .toList() ??
            [];
        //get list data chart
        listDataChart = res.chartSuCoChild
                ?.map(
                  (e) => (e.danhSachKhuVuc ?? [])
                      .map(
                        (valueChild) => ChartData(
                          valueChild.khuVuc ?? '',
                          (valueChild.soLuong ?? 0).toDouble(),
                          getColorChart(valueChild.khuVuc ?? ''),
                        ),
                      )
                      .toList(),
                )
                .toList() ??
            [];
//
        checkDataChart.add(true);
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Color getColorChart(String title) {
    switch (title) {
      case 'Khu vực A':
        return Colors.blue;
      case 'Khu vực B':
        return Colors.yellow;
      default: 
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
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getCategory({String query = 'khu-vuc'}) async {
    final Result<List<CategoryModel>> result =
        await _hoTroKyThuatRepository.getCategory(query);
    result.when(
      success: (res) {
        if (query == 'khu-vuc') {
          listKhuVuc.add(res);
          listToaNha.add(res.first.childCategories ?? []);
        } else {
          listLoaiSuCo.sink.add(res);
        }
      },
      error: (error) {
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

  ///Huy
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
          } else {

          }
        }
    }
    print(listIdSuCo);
    return listIdSuCo;
  }

  void init() {
    showErrorLoaiSuCo.add(false);
    showErrorKhuVuc.add(false);
    showErrorToaNha.add(false);
  }

  /*
  * "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "userRequestId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "phone": "string",
  "description": "string",
  "districtId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "districtName": "string",
  "buildingId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "buildingName": "string",
  "room": "string",
  "name": "string",
  "danhSachSuCo": [
    "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  ],
  "userInUnit": "string",
  "fileUpload": [
    "string"
  ]
  * */
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
    if ((addTaskHTKTRequest.danhSachSuCo ?? []).isEmpty) {
      validateAllDropDown = false;
      showErrorLoaiSuCo.sink.add(true);
    }
    if (addTaskHTKTRequest.buildingName != null &&
        addTaskHTKTRequest.districtName != null &&
        (addTaskHTKTRequest.danhSachSuCo ?? []).isNotEmpty) {
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
