import 'dart:convert';
import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/so_luong_phat_bieu_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';

import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/chi_tiet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/list_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thiet_bi_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thong_tin_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/xem_ket_luan_hop_response.dart';

import 'package:ccvc_mobile/data/response/lich_hop/chon_bien_ban_cuoc_hop_response.dart';

import 'package:ccvc_mobile/data/response/lich_hop/chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_bieu_quyet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phat_bieu_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dash_board_lh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/gui_mail_ket_luat-response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/moi_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/select_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_ket_luan_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_moi_bieu_quayet_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tong_phien_hop_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/list_phien_hop_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'hop_services.g.dart';

@RestApi()
abstract class HopServices {
  @factoryMethod
  factory HopServices(Dio dio, {String baseUrl}) = _HopServices;

  @GET(ApiConstants.GET_DASH_BOARD_LH)
  Future<DashBoardLichHopResponse> getData(
    @Query('dateStart') String dateStart,
    @Query('dateTo') String dateTo,
  );

  @POST(ApiConstants.POST_DANH_SACH_LICH_HOP)
  Future<DanhSachLichHopResponse> postData(
    @Body() DanhSachLichHopRequest bodyDSLH,
  );

  @POST(ApiConstants.CATEGORY_LIST)
  Future<CatogoryListResponse> getLoaiHop(
    @Body() CatogoryListRequest catogoryListRequest,
  );

  @POST(ApiConstants.SCHEDULE_FIELD)
  Future<CatogoryListResponse> getLinhVuc(
    @Body() CatogoryListRequest catogoryListRequest,
  );

  @POST(ApiConstants.SEARCH_CAN_BO)
  Future<NguoiChuTriResponse> getNguoiChuTri(
    @Body() NguoiChuTriRequest nguoiChuTriRequest,
  );

  @GET(ApiConstants.DANH_SACH_CAN_BO_LICH_HOP)
  Future<DanhSachCanBoHopResponse> getDanhSachChuTri(@Query('id') String id);

  @GET(ApiConstants.DANH_SACH_PHIEN_HOP)
  Future<ListPhienHopRespone> getDanhSachPhienHop(@Query('id') String id);

  @GET(ApiConstants.DETAIL_MEETING_SCHEDULE)
  Future<ChiTietLichHopResponse> getChiTietLichHop(@Query('id') String id);

  @POST(ApiConstants.THEM_PHIEN_HOP_CHI_TIET)
  Future<TaoPhienHopResponse> getThemPhienHop(
    @Query('lichHopId') String lichHopId,
    @Part() TaoPhienHopRepuest taoPhienHopRepuest,
  );

  @GET(ApiConstants.CHUONG_TRINH_HOP)
  Future<ChuongTrinhHopResponse> getChuongTrinhHop(@Query('id') String id);

  @GET(ApiConstants.MEETING_ROOM_DANH_SACH_PHONG_HOP)
  Future<ThongTinPhongHopResponse> getDanhSachPhongHop(
      @Query('lichHopId') String lichHopId);

  @GET(ApiConstants.MEETING_ROOM_DANH_SACH_THIET_BI)
  Future<ThietBiPhongHopResponse> getListThietBiPhongHop(
      @Query('lichHopId') String lichHopId);

  @GET(ApiConstants.DANH_SACH_PHAT_BIEU_LICH_HOP)
  Future<DanhSachPhatBieuLichHopDataResponse> getDanhSachPhatBieuLichHop(
    @Query('lichHopId') String lichHopId,
  );

  @GET(ApiConstants.DANH_SACH_BIEU_QUYET_LICH_HOP)
  Future<DanhSachBieuQuyetLichHopDataResponse> getDanhSachBieuQuyetLichHop(
    @Query('id') String id,
  );

  @GET(ApiConstants.SO_LUONG_PHAT_BIEU)
  Future<SoLuongPhatBieuResponse> getSoLuongPhatBieu(@Query('id') String id);

  @GET(ApiConstants.TONG_PHIEN_HOP)
  Future<TongPhienHopResponse> getTongPhienHop(@Query('LichHopId') String id);

  @GET(ApiConstants.SELECT_PHIEN_HOP)
  Future<SelectPhienHopResponse> selectPhienHop(@Query('scheduleId') String id);

  @GET(ApiConstants.DANH_SACH_LICH_HOP_TPTG)
  Future<ChuongTrinhHopResponse> getDanhSachCuocHopTPTH(@Query('id') String id);

  @POST(ApiConstants.THEM_Y_KIEN_HOP)
  Future<ThemYKienResponse> themYKien(
    @Body() ThemYKienRequest themYKienRequest,
  );

  @GET(ApiConstants.TONG_PHIEN_HOP)
  Future<DanhSachPhienHopResponse> getListPhienHop(
      @Query('LichHopId') String id);

  @POST(ApiConstants.THEM_BIEU_QUYET_HOP)
  Future<ThemMoiBieuQuyetResponse> themBieuQuyet(
      @Body() BieuQuyetRequest bieuQuyetRequest);

  @POST(ApiConstants.MOI_HOP)
  Future<MoiHopResponse> postMoiHop(
    @Query('lichHopId') String lichHopId,
    @Query('IsMultipe') bool IsMultipe,
    @Query('isSendMail') bool isSendMail,
    @Body() List<MoiHopRequest> body,
  );

  @POST(ApiConstants.SEND_EMAIL_KL_HOP)
  Future<GuiMailKetLuanHopResponse> sendMailKetLuatHop(
    @Query('id') String id,
  );

  @PUT(ApiConstants.SUA_KET_LUAN)
  @MultiPart()
  Future<SuaKetLuanResponse> suaKetLuan(
    @Part() String scheduleId,
    @Part() String content,
    @Part() String reportStatusId,
    @Part() String reportTemplateId,
    @Part() List<File> files,
  );

  @POST(ApiConstants.CHON_MAU_BIEN_BAN)
  Future<ChonBienBanCuocHopResponse> postChonMauBienBan(
    @Body() ChonBienBanHopRequest chonBienBanHopRequest,
  );

  @GET(ApiConstants.XEM_KET_LUAN_HOP)
  Future<XemKetLuanHopDataResponse> getXemKetLuanHop(@Query('id') String id);

  @GET(ApiConstants.DANH_SACH_KET_LUAN_HOP)
  Future<ListKetLuanHopResponse> getDanhSachKetLuanHop(
    @Query('id') String id,
  );
}
