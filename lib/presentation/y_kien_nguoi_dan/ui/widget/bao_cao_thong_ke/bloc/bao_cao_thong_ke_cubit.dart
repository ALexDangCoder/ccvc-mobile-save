import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/bloc/bao_cao_thong_ke_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

enum StatusType { CHUA_THUC_HIEN, DA_HOAN_THANH, DANG_THUC_HIEN }

class BaoCaoThongKeYKNDCubit extends BaseCubit<BaoCaoThongKeYKNDState> {
  BaoCaoThongKeYKNDCubit() : super(BaoCaoThongKeYKNDStateInitial());

  final BehaviorSubject<List<YKienNguoiDanDashBroadItem>> _listBaoCaoYKND =
      BehaviorSubject<List<YKienNguoiDanDashBroadItem>>();

  final BehaviorSubject<DashBroadItemYKNDModel> _dashBoardBaoCaoYKND =
      BehaviorSubject<DashBroadItemYKNDModel>();

  final BehaviorSubject<List<ChartData>> _listChartDashBoard =
      BehaviorSubject<List<ChartData>>();

  final BehaviorSubject<List<LinhVucKhacModel>> _chartLinhVucXuLy =
      BehaviorSubject<List<LinhVucKhacModel>>();

  final BehaviorSubject<List<DonViYKNDModel>> _chartDonViXuLy =
      BehaviorSubject<List<DonViYKNDModel>>();

  final BehaviorSubject<List<YKNDByMonth>> _chartSoLuongYkNDByMonth =
      BehaviorSubject<List<YKNDByMonth>>();

  final BehaviorSubject<List<ChartData>> _statusChartData =
      BehaviorSubject<List<ChartData>>();

  Stream<List<ChartData>> get statusChartData => _statusChartData.stream;

  Stream<List<YKNDByMonth>> get chartSoLuongYkNDByMonth =>
      _chartSoLuongYkNDByMonth.stream;

  Stream<List<DonViYKNDModel>> get chartDonViXuLy => _chartDonViXuLy.stream;

  Stream<List<LinhVucKhacModel>> get chartLinhVucXuLy =>
      _chartLinhVucXuLy.stream;

  Stream<List<ChartData>> get streamDashBoardBaoCaoYKND =>
      _listChartDashBoard.stream;

  Stream<DashBroadItemYKNDModel> get listChartDashBoard =>
      _dashBoardBaoCaoYKND.stream;

  Stream<List<YKienNguoiDanDashBroadItem>> get listBaoCaoYKND =>
      _listBaoCaoYKND.stream;

  DashBroadItemYKNDModel dashBroadItemYKNDModel = DashBroadItemYKNDModel();
  final List<ChartData> listDataChart = [];
  final List<ChartData> listStatusDataChart = [];

