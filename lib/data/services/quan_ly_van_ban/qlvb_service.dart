import 'dart:io';

import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/cho_y_kien_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/comment_document_income_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/danh_sach_vb_di_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/danh_sach_y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_cap_nhat_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_huy_duyet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_ky_duyet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_thu_hoi_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_tra_lai_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_xin_y_kien_den_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/theo_doi_van_ban_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/thong_tin_gui_nhan_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbden_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbdi_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_den_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_di_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/luong_xu_ly/luong_xu_ly_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/luong_xu_ly/luong_xu_ly_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/up_load_anh/up_load_anh_response.dart';
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

  @POST(ApiConstants.DANH_SACH_VB_DI)
  Future<DanhSachVBDiResponse> getDanhSachVanBanDiDashBoard(
    @Body() DanhSachVBDiRequest danhSachVBDiRequest,
  );

  @POST(ApiConstants.UPDATE_Y_KIEN_XU_LY)
  Future<PostFileResponse> updateComment(
    @Body() UpdateCommentRequest listComment,
  );

  @POST(ApiConstants.CHO_Y_KIEN)
  Future<PostFileResponse> giveComment(
    @Body() GiveCommentRequest comment,
  );

  @POST(ApiConstants.TRA_LOI_Y_KIEN_VAN_BAN_DEN)
  Future<PostFileResponse> relayCommentDocumentIncome(
    @Body() RelayCommentRequest relay,
  );

  @GET(ApiConstants.CHI_TIET_VAN_BAN_DI)
  Future<ChiTietVanBanDiDataResponse> getDataChiTietVanBanDi(
      @Path('id') String id);

  @GET(ApiConstants.Y_KIEN_VAN_BAN_DI)
  Future<YKienXuLyResponse> getYKienXuLyVBDi(@Path('id') String id);

  @GET(ApiConstants.CHI_TIET_VAN_BAN_DEN)
  Future<ChiTietVanBanDenDataResponse> getDataChiTietVanBanDen(
    @Query('processId') String processId,
    @Query('taskId') String taskId,
    @Query('IsYKien') bool? isYKien,
  );

  @GET(ApiConstants.HOI_BAO_VAN_BAN_DEN)
  Future<HoiBaoVanBanResponse> getHoiBaoVanBanDen(
    @Query('processId') String processId,
  );

  @GET(ApiConstants.THONG_TIN_GUI_NHAN)
  Future<ThongTinGuiNhanDataResponse> getDataThongTinGuiNhan(
      @Path('id') String id);

  @GET(ApiConstants.THEO_DOI_VAN_BAN_DA_BAN_HANH)
  Future<DataTheoDoiVanBanResponse> getTheoDoiVanBan(
    @Path('myId') String myId,
    @Query('id') String id,
  );

  @GET(ApiConstants.LICH_SU_VAN_BAN_DEN)
  Future<DataLichSuVanBanResponse> getDataLichSuVanBanDen(
    @Query('processId') String processId,
    @Query('type') String type,
  );

  @POST(ApiConstants.UPLOAD_FILE_COMMON)
  @MultiPart()
  Future<PostFileResponse> postFile(
    @Part() List<File> path,
  );

  @GET(ApiConstants.GET_DANH_SACH_Y_KIEN)
  Future<DataDanhSachYKienXuLyResponse> getDataDanhSachYKien(
    @Query('vanBanId') String vanBanId,
  );

  @GET(ApiConstants.GET_LICH_SU_XIN_Y_KIEN)
  Future<LichSuXinYKienDenResponse> getLichSuXinYKien(
    @Query('Id') String vanBanId,
  );

  @GET(ApiConstants.LICH_SU_THU_HOI_VAN_BAN_DI)
  Future<DataLichSuThuHoiVanBanDiResponse> getLichSuThuHoiVanBanDi(
      @Path('id') String id, @Query('id') String vanBanId);

  @GET(ApiConstants.LICH_SU_TRA_LAI_VAN_BAN_DI)
  Future<DataLichSuTraLaiVanBanDiResponse> getLichSuTraLaiVanBanDi(
    @Path('id') String id,
    @Query('id') String vanBanId,
  );

  @GET(ApiConstants.LICH_SU_KY_DUYET_VAN_BAN_DI)
  Future<DataLichSuKyDuyetVanBanDiResponse> getLichSuKyDuyetVanBanDi(
      @Path('id') String id, @Query('id') String vanBanId);

  @GET(ApiConstants.LICH_SU_HUY_DUYET_VAN_BAN_DI)
  Future<DataLichSuHuyDuyetVanBanDiResponse> getLichSuHuyDuyetVanBanDi(
      @Path('id') String id, @Query('id') String vanBanId);

  @GET(ApiConstants.LICH_SU_CAP_NHAT_VAN_BAN_DI)
  Future<DataLichSuCapNhatVanBanDiResponse> getLichSuCapNhatVanBanDi(
      @Path('id') String id, @Query('id') String vanBanId);

  @GET(ApiConstants.LUONG_XU_LY_VAB_BAN_DI)
  Future<LuongXuLyVBDiResponse> getLuongXuLyVanBanDi(@Path('id') String id);

  @GET(ApiConstants.LUONG_XU_LY_VAN_BAN_DEN)
  Future<LuongXuLyVanBanDenResponse> getLuongXuLyVanBanDen(
      @Query('processId') String id);

  @POST(ApiConstants.BAO_CAO_THONG_KE_VAN_BAN_DON_VI)
  Future<VanBanDonViResponse> getDataVanBanDonVi(
    @Body() VanBanDonViRequest vanBanDonViRequest,
  );
}
