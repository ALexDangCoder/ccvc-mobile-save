import 'package:ccvc_mobile/data/request/home/danh_sach_cong_viec_resquest.dart';
import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/home/lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/home/lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/home/nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/home/to_do_list_request.dart';
import 'package:ccvc_mobile/data/response/home/bao_chi_mang_xa_hoi_response.dart';
import 'package:ccvc_mobile/data/response/home/config_widget_dash_board_response.dart';
import 'package:ccvc_mobile/data/response/home/danh_sach_cong_viec_response.dart';
import 'package:ccvc_mobile/data/response/home/danh_sach_van_ban_response.dart';
import 'package:ccvc_mobile/data/response/home/dash_board_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/home/lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/home/lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/home/list_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/home/lunar_date_response.dart';
import 'package:ccvc_mobile/data/response/home/nhiem_vu_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/home/sinh_nhat_user_response.dart';
import 'package:ccvc_mobile/data/response/home/su_kien_response.dart';
import 'package:ccvc_mobile/data/response/home/tinh_huong_khan_cap_response.dart';
import 'package:ccvc_mobile/data/response/home/todo_current_user_response.dart';
import 'package:ccvc_mobile/data/response/home/tong_hop_nhiem_vu_response.dart';
import 'package:ccvc_mobile/data/response/home/van_ban_si_so_luong_response.dart';
import 'package:ccvc_mobile/data/response/home/y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_service.g.dart';

@RestApi()
abstract class HomeServiceGateWay {
  @factoryMethod
  factory HomeServiceGateWay(Dio dio, {String baseUrl}) = _HomeServiceGateWay;

  @POST(ApiConstants.GET_PHAM_VI)
  @FormUrlEncoded()
  Future<PhamViResponse> getPhamVi();

  @GET(ApiConstants.GET_DASHBOARD_VB_DEN)
  @FormUrlEncoded()
  Future<DashBoardVBDenResponse> getDashBoardVBDen(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @GET(ApiConstants.GET_VB_DI_SO_LUONG)
  @FormUrlEncoded()
  Future<VanBanDiSoLuongResponse> getDashBoardVBDi(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @POST(ApiConstants.GET_DANH_SACH_VAN_BAN)
  @FormUrlEncoded()
  Future<DanhSachVanBanResponse> getDanhSachVanBan(
    @Body() DanhSachVBRequest danhSachVBRequestm,
  );

  @POST(ApiConstants.GET_DANH_SACH_VAN_BAN_SEARCH)
  @FormUrlEncoded()
  Future<SearchDanhSachVanBanResponse> searchDanhSachVanBan(
    @Body() SearchVBRequest searchVBRequest,
  );

  @GET(ApiConstants.TONG_HOP_NHIEM_VU)
  @FormUrlEncoded()
  Future<TongHopNhiemVuResponse> getTongHopNhiemVu(
    @Query('isCaNhan') bool isCaNhan,
    @Query('ngayDauTien') String ngayDauTien,
    @Query('ngayCuoiCung') String ngayCuoiCung,
  );

  @POST(ApiConstants.NHIEM_VU_GET_ALL)
  @FormUrlEncoded()
  Future<NhiemVuResponse> getNhiemVu(@Body() NhiemVuRequest nhiemVuRequest);

  @GET(ApiConstants.TINH_HINH_XU_LY_TRANG_CHU)
  @FormUrlEncoded()
  Future<YKienNguoiDanResponse> getYKienNguoiDan(
    @Query('DonViId') String donViId,
    @Query('TuNgay') String tuNgay,
    @Query('DenNgay') String denNgay,
  );

  @GET(ApiConstants.DANH_SACH_PAKN)
  @FormUrlEncoded()
  Future<ListYKienNguoiDanResponse> getListYKienNguoiDan(
    @Query('pageSize') int pageSize,
    @Query('page') int page,
    @Query('trangThai') String trangThai,
    @Query('tuNgay') String tuNgay,
    @Query('denNgay') String denNgay,
    @Query('donViId') String donViId,
    @Query('userId') String userId,
    @Query('loaiMenu') String? loaiMenu,
  );

  @POST(ApiConstants.DANH_SACH_LICH_LAM_VIEC)
  @FormUrlEncoded()
  Future<LichLamViecResponse> getLichLamViec(
    @Body() LichLamViecRequest lamViecRequest,
  );

  @POST(ApiConstants.CANLENDAR_LIST_MEETING)
  @FormUrlEncoded()
  Future<LichHopResponse> getLichHop(@Body() LichHopRequest lichHopRequest);

  @POST(ApiConstants.DANH_SACH_CONG_VIEC)
  Future<DanhSachCongViecResponse> getDanhSachCongViec(@Body() DanhSachCongViecRequest request);
}

@RestApi()
abstract class HomeServiceCCVC {
  @factoryMethod
  factory HomeServiceCCVC(Dio dio, {String baseUrl}) = _HomeServiceCCVC;

  @GET(ApiConstants.SINH_NHAT_DASHBOARD)
  @FormUrlEncoded()
  Future<SinhNhatUserResponse> getSinhNhat(
    @Query('DateFrom') String dateFrom,
    @Query('DateTo') String dateTo,
  );

  @GET(ApiConstants.SU_KIEN_TRONG_NGAY)
  @FormUrlEncoded()
  Future<SuKienResponse> getSuKien(
    @Query('DateFrom') String dataFrom,
    @Query('DateTo') String dateTo,
  );

  @GET(ApiConstants.SEARCH_NEW)
  @FormUrlEncoded()
  Future<BaoChiMangXaHoiResponse> getBaoChiMangXaHoi(
    @Query('pageIndex') int pageIndex,
    @Query('pageSize') int pageSize,
    @Query('fromDate') String fromDate,
    @Query('toDate') String toDate,
    @Query('keyword') String keyWord,
  );

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

  @GET(ApiConstants.TODO_LIST_CURRENT_USER)
  @FormUrlEncoded()
  Future<ToDoListResponse> getTodoList();

  @GET(ApiConstants.GET_LUNAR_DATE)
  @FormUrlEncoded()
  Future<LunarDateResponse> getLunarDate(@Query('inputDate') String inputDate);

  @GET(ApiConstants.GET_TINH_HUONG_KHAN_CAP)
  @FormUrlEncoded()
  Future<TinhHuongKhanCapResponse> getTinhHuongKhanCap();

  @GET(ApiConstants.GET_DASHBOARD_WIDGET)
  @FormUrlEncoded()
  Future<DashBoardResponse> getDashBoard();

}
