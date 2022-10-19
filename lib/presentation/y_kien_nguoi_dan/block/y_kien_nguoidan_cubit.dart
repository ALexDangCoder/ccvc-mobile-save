import 'dart:ui';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/indicator_chart.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

enum StatusType { CHUA_THUC_HIEN, DA_HOAN_THANH, DANG_THUC_HIEN }

class TextTrangThai {
  String text;
  Color color;

  TextTrangThai(this.text, this.color);
}

class YKienNguoiDanCubitt extends BaseCubit<YKienNguoiDanState> {
  bool isExpandedDropDownTiepNhan = true;
  bool isExpandedDropDownXuLy = true;

  YKienNguoiDanCubitt() : super(YKienNguoiDanStateInitial());
  BehaviorSubject<List<bool>> selectTypeYKNDSubject =
      BehaviorSubject.seeded([true, false]);
  bool isCheck = false;
  late String startDate;
  late String endDate;
  DateTime initStartDate = DateTime.now();
  String donViId = '';
  String userId = '';
  String trangThai = '';
  bool showCleanText = false;
  int pageSizeDSPAKN = 10;
  int pageNumberDSPAKN = 1;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  bool isSearching = false;
  String tuKhoa = '';
  Debouncer debouncer = Debouncer();
  bool isEmptyData = false;
  String userIdLocal =
      HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '';

  static const int TRONGHAN = 1;
  static const int DENHAN = 2;
  static const int QUAHAN = 3;

  final List<bool> constListValueDropdown = List.filled(Length_Drop_Down, false)
    ..setAll(
      0,
      [true],
    );
  final BehaviorSubject<List<bool>> listValueDropDownBHVSJ = BehaviorSubject();
  static const int Length_Drop_Down = 27;

  void setColorWhenChooseDropDown(int index) {
    List<bool> tmpList = [];
    if (index < Length_Drop_Down) {
      tmpList = List.filled(Length_Drop_Down, false)
        ..setAll(
          index,
          [true],
        );
    } else {
      tmpList = List.filled(Length_Drop_Down, false);
    }
    listValueDropDownBHVSJ.sink.add(tmpList);
  }

  final List<ChartData> listChartPhanLoai = [];
  BehaviorSubject<bool> isShowFilterList = BehaviorSubject.seeded(false);
  BehaviorSubject<double> sizeDropDown = BehaviorSubject.seeded(500);
  BehaviorSubject<TextTrangThai> textFilter = BehaviorSubject.seeded(
    TextTrangThai(
      S.current.all,
      titleCalenderWork,
    ),
  );

  void resetBeforeRefresh() {
    pageSizeDSPAKN = 10;
    pageNumberDSPAKN = 1;
    initStartDate = DateTime.now();
    isFilter = false;
    hanXuLy = null;
    trangThaiFilter = null;
    loaiMenu = null;
    tuKhoa = '';
  }

  ///dashboard

  final BehaviorSubject<DocumentDashboardModel> getTinhHinhXuLy =
      BehaviorSubject<DocumentDashboardModel>();

  final BehaviorSubject<List<ChartData>> _chartTinhHinhXuLy =
      BehaviorSubject<List<ChartData>>();

  final BehaviorSubject<List<ChartData>> _chartPhanLoai =
      BehaviorSubject<List<ChartData>>();

  final BehaviorSubject<List<YKienNguoiDanDashBroadItem>> _listItemDashBoard =
      BehaviorSubject<List<YKienNguoiDanDashBroadItem>>();

  final BehaviorSubject<List<YKienNguoiDanModel>> _listYKienNguoiDan =
      BehaviorSubject<List<YKienNguoiDanModel>>();

  final BehaviorSubject<DocumentDashboardModel> _statusTinhHinhXuLyData =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<bool> _selectSearch = BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> _removeTextSearch = BehaviorSubject.seeded(false);

  Stream<bool> get selectSearch => _selectSearch.stream;

