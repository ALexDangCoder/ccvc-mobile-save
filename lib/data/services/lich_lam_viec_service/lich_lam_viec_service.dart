import 'package:ccvc_mobile/data/request/list_lich_lv/list_lich_lv_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/huy_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec_dashbroad/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec_dashbroad/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/response/list_lich_lv/list_lich_lv_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'lich_lam_viec_service.g.dart';

@RestApi()
abstract class LichLamViecService {
  @factoryMethod
  factory LichLamViecService(Dio dio, {String baseUrl}) = _LichLamViecService;

  @GET(ApiConstants.LICH_LAM_VIEC_DASHBOARD)
  Future<LichLamViecDashBroadResponse> getLichLamViec(
    @Query('dateStart') String dateStart,
    @Query('dateTo') String dateTo,
  );

  @POST(ApiConstants.LICH_LAM_VIEC_DASHBOARD_RIGHT)
  Future<LichLamViecDashBroadRightResponse> getLichLamViecRight(
    @Query('dateStart') String dateStart,
    @Query('dateTo') String dateTo,
    @Query('type') int type,
  );

  @POST(ApiConstants.LIST_LICH_LV)
  Future<ListLichLvResponse> getListLichLv(
    @Body() ListLichLvRequest lichLvRequest,
  );

  @GET(ApiConstants.CANCEL_TIET_LICH_LAM_VIEC)
  Future<CancelCalenderWorkResponse> cancelCalenderWork(@Path('id') String id);
}
