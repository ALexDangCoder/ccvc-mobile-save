import 'package:ccvc_mobile/data/response/bao_cao/appid_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
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
}
