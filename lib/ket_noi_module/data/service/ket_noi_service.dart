import 'package:ccvc_mobile/ket_noi_module/data/response/list_chung_ket_noi_response.dart';
import 'package:ccvc_mobile/ket_noi_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'ket_noi_service.g.dart';

@RestApi()
abstract class KetNoiService {
  @factoryMethod
  factory KetNoiService(Dio dio, {String baseUrl}) = _KetNoiService;

  @GET(ApiConstants.KETNOI)
  @FormUrlEncoded()
  Future<ListChungKetNoiResponse> getListChungKetNoi(
    @Query('pageIndex') int pageIndex,
    @Query('pageSize') int pageSize,
    @Query('type') String type,
  );
}
