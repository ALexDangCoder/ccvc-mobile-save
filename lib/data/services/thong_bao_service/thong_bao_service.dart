import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_quan_trong_response.dart';
import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'thong_bao_service.g.dart';

@RestApi()
abstract class ThongBaoService {
  @factoryMethod
  factory ThongBaoService(Dio dio, {String baseUrl}) = _ThongBaoService;

  @GET(ApiConstants.GET_NOTIFY_APP_CODES)
  Future<ThongBaoResponse> getNotifyAppcodes();

  @GET(ApiConstants.GET_THONG_BAO_QUAN_TRONG)
  Future<ThongBaoQuanTrongResponse> getThongBaoQuanTrong(
    @Query('appCode') String appCode,
    @Query('active') bool active,
    @Query('seen') int seen,
    @Query('currentPage') int currentPage,
    @Query('pageSize') int pageSize,
  );
}
