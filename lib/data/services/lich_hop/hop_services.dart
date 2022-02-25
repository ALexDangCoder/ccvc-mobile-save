import 'dart:convert';

import 'package:ccvc_mobile/data/request/lich_hop/add_file_tao_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/response/lich_hop/add_file_tao_lich_hop.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/so_luong_phat_bieu_response.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dash_board_lh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/select_phien_hop_response.dart';
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
      @Body() CatogoryListRequest catogoryListRequest);

  @POST(ApiConstants.SEARCH_CAN_BO)
  Future<NguoiChuTriResponse> getNguoiChuTri(
      @Body() NguoiChuTriRequest nguoiChuTriRequest);

  @GET(ApiConstants.DANH_SACH_CAN_BO_LICH_HOP)
  Future<DanhSachCanBoHopResponse> getDanhSachChuTri(@Query('id') String id);

  @POST(ApiConstants.POST_DANH_SACH_LICH_HOP)
  Future<AddFileTaoLichHopResponse> postFile(
    @Body() AddFileTaoLichHopRequest addFileTaoLichHopRequest,
  );
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

  @GET(ApiConstants.SO_LUONG_PHAT_BIEU)
  Future<SoLuongPhatBieuResponse> getSoLuongPhatBieu(@Query('id') String id);

  @GET(ApiConstants.TONG_PHIEN_HOP)
  Future<TongPhienHopResponse> getTongPhienHop(@Query('LichHopId') String id);

  @GET(ApiConstants.SELECT_PHIEN_HOP)
  Future<SelectPhienHopResponse> selectPhienHop(@Query('scheduleId') String id);

  @POST(ApiConstants.THEM_Y_KIEN_HOP)
  Future<ThemYKienResponse> themYKien(
      @Body() ThemYKienRequest themYKienRequest);

  @GET(ApiConstants.TONG_PHIEN_HOP)
  Future<DanhSachPhienHopResponse> getListPhienHop(
      @Query('LichHopId') String id);

}
