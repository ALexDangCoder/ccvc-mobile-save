import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/danh_sach_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/tong_dai_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/group_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/support_detail_response.dart';
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

  @GET(ApiConstants.GET_TONG_DAI)
  Future<TongDaiResponse> getTongDai();

  @GET(ApiConstants.GET_SUPPORT_DETAIL)
  Future<SupportDetailResponse> getSupportDetail(
    @Query('id') String id,
  );

  @GET(ApiConstants.LIST_THANH_VIEN_BAO_CAO)
  Future<GroupImplResponse> getListThanhVien(
    @Query('groupId') String groupId,
    @Query('pageIndex') String pageIndex,
    @Query('pageSize') String pageSize,
  );
}
