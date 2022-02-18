import 'package:ccvc_mobile/data/request/quan_ly_van_ban/danh_sach_vb_di_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/dash_board_vb_den_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/dash_board_vb_di_request.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbden_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbdi_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_den_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_di_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'qlvb_service.g.dart';

@RestApi()
abstract class QuanLyVanBanClient {
  @factoryMethod
  factory QuanLyVanBanClient(Dio dio, {String baseUrl}) = _QuanLyVanBanClient;

  @GET(ApiConstants.DASH_BOARD_VBDEN)
  Future<DoashBoashVBDenResponse> getVbDen(@Body() VBDenRequest vbDenRequest);

  @GET(
    ApiConstants.DASH_BOARD_VBDi,
  )
  Future<DoashBoashVBDiResponse> getVbDi(@Body() VBDiRequest vbDiRequest);

  @POST(ApiConstants.DANH_SACH_VB_DEN)
  Future<DanhSachVBDenResponse> getListVBDen();

  @POST(ApiConstants.DANH_SACH_VB_DI)
  Future<DanhSachVBDiResponse> getListVBDi(
      @Body() DanhSachVBDiRequest danhSachVBDiRequest,);
  @POST(ApiConstants.DANH_SACH_VB_DEN)
  Future<DanhSachVBDenResponse> getDanhSachVanBanDen(
    @Body() DanhSachVBDiRequest danhSachVBDiRequest,
  );

  @POST(ApiConstants.DANH_SACH_VB_DI)
  Future<DanhSachVBDiResponse> getDanhSachVanBanDi(
    @Body() DanhSachVBDiRequest danhSachVBDiRequest,
  );
}
