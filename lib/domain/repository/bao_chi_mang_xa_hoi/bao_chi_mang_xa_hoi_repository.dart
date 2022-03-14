import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';

mixin BaoChiMangXaHoiRepository {
  Future<Result<ListDashBoardItemModel>> getDashBoardTatCaChuDe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  );

  Future<Result<ListChuDeModel>> getDashListChuDe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  );

  Future<Result<TuongTacThongKeResponseModel>> getTuongTacThongKe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  );

  Future<Result<List<ListMenuItemModel>>> getMenuBCMXH();
}
