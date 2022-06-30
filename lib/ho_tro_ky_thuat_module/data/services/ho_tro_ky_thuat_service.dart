import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/danh_sach_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'ho_tro_ky_thuat_service.g.dart';

@RestApi()
abstract class HoTroKyThuatService {
  @factoryMethod
  factory HoTroKyThuatService(Dio dio, {String baseUrl}) = _HoTroKyThuatService;

  @POST(ApiConstants.DANH_SACH_SU_CO)
  Future<DanhSachSuCoResponse> postDanhSachSuCo(
    @Field('pageIndex') int pageIndex,
    @Field('pageSize') int pageSize,
  );
}
