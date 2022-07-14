import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/confirm_officer_request.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/confirm_officer_response.dart';
import 'package:ccvc_mobile/data/response/thanh_phan_tham_gia/can_bo_response.dart';
import 'package:ccvc_mobile/data/response/thanh_phan_tham_gia/officer_join_response.dart';
import 'package:ccvc_mobile/data/response/thanh_phan_tham_gia/tree_don_vi_tham_gia_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'thanh_phan_tham_gia_service.g.dart';

@RestApi()
abstract class ThanhPhanThamGiaService {
  @factoryMethod
  factory ThanhPhanThamGiaService(Dio dio, {String baseUrl}) =
      _ThanhPhanThamGiaService;

  @GET(ApiConstants.GET_TREE_DON_VI)
  Future<TreeDonViThamGiaResponse> getTreeDonVi(@Query('getAll') bool getAll);

  @POST(ApiConstants.SEARCH_CAN_BO)
  Future<SearchCanBoResponse> searchCanBo(
      @Body() SearchCanBoRequest searchCanBoRequest);

  @GET(ApiConstants.GET_LIST_USER_IN_UNIT)
  Future<SearchCanBoResponse> getUser(
      @Query('donViId') String id,
      @Query('appId') String appId,
      @Query('isGetAll') String isGetAll,
      @Query('pageIndex') String ipageIndexd,
      @Query('pageSize') String pageSize,
      );

  @GET(ApiConstants.OFFICERS_JOIN)
  Future<OfficerJoinResponse> getOfficerJoin(
    @Query('lichId') String id,
  );

  @POST(ApiConstants.CONFIRM_OFFICER)
  Future<ConfirmOfficerResponse> confirmOfficer(
    @Body() ConfirmOfficerRequest request,
  );
}
