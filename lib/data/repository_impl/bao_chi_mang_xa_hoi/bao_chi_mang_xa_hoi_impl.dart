import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/list_chu_de_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_service.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';

class BaoChiMangXaHoiImpl implements BaoChiMangXaHoiRepository {
  final BaoChiMangXaHoiService _baoChiMangXaHoiService;

  BaoChiMangXaHoiImpl(this._baoChiMangXaHoiService);

  @override
  Future<Result<ListDashBoardItemModel>> getDashBoardTatCaChuDe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<DoashBoashTatCaChuDeResponse,
        ListDashBoardItemModel>(
      () => _baoChiMangXaHoiService.getDashBoardTatCaChuDe(
          pageIndex, pageSize, total, hasNextPage, fromDate, toDate,),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ListChuDeModel>> getDashListChuDe(
      int pageIndex,
      int pageSize,
      int total,
      bool hasNextPage,
      String fromDate,
      String toDate,) {
    return runCatchingAsync<ListChuDeResponse,
        ListChuDeModel>(
          () => _baoChiMangXaHoiService.getListTatCaChuDe(
          pageIndex, pageSize, total, hasNextPage, fromDate, toDate,),
          (res) => res.toDomain(),
    );
  }
}
