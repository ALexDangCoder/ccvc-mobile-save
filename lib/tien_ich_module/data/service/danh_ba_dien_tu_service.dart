import 'package:ccvc_mobile/tien_ich_module/data/request/sua_danh_sach_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/them_danh_ba_ca_nhan_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/danh_ba_dien_tu_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/them_danh_ba_ca_nhan_response.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'danh_ba_dien_tu_service.g.dart';

@RestApi()
abstract class DanhBaDienTuService {
  @factoryMethod
  factory DanhBaDienTuService(Dio dio, {String baseUrl}) = _DanhBaDienTuService;

  @GET(ApiConstants.GET_LIST_DANH_BA_CA_NHAN)
  Future<DanhBaResponse> getListDanhBaCaNhan(
    @Query('pageIndex') int pageIndex,
    @Query('pageSize') int pageSize,
  );

  @POST(ApiConstants.POST_DANH_BA_CA_NHAN)
  Future<ThemDanhBaCaNhanResponse> postThemDanhBaCaNhan(
    @Body() ThemDanhBaCaNhanRequest themDanhBaCaNhanRequest,
  );

  @PUT(ApiConstants.POST_DANH_BA_CA_NHAN)
  Future<ThemDanhBaCaNhanResponse> putDanhBaCaNhan(
    @Body() SuaDanhBaCaNhanRequest suaDanhBaCaNhanRequest,
  );
}