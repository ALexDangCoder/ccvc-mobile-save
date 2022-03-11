import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_resquest.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_state.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class ChuDeCubit extends BaseCubit<ChuDeState> {
  ChuDeCubit() : super(ChuDeStateInitial());

  final BehaviorSubject<List<ChuDeModel>> _listYKienNguoiDan =
      BehaviorSubject<List<ChuDeModel>>();

  final BehaviorSubject<TuongTacThongKeResponseModel> _dataBaoCaoThongKe =
      BehaviorSubject<TuongTacThongKeResponseModel>();

  List<String> listTitle = [
    S.current.tin_tong_hop,
    S.current.cac_dia_phuong,
    S.current.uy_ban_nhan_dan_tinh,
    S.current.lanh_dao_tinh
  ];

  Stream<List<ChuDeModel>> get listYKienNguoiDan => _listYKienNguoiDan.stream;

  Stream<TuongTacThongKeResponseModel> get dataBaoCaoThongKe =>
      _dataBaoCaoThongKe.stream;

  String startDate = DateTime.now().formatApiStartDay;
  String endDate = DateTime.now().formatApiEndDay;

  String startDateBaoCaoThongKe = DateTime.now().formatApiSS;
  String endDateBaoCaoThongKe = DateTime.now().formatApiSS;

  DashBoardTatCaChuDeRequest dashBoardTatCaChuDeRequest =
      DashBoardTatCaChuDeRequest(
    pageIndex: 1,
    pageSize: 30,
    total: 2220,
    hasNextPage: true,
    fromDate: DateTime.now().formatApiSS,
    toDate: DateTime.now().formatApiSS,
  );
  final BaoChiMangXaHoiRepository _BCMXHRepo = Get.find();

  Future<void> getListTatCaCuDe(String startDate, String enDate) async {
    final result = await _BCMXHRepo.getDashListChuDe(
      1,
      30,
      233,
      true,
      startDate,
      enDate,
    );
    result.when(
      success: (res) {
        final result = res.getlistChuDe ?? [];
        _listYKienNguoiDan.sink.add(result);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getListBaoCaoThongKe(String startDate, String enDate) async {
    final result = await _BCMXHRepo.getTuongTacThongKe(
      1,
      30,
      49,
      true,
      startDate,
      enDate,
    );
    result.when(
      success: (res) {
        print('-------------------------------------------------- thanh cong----------------------');
        final result = res;
        _dataBaoCaoThongKe.sink.add(result);
      },
      error: (err) {
        print('-------------------------------------------------- that bai----------------------');
        return;
      },
    );
  }
}
