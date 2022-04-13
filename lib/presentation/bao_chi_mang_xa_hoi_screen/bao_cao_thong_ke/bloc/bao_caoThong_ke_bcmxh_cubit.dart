import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_thoi_gian_request.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_cao_thong_ke_bcmxh_state.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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

  Future<void> getTongQuanBaoCao() async {
    showLoading();
    final result = await _BCMXHRepo.tongQuanBaoCaoThongKe(
      '2022/03/01 00:00:00',
      '2022/04/08 00:00:00',
      848,
    );
    result.when(
      success: (res) {
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
        dataTongQuan[KEY_TONG_QUAN] = chartDataTongQuan;
        dataTongQuan[KEY_STATUS_TONG_QUAN] = chartDataStatusTongQuan;
        _mapTongQuan.sink.add(dataTongQuan);
        showContent();
      },
      error: (err) {
        return;
      },
    );
  }

  void clear() {
    showContent();
  }

  Future<void> getTinTongHop() async {
    showLoading();
    final result = await _BCMXHRepo.tinTongHopBaoCaoThongKe(
      '2022/03/01 00:00:00',
      '2022/04/08 00:00:00',
    );
    showContent();
    result.when(
      success: (res) {
        final List<List<BarChartModel>> listbarChar = [];
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
          listbarChar.add(barCharData);
        }
        print('--------------------------done------------------');
        _listTinTongHop.sink.add(listbarChar);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getBaoCaoTheoNguon() async {
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoNguon(
      '2022/03/01 00:00:00',
      '2022/04/08 00:00:00',
      848,
    );
    showContent();
    result.when(
      success: (res) {
        chartBaoCaoTheoNguonData.add(ChartData(
            S.current.mang_xa_hoi, double.parse(res.mangXaHoi), Colors.white));
        chartBaoCaoTheoNguonData.add(ChartData(
            S.current.bao_chi, double.parse(res.baoChi), Colors.blue));
        chartBaoCaoTheoNguonData.add(
            ChartData(S.current.forum, double.parse(res.forum), Colors.green));
        chartBaoCaoTheoNguonData.add(
            ChartData(S.current.blog, double.parse(res.blog), Colors.yellow));
        chartBaoCaoTheoNguonData.add(
            ChartData(S.current.khac, double.parse(res.nguonKhac), Colors.red));
        _chartBaoCaoTheoNguon.sink.add(chartBaoCaoTheoNguonData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getBaoCaoTheoSacThai() async {
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoSacThai(
      '2022/03/01 00:00:00',
      '2022/04/08 00:00:00',
      848,
    );
    showContent();
    result.when(
      success: (res) {
        chartBaoCaoTheoSacThaiData.add(ChartData(
            S.current.trung_lap, res.trungLap.toDouble(), Colors.blue));
        chartBaoCaoTheoSacThaiData.add(ChartData(
            S.current.tich_cuc, res.tichCuc.toDouble(), Colors.green));
        chartBaoCaoTheoSacThaiData.add(ChartData(
            S.current.tieu_cuc, res.tieuCuc.toDouble(), Colors.orange));
        _chartBaoCaoTheoSacThai.sink.add(chartBaoCaoTheoSacThaiData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getBaoCaoTheoThoiGian() async {
    final ThongKeTheoThoiGianRequest request = ThongKeTheoThoiGianRequest(
      treeNodes: [TreeNode(title: '', id: 848)],
      fromDate: '2022/04/06 00:00:00',
      toDate: '2022/04/13 00:00:00',
      sourceId: 0,
    );
    showLoading();
    final result = await _BCMXHRepo.baoCaoTheoThoiGian(
      request,
    );
    showContent();
    result.when(
      success: (res) {
        print('--------------------------thanh cong-------------------------');
      },
      error: (err) {
        print('--------------------------that bai-------------------------');
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
}
