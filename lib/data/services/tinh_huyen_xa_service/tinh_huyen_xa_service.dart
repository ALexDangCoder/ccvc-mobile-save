import 'package:ccvc_mobile/data/response/tinh_huyen_xa/tinh_huyen_xa_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'tinh_huyen_xa_service.g.dart';

@RestApi()
abstract class TinhHuyenXaService {
  @factoryMethod
  factory TinhHuyenXaService(Dio dio, {String baseUrl}) = _TinhHuyenXaService;

  @GET(ApiConstants.GET_TINH_HUYEN_XA)
  Future<TinhHuyenXaResponse> getData();

  @GET(ApiConstants.GET_TINH_HUYEN_XA)
  Future<TinhHuyenXaResponse> getDataChild(@Query('parentId') String parentId);
}