  Stream<bool> get removeTextSearch => _removeTextSearch.stream;

  Stream<DocumentDashboardModel> get statusTinhHinhXuLyData =>
      _statusTinhHinhXuLyData.stream;

  Stream<List<YKienNguoiDanModel>> get danhSachYKienNguoiDan =>
      _listYKienNguoiDan.stream;

  Stream<List<YKienNguoiDanDashBroadItem>> get listItemDashboard =>
      _listItemDashBoard.stream;

  Stream<List<ChartData>> get chartTinhHinhXuLy => _chartTinhHinhXuLy.stream;

  Stream<List<ChartData>> get chartPhanLoai => _chartPhanLoai.stream;

  String search = '';

  void setSelectSearch() {
    _selectSearch.sink.add(!_selectSearch.value);
  }

  void showIconRemove() {
    _removeTextSearch.sink.add(!_removeTextSearch.value);
  }

  ImageThongTinYKienNguoiDan imageThongTinYKienNguoiDan =
      ImageThongTinYKienNguoiDan();

  List<String> img = [
    ImageAssets.icChoDuyetYKND,
    ImageAssets.ic_cho_tiep_nhan_xu_ly,
    ImageAssets.ic_cho_cho_bo_sung_y_kien,
  ];

  DocumentDashboardModel dashboardModel = DocumentDashboardModel();
  List<ItemIndicator> listIndicator = [
    ItemIndicator(color: numberOfCalenders, title: S.current.cong_dvc_quoc_gia),
    ItemIndicator(color: labelColor, title: S.current.thu_dien_tu),
    ItemIndicator(color: colorA2AEBD, title: S.current.thu_dien_tu_hai),
    ItemIndicator(
      color: itemWidgetUsing,
      title: S.current.ung_dung_chi_dao_dieu_hanh,
    ),
    ItemIndicator(
      color: itemWidgetNotUse,
      title: S.current.he_thong_quan_ly_van_ban,
    ),
  ];
  final List<YKienNguoiDanDashBroadItem> listInitDashBoard = [
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_cho_cho_bo_sung_y_kien,
      numberOfCalendars: 0,
      typeName: S.current.cho_bo_sung_thong_tin,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_cho_cho_y_kien,
      numberOfCalendars: 0,
      typeName: S.current.cho_cho_y_kien,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.icChoDuyetYKND,
      numberOfCalendars: 0,
      typeName: S.current.cho_duyet,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_cho_phan_cong_xu_ly,
      numberOfCalendars: 0,
      typeName: S.current.cho_phan_cong_xu_ly,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_cho_tiep_nhan,
      numberOfCalendars: 0,
      typeName: S.current.cho_tiep_nhan,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_cho_tiep_nhan_xu_ly,
      numberOfCalendars: 0,
      typeName: S.current.cho_tiep_nhan_xu_ly,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_cho_xu_ly,
      numberOfCalendars: 0,
      typeName: S.current.cho_xu_ly,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_tong_so_yknd,
      numberOfCalendars: 0,
      typeName: S.current.tong_hop_yknd_da_nhan,
    ),
  ];

  String formatDateTime(String dt) {
    final inputFormat = DateFormat(DateFormatApp.date);
    final inputDate = inputFormat.parse(dt); // <-- dd/MM 24H format

    final outputFormat = DateFormat(DateFormatApp.date);
    final outputDate = outputFormat.format(inputDate);
    return outputDate; // 12/31/2000 11:59 PM <-- MM/dd 12H format
  }

  void callApi() {
    getUserData();
    // getDashBoardPAKNTest();
    getDashBoardTinhHinhXuLy(
      donViId,
      startDate,
      endDate,
    );
    getDashBoardPhanLoai(
      donViId,
      startDate,
      endDate,
    );
    getThongTinYKienNguoiDan(
      donViId,
      startDate,
      endDate,
    );
    getDanhSachYKienNguoiDan(
      startDate,
      endDate,
      trangThai,
      10,
      1,
      userId,
      donViId,
    );
  }

  final YKienNguoiDanRepository _YKNDRepo = Get.find();

  Future<void> getThongTinYKienNguoiDan(
    String donViID,
    String startDate,
    String enDate,
  ) async {
    showLoading();
    final result = await _YKNDRepo.thongTingNguoiDan(
      donViID,
      startDate,
      enDate,
    );
    showContent();
    result.when(
      success: (res) {
        final List<YKienNguoiDanDashBroadItem> listItem = [];
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_cho_cho_bo_sung_y_kien,
            numberOfCalendars: res.choBoXungThongTin,
            typeName: S.current.cho_bo_sung_thong_tin,
          ),
        );
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_cho_cho_y_kien,
            numberOfCalendars: res.choChoYKien,
            typeName: S.current.cho_cho_y_kien,
          ),
        );
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: imageThongTinYKienNguoiDan.imgChoDuyet,
            numberOfCalendars: res.choDuyet,
            typeName: S.current.cho_duyet,
          ),
        );
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_cho_phan_cong_xu_ly,
            numberOfCalendars: res.choPhanCongXuLy,
            typeName: S.current.cho_phan_cong_xu_ly,
          ),
        );
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_cho_tiep_nhan,
            numberOfCalendars: res.choTiepNhan,
            typeName: S.current.cho_tiep_nhan,
          ),
        );
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_cho_tiep_nhan_xu_ly,
            numberOfCalendars: res.choTiepNhanXuLy,
            typeName: S.current.cho_tiep_nhan_xu_ly,
          ),
        );

        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_cho_xu_ly,
            numberOfCalendars: res.choXuLy,
            typeName: S.current.cho_xu_ly,
          ),
        );
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_tong_so_yknd,
            numberOfCalendars: res.tongSoPakn,
            typeName: S.current.tong_hop_yknd_da_nhan,
          ),
        );

        _listItemDashBoard.sink.add(listItem);
      },
      error: (err) {
        return;
      },
    );
  }

  ///huy

  void clearDSPAKN() {
    pageNumberDSPAKN = 1;
    loadMore = false;
    canLoadMoreList = true;
    refresh = false;
    listDanhSachKetQuaPakn.value.clear();
  }

  Future<void> loadMoreGetDSPAKN() async {
    if (loadMore == false) {
      pageNumberDSPAKN += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getDanhSachPAKN();
    } else {
      //nothing
    }
  }

  Future<void> loadMoreGetDSPAKNFilter() async {
    if (loadMore == false) {
      pageNumberDSPAKN += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getDanhSachPAKNFilterChart(flagLoadMore: true);
    } else {
      //nothing
    }
  }

  Future<void> loadMorePAKNVanBanFilter() async {
    if (loadMore == false) {
      pageNumberDSPAKN += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getPAKNTiepNhanCacVanBan(flagLoadMore: true);
    } else {
      //nothing
    }
  }

  Future<void> loadMorePAKNXuLyCacYKienFilter() async {
    if (loadMore == false) {
      pageNumberDSPAKN += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getDSPAKNXuLyChoVaDaChoYKien(flagLoadMore: true);
    } else {
      //nothing
    }
  }

  Future<void> refreshGetDSPAKN() async {
    canLoadMoreList = true;
    if (refresh == false) {
      pageNumberDSPAKN = 1;
      refresh = true;
      await getDanhSachPAKN();
    }
  }

  BehaviorSubject<List<DanhSachKetQuaPAKNModel>> listDanhSachKetQuaPakn =
      BehaviorSubject();

  Future<void> getDanhSachPAKN({
    bool isSearch = false,
  }) async {
    showLoading();
    if (isSearch) {
      clearDSPAKN();
    }
    final result = await _YKNDRepo.getDanhSachPAKN(
      donViId: donViId,
      pageNumber: pageNumberDSPAKN.toString(),
      pageSize: pageSizeDSPAKN.toString(),
      trangThai: trangThaiFilter,
      tuNgay: startDate,
      denNgay: endDate,
      userId: userId,
      tuKhoa: tuKhoa,
    );
    result.when(
      success: (success) {
        showContent();
        if (listDanhSachKetQuaPakn.hasValue) {
          listDanhSachKetQuaPakn.sink
              .add(listDanhSachKetQuaPakn.value + success);
          canLoadMoreList = success.length >= pageSizeDSPAKN;
          loadMore = false;
          refresh = false;
        } else {
          listDanhSachKetQuaPakn.sink.add(success);
        }
      },
      error: (error) {
        listDanhSachKetQuaPakn.sink.add([]);
      },
    );
    showContent();
  }

  bool isFilter = false;
  int? hanXuLy;
  String? trangThaiFilter;
  String? loaiMenu;
  static const String TiepNhan = 'TiepNhan';

  Future<void> getDanhSachPAKNFilterChart({bool flagLoadMore = false}) async {
    isFilter = true;
    if (!flagLoadMore) {
      clearDSPAKN();
    } else {}
    showLoading();
    final data = await _YKNDRepo.getDanhSachPaknFilter(
      pageIndex: pageNumberDSPAKN,
      pageSize: pageSizeDSPAKN,
      trangThai: trangThaiFilter,
      loaiMenu: loaiMenu,
      dateTo: startDate,
      dateFrom: endDate,
      hanXuLy: hanXuLy,
      tuKhoa: tuKhoa,
    );
    data.when(
      success: (success) {
        if (listDanhSachKetQuaPakn.hasValue) {
          listDanhSachKetQuaPakn.sink
              .add(listDanhSachKetQuaPakn.value + success);
          canLoadMoreList = success.length >= pageSizeDSPAKN;
          loadMore = false;
          refresh = false;
        } else {
          listDanhSachKetQuaPakn.sink.add(success);
        }
        showContent();
      },
      error: (error) {
        listDanhSachKetQuaPakn.sink.add([]);
      },
    );
  }

  int trangThaiVanBanDi = 1;
  bool isFilterTiepNhan = false;

  Future<void> getPAKNTiepNhanCacVanBan({bool flagLoadMore = false}) async {
    isFilterTiepNhan = true;
    if (!flagLoadMore) {
      clearDSPAKN();
    } else {}
    showLoading();
    final String startDateFormat = formatDateApi(startDate);
    final String endDateFormat = formatDateApi(endDate);
    final data = await _YKNDRepo.getDanhSachChoTaoVBDi(
      pageIndex: pageNumberDSPAKN,
      pageSize: pageSizeDSPAKN,
      dateFrom: startDateFormat,
      dateTo: endDateFormat,
      donViId: userIdLocal,
      trangThaiVanBanDi: trangThaiVanBanDi,
    );
    data.when(
      success: (success) {
        if (listDanhSachKetQuaPakn.hasValue) {
          listDanhSachKetQuaPakn.sink
              .add(listDanhSachKetQuaPakn.value + success);
          canLoadMoreList = success.length >= pageSizeDSPAKN;
          loadMore = false;
          refresh = false;
        } else {
          listDanhSachKetQuaPakn.sink.add(success);
        }
        showContent();
      },
      error: (error) {
        listDanhSachKetQuaPakn.sink.add([]);
      },
    );
  }

  bool isFilterXuLy = false;
  bool daChoYKien = false;

  Future<void> getDSPAKNXuLyChoVaDaChoYKien({bool flagLoadMore = false}) async {
    isFilterXuLy = true;
    if (!flagLoadMore) {
      clearDSPAKN();
    } else {}
    showLoading();
    final data = await _YKNDRepo.getDanhSachPAKNXuLyCacYKien(
      pageIndex: pageNumberDSPAKN,
      pageSize: pageSizeDSPAKN,
      dateFrom: startDate.split('/').reversed.join('/'),
      dateTo: endDate.split('/').reversed.join('/'),
      daChoYKien: daChoYKien,
    );
    data.when(
      success: (success) {
        if (listDanhSachKetQuaPakn.hasValue) {
          listDanhSachKetQuaPakn.sink
              .add(listDanhSachKetQuaPakn.value + success);
          canLoadMoreList = success.length >= pageSizeDSPAKN;
          loadMore = false;
          refresh = false;
        } else {
          listDanhSachKetQuaPakn.sink.add(success);
        }
        showContent();
      },
      error: (error) {
        listDanhSachKetQuaPakn.sink.add([]);
      },
    );
  }

  final BehaviorSubject<DashBoardPAKNModel> dashBoardPAKNTiepCanXuLyBHVSJ =
      BehaviorSubject();

  Future<void> getDashBoardPAKNTiepCanXuLy() async {
    showLoading();
    final result = await _YKNDRepo.getDashBoardPAKNTiepNhanXuLy(
      startDate,
      endDate,
    );
    result.when(
      success: (success) {
        dashBoardPAKNTiepCanXuLyBHVSJ.sink.add(success);
        showContent();
      },
      error: (error) {
        showError();
      },
    );
    showContent();
  }

  Future<void> getDashBoardTinhHinhXuLy(
    String donViID,
    String startDate,
    String enDate,
  ) async {
    showLoading();
    final result = await _YKNDRepo.dasdBoardTinhHinhXuLy(
      donViID,
      startDate,
      enDate,
    );
    showContent();
    result.when(
      success: (res) {
        final listDataTinhHinhXuLy = res.tinhHinhXuLyModel.listTinhHinh;
        final listStatusTinhHinhXuLy = res.tinhHinhXuLyModel.listTrangThai;
        final List<ChartData> listChartTinhHinhxuLy = listDataTinhHinhXuLy
            .map(
              (e) => ChartData(
                e.status,
                e.soLuong.toDouble(),
                getColorStatus(
                  e.status.vietNameseParse().replaceAll(' ', '_').toUpperCase(),
                ),
              ),
            )
            .toList();

        final DocumentDashboardModel statusTrangThaiXuLyData =
            DocumentDashboardModel();
        for (final element in listStatusTinhHinhXuLy) {
          getStatusTinhHinhXuLy(
            element.status.vietNameseParse().replaceAll(' ', '_').toUpperCase(),
            statusTrangThaiXuLyData,
            element,
          );
        }
        _chartTinhHinhXuLy.sink.add(listChartTinhHinhxuLy);
        _statusTinhHinhXuLyData.sink.add(statusTrangThaiXuLyData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getDashBoardPhanLoai(
    String donViID,
    String startDate,
    String enDate,
  ) async {
    showLoading();
    final result = await _YKNDRepo.dasdBoardPhanLoai(
      donViID,
      startDate,
      enDate,
    );
    showContent();
    result.when(
      success: (res) {
        listChartPhanLoai.clear();
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[4].tenNguon,
            res.listPhanLoai[4].soLuong.toDouble(),
            choTrinhKyColor,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[0].tenNguon,
            res.listPhanLoai[0].soLuong.toDouble(),
            labelColor,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[3].tenNguon,
            res.listPhanLoai[3].soLuong.toDouble(),
            colorA2AEBD,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[5].tenNguon,
            res.listPhanLoai[5].soLuong.toDouble(),
            itemWidgetUsing,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[6].tenNguon,
            res.listPhanLoai[6].soLuong.toDouble(),
            itemWidgetNotUse,
          ),
        );
        _chartPhanLoai.sink.add(listChartPhanLoai);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getDanhSachYKienNguoiDan(
    String tuNgay,
    String denNgay,
    String? trangThai,
    int pageSize,
    int pageNumber,
    String userId,
    String donViId,
  ) async {
    showLoading();
    final result = await _YKNDRepo.danhSachYKienNguoiDan(
      tuNgay,
      denNgay,
      trangThai ?? '',
      pageSize,
      pageNumber,
      userId,
      donViId,
    );
    showContent();
    result.when(
      success: (res) {
        _listYKienNguoiDan.sink.add(res.listYKienNguoiDan);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> searchDanhSachYKienNguoiDan(
    String tuNgay,
    String denNgay,
    String? trangThai,
    int pageSize,
    int pageNumber,
    String tuKhoa,
    String userId,
    String donViId,
  ) async {
    showLoading();
    final result = await _YKNDRepo.searchYKienNguoiDan(
      tuNgay,
      denNgay,
      trangThai ?? '',
      pageSize,
      pageNumber,
      tuKhoa,
      userId,
      donViId,
    );
    showContent();
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  DocumentDashboardModel getStatusTinhHinhXuLy(
    String codeStatus,
    DocumentDashboardModel data,
    TinhHinhModel tinhHinhModel,
  ) {
    switch (codeStatus) {
      case 'DEN_HAN':
        data.soLuongDenHan = tinhHinhModel.soLuong;
        break;
      case 'TRONG_HAN':
        data.soLuongTrongHan = tinhHinhModel.soLuong;
        break;
      case 'QUA_HAN':
        data.soLuongQuaHan = tinhHinhModel.soLuong;
        break;
    }
    return data;
  }

  Color getColorStatus(String status) {
    Color colorResult = Colors.transparent;
    switch (status) {
      case 'CHUA_THUC_HIEN':
        colorResult = choVaoSoColor;
        break;
      case 'DA_HOAN_THANH':
        colorResult = daXuLyColor;
        break;
      case 'DANG_THUC_HIEN':
        colorResult = numberOfCalenders;
        break;
    }
    return colorResult;
  }

  String getTrangThai(String status) {
    final String statusCode =
        status.split(' ').join('_').toUpperCase().vietNameseParse();
    String trangThai = '';
    switch (statusCode) {
      case 'CHUA_THUC_HIEN':
        trangThai = StatusYKND.CHUA_THUC_HIEN_YKND;
        break;
      case 'DA_HOAN_THANH':
        trangThai = StatusYKND.DA_HOAN_THANH_YKND;
        break;
      case 'DANG_THUC_HIEN':
        trangThai = StatusYKND.DANG_THUC_HIEN_YKND;
        break;
      case 'QUA_HAN':
        trangThai = StatusYKND.QUA_HAN_YKND;
        break;
      case 'DEN_HAN':
        trangThai = StatusYKND.DEN_HAN_YKND;
        break;
      case 'TRONG_HAN':
        trangThai = StatusYKND.TRONG_HAN_YKND;
        break;
    }
    return trangThai;
  }

  void initTimeRange() {
    final DateTime date = DateTime.now();
    initStartDate = DateTime(date.year, date.month, date.day - 30);
    startDate =
        DateTime(date.year, date.month, date.day - 30).toStringWithListFormat;
    endDate = DateTime.now().toStringWithListFormat;
  }

  String formatDateApi(String valueDate) {
    final tmp = DateFormat(DateFormatApp.date).parse(valueDate);
    final result = DateFormat(DateTimeFormat.DOB_FORMAT).format(tmp);
    return result;
  }

  void getUserData() {
    final DataUser? dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser.userInformation?.donViTrucThuoc?.id ?? '';
      userId = dataUser.userId ?? '';
    }
  }

  void dispose() {
    listDanhSachKetQuaPakn.value.clear();
  }

  static const int Cho_Tiep_Nhan_TC = 0;
  static const int Phan_Xu_Ly_TC = 1;
  static const int Dang_Xu_Ly_TC = 2;
  static const int Cho_Duyet_TC = 3;
  static const int Cho_Bo_Sung_TT_TC = 4;

  static const int CHO_TIEP_NHAN_XU_LY_XLY = 0;
  static const int CHO_XU_LY_XLY = 1;
  static const int CHO_PHAN_XU_LY_XLY = 2;
  static const int CHO_DUYET_XLY = 3;
  static const int DA_PHAN_CONG_XLY = 4;
  static const int DA_THUC_HIEN_XLY = 5;
  static const String XULY = 'XuLy';

  void getPAKNXuLy(int index) {
    hanXuLy = null;
    loaiMenu = XULY;
    switch (index) {
      case CHO_TIEP_NHAN_XU_LY_XLY:
        trangThaiFilter = YKienNguoiDanCubitt.ChoTiepNhanXuLy;
        textFilter.add(
          TextTrangThai(
            S.current.cho_tiep_nhan_xu_ly,
            AppTheme.getInstance().choXuLyColor(),
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_XL_CHO_TIEP_NHAN_XL);
        break;
      case CHO_XU_LY_XLY:
        trangThaiFilter = YKienNguoiDanCubitt.ChoXuLy;
        textFilter.add(
          TextTrangThai(
            S.current.cho_xu_ly,
            textColorForum,
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_XL_CHO_XU_LY);
        break;
      case CHO_PHAN_XU_LY_XLY:
        trangThaiFilter = YKienNguoiDanCubitt.ChoPhanCongXuLy;
        textFilter.add(
          TextTrangThai(
            S.current.cho_phan_cong_xu_ly,
            AppTheme.getInstance().choXuLyColor(),
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_XL_CHO_PHAN_CONG_XL);
        break;
      case CHO_DUYET_XLY:
        trangThaiFilter = YKienNguoiDanCubitt.ChoDuyet;
        textFilter.add(
          TextTrangThai(
            S.current.cho_duyet,
            textColorForum,
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_XL_CHO_DUYET);
        break;
      case DA_PHAN_CONG_XLY:
        trangThaiFilter = YKienNguoiDanCubitt.DaPhanCong;
        textFilter.add(
          TextTrangThai(
            S.current.da_phan_cong,
            daXuLyColor,
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_XL_DA_PHAN_CONG);
        break;
      default:
        trangThaiFilter = YKienNguoiDanCubitt.DaHoanThanh;
        textFilter.add(
          TextTrangThai(
            S.current.da_hoan_thanh,
            greenChart,
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_XL_DA_HOAN_THANH);
        clearDSPAKN();
        break;
    }
    isShowFilterList.add(false);
    getDanhSachPAKNFilterChart();
  }

  void getPaknTiepCan(int index) {
    switch (index) {
      case Cho_Tiep_Nhan_TC:
        trangThaiFilter = YKienNguoiDanCubitt.ChoTiepNhan;
        textFilter.add(
          TextTrangThai(
            S.current.cho_tiep_nhan,
            AppTheme.getInstance().choXuLyColor(),
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_TC_CHO_TIEP_NHAN);
        break;
      case Phan_Xu_Ly_TC:
        trangThaiFilter = YKienNguoiDanCubitt.PhanXuLy;
        textFilter.add(
          TextTrangThai(
            S.current.phan_xu_ly,
            AppTheme.getInstance().subTitleColor(),
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_TC_PHAN_XU_LY);
        break;
      case Dang_Xu_Ly_TC:
        trangThaiFilter = YKienNguoiDanCubitt.DangXuLy;
        textFilter.add(
          TextTrangThai(
            S.current.dang_xu_ly,
            textColorForum,
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_TC_DANG_XU_LY);
        break;
      case Cho_Duyet_TC:
        trangThaiFilter = YKienNguoiDanCubitt.ChoDuyet;
        textFilter.add(
          TextTrangThai(
            S.current.cho_duyet,
            textColorForum,
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_TC_CHO_DUYET);
        break;
      default:
        trangThaiFilter = YKienNguoiDanCubitt.ChoBoSungThongTin;
        textFilter.add(
          TextTrangThai(
            S.current.cho_bo_sung_thong_tin,
            AppTheme.getInstance().choXuLyColor(),
          ),
        );
        setColorWhenChooseDropDown(INDEX_FILTER_TC_CHO_BSTT);
        break;
    }
    hanXuLy = null;
    loaiMenu = TiepNhan;
    isShowFilterList.add(false);
    getDanhSachPAKNFilterChart();
  }

  static const String ChoTiepNhan = '1';
  static const String ChoChuyenXuLy = '2';
  static const String ChoTiepNhanXuLy = '3';
  static const String ChoPhanCongXuLy = '4,12';
  static const String ChoDonViDuyet = '5';
  static const String ChoBoDuyet = '6';
  static const String ChoDuyet = '6,13,18';
  static const String ChoChuyenDonVi = '7';
  static const String DaHoanThanh = '8';
  static const String ChoBoSungThongTin = '9,22';
  static const String TuChoiTiepNhan = '10';
  static const String HuyBo = '11';
  static const String ChoXuLy = '12';
  static const String ChoDuyetChuyenDonViXuLy = '13';
  static const String ChoXacNhanChuyenDonViXuLy = '14';
  static const String HuyTrinh = '15';
  static const String HuyDuyet = '16';
  static const String ThuHoi = '17';
  static const String ChoDuyetYCPH = '18';
  static const String ChuyenXuLy = '19';
  static const String DaPhanCong = '20';
  static const String PhanXuLy = '21';
  static const String DangXuLy = '3,4,12';
  static const String ChoNguoiDanBoSungThongTin = '22';
  ///TC: Tiếp cận
  ///XL: Xử lý
  static const int INDEX_FILTER_ALL = 0;
  static const int INDEX_FILTER_TC_CHO_TIEP_NHAN = 1;
  static const int INDEX_FILTER_TC_PHAN_XU_LY = 2;
  static const int INDEX_FILTER_TC_DANG_XU_LY = 3;
  static const int INDEX_FILTER_TC_CHO_TAO_VB_DI = 4;
  static const int INDEX_FILTER_TC_DA_CHO_VB_DI = 5;
  static const int INDEX_FILTER_TC_DA_HOAN_THANH = 6;
  static const int INDEX_FILTER_TC_CHO_BSTT = 7;
  static const int INDEX_FILTER_TC_BI_TU_CHOI_TIEP_NHAN = 8;
  static const int INDEX_FILTER_TC_BI_HUY_BO = 9;
  static const int INDEX_FILTER_TC_THU_HOI = 25;
  static const int INDEX_FILTER_TC_TRA_LAI = 26;
  static const int INDEX_FILTER_TC_CHUYEN_XU_LY = 10;
  static const int INDEX_FILTER_XL_CHO_TIEP_NHAN_XL = 11;
  static const int INDEX_FILTER_XL_CHO_PHAN_CONG_XL = 12;
  static const int INDEX_FILTER_XL_DA_PHAN_CONG = 13;
  static const int INDEX_FILTER_XL_CHO_XU_LY = 14;
  static const int INDEX_FILTER_XL_CHO_DUYET = 15;
  static const int INDEX_FILTER_XL_CHO_TAO_VB_DI = 16;
  static const int INDEX_FILTER_XL_DA_CHO_VB_DI = 17;
  static const int INDEX_FILTER_XL_DA_HOAN_THANH = 18;
  static const int INDEX_FILTER_XL_CHO_CHO_Y_KIEN = 19;
  static const int INDEX_FILTER_XL_DA_CHO_Y_KIEN = 20;
  static const int INDEX_FILTER_XL_THU_HOI = 21;
  static const int INDEX_FILTER_XL_TRA_LAI =  22;
  static const int INDEX_FILTER_XL_CHUYEN_XU_LY = 23;
  static const int INDEX_FILTER_TC_CHO_DUYET = 24;
  static const int INDEX_FILTER_OUT_RANGE = 27;
}
