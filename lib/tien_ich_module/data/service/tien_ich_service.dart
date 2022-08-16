import 'dart:io';

import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/chuyen_vb_thanh_giong_noi_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/count_dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/danh_sach_hssd_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/detail_huong_dan_su_dung_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/lich_am_duong_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/list_nguoi_thuc_hien_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/nhom_cv_moi_dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/post_anh_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/todo_list_get_all_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/todo_response.dart';
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
  Future<ToDoListResponseTwo> getTodoList();

  @PUT(ApiConstants.TODO_LIST_UPDATE)
  @FormUrlEncoded()
  Future<ToDoListUpdateResponseTwo> updateTodoList(
    @Body() ToDoListRequest toDoListRequest,
  );

  @POST(ApiConstants.TODO_LIST_CREATE)
  @FormUrlEncoded()
  Future<ToDoListUpdateResponseTwo> createTodoList(
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

  @GET(ApiConstants.NHOM_CV_MOI)
  @FormUrlEncoded()
  Future<NhomCVMoiDSCVResponse> NhomCVMoi();

  @GET(ApiConstants.TODO_LIST_CURRENT_USER)
  @FormUrlEncoded()
  Future<ToDoListDSCVResponse> getTodoListDSCV();

  @GET(ApiConstants.GAN_CONG_VIEC_CHO_TOI)
  @FormUrlEncoded()
  Future<ToDoListDSCVResponse> getListDSCVGanChoToi();

  @DELETE(ApiConstants.XOA_CONG_VIEC)
  Future<ToDoListUpdateResponseTwo> xoaCongViec(
    @Query('id') String id,
  );

  @POST(ApiConstants.TAO_NHOM_CONG_VIEC_MOI)
  @FormUrlEncoded()
  Future<ThemNhomCVMoiDSCVResponse> createNhomCongViecMoi(
    @Field('label') String label,
  );

  @PUT(ApiConstants.SUA_TEN_NHOM_CONG_VIEC_MOI)
  @FormUrlEncoded()
  Future<ThemNhomCVMoiDSCVResponse> updateLabelGroupTodoList(
    @Field('id') String id,
    @Field('label') String newLabel,
  );

  @DELETE(ApiConstants.XOA_NHOM_CONG_VIEC_MOI)
  @FormUrlEncoded()
  Future<ThemNhomCVMoiDSCVResponse> deleteGroupTodoList(
    @Query('id') String id,
  );

  @POST(ApiConstants.CHUYEN_VB_SANG_GIONG_NOI)
  @FormUrlEncoded()
  Future<ChuyenVBThanhGiongNoiResponse> chuyenVBSangGiongNoi(
    @Field('text') String text,
    @Field('voiceTone') String voiceTone,
  );

  @POST(ApiConstants.TRANSLATE_FILE)
  @MultiPart()
  Future<String> translateFile(
    @Part() File file,
    @Part() String target,
    @Part() String source,
  );

  @POST(ApiConstants.POST_FILE)
  @MultiPart()
  Future<PostAnhResponse> uploadFile(
    @Part() File fileUpload,
  );

  @POST(ApiConstants.POST_FILE_DSCV)
  @MultiPart()
  Future<PostAnhResponse> uploadFileDSCV(
    @Part() File fileUpload,
  );

  @GET(ApiConstants.GET_LICH_AM_DUONG)
  Future<DataLichAmDuongResponse> getLichAmDuong(
    @Query('dateStr') String date,
  );

  @GET(ApiConstants.CONG_VIEC_GAN_CHO_NGUOI_KHAC)
  @FormUrlEncoded()
  Future<ToDoListDSCVResponse> getListDSCVGanChoNguoiKhac();

  @POST(ApiConstants.GET_ALL_CONG_VIEC_WITH_FILTER)
  Future<TodoGetAllResponse> getAllListDSCVWithFilter(
    @Field('pageIndex') int? pageIndex,
    @Field('pageSize') int? pageSize,
    @Field('searchWord') String? searchWord,
    @Field('isImportant') bool? isImportant,
    @Field('isForMe') bool? isForMe,
    @Field('inUsed') bool? inUsed,
    @Field('isTicked') bool? isTicked,
    @Field('groupId') String? groupId,
    @Field('isGiveOther') bool? isGiveOther,
  );

  @GET(ApiConstants.GET_COUNT_TODO)
  Future<CountTodoResponse> getCountTodo();
}

@RestApi()
abstract class TienIchServiceUAT {
  @factoryMethod
  factory TienIchServiceUAT(Dio dio, {String baseUrl}) = _TienIchServiceUAT;
}

@RestApi()
abstract class TienIchServiceCommon {
  @factoryMethod
  factory TienIchServiceCommon(Dio dio, {String baseUrl}) =
      _TienIchServiceCommon;

  @GET(ApiConstants.LIST_NGUOI_THUC_HIEN)
  Future<ListNguoiThucHienResponse> getListNguoiThucHien(
    @Query('HoTenFilter') String hoTen,
    @Query('PageSize') int pageSize,
    @Query('PageIndex') int pageIndex,
  );

  @GET(ApiConstants.LIST_NGUOI_THUC_HIEN)
  Future<ListNguoiThucHienResponse> getCanBo(
      @Query('FilterBy') String Id,
      @Query('PageSize') int pageSize,
      @Query('PageIndex') int pageIndex,
      );

  @GET(ApiConstants.TREE_DANH_BA)
  @FormUrlEncoded()
  Future<TreeDanhBaResponse> treeDanhBa(
    @Query('soCap') int soCap,
    @Query('idDonViCha') String idDonViCha,
  );
}

@RestApi()
abstract class TienIchServiceGateWay {
  @factoryMethod
  factory TienIchServiceGateWay(Dio dio, {String baseUrl}) =
      _TienIchServiceGateWay;

  @POST(ApiConstants.TRANSLATE_DOCUMENT)
  @MultiPart()
  Future<String> translateDocument(
    @Part() String vanBan,
    @Part() String target,
    @Part() String source,
  );
}
