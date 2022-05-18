import 'dart:ui';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/indicator_chart.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
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

  YKienNguoiDanCubitt() : super(YKienNguoiDanStateInitial());
  BehaviorSubject<List<bool>> selectTypeYKNDSubject =
      BehaviorSubject.seeded([true, false]);
  bool isCheck = false;
  late String startDate;
  late String endDate;
  String donViId = '';
  String userId = '';
  String trangThai = '';

  int pageSizeDSPAKN = 10;
  int pageNumberDSPAKN = 1;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;

  static const int TRONGHAN = 1;
  static const int DENHAN = 2;
  static const int QUAHAN = 3;


  final List<ChartData> listChartPhanLoai = [];
  final BehaviorSubject<DashboardTinhHinhXuLuModel> _dashBoardTinhHinhXuLy =
      BehaviorSubject<DashboardTinhHinhXuLuModel>();

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
  final BehaviorSubject<bool> _selectSreach = BehaviorSubject.seeded(false);

  Stream<bool> get selectSreach => _selectSreach.stream;

  Stream<DocumentDashboardModel> get statusTinhHinhXuLyData =>
      _statusTinhHinhXuLyData.stream;

  Stream<List<YKienNguoiDanModel>> get danhSachYKienNguoiDan =>
      _listYKienNguoiDan.stream;

  Stream<List<YKienNguoiDanDashBroadItem>> get listItemDashboard =>
      _listItemDashBoard.stream;

  Stream<List<ChartData>> get chartTinhHinhXuLy => _chartTinhHinhXuLy.stream;

  Stream<List<ChartData>> get chartPhanLoai => _chartPhanLoai.stream;

  Stream<DashboardTinhHinhXuLuModel> get dashBoardTinhHinhXuLy =>
      _dashBoardTinhHinhXuLy.stream;

  String search = '';

  void setSelectSearch() {
    _selectSreach.sink.add(!_selectSreach.value);
  }

  ImageThongTinYKienNguoiDan imageThongTinYKienNguoiDan =
      ImageThongTinYKienNguoiDan();

  List<DashboardSchedule> list = [
    DashboardSchedule(1, '22ssads2', 'Chờ duyệt'),
    DashboardSchedule(2, '2dasdsd22', 'Thời gian'),
    DashboardSchedule(3, '2dasdsd22', 'Thời gian'),
  ];
  List<String> img = [
    ImageAssets.icChoDuyetYKND,
    ImageAssets.ic_cho_tiep_nhan_xu_ly,
    ImageAssets.ic_cho_cho_bo_sung_y_kien,
  ];

  List<ChartData> chartYKienNduoiDan = [
    ChartData(S.current.cong_dvc_quoc_gia, 10, choTrinhKyColor),
    ChartData(S.current.thu_dien_tu, 10, labelColor),
    ChartData(S.current.thu_dien_tu_hai, 10, unselectLabelColor),
    ChartData(S.current.ung_dung_chi_dao_dieu_hanh, 5, itemWidgetUsing),
    ChartData(S.current.he_thong_quan_ly_van_ban, 5, itemWidgetNotUse),
  ];
  List<ChartData> chartYKienNduoiDanTablet = [
    ChartData(S.current.thu_dien_tu, 10, labelColor),
    ChartData(S.current.cong_dvc_quoc_gia, 10, numberOfCalenders),
    ChartData(S.current.ung_dung_chi_dao_dieu_hanh, 5, itemWidgetUsing),
    ChartData(S.current.thu_dien_tu_hai, 10, unselectLabelColor),
    ChartData(S.current.he_thong_quan_ly_van_ban, 5, itemWidgetNotUse),
  ];
  List<ChartData> chartColorPhanLoaiYKND = [
    ChartData(S.current.dang_xu_ly, 30, choXuLyColor),
    ChartData(S.current.da_hoan_thanh, 12, daXuLyColor),
    ChartData(S.current.chua_thuc_hien, 14, choVaoSoColor),
  ];

  List<ChartData> chartPhanLoaiYKND = [
    ChartData(S.current.dang_xu_ly, 30, choXuLyColor),
    ChartData(S.current.da_hoan_thanh, 12, daXuLyColor),
    ChartData(S.current.chua_thuc_hien, 14, choVaoSoColor),
  ];
  DocumentDashboardModel dashboardModel = DocumentDashboardModel(
    soLuongTrongHan: 0,
    soLuongDenHan: 0,
    soLuongQuaHan: 0,
  );
  List<ItemIndicator> listIndicator = [
    ItemIndicator(color: numberOfCalenders, title: S.current.cong_dvc_quoc_gia),
    ItemIndicator(color: labelColor, title: S.current.thu_dien_tu),
    ItemIndicator(color: unselectLabelColor, title: S.current.thu_dien_tu_hai),
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
  List<NguoiDanModel> listYKienNguoiDan = [
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.DANG_XU_LY),
    NguoiDanModel(
        ngheNghiep: 'Nhan vien van phong that nghiep',
        ngayThang: '18/10/2021',
        ten: 'Ha Kieu Anh',
        statusData: StatusYKien.QUA_HAN),
    NguoiDanModel(
      ngheNghiep: 'Nhan vien van phong that nghiep',
      ngayThang: '18/10/2021',
      ten: 'Ha Kieu Anh',
      statusData: StatusYKien.DANG_XU_LY,
    ),
  ];

  String formatDateTime(String dt) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final inputDate = inputFormat.parse(dt); // <-- dd/MM 24H format

    final outputFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputFormat.format(inputDate);
    return outputDate; // 12/31/2000 11:59 PM <-- MM/dd 12H format
  }

  void callApi() {
    getUserData();
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

  Future<void> loadMoreGetDSPAKN() async {
    if(loadMore == false) {
      pageNumberDSPAKN += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getDanhSachPAKN();
    } else {
      //nothing
    }
  }

  Future<void> refreshGetDSPAKN() async {
    canLoadMoreList = true;
    if(refresh == false) {
      pageNumberDSPAKN = 1;
      refresh = true;
      await getDanhSachPAKN();
    }
  }

  BehaviorSubject<List<DanhSachKetQuaPAKNModel>> listDanhSachKetQuaPakn = BehaviorSubject();

  Future<void> getDanhSachPAKN() async {
    showLoading();
    // final result = await _YKNDRepo.getDanhSachPAKN(
    //   tuNgay: startDate,
    //   donViId: donViId,
    //   denNgay: endDate,
    //   pageSize: pageSizeDSPAKN.toString(),
    //   pageNumber: pageNumberDSPAKN.toString(),
    //   userId: userId,
    // );
    final result = await _YKNDRepo.getDanhSachPAKN(
      tuNgay: '05/04/2022',
      donViId: '0bf3b2c3-76d7-4e05-a587-9165c3624d76',
      denNgay: '17/05/2022',
      pageSize: '10',
      pageNumber: '1',
      userId: '19266143-feee-44d0-828a-e29df215f481',
    );
    result.when(success: (success) {
      if(listDanhSachKetQuaPakn.hasValue) {
        listDanhSachKetQuaPakn.sink.add(listDanhSachKetQuaPakn.value + success);
        canLoadMoreList = listDanhSachKetQuaPakn.value.length >= pageSizeDSPAKN;
        loadMore = false;
        refresh = false;
      } else {
        listDanhSachKetQuaPakn.sink.add(success);
      }
      showContent();
    }, error: (error) {
      listDanhSachKetQuaPakn.sink.add([]);
    });
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
            unselectLabelColor,
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
    startDate = DateTime.now().toStringWithListFormat;
    endDate = DateTime.now().toStringWithListFormat;
  }

  void getUserData() {
    final DataUser? dataUser = HiveLocal.getDataUser();
    if (dataUser != null) {
      donViId = dataUser.userInformation?.donViTrucThuoc?.id ?? '';
      userId = dataUser.userId ?? '';
    }
  }
}
