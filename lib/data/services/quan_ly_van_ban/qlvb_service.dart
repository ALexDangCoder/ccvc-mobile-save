import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/danh_sach_vb_di_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/thong_tin_gui_nhan_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbden_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbdi_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_den_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
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
  Future<DoashBoashVBDenResponse> getVbDen(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @GET(
    ApiConstants.DASH_BOARD_VBDi,
  )
  Future<DoashBoashVBDiResponse> getVbDi(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @POST(ApiConstants.DANH_SACH_VB_DEN)
  Future<DanhSachVBDenResponse> getListVBDen();

  @POST(ApiConstants.DANH_SACH_VB_DI)
  Future<DanhSachVBDiResponse> getListVBDi(
    @Body() DanhSachVBDiRequest danhSachVBDiRequest,
  );

  @POST(ApiConstants.DANH_SACH_VB_DEN)
  @FormUrlEncoded()
  Future<DanhSachVBDenResponse> getDanhSachVanBanDen(
    @Body() DanhSachVBRequest danhSachVBDenRequest,
  );

  @POST(ApiConstants.DANH_SACH_VB_DI)
  Future<DanhSachVBDiResponse> getDanhSachVanBanDi(
    @Body() DanhSachVBDiRequest danhSachVBDiRequest,
  );

  @GET(ApiConstants.CHI_TIET_VAN_BAN_DI)
  Future<ChiTietVanBanDiDataResponse> getDataChiTietVanBanDi(
      @Path('id') String id);

  @GET(ApiConstants.CHI_TIET_VAN_BAN_DEN)
  Future<ChiTietVanBanDenDataResponse> getDataChiTietVanBanDen(
      @Query('processId') String processId,
      @Query('taskId') String taskId,
      @Query('IsYKien') bool isYKien,
      );
  @GET(ApiConstants.THONG_TIN_GUI_NHAN)
  Future<ThongTinGuiNhanDataResponse> getDataThongTinGuiNhan(
      @Path('id') String id);

  @GET(ApiConstants.LICH_SU_VAN_BAN_DEN)
  Future<DataLichSuVanBanResponse> getDataLichSuVanBanDen(
      @Query('processId') String processId,
      @Query('type') String type,
      );
}
