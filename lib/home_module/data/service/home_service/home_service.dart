import 'package:ccvc_mobile/home_module/data/request/home/tong_hop_nhiem_vu_request.dart';
import 'package:ccvc_mobile/home_module/data/response/home/get_weather_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/nguoi_gan_response.dart';
import 'package:ccvc_mobile/home_module/data/response/home/van_ban_don_vi_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '/home_module/data/request/account/gui_loi_chuc_request.dart';
import '/home_module/data/request/home/danh_sach_cong_viec_resquest.dart';
import '/home_module/data/request/home/danh_sach_van_ban_den_request.dart';
import '/home_module/data/request/home/lich_hop_request.dart';
import '/home_module/data/request/home/lich_lam_viec_request.dart';
import '/home_module/data/request/home/nhiem_vu_request.dart';
import '/home_module/data/request/home/to_do_list_request.dart';
import '/home_module/data/response/home/bao_chi_mang_xa_hoi_response.dart';
import '/home_module/data/response/home/config_widget_dash_board_response.dart';
import '/home_module/data/response/home/danh_sach_cong_viec_response.dart';
import '/home_module/data/response/home/danh_sach_thiep_response.dart';
import '/home_module/data/response/home/danh_sach_van_ban_response.dart';
import '/home_module/data/response/home/dash_board_van_ban_den_response.dart';
import '/home_module/data/response/home/dashboard_tinh_hinh_pakn_response.dart';
import '/home_module/data/response/home/gui_loi_chuc_response.dart';
import '/home_module/data/response/home/lich_hop_response.dart';
import '/home_module/data/response/home/lich_lam_viec_response.dart';
import '/home_module/data/response/home/list_y_kien_nguoi_dan_response.dart';
import '/home_module/data/response/home/lunar_date_response.dart';
import '/home_module/data/response/home/nhiem_vu_response.dart';
import '/home_module/data/response/home/pham_vi_response.dart';
import '/home_module/data/response/home/sinh_nhat_user_response.dart';
import '/home_module/data/response/home/su_kien_response.dart';
import '/home_module/data/response/home/tinh_huong_khan_cap_response.dart';
import '/home_module/data/response/home/todo_current_user_response.dart';
import '/home_module/data/response/home/tong_hop_nhiem_vu_response.dart';
import '/home_module/data/response/home/van_ban_si_so_luong_response.dart';
import '/home_module/data/response/home/y_kien_nguoi_dan_response.dart';
import '/home_module/utils/constants/api_constants.dart';

part 'home_service.g.dart';

@RestApi()
abstract class HomeServiceGateWay {
  @factoryMethod
  factory HomeServiceGateWay(Dio dio, {String baseUrl}) = _HomeServiceGateWay;

  @GET(ApiConstants.GET_WEATHER)
  Future<WeatherResponse> getWeather(
    @Query('code') String code,
  );

  @GET(ApiConstants.DOASHBOARD_TINH_HINH_XU_LY_PAKN)
  Future<DashboardTinhHinhPAKNResponse> getDashboardTinhHinhPAKN(
      @Query('isDonVi') bool isDonVi);

  @GET(ApiConstants.DOASHBOARD_TINH_HINH_XU_LY_PAKN_CA_NHAN)
  Future<TinhHinhXuLyPAKNCaNhan> getDashboardTinhHinhPAKNCaNhan();

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

  @POST(ApiConstants.TONG_HOP_NHIEM_VU)
  @FormUrlEncoded()
  Future<TongHopNhiemVuResponse> getTongHopNhiemVu(
    @Body() TongHopNhiemVuRequest tongHopNhiemVuRequest,
  );

  @POST(ApiConstants.TINH_HINH_XU_LY_VAN_BAN)
  @FormUrlEncoded()
  Future<VanBanDonViResponse> getTinhHinhXuLyVanBan(
    @Query('CanBoId') String canBoId,
    @Query('DonViId') String donViId,
    @Query('startDate') String startDate,
    @Query('endDate') String endDate,
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
  Future<DanhSachCongViecResponse> getDanhSachCongViec(
      @Body() DanhSachCongViecRequest request);
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

  @GET(ApiConstants.GET_DASHBOARD_WIDGET)
  @FormUrlEncoded()
  Future<DashBoardResponse> getDashBoard();

  @POST(ApiConstants.GUI_LOI_CHUC)
  Future<GuiLoiChucResponse> guiLoiChuc(
      @Body() GuiLoiChucRequest guiLoiChucRequest);

  @GET(ApiConstants.GET_TIN_BUON)
  Future<TinhHuongKhanCapResponse> getTinBuon();

  @GET(ApiConstants.GET_LIST_THONG_TIN_THIEP)
  Future<DanhSachThiepResponse> getDanhSachThiep(
      @Query('pageIndex') int pageIndex, @Query('pageSize') int pageSize);

  @GET(ApiConstants.GET_LIST_CAN_BO)
  Future<NguoiGanResponse> getListNguoiGan(
    @Query('PageIndex') int pageIndex,
    @Query('PageSize') int pageSize,
    @Query('IsGetAll') bool isGetAll,
  );
}

@RestApi()
abstract class HomeServiceCommon {
  @factoryMethod
  factory HomeServiceCommon(Dio dio, {String baseUrl}) = _HomeServiceCommon;

  @GET(ApiConstants.GET_LIST_CAN_BO)
  Future<NguoiGanResponse> getListNguoiGan(
    @Query('PageIndex') int pageIndex,
    @Query('PageSize') int pageSize,
    @Query('IsGetAll') bool isGetAll,
    @Query('FilterBy') String keyFilter,
  );
}
