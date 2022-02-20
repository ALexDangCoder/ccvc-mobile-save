import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_state.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class QLVBCCubit extends BaseCubit<QLVBState> {
  QLVBCCubit() : super(QLVbStateInitial());
  final BehaviorSubject<DocumentDashboardModel> _getVbDen =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<DocumentDashboardModel> _getVbDi =
      BehaviorSubject<DocumentDashboardModel>();
  final BehaviorSubject<ChartData> _dataChartVBDen =
      BehaviorSubject<ChartData>();
  final BehaviorSubject<ChartData> _dataChartVBDi =
      BehaviorSubject<ChartData>();
  final List<ChartData> chartDataVbDen = [];
  final List<ChartData> chartDataVbDi = [];

  Stream<DocumentDashboardModel> get getVbDen => _getVbDen.stream;

  Stream<DocumentDashboardModel> get getVbDi => _getVbDi.stream;

  Stream<ChartData> get dataChatVbDen => _dataChartVBDen.stream;

  Stream<ChartData> get dataChatVbDi => _dataChartVBDi.stream;

  void callAPi() {
    dataVBDi(startDate: '2022-02-01', endDate: '2022-02-28');
    dataVBDen(startDate: '2022-02-01', endDate: '2022-02-28');
  }

  final QLVBRepository _QLVBRepo = Get.find();

  Future<void> dataVBDi({
    required String startDate,
    required String endDate,
  }) async {
    final result = await _QLVBRepo.getVBDi(startDate, endDate);
    result.when(
      success: (res) {
        final dataVbDi = DocumentDashboardModel(
          soLuongChoTrinhKy: res.soLuongChoTrinhKy,
          soLuongChoXuLy: res.soLuongChoXuLy,
          soLuongDaXuLy: res.soLuongDaXuLy,
          soLuongThuongKhan: res.soLuongThuongKhan,
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_trinh_ky,
            dataVbDi.soLuongChoTrinhKy?.toDouble() ?? 0,
            choTrinhKyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_xu_ly,
            dataVbDi.soLuongChoXuLy?.toDouble() ?? 0,
            choXuLyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDi.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        _getVbDi.sink.add(dataVbDi);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> dataVBDen({
    required String startDate,
    required String endDate,
  }) async {
    final result = await _QLVBRepo.getVBDen(startDate, endDate);
    result.when(
      success: (res) {
        DocumentDashboardModel dataVbDen = res;
        chartDataVbDen.add(
          ChartData(
            S.current.cho_xu_ly,
            dataVbDen.soLuongChoXuLy?.toDouble() ?? 0,
            choXuLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.dang_xu_ly,
            dataVbDen.soLuongDangXuLy?.toDouble() ?? 0,
            dangXyLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDen.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.cho_vao_so,
            dataVbDen.soLuongChoVaoSo?.toDouble() ?? 0,
            choVaoSoColor,
          ),
        );
        _getVbDen.sink.add(dataVbDen);
      },
      error: (err) {
        return;
      },
    );
  }
}
