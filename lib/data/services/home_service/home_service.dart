import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/home/nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/response/home/config_widget_dash_board_response.dart';
import 'package:ccvc_mobile/data/response/home/danh_sach_van_ban_response.dart';
import 'package:ccvc_mobile/data/response/home/dash_board_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/home/list_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/home/lunar_date_response.dart';
import 'package:ccvc_mobile/data/response/home/nhiem_vu_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/home/tinh_huong_khan_cap_response.dart';
import 'package:ccvc_mobile/data/response/home/tong_hop_nhiem_vu_response.dart';
import 'package:ccvc_mobile/data/response/home/van_ban_si_so_luong_response.dart';
import 'package:ccvc_mobile/data/response/home/y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_service.g.dart';

@RestApi()
abstract class HomeService {
  @factoryMethod
  factory HomeService(Dio dio, {String baseUrl}) = _HomeService;

  @POST(BaseUrlConstants.baseUrlGateway + ApiConstants.GET_PHAM_VI)
  @FormUrlEncoded()
  Future<PhamViResponse> getPhamVi();

  @GET(BaseUrlConstants.baseURLCCVC + ApiConstants.GET_LUNAR_DATE)
  @FormUrlEncoded()
  Future<LunarDateResponse> getLunarDate(@Query('inputDate') String inputDate);

  @GET(BaseUrlConstants.baseURLCCVC + ApiConstants.GET_TINH_HUONG_KHAN_CAP)
  @FormUrlEncoded()
  Future<TinhHuongKhanCapResponse> getTinhHuongKhanCap();

  @GET(BaseUrlConstants.baseURLCCVC + ApiConstants.GET_DASHBOARD_WIDGET)
  @FormUrlEncoded()
  Future<DashBoardResponse> getDashBoard();

  @GET(BaseUrlConstants.baseUrlGateway + ApiConstants.GET_DASHBOARD_VB_DEN)
  @FormUrlEncoded()
  Future<DashBoardVBDenResponse> getDashBoardVBDen(
      @Query('NgayDauTien') String ngayDauTien,
      @Query('NgayCuoiCung') String ngayCuoiCung);

  @GET(BaseUrlConstants.baseUrlGateway + ApiConstants.GET_VB_DI_SO_LUONG)
  @FormUrlEncoded()
  Future<VanBanDiSoLuongResponse> getDashBoardVBDi(
      @Query('NgayDauTien') String ngayDauTien,
      @Query('NgayCuoiCung') String ngayCuoiCung);

  @POST(BaseUrlConstants.baseUrlGateway + ApiConstants.GET_DANH_SACH_VAN_BAN)
  @FormUrlEncoded()
  Future<DanhSachVanBanResponse> getDanhSachVanBan(
    @Body() DanhSachVBRequest danhSachVBRequestm,
  );

  @POST(BaseUrlConstants.baseUrlGateway +
      ApiConstants.GET_DANH_SACH_VAN_BAN_SEARCH)
  @FormUrlEncoded()
  Future<SearchDanhSachVanBanResponse> searchDanhSachVanBan(
    @Body() SearchVBRequest searchVBRequest,
  );

  @GET(BaseUrlConstants.baseUrlGateway + ApiConstants.TONG_HOP_NHIEM_VU)
  @FormUrlEncoded()
  Future<TongHopNhiemVuResponse> getTongHopNhiemVu(
    @Query('isCaNhan') bool isCaNhan,
    @Query('ngayDauTien') String ngayDauTien,
    @Query('ngayCuoiCung') String ngayCuoiCung,
  );

  @POST(BaseUrlConstants.baseUrlGateway + ApiConstants.NHIEM_VU_GET_ALL)
  @FormUrlEncoded()
  Future<NhiemVuResponse> getNhiemVu(@Body() NhiemVuRequest nhiemVuRequest);

  @GET(BaseUrlConstants.baseUrlGateway + ApiConstants.TINH_HINH_XU_LY_TRANG_CHU)
  @FormUrlEncoded()
  Future<YKienNguoiDanResponse> getYKienNguoiDan(
      @Query('DonViId') String donViId,
      @Query('TuNgay') String tuNgay,
      @Query('DenNgay') String denNgay);

  @GET(BaseUrlConstants.baseUrlGateway + ApiConstants.DANH_SACH_PAKN)
  @FormUrlEncoded()
  Future<ListYKienNguoiDanResponse> getListYKienNguoiDan(
      @Query('pageSize') int pageSize,
      @Query('page') int page,
      @Query('trangThai') String trangThai,
      @Query('tuNgay') String tuNgay,
      @Query('denNgay') String denNgay,
      @Query('donViId') String donViId,
      @Query('userId') String userId,
      @Query('loaiMenu') String? loaiMenu
      );
}
