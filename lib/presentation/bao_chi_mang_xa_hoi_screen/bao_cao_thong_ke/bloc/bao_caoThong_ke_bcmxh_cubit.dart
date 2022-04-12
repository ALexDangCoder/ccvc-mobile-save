import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_cao_thong_ke_bcmxh_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class BaoCaoThongKeBCMXHCubit extends BaseCubit<BaoCaoThongKeBCMXhState> {
  BaoCaoThongKeBCMXHCubit() : super(BaoCaoThongKeBCMXhStateInitial());

  final BehaviorSubject<Map<String, List<BarChartModel>>> _mapTongQuan =
      BehaviorSubject<Map<String, List<BarChartModel>>>();

  final BehaviorSubject<List<List<BarChartModel>>> _listTinTongHop =
      BehaviorSubject<List<List<BarChartModel>>>();

  Stream<List<List<BarChartModel>>> get listTinTongHop =>
      _listTinTongHop.stream;

  Stream<Map<String, List<BarChartModel>>> get mapTongQuan =>
      _mapTongQuan.stream;

  final List<BarChartModel> chartDataTongQuan = [];
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
  void clear(){
    showContent();
  }
  Future<void> getTinTongHop() async {
    showLoading();
    final result = await _BCMXHRepo.tinTongHopBaoCaoThongKe(
      '2022/03/01 00:00:00',
      '2022/04/08 00:00:00',
    );
    result.when(
      success: (res) {
        final List<List<BarChartModel>> listbarChar = [];
        for (final element in res) {
          final List<BarChartModel> barCharData = [];
          barCharData.add(BarChartModel(
              soLuong: element.reach.toInt(), ten: S.current.bai_viet,),);
          barCharData.add(BarChartModel(
              soLuong: element.like.toInt(), ten: S.current.like,),);
          barCharData.add(BarChartModel(
              soLuong: element.share.toInt(), ten: S.current.share,),);
          barCharData.add(BarChartModel(
              soLuong: element.comment.toInt(), ten: S.current.comment,),);
          listbarChar.add(barCharData);
        }
        _listTinTongHop.sink.add(listbarChar);
        showContent();
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
}
