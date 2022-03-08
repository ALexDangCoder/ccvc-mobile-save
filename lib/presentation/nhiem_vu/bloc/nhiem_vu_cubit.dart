import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:rxdart/rxdart.dart';

class NhiemVuCubit extends BaseCubit<NhiemVuState> {
  NhiemVuCubit() : super(const NhiemVuStateIntial());

  final BehaviorSubject<ChartData> _dataChartNhiemVu =
      BehaviorSubject<ChartData>();
  BehaviorSubject<List<bool>> selectTypeNhiemVuSubject =
      BehaviorSubject.seeded([true, false]);

  Stream<ChartData> get dataChartNhiemVu => _dataChartNhiemVu.stream;
  final List<ChartData> chartDataNhiemVu = [
    ChartData(
      S.current.cho_phan_xu_ly,
      30,
      choXuLyColor,
    ),
    ChartData(
      S.current.da_thuc_hien,
      12,
      daXuLyColor,
    ),
    ChartData(
      S.current.dang_thuc_hien,
      14,
      yellowColor,
    ),
  ];
  final List<ChartData> chartDataCongViec = [
    ChartData(
      S.current.chua_thuc_hien,
      30,
      yellowColor,
    ),
    ChartData(S.current.dang_thuc_hien, 14, dangThucHienPurble),
    ChartData(
      S.current.da_thuc_hien,
      12,
      daXuLyColor,
    ),
  ];
}
