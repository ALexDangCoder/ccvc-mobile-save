import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_thoi_gian_request.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/nguon_bao_cao_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_cao_thong_ke_bcmxh_state.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class BaoCaoThongKeBCMXHCubit extends BaseCubit<BaoCaoThongKeBCMXhState> {
  BaoCaoThongKeBCMXHCubit() : super(BaoCaoThongKeBCMXhStateInitial());

  final BehaviorSubject<Map<String, List<BarChartModel>>> _mapTongQuan =
      BehaviorSubject<Map<String, List<BarChartModel>>>();

  final BehaviorSubject<List<List<BarChartModel>>> _listTinTongHop =
      BehaviorSubject<List<List<BarChartModel>>>();

  final BehaviorSubject<List<ChartData>> _chartBaoCaoTheoNguon =
      BehaviorSubject<List<ChartData>>();
  final BehaviorSubject<List<ChartData>> _chartBaoCaoTheoSacThai =
      BehaviorSubject<List<ChartData>>();

  final BehaviorSubject<List<LineChartData>> _lineChartTheoThoiGian =
      BehaviorSubject<List<LineChartData>>();

  final BehaviorSubject<NguonBaoCaoLineChartModel> _lineChartTheoNguon =
      BehaviorSubject<NguonBaoCaoLineChartModel>();

  final BehaviorSubject<SacThaiLineChartModel> _lineChartTheoSacThai =
      BehaviorSubject<SacThaiLineChartModel>();

  late String initStartDate;
  late String initEndDate;

  Stream<SacThaiLineChartModel> get lineChartTheoSacThai =>
      _lineChartTheoSacThai.stream;

  Stream<NguonBaoCaoLineChartModel> get lineChartTheoNguon =>
      _lineChartTheoNguon.stream;

  Stream<List<LineChartData>> get lineChartTheoThoiGian =>
      _lineChartTheoThoiGian.stream;

  Stream<List<ChartData>> get chartBaoCaoTheoNguon =>
      _chartBaoCaoTheoNguon.stream;

  Stream<List<ChartData>> get chartBaoCaoTheoSacThai =>
      _chartBaoCaoTheoSacThai.stream;

  Stream<List<List<BarChartModel>>> get listTinTongHop =>
      _listTinTongHop.stream;

  Stream<Map<String, List<BarChartModel>>> get mapTongQuan =>
      _mapTongQuan.stream;

  final List<BarChartModel> chartDataTongQuan = [];
  final List<ChartData> chartBaoCaoTheoNguonData = [];
  final List<ChartData> chartBaoCaoTheoSacThaiData = [];
  final List<BarChartModel> chartTinTongHop = [];

  final List<BarChartModel> chartDataStatusTongQuan = [];
  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();
  final Map<String, List<BarChartModel>> dataTongQuan = {};
  final List<String> listTitleSubBarChart = [
    S.current.bai_viet,
    S.current.like,
    S.current.share,
    S.current.comment,
  ];
  static const String KEY_TONG_QUAN = 'tongguan';
  static const String KEY_STATUS_TONG_QUAN = 'status';

  Future<void> callApi(int topic) async {
    final queue = Queue(parallel: 7);
    await queue.add(
      () => initDateTIme(),
    );
    unawaited(
      queue.add(
        () => getTongQuanBaoCao(
          initStartDate,
          initEndDate,
          topic,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => getTinTongHop(
          initStartDate,
          initEndDate,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => getBaoCaoTheoNguon(
          initStartDate,
          initEndDate,
          topic,
        ),
      ),
    );

    unawaited(
      queue.add(
        () => getBaoCaoTheoThoiGian(
          initStartDate,
          initEndDate,
          topic,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => getBaoCaoTheoNguonLineChart(
          initStartDate,
          initEndDate,
          topic,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => getSacThaiLineChart(
          initStartDate,
          initEndDate,
          topic,
        ),
      ),
    );
    unawaited(
      queue.add(
        () => getBaoCaoTheoSacThai(
          initStartDate,
          initEndDate,
          topic,
        ),
      ),
    );
    await queue.onComplete;
    queue.dispose();
  }

  Future<void> getTongQuanBaoCao(
    String startDate,
    String endDate,
    int topic,
  ) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    showLoading();
    final result = await _BCMXHRepo.tongQuanBaoCaoThongKe(
      formatStartDate,
      formatEndDate,
      topic,
    );
    result.when(
      success: (res) {
        showContent();
        chartDataTongQuan.clear();
        chartDataStatusTongQuan.clear();
        chartDataTongQuan.add(
          BarChartModel(soLuong: res.tongTin ?? 0, ten: S.current.tong_tin),
        );
        chartDataTongQuan.add(
          BarChartModel(
            soLuong: res.mangXaHoi ?? 0,
            ten: S.current.mang_xa_hoi,
          ),
        );
        chartDataTongQuan.add(
          BarChartModel(soLuong: res.baoChi ?? 0, ten: S.current.bao_chi),
        );
        chartDataTongQuan.add(
          BarChartModel(soLuong: res.forum ?? 0, ten: S.current.forum),
        );
        chartDataTongQuan.add(
          BarChartModel(soLuong: res.blog ?? 0, ten: S.current.blog),
        );
        chartDataTongQuan.add(
          BarChartModel(soLuong: res.nguonKhac ?? 0, ten: S.current.nguon_khac),
        );
        chartDataStatusTongQuan.clear();
        chartDataStatusTongQuan
            .add(BarChartModel(soLuong: res.like ?? 0, ten: S.current.like));

        chartDataStatusTongQuan
            .add(BarChartModel(soLuong: res.share ?? 0, ten: S.current.share));
        chartDataStatusTongQuan.add(
          BarChartModel(soLuong: res.comment ?? 0, ten: S.current.comment),
        );
        chartDataStatusTongQuan.add(
          BarChartModel(soLuong: res.tichCuc ?? 0, ten: S.current.tich_cuc),
        );
        chartDataStatusTongQuan.add(
          BarChartModel(soLuong: res.tieuCuc ?? 0, ten: S.current.tieu_cuc),
        );
        chartDataStatusTongQuan.add(
          BarChartModel(
            soLuong: res.trungLap ?? 0,
            ten: S.current.trung_lap,
          ),
        );
        dataTongQuan[KEY_TONG_QUAN] = chartDataTongQuan.reversed.toList();
        dataTongQuan[KEY_STATUS_TONG_QUAN] =
            chartDataStatusTongQuan.reversed.toList();
        _mapTongQuan.sink.add(dataTongQuan);
      },
      error: (err) {
        showEmpty();
      },
    );
  }

  void clear() {
    showContent();
  }

  Future<void> getTinTongHop(String startDate, String endDate) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    showLoading();
    final result = await _BCMXHRepo.tinTongHopBaoCaoThongKe(
      formatStartDate,
      formatEndDate,
    );

    result.when(
      success: (res) {
        showContent();
        final List<List<BarChartModel>> listBarChar = [];
        for (final element in res) {
          final List<BarChartModel> barCharData = [];
          barCharData.add(
            BarChartModel(
              soLuong: element.reach.toInt(),
              ten: S.current.bai_viet,
            ),
          );
          barCharData.add(
            BarChartModel(
              soLuong: element.like.toInt(),
              ten: S.current.like,
            ),
          );
          barCharData.add(
            BarChartModel(
              soLuong: element.share.toInt(),
              ten: S.current.share,
            ),
          );
          barCharData.add(
            BarChartModel(
              soLuong: element.comment.toInt(),
              ten: S.current.comment,
            ),
          );
          listBarChar.add(barCharData);
        }
        _listTinTongHop.sink.add(listBarChar);
      },
      error: (err) {
        showEmpty();
      },
    );
  }

  Future<void> getBaoCaoTheoNguon(
    String startDate,
    String endDate,
    int topic,
  ) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoNguon(
      formatStartDate,
      formatEndDate,
      topic,
    );
    showContent();
    result.when(
      success: (res) {
        showContent();
        chartBaoCaoTheoNguonData.clear();
        chartBaoCaoTheoNguonData.add(
          ChartData(
            S.current.mang_xa_hoi,
            double.parse(res.mangXaHoi),
            blueNhatChart,
          ),
        );
        chartBaoCaoTheoNguonData.add(
          ChartData(
            S.current.bao_chi,
            double.parse(res.baoChi),
            greenChart,
          ),
        );
        chartBaoCaoTheoNguonData.add(
          ChartData(S.current.forum, double.parse(res.forum), grayChart),
        );
        chartBaoCaoTheoNguonData.add(
          ChartData(S.current.blog, double.parse(res.blog), orangeNhatChart),
        );
        chartBaoCaoTheoNguonData.add(
          ChartData(
            S.current.khac,
            double.parse(res.nguonKhac),
            purpleChart,
          ),
        );
        _chartBaoCaoTheoNguon.sink.add(chartBaoCaoTheoNguonData);
      },
      error: (err) {
        showEmpty();
      },
    );
  }

  Future<void> getBaoCaoTheoSacThai(
    String startDate,
    String endDate,
    int topic,
  ) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoSacThai(
      formatStartDate,
      formatEndDate,
      topic,
    );

    result.when(
      success: (res) {
        showContent();
        chartBaoCaoTheoSacThaiData.clear();
        chartBaoCaoTheoSacThaiData.add(
          ChartData(
            S.current.trung_lap,
            res.trungLap.toDouble(),
            Colors.blue,
          ),
        );
        chartBaoCaoTheoSacThaiData.add(
          ChartData(
            S.current.tich_cuc,
            res.tichCuc.toDouble(),
            Colors.green,
          ),
        );
        chartBaoCaoTheoSacThaiData.add(
          ChartData(
            S.current.tieu_cuc,
            res.tieuCuc.toDouble(),
            Colors.orange,
          ),
        );
        _chartBaoCaoTheoSacThai.sink.add(chartBaoCaoTheoSacThaiData);
      },
      error: (err) {
        showEmpty();
        return;
      },
    );
  }

  Future<void> getBaoCaoTheoThoiGian(
    String startDate,
    String endDate,
    int topic,
  ) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    final ThongKeTheoThoiGianRequest request = ThongKeTheoThoiGianRequest(
      treeNodes: [TreeNode(title: '', id: topic)],
      fromDate: formatStartDate,
      toDate: formatEndDate,
      sourceId: 0,
    );
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoThoiGian(
      request,
    );

    result.when(
      success: (res) {
        showContent();
        _lineChartTheoThoiGian.sink.add(res);
      },
      error: (err) {
        showEmpty();
        return;
      },
    );
  }

  Future<void> getBaoCaoTheoNguonLineChart(
    String startDate,
    String endDate,
    int topic,
  ) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoNguonLineChart(
      formatStartDate,
      formatEndDate,
      topic,
      '',
      0,
    );
    showContent();
    result.when(
      success: (res) {
        _lineChartTheoNguon.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getSacThaiLineChart(
    String startDate,
    String endDate,
    int topic,
  ) async {
    final formatStartDate = DateTime.parse(startDate).formatApiSS;
    final formatEndDate = DateTime.parse(endDate).formatApiSS;
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoSacThaiLineChart(
      formatStartDate,
      formatEndDate,
      topic,
    );
    showContent();
    result.when(
      success: (res) {
        _lineChartTheoSacThai.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
  }

  bool checkDataList(List<dynamic> data) {
    for (final i in data) {
      if (i.soLuong != 0) return true;
    }
    return false;
  }

  Future<void> initDateTIme() async {
    const int millisecondOfWeek = 7 * 24 * 60 * 60 * 1000;
    final int millisecondNow = DateTime.now().millisecondsSinceEpoch;
    final int prevWeek = millisecondNow - millisecondOfWeek;
    initEndDate = DateTime.now().toString();
    initStartDate = DateTime.fromMillisecondsSinceEpoch(prevWeek).toString();
  }
}
