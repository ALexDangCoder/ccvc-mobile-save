import 'package:ccvc_mobile/data/response/bao_cao/appid_response.dart';
import 'package:ccvc_mobile/data/response/bao_cao/folder_response.dart';
import 'package:ccvc_mobile/data/response/bao_cao/group_response.dart';
import 'package:ccvc_mobile/data/response/bao_cao/report_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
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
    @Header("AppId") String appId,
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
    @Header("AppId") String appId,
  );
}
