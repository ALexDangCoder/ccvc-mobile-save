import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/list_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/menu_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/tin_tuc_thoi_su_response.dart';
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
  Future<DoashBoashTatCaChuDeResponse> getDashBoardTatCaChuDe(
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
    @Query('total') int total,
  );
}
