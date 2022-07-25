import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/check_trung_lich_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_di_thay_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/thu_hoi_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tinh_huyen_xa_request.dart';
import 'package:ccvc_mobile/data/request/them_y_kien_repuest/them_y_kien_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/data_config_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/delete_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/huy_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/trang_thai/trang_thai_lv_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/event_calendar_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/check_trung_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/cu_can_bo_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/menu_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/sua_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_moi_ban_ghi_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tinh_huyen_xa_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tinh_trang_bao_cao_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
import 'package:ccvc_mobile/data/response/list_lich_lv/list_lich_lv_response.dart';
import 'package:ccvc_mobile/data/response/them_y_kien_response/them_y_kien_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'lich_lam_viec_service.g.dart';

@RestApi()
abstract class WorkCalendarService {
  @factoryMethod
  factory WorkCalendarService(Dio dio, {String baseUrl}) = _WorkCalendarService;

  @GET(ApiConstants.LICH_LAM_VIEC_DASHBOARD)
  Future<LichLamViecDashBroadResponse> getLichLamViec(
    @Query('dateStart') String dateStart,
    @Query('dateTo') String dateTo,
  );

  @POST(ApiConstants.LICH_LAM_VIEC_DASHBOARD_RIGHT)
  Future<LichLamViecDashBroadRightResponse> getLichLamViecRight(
    @Body() LichLamViecRightRequest lamViecRightRequest,
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
    @Body() NguoiChuTriRequest nguoiChuTriRequest,
  );

  @POST(ApiConstants.EVENT_CALENDAR_LICH_LV)
  Future<EventCalendarResponse> postEventCalendar(
    @Body() EventCalendarRequest eventCalendarRequest,
  );

  @POST(ApiConstants.SCHEDULE_FIELD)
  Future<CatogoryListResponse> getLinhVuc(
    @Body() CatogoryListRequest catogoryListRequest,
  );

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
    @Body() DanhSachLichLamViecRequest danhSachLichLamViecRequest,
  );

//?scheduleId={id}&only=true&isLichLap=true&?
  @DELETE(ApiConstants.XOA_LICH_LAM_VIEC)
  Future<MessageResponse> deleteCalenderWork(
    @Query('scheduleId') String id,
    @Query('only') bool only,
  );

//?scheduleId={id}&statusId=8&isMulti=false
  @GET(ApiConstants.CANCEL_TIET_LICH_LAM_VIEC)
  Future<CancelCalenderWorkResponse> cancelCalenderWork(
    @Query('scheduleId') String id,
    @Query('statusId') int statusId,
    @Query('isMulti') bool isMulti,
  );

  @GET(ApiConstants.SCHEDULE_OPINION_LIST)
  Future<DanhSachYKienResponse> getDanhSachYKien(
      @Query('scheduleId') String scheduleId);

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

  @POST(ApiConstants.TAO_LICH_LAM_VIEC)
  @MultiPart()
  Future<TaoLichLamViecResponse> createWorkCalendar(
    @Body() FormData data,
    @Part() List<File> Files,
  );

  @POST(ApiConstants.CHECK_TRUNG_LICH_LICH_LAM_VIEC)
  Future<CheckTrungLichLamViecResponse> checkTrungLichLamviec(
    @Body() CheckTrungLichRequest data,
  );

  @PUT(ApiConstants.TAO_LICH_LAM_VIEC)
  Future<SuaLichLamViecResponse> suaLichLamviec(
    @Body() FormData data,
  );

  @POST(ApiConstants.TAO_BAO_KET_QUA)
  Future<TaoBaoCaoKetQuaResponse> taoBaoCaoKetQua(
    @Part() String ReportStatusId,
    @Part() String ScheduleId,
    @Part() String Content,
    @Part() List<File> Files,
  );

  @PUT(ApiConstants.SUA_BAO_CAO_KET_QUA)
  Future<TaoBaoCaoKetQuaResponse> suaBaoCaoKetQua(
    @Part() String ReportStatusId,
    @Part() String ScheduleId,
    @Part() String Content,
    @Part() List<File> Files,
    @Part() List<String> FilesDelete,
    @Part() String Id,
  );

  @POST(ApiConstants.TAO_MOI_BAN_GHI)
  Future<TaoMoiBanGhiResponse> taoMoiBanGhi(
    @Body() TaoMoiBanGhiRequest body,
  );

  @GET(ApiConstants.MENU_LICH_LV)
  Future<MenuResponse> getMenuLichLV(
    @Query('DateStart') String DateStart,
    @Query('DateTo') String DateTo,
  );

  @POST(ApiConstants.THEM_Y_KIEN)
  Future<ThemYKienResponse> themYKien(
    @Body() ThemYKienRequest themYKienRequest,
  );

  @POST(ApiConstants.TINH_SELECT)
  Future<PageDaTaTinhSelectModelResponse> tinhSelect(
    @Body() TinhSelectRequest tinhSelectRequest,
  );

  @POST(ApiConstants.HUYEN_SELECT)
  Future<PageDaTaHuyenSelectModelResponse> huyenSelect(
    @Body() HuyenSelectRequest huyenSelectRequest,
  );

  @POST(ApiConstants.XA_SELECT)
  Future<PageDaTaXaSelectModelResponse> xaSelect(
    @Body() WardRequest xaSelectRequest,
  );

  @POST(ApiConstants.DAT_NUOC_SELECT)
  Future<PageDataDatNuocSelectModelResponse> datNuocSelect(
    @Body() DatNuocSelectRequest datNuocSelectRequest,
  );

  @POST(ApiConstants.THU_HOI_LICH_LAM_VIEC)
  Future<MessageResponse> recallWorkCalendar(
    @Body() List<RecallRequest> request,
    @Query('isMulti') bool isMulti,
  );

  @GET(ApiConstants.CONFIG_SYSTEM)
  Future<DataConfigResponse> getConfigTime();

  @POST(ApiConstants.CU_CAN_BO_DI_THAY_LICH_LAM_VIEC)
  Future<CuCanBoLichLamViecResponse> cuCanBoDiThayLichLamViec(
    @Body() DataCuCanBoDiThayLichLamViecRequest cuCanBoDiThayRequest,
  );

  @POST(ApiConstants.CU_CAN_BO_DI_THAY_LICH_LAM_VIEC)
  Future<CuCanBoLichLamViecResponse> cuCanBoLichLamViec(
    @Body() DataCuCanBoLichLamViecRequest cuCanBoDiThayRequest,
  );
}
