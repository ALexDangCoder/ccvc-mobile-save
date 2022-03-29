import 'dart:ui';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/dashboard_schedule.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan%20_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_state.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/indicator_chart.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

enum StatusType { CHUA_THUC_HIEN, DA_HOAN_THANH, DANG_THUC_HIEN }

class YKienNguoiDanCubitt extends BaseCubit<YKienNguoiDanState> {
  YKienNguoiDanCubitt() : super(YKienNguoiDanStateInitial());
  BehaviorSubject<List<bool>> selectTypeYKNDSubject =
      BehaviorSubject.seeded([true, false]);
  bool isCheck = false;
  late String startDate;
  late String endDate;
  String donViId = '';
  String userId = '';
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

  Stream<List<YKienNguoiDanModel>> get danhSachYKienNguoiDan =>
      _listYKienNguoiDan.stream;

  Stream<List<YKienNguoiDanDashBroadItem>> get listItemDashboard =>
      _listItemDashBoard.stream;

  Stream<List<ChartData>> get chartTinhHinhXuLy => _chartTinhHinhXuLy.stream;

  Stream<List<ChartData>> get chartPhanLoai => _chartPhanLoai.stream;

  Stream<DashboardTinhHinhXuLuModel> get dashBoardTinhHinhXuLy =>
      _dashBoardTinhHinhXuLy.stream;

  List<DashboardSchedule> list = [
    DashboardSchedule(1, '22ssads2', 'Chờ duyệt'),
    DashboardSchedule(2, '2dasdsd22', 'Thời gian'),
    DashboardSchedule(3, '2dasdsd22', 'Thời gian'),
  ];
  List<String> img = [
    ImageAssets.icChoDuyetYKND,
    ImageAssets.icDongHoYKND,
    ImageAssets.icDongHoYKND,
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
      '01/03/2022',
      '28/03/2022',
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
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.choDuyet,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.choXuLy,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.tongSoPakn,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.choTiepNhan,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.choPhanCongXuLy,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.choChoYKien,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(YKienNguoiDanDashBroadItem(
          img: ImageAssets.icChoDuyetYKND,
          numberOfCalendars: res.choBoXungThongTin,
          typeName: S.current.cho_duyet,
        ));
        listItem.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.icChoDuyetYKND,
            numberOfCalendars: res.choDuyet,
            typeName: S.current.cho_duyet,
          ),
        );
        _listItemDashBoard.sink.add(listItem);
      },
      error: (err) {
        return;
      },
    );
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
        final List<ChartData>listChartTinhHinhxuLy= listDataTinhHinhXuLy
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
        _chartTinhHinhXuLy.sink.add(listChartTinhHinhxuLy);
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
            res.listPhanLoai[4].status,
            res.listPhanLoai[4].soLuong.toDouble(),
            choTrinhKyColor,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[0].status,
            res.listPhanLoai[0].soLuong.toDouble(),
            labelColor,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[3].status,
            res.listPhanLoai[3].soLuong.toDouble(),
            unselectLabelColor,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[5].status,
            res.listPhanLoai[5].soLuong.toDouble(),
            itemWidgetUsing,
          ),
        );
        listChartPhanLoai.add(
          ChartData(
            res.listPhanLoai[6].status,
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
    int pageSize,
    int pageNumber,
    String userId,
    String donViId,
  ) async {
    showLoading();
    final result = await _YKNDRepo.danhSachYKienNguoiDan(
      tuNgay,
      denNgay,
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
      pageSize,
      pageNumber,
      tuKhoa,
      userId,
      donViId,
    );
    showContent();
    result.when(
      success: (res) {
        print(res.listYKienNguoiDan.length);
      },
      error: (err) {
        return;
      },
    );
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