  final List<String> titleBaoCaoYKND = [
    S.current.cho_tiep_nhan,
    S.current.da_xu_ly,
    S.current.dang_tai_cong_khai,
    S.current.dang_xu_ly,
    S.current.so_luong_y_kien,
  ];
  final List<YKienNguoiDanDashBroadItem> listInitDataBaoCao = [
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_tong_so_yknd,
      numberOfCalendars: 0,
      typeName: S.current.so_y_kien_tiep_nha,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_da_xu_ly_yknd,
      numberOfCalendars: 0,
      typeName: S.current.da_xu_ly,
    ),
    YKienNguoiDanDashBroadItem(
      img: ImageAssets.ic_dang_xu_ly_yknd,
      numberOfCalendars: 0,
      typeName: S.current.dang_xu_ly,
    ),
  ];

  final List<String> imgBaoCaoYKND = [
    S.current.cho_tiep_nhan,
    S.current.da_xu_ly,
    S.current.dang_tai_cong_khai,
    S.current.dang_xu_ly,
    S.current.so_luong_y_kien,
  ];

  Future<void> callApi(
    String startDate,
    String endDate, {
    List<String>? listDonVi,
  }) async {
    final queue = Queue(parallel: 4);
    unawaited(
      queue.add(
        () => dashBoardBaoCaoPieChartYKND(
          0,
          true,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => dashBoardLinhKhacXuLy(
          startDate,
          endDate,
          listDonVi: listDonVi,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => dashBoardDonViXuLy(
          startDate,
          endDate,
          listDonVi: listDonVi,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => dashBoardSoLuongByMonth(
          startDate,
          endDate,
          listDonVi: listDonVi,
        ),
      ),
    );
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  final YKienNguoiDanRepository _YKNDRepo = Get.find();

  Future<void> baoCaoYKND(
    String tuNgay,
    String denNgay, {
    List<String>? listDonVi,
  }) async {
    showLoading();
    final result = await _YKNDRepo.baoCaoYKienNguoiDan(
      tuNgay,
      denNgay,
      listDonVi: listDonVi ?? [],
    );
    showContent();
    result.when(
      success: (res) {
        List<YKienNguoiDanDashBroadItem> listBaoCao = [];
        listBaoCao.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_tong_so_yknd,
            numberOfCalendars: res.thongKeYKNDData.soLuongYKien,
            typeName: S.current.so_y_kien_tiep_nha,
          ),
        );
        listBaoCao.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_da_xu_ly_yknd,
            numberOfCalendars: res.thongKeYKNDData.daXuLy,
            typeName: S.current.da_xu_ly,
          ),
        );
        listBaoCao.add(
          YKienNguoiDanDashBroadItem(
            img: ImageAssets.ic_dang_xu_ly_yknd,
            numberOfCalendars: res.thongKeYKNDData.dangXuLy,
            typeName: S.current.dang_xu_ly,
          ),
        );
        _listBaoCaoYKND.sink.add(listBaoCao);
      },
      error: (err) {
        return;
      },
    );
  }

  double getMax(List<DonViYKNDModel> data) {
    double value = 0;
    data.forEach((element) {
      if ((element.soPhanAnhKienNghi.toDouble()) > value) {
        value = element.soPhanAnhKienNghi.toDouble();
      }
    });
    final double range = value % 10;

    return (value + (10.0 - range)) / 5;
  }

  Future<void> dashBoardBaoCaoYKND(
    String tuNgay,
    String denNgay, {
    List<String>? listDonVi,
  }) async {
    showLoading();
    final result = await _YKNDRepo.dashBoardBaoCaoYKND(
      tuNgay,
      denNgay,
      listDonVi: listDonVi,
    );
    showContent();
    result.when(
      success: (res) {
        listDataChart.clear();
        listStatusDataChart.clear();
        final dataResponse = res.listDataDashBoard;
        for (final element in dataResponse) {
          getDataDashBoardBaoCaoThongKe(element, dashBroadItemYKNDModel);
        }
        listDataChart.add(
          ChartData(
            S.current.chuyen_xu_ly_report,
            dashBroadItemYKNDModel.chuyenXuLy?.toDouble() ?? 0,
            choBanHanhColor,
          ),
        );

        listDataChart.add(
          ChartData(
            S.current.yeu_cau_phoi_hop_report,
            dashBroadItemYKNDModel.yeuCauPhoiHop?.toDouble() ?? 0,
            radioFocusColor,
          ),
        );
        listDataChart.add(
          ChartData(
            S.current.cho_bo_sung_thong_tin_pakn,
            dashBroadItemYKNDModel.choBoSungThongTin?.toDouble() ?? 0,
            choTrinhKyColor,
          ),
        );
        listDataChart.add(
          ChartData(
            S.current.cho_duyet,
            dashBroadItemYKNDModel.choDuyet?.toDouble() ?? 0,
            textColorForum,
          ),
        );
        listDataChart.add(
          ChartData(
            S.current.cho_xu_ly,
            dashBroadItemYKNDModel.choXuLy?.toDouble() ?? 0,
            choXuLyYKND,
          ),
        );
        listStatusDataChart.add(
          ChartData(
            S.current.qua_han,
            dashBroadItemYKNDModel.quaHan?.toDouble() ?? 0,
            redChart,
          ),
        );
        listStatusDataChart.add(
          ChartData(
            S.current.den_han,
            dashBroadItemYKNDModel.denHan?.toDouble() ?? 0,
            orangeNhatChart,
          ),
        );
        listStatusDataChart.add(
          ChartData(
            S.current.trong_han,
            dashBroadItemYKNDModel.trongHan?.toDouble() ?? 0,
            choTrinhKyColor,
          ),
        );

        _listChartDashBoard.sink.add(listDataChart);
        _statusChartData.sink.add(listStatusDataChart);
        _dashBoardBaoCaoYKND.add(
          DashBroadItemYKNDModel(
            trongHan: dashBroadItemYKNDModel.trongHan,
            denHan: dashBroadItemYKNDModel.denHan,
            quaHan: dashBroadItemYKNDModel.quaHan,
          ),
        );
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> dashBoardBaoCaoPieChartYKND(
    int filterBy,
    bool isAll,
  ) async {
    showLoading();
    final result = await _YKNDRepo.getBaoCaoPieChart(
      filterBy,
      isAll,
    );
    showContent();
    result.when(
      success: (res) {
        final List<ChartData> listData = [];
        listData.add(ChartData(
            S.current.cong_dvc_quoc_gia, res[0].toDouble(), choBanHanhColor,));
        listData.add(ChartData(
            S.current.cong_dvc_bo, res[1].toDouble(), radioFocusColor,));
        listData.add(ChartData(
            S.current.ung_dung_dieu_hanh, res[3].toDouble(), choTrinhKyColor,));
        listData.add(ChartData(
            S.current.thu_dien_tu, res[4].toDouble(), textColorForum,));
        listData.add(ChartData(
            S.current.the_thong_qlvb, res[6].toDouble(), choXuLyYKND,));

        _listChartDashBoard.sink.add(listData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> dashBoardLinhKhacXuLy(
    String tuNgay,
    String denNgay, {
    List<String>? listDonVi,
  }) async {
    showLoading();
    final result = await _YKNDRepo.chartLinhVucKhac(
      tuNgay,
      denNgay,
      listDonVi: listDonVi,
    );
    showContent();
    result.when(
      success: (res) {
        _chartLinhVucXuLy.sink.add(res.listChartData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> dashBoardDonViXuLy(
    String tuNgay,
    String denNgay, {
    List<String>? listDonVi,
  }) async {
    showLoading();
    final result = await _YKNDRepo.chartDonVi(
      tuNgay,
      denNgay,
      listDonVi: listDonVi,
    );
    showContent();
    result.when(
      success: (res) {
        _chartDonViXuLy.sink.add(res.listChartData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> dashBoardSoLuongByMonth(
    String tuNgay,
    String denNgay, {
    List<String>? listDonVi,
  }) async {
    showLoading();
    final result = await _YKNDRepo.chartSoLuongByMonth(
      tuNgay,
      denNgay,
      listDonVi: listDonVi,
    );
    showContent();
    result.when(
      success: (res) {
        _chartSoLuongYkNDByMonth.sink.add(res.listChartData);
      },
      error: (err) {
        return;
      },
    );
  }

  bool checkDataList(List<dynamic> data) {
    for (final i in data) {
      if (i.soPhanAnhKienNghi != 0) return true;
    }
    return false;
  }
}

void getDataDashBoardBaoCaoThongKe(
  DashBoardBaoCaoYKNDData data,
  DashBroadItemYKNDModel dashBroadItemYKNDModel,
) {
  switch (data.code) {
    case CodeStatusYKND.CHUYEN_XU_LY:
      dashBroadItemYKNDModel.chuyenXuLy = data.soLuong;
      break;
    case CodeStatusYKND.YEU_CAU_PHOI_HOP:
      dashBroadItemYKNDModel.yeuCauPhoiHop = data.soLuong;
      break;
    case CodeStatusYKND.CHO_BO_SUNG_THONG_TIN:
      dashBroadItemYKNDModel.choBoSungThongTin = data.soLuong;
      break;
    case CodeStatusYKND.CHO_DUYET:
      dashBroadItemYKNDModel.choDuyet = data.soLuong;
      break;
    case CodeStatusYKND.CHO_XU_LY_YKND:
      dashBroadItemYKNDModel.choXuLy = data.soLuong;
      break;
    case CodeStatusYKND.QUA_HAN_YKND:
      dashBroadItemYKNDModel.quaHan = data.soLuong;
      break;
    case CodeStatusYKND.TRONG_HAN_YKND:
      dashBroadItemYKNDModel.trongHan = data.soLuong;
      break;
    case CodeStatusYKND.DEN_HAN_YKND:
      dashBroadItemYKNDModel.denHan = data.soLuong;
      break;
    default:
      break;
  }
}
