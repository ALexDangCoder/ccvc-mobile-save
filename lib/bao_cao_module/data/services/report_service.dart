import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/request/users_ngoai_he_thong_truy_cap_truy_cap_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/appid_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/can_bo_chia_se_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/ds_user_ngoai_he_thong_duoc_truy_cap_res.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/folder_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/group_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/list_tree_report_respose.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/report_detail_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/report_response.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'report_service.g.dart';

@RestApi()
abstract class ReportService {
  @factoryMethod
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @GET(ApiConstants.LIST_REPORT)
  Future<ReportResponse> getListReport(
    @Query('folderId') String folderId,
    @Query('sort') int sort,
    @Query('keyWord') String keyWord,
    @Header('AppId') String appId,
  );

  @GET(ApiConstants.LIST_REPORT_SHARE_TO_ME)
  Future<ReportResponse> getListReportShareToMe(
      @Query('folderId') String folderId,
      @Query('sort') int sort,
      @Query('keyWord') String keyWord,
      @Header('AppId') String appId,
      );

  @POST(ApiConstants.LIST_GROUP_BAO_CAO)
  Future<GroupImplResponse> getListGroup(
    @Field('appId') String appId,
    @Field('pageIndex') String pageIndex,
    @Field('pageSize') String pageSize,
  );

  @GET(ApiConstants.LIST_THANH_VIEN_BAO_CAO)
  Future<GroupImplResponse> getListThanhVien(
    @Query('groupId') String groupId,
    @Query('pageIndex') String pageIndex,
    @Query('pageSize') String pageSize,
  );

  @GET(ApiConstants.GET_APP_ID)
  Future<AppIdResponse> getHTCS(
    @Query('Code') String code,
  );

  @GET(ApiConstants.GET_FOLDER_ID)
  Future<FolderResponse> getFolderID(
    @Header('AppId') String appId,
  );

  @POST(ApiConstants.POST_LIKE_REPORT)
  Future<dynamic> postLikeReport(
    @Body() List<String> idReport,
    @Header('AppId') String appId,
  );

  @PUT(ApiConstants.PUT_DISLIKE_REPORT)
  Future<dynamic> putDisLikeReport(
    @Body() List<String> idReport,
    @Header('AppId') String appId,
  );

  @GET(ApiConstants.GET_LIST_REPORT_FAVORITE)
  Future<ReportResponse> getListReportFavorite(
    @Header('AppId') String appId,
    @Query('folderId') String folderId,
  );

  @GET(ApiConstants.GET_LIST_TREE_REPORT)
  Future<ListTreeReportResponse> getListReportTree(
    @Header('AppId') String appId,
    @Query('folderId') String folderId,
  );

  @POST(ApiConstants.CREATE_NEW_USER)
  Future<PostDataResponse> addNewUser(
    @Body() Map<String, String> mapUser,
    @Header('AppId') String appId,
  );

  @POST('${ApiConstants.SHARE_REPORT}/{idReport}')
  Future<PostDataResponse> shareReport(
    @Path() String idReport,
    @Body() List<ShareReport> mapData,
    @Header('AppId') String appId,
  );

  @POST(ApiConstants.GET_DS_NGOAI_HE_THONG_DUOC_TRUY_CAP)
  Future<UserNgoaiHeThongTruyCapTotalResponse> getUsersNgoaiHeThongDuocTruyCap(
    @Header('AppId') String appId,
    @Body() UsersNgoaiHeThongTruyCapRequest request,
  );

  @GET(ApiConstants.REPORT_DETAIL)
  Future<ReportDetailResponse> getReportDetail(
    @Header('AppId') String appId,
    @Query('id') String idReport,
  );


}
