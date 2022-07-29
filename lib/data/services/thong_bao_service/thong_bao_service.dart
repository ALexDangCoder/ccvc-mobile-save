import 'package:ccvc_mobile/data/request/thong_bao/device_request.dart';
import 'package:ccvc_mobile/data/request/thong_bao/setting_notify_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/delete_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/thong_bao/setting_notify_response.dart';
import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_quan_trong_response.dart';
import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'thong_bao_service.g.dart';

@RestApi()
abstract class ThongBaoService {
  @factoryMethod
  factory ThongBaoService(Dio dio, {String baseUrl}) = _ThongBaoService;

  @GET(ApiConstants.SETTING_NOTIFY)
  Future<SettingNotifyResponse> getSettingNotify();

  @POST(ApiConstants.SETTING_NOTIFY)
  Future<TaoBaoCaoKetQuaResponse> postSettingNotify(
    @Body() SettingNotifyRequest body,
  );

  @GET(ApiConstants.GET_NOTIFY_APP_CODES)
  Future<ThongBaoResponse> getNotifyAppcodes();

  @GET(ApiConstants.GET_THONG_BAO_QUAN_TRONG)
  Future<ThongBaoQuanTrongResponse> getThongBaoQuanTrong(
    @Query('active') bool active,
    @Query('seen') int seen,
    @Query('currentPage') int currentPage,
    @Query('pageSize') int pageSize,
  );

  @GET(ApiConstants.GET_THONG_BAO_QUAN_TRONG)
  Future<ThongBaoQuanTrongResponse> getListThongBao(
    @Query('appCode') String appCode,
    @Query('active') bool active,
    @Query('seen') int seen,
    @Query('currentPage') int currentPage,
    @Query('pageSize') int pageSize,
  );

  @POST(ApiConstants.READ_ALL)
  Future<ChinhSuaBaoCaoKetQuaResponse> readAllNoti(
    @Query('appCode') String appCode,
  );

  @DELETE(ApiConstants.DELETE_NOTIFY)
  Future<TaoLichLamViecResponse> deleteNotify(
    @Query('notiId') String notiId,
  );

  @POST(ApiConstants.CREATE_DEVICE)
  Future<MessageResponse> createDevice(@Body() DeviceRequest body);

  @POST(ApiConstants.UPDATE_DEVICE)
  Future<TaoBaoCaoKetQuaResponse> updateDevice(@Body() DeviceRequest body);
}
