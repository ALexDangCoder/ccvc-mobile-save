import 'package:ccvc_mobile/home_module/data/response/home/todo_current_user_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/danh_sach_hssd_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/detail_huong_dan_su_dung_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/lich_am_duong_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/list_nguoi_thuc_hien_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/nhom_cv_moi_dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/topic_hdsd_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/tra_cuu_van_ban_phap_luat_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/tree_danh_ba_response.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'tien_ich_service.g.dart';

@RestApi()
abstract class TienIchService {
  @factoryMethod
  factory TienIchService(Dio dio, {String baseUrl}) = _TienIchService;

  @GET(ApiConstants.TOPIC_HDSD)
  Future<DataTopicHDSDResponse> getTopicHDSD();

  @GET(ApiConstants.TODO_LIST_CURRENT_USER)
  @FormUrlEncoded()
  Future<ToDoListResponse> getTodoList();

  @PUT(ApiConstants.TODO_LIST_UPDATE)
  @FormUrlEncoded()
  Future<ToDoListUpdateResponse> updateTodoList(
    @Body() ToDoListRequest toDoListRequest,
  );

  @POST(ApiConstants.TODO_LIST_CREATE)
  @FormUrlEncoded()
  Future<ToDoListUpdateResponse> createTodoList(
    @Body() CreateToDoRequest createToDoRequest,
  );

  @GET(ApiConstants.GET_DANH_SACH_HDSD)
  Future<DataDanhSachHDSDResponse> getDanhSachHDSD(
    @Query('pageIndex') int pageIndex,
    @Query('pageSize') int pageSize,
    @Query('topicId') String topicId,
    @Query('type') String type,
    @Query('searchKeyword') String searchKeyword,
  );

  @GET(ApiConstants.GET_DETAIL_HUONG_DAN_SU_DUNG)
  Future<DataDetailHuongDanSuDungResponse> getDetailHuongDanSuDung(
    @Query('id') String id,
  );

  @GET(ApiConstants.GET_TRA_CUU_VAN_BAN_PHAP_LUAT)
  Future<DataTraCuuVanBanPhapLuatResponse> getTraCuuVanBanPhapLuat(
    @Query('Title') String title,
    @Query('PageIndex') int pageIndex,
    @Query('PageSize') int pageSize,
  );
}

@RestApi()
abstract class TienIchServiceUAT {
  @factoryMethod
  factory TienIchServiceUAT(Dio dio, {String baseUrl}) = _TienIchServiceUAT;

  @GET(ApiConstants.GET_LICH_AM_DUONG)
  Future<DataLichAmDuongResponse> getLichAmDuong(
    @Query('dateStr') String date,
  );

  @GET(ApiConstants.NHOM_CV_MOI)
  @FormUrlEncoded()
  Future<NhomCVMoiDSCVResponse> NhomCVMoi();
}

@RestApi()
abstract class TienIchServiceCommon {
  @factoryMethod
  factory TienIchServiceCommon(Dio dio, {String baseUrl}) =
      _TienIchServiceCommon;

  @GET(ApiConstants.LIST_NGUOI_THUC_HIEN)
  @FormUrlEncoded()
  Future<ListNguoiThucHienResponse> getListNguoiThucHien(
    @Query('IsGetAll') bool isGetAll,
    @Query('PageSize') int pageSize,
    @Query('PageIndex') int pageIndex,
  );

  @GET(ApiConstants.TREE_DANH_BA)
  @FormUrlEncoded()
  Future<TreeDanhBaResponse> TreeDanhBa(
    @Query('soCap') int soCap,
  );
}
