import 'package:ccvc_mobile/bao_cao_module/data/response/appid_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/can_bo_chia_se_response.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'report_common_service.g.dart';

@RestApi()
abstract class ReportCommonService {
  @factoryMethod
  factory ReportCommonService(Dio dio, {String baseUrl}) = _ReportCommonService;

  @GET(ApiConstants.GET_APP_ID)
  Future<AppIdResponse> getHTCS(
    @Query('Code') String code,
  );

  @GET(ApiConstants.GET_USER_PAGING)
  Future<CanBoChiaSeResponse> getUserPaging(
      @Query('donViId') String donViId,
      @Query('appId') String appId,
      @Query('hoTen') String hoTen,
      @Query('isGetAll') bool getAll,
      @Query('pageIndex') int pageIndex,
      @Query('pageSize') int pageSize,
      );
}
