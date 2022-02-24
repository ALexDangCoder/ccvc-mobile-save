import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/trang_thai/trang_thai_lv_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_lich_lam_viec_response.dart';

import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tinh_trang_bao_cao_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_moi_ban_ghi_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
import 'package:ccvc_mobile/data/request/list_lich_lv/list_lich_lv_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/delete_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/huy_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/list_lich_lv/list_lich_lv_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'lich_lam_viec_service.g.dart';

@RestApi()
abstract class LichLamViecService {
  @factoryMethod
  factory LichLamViecService(Dio dio, {String baseUrl}) = _LichLamViecService;

  @GET(ApiConstants.LICH_LAM_VIEC_DASHBOARD)
  Future<LichLamViecDashBroadResponse> getLichLamViec(
    @Query('dateStart') String dateStart,
    @Query('dateTo') String dateTo,
  );

  @POST(ApiConstants.LICH_LAM_VIEC_DASHBOARD_RIGHT)
  Future<LichLamViecDashBroadRightResponse> getLichLamViecRight(
    @Query('dateStart') String dateStart,
    @Query('dateTo') String dateTo,
    @Query('type') int type,
  );

  @POST(ApiConstants.POST_DANH_SACH_LICH_LAM_VIEC)
  Future<DanhSachLichLamViecResponse> postData(
    @Body() DanhSachLichLamViecRequest bodyDanhSachLichLamViec,
  );

  @POST(ApiConstants.CATEGORY_LIST)
  Future<CatogoryListResponse> getLoaiLichLamViec(
    @Body() CatogoryListRequest catogoryListRequest,
  );

  @POST(ApiConstants.SEARCH_CAN_BO)
  Future<NguoiChuTriResponse> getNguoiChuTri(
      @Body() NguoiChuTriRequest nguoiChuTriRequest,);

  @POST(ApiConstants.SCHEDULE_FIELD)
  Future<CatogoryListResponse> getLinhVuc(
      @Body() CatogoryListRequest catogoryListRequest,);

  @GET(ApiConstants.CHI_TIET_LICH_LAM_VIEC)
  Future<DetailCalenderWorkResponse> detailCalenderWork(@Path('id') String id);

  @GET(ApiConstants.SCHEDULE_REPORT_LIST)
  Future<DanhSachBaoCaoResponse> getDanhSachBaoCaoKetQua(
    @Query('scheduleId') String scheduleId,
  );

  @DELETE(ApiConstants.DELETE_SCHEDULE_REPORT)
  Future<XoaBaoCaoKetQuaResponse> deleteBaoCaoKetQua(@Query('id') String id);

  @POST(ApiConstants.LIST_LICH_LV)
  Future<ListLichLvResponse> getListLichLv(
    @Body() ListLichLvRequest lichLvRequest,
  );

  @DELETE(ApiConstants.XOA_LICH_LAM_VIEC)
  Future<DeleteCalenderWorkResponse> deleteCalenderWork(@Path('id') String id);

  @GET(ApiConstants.CANCEL_TIET_LICH_LAM_VIEC)
  Future<CancelCalenderWorkResponse> cancelCalenderWork(@Path('id') String id);

  @GET(ApiConstants.SCHEDULE_OPINION_LIST)
  Future<DanhSachYKienResponse> getDanhSachYKien(
      @Query('scheduleId') String scheduleId,);

  @PUT(ApiConstants.UPDATE_SCHEDULE_REPORT)
  @MultiPart()
  Future<ChinhSuaBaoCaoKetQuaResponse> updateBaoCaoKetQua(
    @Part() String ReportStatusId,
    @Part() String ScheduleId,
    @Part() String Content,
    @Part() List<File> Files,
    @Part() List<String> FilesDelete,
    @Part() String id,
  );

  @GET(ApiConstants.REPORT_STATUS_LIST)
  Future<ListTinhTrangResponse> getListTinhTrangBaoCao();

  @GET(ApiConstants.TRANG_THAI)
  Future<TrangThaiLVResponse> detailTrangThai();

  @POST(ApiConstants.TAO_MOI_BAN_GHI)
  Future<TaoMoiBanGhiResponse> taoMoiBanGhi(
    @Body() TaoMoiBanGhiRequest body,
  );
}
