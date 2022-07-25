import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/group_response.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'htcs_service.g.dart';

@RestApi()
abstract class HTCSService {
  @factoryMethod
  factory HTCSService(Dio dio, {String baseUrl}) = _HTCSService;

  @POST('${ApiConstants.SHARE_REPORT_HTCS}/{idReport}')
  Future<PostDataResponse> shareReport(
      @Path() String idReport,
      @Body() List<ShareReport> mapData,
      @Header('AppId') String appId,
      );
}
