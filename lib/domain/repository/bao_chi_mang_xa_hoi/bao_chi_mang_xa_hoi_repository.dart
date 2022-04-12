import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bao_cao_tong_quan_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/tin_tuc_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';

mixin BaoChiMangXaHoiRepository {
  Future<Result<DashBoardModel>> getDashBoardTatCaChuDe(
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

  Future<Result<TinTucRadioResponseModel>> getTinTucThoiSu(
    int pageIndex,
    int pageSize,
    String fromDate,
    String toDate,
    int topic,
  );

  Future<Result<TheoDoiBaiVietModel>> getBaiVietTheoDoi(
    int pageIndex,
    int pageSize,
    String fromDate,
    String toDate,
    int topic,
  );

  Future<Result<TinTucModel>> searchTinTuc(
    int pageIndex,
    int pageSize,
    String fromDate,
    String toDate,
    String keyword,
  );

  Future<Result<BaoCaoTongQuanModel>> tongQuanBaoCaoThongKe(
    String fromDate,
    String enddDate,
    int treeNode,
  );

  Future<Result<List<TinTongHopModel>>> tinTongHopBaoCaoThongKe(
      String fromDate,
      String enddDate,
      );
}
