import 'package:ccvc_mobile/data/response/home/config_widget_dash_board_response.dart';
import 'package:ccvc_mobile/data/response/home/dash_board_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/home/lunar_date_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/home/tinh_huong_khan_cap_response.dart';
import 'package:ccvc_mobile/data/response/home/van_ban_si_so_luong_response.dart';
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
}
