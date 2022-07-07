import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_state.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/request/add_task_request.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_data.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/nguoi_tiep_nhan_yeu_cau_model.dart';
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
  static const LOAI_SU_CO = 'loai-su-co';
  static const TRANG_THAI = 'trang-thai';
  static const KHU_VUC = 'khu-vuc';
  static const int checkDataThongTinChungSuccess = 3;
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
  BehaviorSubject<List<CategoryModel>> listKhuVuc = BehaviorSubject.seeded([]);
  BehaviorSubject<List<CategoryModel>> listLoaiSuCo =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CategoryModel>> listTrangThai =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<ChildCategories>> listToaNha =
      BehaviorSubject.seeded([]);
  List<List<ChartData>> listDataChart = [];
  List<ChartData> listStatusData = [];
  List<String> listTitle = [];
  String? codeUnit;
  String? createOn;
  String? finishDay;
  String? userRequestId;
  String? districtId;
  String? buildingId;
  String? room;
  String? processingCode;
  String? handlerId;
  String? keyWord;

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

  List<String> getListThanhVien(List<ThanhVien> listData) {
    final List<String> list =
        listData.map((e) => e.tenThanhVien ?? '').toList();
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
    showLoading();
    checkDataChart.add(false);
    await geiApiAddAndSearch(); //todo ké
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

  Future<void> geiApiAddAndSearch() async {
    showLoading();
    await getCategory(title: KHU_VUC);
    await getCategory(title: LOAI_SU_CO);
    await getCategory(title: TRANG_THAI);
    await getNguoiTiepNhanYeuCau();
    showContent();
  }

  Future<void> getNguoiXuLy() async {
    final result = await _hoTroKyThuatRepository.getNguoiXuLy();
    result.when(
      success: (res) {
        listCanCoHTKT.add(res);
      },
      error: (error) {
        checkDataThongTinChung += 1;
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
    final Result<ChartSuCoModel> result =
        await _hoTroKyThuatRepository.getChartSuCo();
    result.when(
      success: (res) {
        //clean data chart
        listDataChart = [];
        listStatusData = [];
        listTitle = [];
        //get list title chart
        if (res.chartSuCoChild?.isNotEmpty ?? false) {
          listTitle = res.chartSuCoChild?.first.danhSachKhuVuc
                  ?.map((e) => e.suCo.toString())
                  .toList() ??
              [];
          //get list status chart
          listStatusData = res.chartSuCoChild
                  ?.map(
                    (value) => ChartData(
                      value.khuVuc ?? '',
                      0,
                      getColorChart(value.khuVuc ?? ''),
                    ),
                  )
                  .toList() ??
              [];
          //get list data chart

          for (final title in listTitle) {
            final List<ChartData> listChart = [];
            for (final ChartSuCoChild value in res.chartSuCoChild ?? []) {
              for (final DanhSachKhuVuc valueChild
                  in value.danhSachKhuVuc ?? []) {
                if (title == valueChild.suCo) {
                  listChart.add(
                    ChartData(
                      valueChild.suCo ?? '',
                      (valueChild.soLuong ?? 0).toDouble(),
                      getColorChart(value.khuVuc ?? ''),
                    ),
                  );
                }
              }
            }
            listDataChart.add(listChart);
          }
//check data

          //
          checkDataChart.add(true);
        }
        //         //get list title chart
//         listTitle =
//             res.chartSuCoChild?.map((e) => e.tenSuCo ?? '').toList() ?? [];
//         //get list status chart
//         listStatusData = res.chartSuCoChild?.first.danhSachKhuVuc
//                 ?.map(
//                   (value) => ChartData(
//                     value.khuVuc ?? '',
//                     (value.soLuong ?? 0).toDouble(),
//                     getColorChart(value.khuVuc ?? ''),
//                   ),
//                 )
//                 .toList() ??
//             [];
//         //get list data chart
//         listDataChart = res.chartSuCoChild
//                 ?.map(
//                   (e) => (e.danhSachKhuVuc ?? [])
//                       .map(
//                         (valueChild) => ChartData(
//                           valueChild.khuVuc ?? '',
//                           (valueChild.soLuong ?? 0).toDouble(),
//                           getColorChart(valueChild.khuVuc ?? ''),
//                         ),
//                       )
//                       .toList(),
//                 )
//                 .toList() ??
//             [];
// //
      },
      error: (error) {
        checkDataThongTinChung += 1;
      },
    );
  }

  Color getColorChart(String title) {
    switch (title) {
      case 'Khu vực A':
        return const Color(0xff5A8DEE);
      case 'Khu vực B':
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
        showContent();
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getCategory({
    required String title,
  }) async {
    final Result<List<CategoryModel>> result =
        await _hoTroKyThuatRepository.getCategory(title);
    result.when(
      success: (res) {
        if (title == KHU_VUC) {
          listKhuVuc.add(res);
          listToaNha.add(res.first.childCategories ?? []);
        } else if (title == LOAI_SU_CO) {
          listLoaiSuCo.add(res);
        } else {
          listTrangThai.add(res);
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
    print(listIdSuCo);
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

///Huy
