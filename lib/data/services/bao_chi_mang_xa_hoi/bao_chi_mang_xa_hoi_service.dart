import 'package:ccvc_mobile/data/request/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_thoi_gian_request.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_sac_thai_line_chart_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_nguon_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_sac_thai_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_thoi_gian_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/thong_ke_theo_ty_le_nguon_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/tong_quan_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/list_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/menu_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/search_tin_tuc_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/theo_doi_bai_viet_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'bao_chi_mang_xa_hoi_service.g.dart';

@RestApi()
abstract class BaoChiMangXaHoiService {
  @factoryMethod
  factory BaoChiMangXaHoiService(Dio dio, {String baseUrl}) =
      _BaoChiMangXaHoiService;

  @GET(ApiConstants.DASH_BOARD_TAT_CA_CHU_DE)
  Future<List<DashBoardTatCaChuDeResponse>> getDashBoardTatCaChuDe(
    @Query('pageIndex') int pageInDex,
    @Query('pageSize') int pageSize,
    @Query('total') int total,
    @Query('hasNextPage') bool hasNextPage,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
  );

  @GET(ApiConstants.GET_LIST_TAT_CA_CHU_DE)
  Future<ListChuDeResponse> getListTatCaChuDe(
    @Query('pageIndex') int pageInDex,
    @Query('pageSize') int pageSize,
    @Query('total') int total,
    @Query('hasNextPage') bool hasNextPage,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
  );

  @GET(ApiConstants.BAO_CAO_THONG_KE)
  Future<String> getBaoCaoThongKe(
    @Query('pageIndex') int pageInDex,
    @Query('pageSize') int pageSize,
    @Query('total') int total,
    @Query('hasNextPage') bool hasNextPage,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
  );

  @GET(ApiConstants.MENU_BCMXH)
  Future<List<MenuBCMXHResponse>> getMenuBCMXH();

  @GET(ApiConstants.Tin_TUC_THOI_SU)
  Future<String> getTinTucThoiSu(
    @Query('pageIndex') int pageInDex,
    @Query('pageSize') int pageSize,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('topic') int total,
  );

  @GET(ApiConstants.BAI_VIET_THEO_DOI)
  Future<String> getTheoDoiBaiViet(
    @Query('pageIndex') int pageInDex,
    @Query('pageSize') int pageSize,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('topic') int total,
  );

  @GET(ApiConstants.SEARCH_TIN_TUC)
  Future<SearchTinTucResponse> searchTinTuc(
    @Query('pageIndex') int pageInDex,
    @Query('pageSize') int pageSize,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('keyword') String keyword,
  );

  @GET(ApiConstants.TONG_QUAN_BAO_CAO_BCMXH)
  Future<TongQuanDeResponse> baoCaoTongQuan(
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('treeNode') int treeNode,
  );

  @GET(ApiConstants.TIN_TONG_HOP_BAO_CAO_BCMXH)
  Future<String> tinTongHop(
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
  );

  @GET(ApiConstants.BAO_CAO_THEO_NGUON_BCMXH)
  Future<TyLeNguonResponse> baoCaoTheoNguon(
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('treeNode') int treeNode,
  );

  @GET(ApiConstants.BAO_CAO_THEO_SAC_THAI)
  Future<SacThaiResponse> baoCaoTheoSacThai(
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('treeNode') int treeNode,
  );

  @POST(ApiConstants.BAO_CAO_THEO_THOI_GIAN)
  Future<List<ThongKeTheoThoiGianResponse>> baoCaoTheoThoiGian(
    @Body() ThongKeTheoThoiGianRequest thoiGianRequest,
  );

  @GET(ApiConstants.BAO_CAO_THEO_NGUON_LINE_CHART)
  Future<ThongKeTheoNguonResponse> baoCaoLineChart(
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('treeNodes[0][id]') int treeNodeID,
    @Query('treeNodes[0][title]') String treeNodeTitle,
    @Query('sourceId') int sourceId,
  );

  @GET(ApiConstants.BAO_CAO_THEO_SAC_THAI_LINE_CHART)
  Future<ThongKeTheoSacThaiResponse> baoCaoTheoSacThaiLineChart(
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('treeNode') int treeNode,
  );

  @POST(ApiConstants.THEO_DOI_BAI_VIET)
  Future<BaiVietResponse> followTopic(
    @Query('url') String url,
  );
}
