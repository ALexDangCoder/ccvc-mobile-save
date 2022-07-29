import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/cap_nhat_trang_thai_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/cu_can_bo_di_thay_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_thong_ke_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_theo_doi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/phan_cong_thu_ky_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/sua_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_moi_vote_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/so_luong_phat_bieu_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/add_file_tao_lich_hop.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/cap_nhat_trang_thai_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/chi_tiet_bieu_quyet_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/chi_tiet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_can_bo_bieu_quyet_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_nhiem_vu_Chi_tiet_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_nhiem_vu_kl_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_y_kien_lich_hop.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/file_upload_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/list_status_room_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/phan_cong_thu_ky_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/status_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/sua_bieu_quyet_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/them_moi_vote_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thiet_bi_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thong_tin_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/xem_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/xoa_bieu_quyet_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chon_bien_ban_cuoc_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/co_cau_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/cu_can_bo_di_thay_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_bieu_quyet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_nguoi_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phat_bieu_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dash_board_lh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dashborad_thong_ke_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/duyet_lich_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/event_calendar_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/gui_mail_ket_luat-response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_dang_theo_doi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_theo_doi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/select_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/statistic_by_month_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_ket_luan_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_hop/danh_sach_don_vi_con_phong_res.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_hop/phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_hop/them_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/thanh_phan_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_moi_bieu_quayet_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/thong_ke_linh_vuc_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/ti_le_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/to_chuc_boi_don_vi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tong_phien_hop_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/xoa_chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/list_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/menu_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
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

  @POST(ApiConstants.POST_DANH_SACH_THONG_KE)
  Future<DanhSachLichHopResponse> postDataThongKe(
    @Body() DanhSachThongKeRequest bodyDSLH,
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

  @POST(ApiConstants.SEARCH_CAN_BO)
  Future<NguoiTheoDoiLHResponse> getNguoiTheoDoi(
    @Body() NguoiTheoDoiRequest nguoiTheoDoiRequest,
  );

  @GET(ApiConstants.NGUOI_DANG_THEO_DOI)
  Future<NguoiDangTheoDoiResponse> getNguoiDangTheoDoi(
    @Query('type') String type,
    @Query('DateFrom') String DateFrom,
    @Query('DateTo') String DateTo,
  );

  @GET(ApiConstants.DANH_SACH_CAN_BO_LICH_HOP)
  Future<DanhSachCanBoHopResponse> getDanhSachChuTri(
    @Query('id') String id,
  );

  @GET(ApiConstants.DANH_SACH_CAN_BO_LICH_HOP)
  Future<DanhSachCanBoHopResponse> getDanhSachThuHoi(
    @Query('id') String id,
    @Query('except') bool except,
  );

  @POST(ApiConstants.ADD_FILE_TAI_LIEU_TAO_LICH_HOP)
  @MultiPart()
  Future<UploadFileWithMeetingResponse> postFile(
    @Query('entityType') int? entityType,
    @Query('entityName') String? entityName,
    @Query('entityId') String? entityId,
    @Query('isMutil') bool isMutil,
    @Part() List<File> files,
  );

  @POST(ApiConstants.EVENT_CALENDAR_LICH_HOP)
  Future<EventCalendarResponse> postEventCalendar(
    @Body() EventCalendarRequest eventCalendarRequest,
  );

  @GET(ApiConstants.DANH_SACH_PHIEN_HOP)
  Future<ListPhienHopRespone> getDanhSachPhienHop(@Query('id') String id);

  @GET(ApiConstants.DETAIL_MEETING_SCHEDULE)
  Future<ChiTietLichHopResponse> getChiTietLichHop(@Query('id') String id);

  @POST(ApiConstants.THEM_PHIEN_HOP_CHI_TIET)
  Future<TaoPhienHopResponse> getThemPhienHop(
    @Query('lichHopId') String lichHopId,
    @Part(name: '[0].canBoId') String canBoId,
    @Part(name: '[0].donViId') String donViId,
    @Part(name: '[0].vaiTroThamGia') int vaiTroThamGia,
    @Part(name: '[0].thoiGian_BatDau') String thoiGian_BatDau,
    @Part(name: '[0].thoiGian_KetThuc') String thoiGian_KetThuc,
    @Part(name: '[0].noiDung') String noiDung,
    @Part(name: '[0].tieuDe') String tieuDe,
    @Part(name: '[0].hoTen') String hoTen,
    @Part(name: '[0].IsMultipe') bool IsMultipe,
    @Body() FormData? file,
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
    @Query('status') int stutus,
    @Query('lichHopId') String lichHopId,
    @Query('phienHop') String phienHop,
  );

  @GET(ApiConstants.DANH_SACH_PHAT_BIEU_LICH_HOP)
  Future<DanhSachPhatBieuLichHopDataResponse>
      getDanhSachPhatBieuLichHopNoStatus(
    @Query('lichHopId') String lichHopId,
  );

  @GET(ApiConstants.DANH_SACH_BIEU_QUYET_LICH_HOP)
  Future<DanhSachBieuQuyetLichHopDataResponse> getDanhSachBieuQuyetLichHop(
    @Query('idLichHop') String idLichHop,
    @Query('canBoId') String canBoId,
    @Query('idPhienHop') String idPhienHop,
  );

  @GET(ApiConstants.SO_LUONG_PHAT_BIEU)
  Future<SoLuongPhatBieuResponse> getSoLuongPhatBieu(
      @Query('LichHopId') String id);

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
    @Body() BieuQuyetRequest bieuQuyetRequest,
  );

  @POST(ApiConstants.MOI_HOP)
  Future<ThanhPhanThamGiaResponse> postMoiHop(
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
      @Part() List<String> filesDelete);

  @POST(ApiConstants.CHON_MAU_BIEN_BAN)
  Future<ChonBienBanCuocHopResponse> postChonMauBienBan(
    @Body() ChonBienBanHopRequest chonBienBanHopRequest,
  );

  @POST(ApiConstants.CREATE_METTING)
  Future<ChiTietLichHopResponse> createMetting(
    @Body() TaoLichHopRequest taoLichHopRequest,
  );

  @GET(ApiConstants.XEM_KET_LUAN_HOP)
  Future<XemKetLuanHopDataResponse> getXemKetLuanHop(@Query('id') String id);

  @GET(ApiConstants.SCHEDULE_OPINION_LIST)
  Future<DanhSachYKienlichHopResponse> getDanhSachYKien(
    @Query('scheduleId') String scheduleId,
    @Query('phienHopId') String phienHopId,
  );

  @GET(ApiConstants.STATUS_LIST_KET_LUAN_HOP)
  Future<StatusKetLuanHopResponse> getListStatusKetLuanHop();

  @DELETE(ApiConstants.DELETE_SCHEDULE_REPORT)
  Future<XoaBaoCaoKetQuaResponse> deleteKetLuanHop(@Query('id') String id);

  @DELETE(ApiConstants.DELETE_DETAIL_CELENDER_MEET)
  Future<CuCanBoDiThayResponse> deleteChiTietLichHop(
    @Query('lstLichHopId') String id,
    @Query('isMulti') bool isMulti,
  );

  @GET(ApiConstants.CANCEL_DETAIL_CELENDER_MEET)
  Future<XoaBaoCaoKetQuaResponse> huyChiTietLichHop(
    @Query('scheduleId') String scheduleId,
    @Query('statusId') int statusId,
    @Query('isMulti') bool isMulti,
  );

  @GET(ApiConstants.MENU_LICH_HOP)
  Future<MenuResponse> getMenuLichHop(
    @Query('DateStart') String DateStart,
    @Query('DateTo') String DateTo,
  );

  @POST(ApiConstants.STATISTIC_BY_MONTH)
  Future<StatisticByMonthResponse> postStatisticByMonth(
    @Field('dateFrom') String dateFrom,
    @Field('dateTo') String dateTo,
  );

  @POST(ApiConstants.DASHBOARD_THONG_KE)
  Future<DashBoardThongKeResponse> getDashBoardThongKe(
    @Field('dateFrom') String dateFrom,
    @Field('dateTo') String dateTo,
  );

  @POST(ApiConstants.CO_CAU_LICH_HOP)
  Future<CoCauLichHopResponse> postCoCauLichHop(
    @Field('dateFrom') String dateFrom,
    @Field('dateTo') String dateTo,
  );

  @POST(ApiConstants.TO_CHUC_BOI_DON_VI)
  Future<ToChucBoiDonViResponse> postToChucBoiDonVi(
    @Field('dateFrom') String dateFrom,
    @Field('dateTo') String dateTo,
  );

  @POST(ApiConstants.TI_LE_THAM_GIA)
  Future<TiLeThamGiaResponse> postTiLeThamGia(
    @Field('dateFrom') String dateFrom,
    @Field('dateTo') String dateTo,
  );

  @POST(ApiConstants.SUA_LICH_HOP)
  Future<ChiTietLichHopResponse> postSuaLichHop(
    @Body() TaoLichHopRequest taoLichHopRequest,
  );

  @POST(ApiConstants.NHIEM_VU_GET_ALL)
  @FormUrlEncoded()
  Future<ListNhiemVuChiTietLichHopResponse> getNhiemVuCHiTietHop(
    @Body() NhiemVuChiTietHopRequest nhiemVuChiTietHopRequest,
  );

  @GET(ApiConstants.DANH_SACH_LOAI_NHIEM_VU)
  Future<List<DanhSachNhiemVulichHopResponse>> getDanhSachLoaiNhiemVu();

  @POST(ApiConstants.THEM_PHIEN_NhIEM_VU)
  Future<ListNhiemVuChiTietLichHopResponse> postThemNhiemVu(
    @Body() ThemNhiemVuRequest themNhiemVuRequest,
  );

  @PUT(ApiConstants.EDIT_CHUONG_TRINH_HOP)
  Future<SuaChuongTrinhHopResponse> suaChuongTrinhHop(
    @Part(name: 'Id') String id,
    @Part(name: 'LichHopId') String lichHopId,
    @Part(name: 'TieuDe') String tieuDe,
    @Part(name: 'ThoiGian_BatDau') String thoiGianBatDau,
    @Part(name: 'ThoiGian_KetThuc') String thoiGianKetThuc,
    @Part(name: 'CanBoId') String canBoId,
    @Part(name: 'DonViId') String donViId,
    @Part(name: 'NoiDung') String noiDung,
    @Part(name: 'hoTen') String hoTen,
    @Part(name: 'IsMultipe') bool isMultipe,
    @Part(name: 'Files') List<File> file,
    @Part(name: 'FilesDelete') List<String> fileDelete,
  );

  @DELETE(ApiConstants.XOA_CHUONG_TRINH_HOP)
  Future<XoaChuongTrinhHopResponse> xoaChuongTrinhHop(@Query('id') String id);

  @GET(ApiConstants.GET_DANH_SACH_NTG_CHUONG_TRINH_HOP)
  Future<DanhSachNguoiThamGiaResponse> getDanhSachNTGChuongTrinhHop(
    @Query('id') String id,
  );

  @POST(ApiConstants.PHAN_CONG_THU_KY)
  Future<PhanCongThuKyResponse> postPhanCongThuKy(
    @Body() PhanCongThuKyRequest phanCongThuKyRequest,
  );

  @POST(ApiConstants.TAO_BIEU_QUYET)
  Future<PhanCongThuKyResponse> postTaoPhatBieu(
    @Body() TaoBieuQuyetRequest taoBieuQuyetRequest,
  );

  @POST(ApiConstants.DUYET_PHAT_BIEU)
  Future<PhanCongThuKyResponse> postDuyetOrHuyDuyetPhatBieu(
    @Field('ids') List<String> ids,
    @Field('lichHopId') String lichHopId,
    @Field('type') int type,
  );

  @POST(ApiConstants.DIEM_DANH)
  Future<ThemPhienHopResponse> postDiemDanh(
    @Body() List<String> data,
  );

  @POST(ApiConstants.THU_HOI_HOP)
  Future<PhanCongThuKyResponse> postThuHoiHop(
    @Query('isMulti') bool isMulti,
    @Body() List<ThuHoiHopRequest> thuHoiHopRequest,
  );

  @POST(ApiConstants.HUY_DIEM_DANH)
  Future<ThemPhienHopResponse> postHuyDiemDanh(
    @Query('request') String request,
  );

  @GET(ApiConstants.DS_DON_VI_CON_PHONG)
  Future<DonViConPhongResponse> danhSachDVChaConPhong(
    @Query('id') String id,
  );

  @GET(ApiConstants.DS_PHONG_HOP)
  Future<DSPhongHopResponse> danhSachPhongHop(
    @Query('DonViId') String id,
    @Query('TuNgay') String TuNgay,
    @Query('DenNgay') String DenNgay,
    @Query('Bit_TTDH') bool Bit_TTDH,
  );

  @POST(ApiConstants.DUYET_HOAC_HUYDUYET_PHONG_HOP)
  Future<ThemPhienHopResponse> huyOrDuyetPhongHop(
    @Field('lichHopId') String hopId,
    @Field('isDuyet') bool isDuyet,
    @Field('lyDo') String lyDo,
  );

  @PUT(ApiConstants.CHON_PHONG_HOP)
  Future<ThemPhienHopResponse> thayDoiPhongHop(
    @Field('bit_TTDH') bool bit_TTDH,
    @Field('lichHopId') String lichHopId,
    @Field('phongHopId') String phongHopId,
    @Field('tenPhong') String tenPhong,
  );

  @POST(ApiConstants.DUYET_HOAC_HUYDUYET_THIET_BI)
  Future<ThemPhienHopResponse> duyetOrHuyDuyetThietBi(
    @Field('isDuyet') bool isDuyet,
    @Field('lichHopId') String lichHopId,
    @Field('lyDo') String lyDo,
    @Field('thietBiId') String thietBiId,
  );

  @POST(ApiConstants.DUYET_HOAC_HUYDUYET_KY_THUAT)
  Future<ThemPhienHopResponse> duyetOrHuyDuyetKyThuat(
    @Field('hopId') String hopId,
    @Field('isDuyet') bool isDuyet,
    @Field('lyDo') String lyDo,
  );

  @POST(ApiConstants.CHON_PHONG_HOP_METTING)
  Future<ThemPhienHopResponse> chonPhongHopMetting(
    @Body() TaoLichHopRequest taoLichHopRequest,
  );

  @GET(ApiConstants.CHECK_LICH_HOP_TRUNG)
  Future<dynamic> checkLichHopTrung(
    @Query('ScheduleId') String? scheduleId,
    @Query('DonViId') String donViId,
    @Query('UserId') String userId,
    @Query('TimeFrom') String timeFrom,
    @Query('TimeTo') String timeTo,
    @Query('DateFrom') String dateFrom,
    @Query('DateTo') String dateTo,
  );

  @POST(ApiConstants.MOI_HOP)
  Future<ThanhPhanThamGiaResponse> moiHop(
    @Query('lichHopId') String lichHopId,
    @Query('IsMultipe') bool IsMultipe,
    @Query('isSendMail') bool isSendMail,
    @Body() List<MoiThamGiaHopRequest> body,
  );

  @POST(ApiConstants.THEM_PHIEN_HOP_CHI_TIET)
  Future<ThemPhienHopResponse> themPhienHop(
    @Query('lichHopId') String lichHopId,
    @Body() FormData data,
  );

  @POST(ApiConstants.HUY_AND_DUYET_LICH_HOP)
  Future<DuyetLichResponse> huyDuyetLichHop(
    @Field('lichHopId') String lichHopId,
    @Field('isDuyet') bool isDuyet,
    @Field('lyDo') String lyDo,
  );

  @POST(ApiConstants.CU_CAN_BO_DI_THAY)
  Future<CuCanBoDiThayResponse> cuCanBoDiThay(
    @Body() CuCanBoDiThayRequest cuCanBoDiThayRequest,
  );

  @POST(ApiConstants.CONFIRM_HOP)
  Future<ThemPhienHopResponse> xacNhanThamGiaHop(
    @Field('hopId') String hopId,
    @Field('isThamGia') bool isThamGia,
  );

  @POST(ApiConstants.CONFIRM_OR_CANCEL_KET_LUAN_HOP)
  Future<ThemPhienHopResponse> xacNhanHoacHuyKetLuanHop(
    @Field('lichHopId') String lichHopId,
    @Field('isDuyet') bool isDuyet,
    @Field('noiDung') String noiDung,
  );

  @POST(ApiConstants.CREATE_KET_LUAN_HOP)
  @FormUrlEncoded()
  Future<ThemPhienHopResponse> createKetLuanHop(
    @Part(name: 'scheduleId') String? scheduleId,
    @Part(name: 'reportStatusId') String? reportStatusId,
    @Part(name: 'reportTemplateId') String? reportTemplateId,
    @Part(name: 'content') String? content,
    @Part(name: 'files') List<File> files,
  );

  @PUT(ApiConstants.GUI_DUYET_KET_LUAN_HOP)
  Future<ThemPhienHopResponse> guiDuyetKetLuanHop(
    @Query('meetId') String meetId,
  );

  @PUT(ApiConstants.THU_HOI_KET_LUAN_HOP)
  Future<ThemPhienHopResponse> thuHoiKetLuanHop(
    @Query('meetId') String meetId,
  );

  @DELETE(ApiConstants.DELETE_FILE)
  Future<ThemPhienHopResponse> deleteFileHop(
    @Query('id') String id,
  );

  @GET(ApiConstants.LIST_STATUS_ROOM)
  Future<ListStatusRoomResponse> getListStatusRoom();

  @PUT(ApiConstants.SUA_TRANG_THAI)
  Future<CapNhatTrangThaiResponse> suaTrangThai(
    @Body() CapNhatTrangThaiRequest capNhatTrangThaiRequest,
  );

  @POST(ApiConstants.THEM_MOI_VOTE)
  Future<ThemMoiVoteResponse> themMoiVote(
    @Body() ThemMoiVoteRequest themMoiVoteRequest,
  );

  @POST(ApiConstants.GET_LICH_CAN_KLCH)
  Future<DanhSachLichHopResponse> getLichCanKLCH(
    @Body() DanhSachLichHopRequest lichHopRequest,
  );

  @GET(ApiConstants.CHI_TIET_BIEU_QUYET)
  Future<ChiTietBieuQuyetResponse> chiTietBieuQuyet(@Path('id') String id);

  @PUT(ApiConstants.SUA_BIEU_QUYET)
  Future<SuaBieuQuyetResponse> suaBieuQuyet(
    @Body() SuaBieuQuyetRequest suaBieuQuyetRequest,
  );

  @DELETE(ApiConstants.XOA_BIEU_QUYET)
  Future<XoaBieuQuyetResponse> xoaBieuQuyet(
    @Query('bieuQuyetId') String bieuQuyetId,
    @Query('canboId') String canboId,
  );

  @POST(ApiConstants.UPLOAD_FILE_COMMON)
  @MultiPart()
  Future<FileUploadResponse> uploadMultiFile(
    @Part() List<File> path,
  );

  @GET(ApiConstants.DANH_SACH_CAN_BO_BIEU_QUYET)
  Future<DanhSachCanBoBieuQuyetResponse> danhSachCanBoBieuQuyet(
    @Query('luaChonId') String luaChonId,
    @Query('lichHopId') String lichHopId,
    @Query('bieuQuyetId') String bieuQuyetId,
  );

  @GET(ApiConstants.GET_LICH_HOP_THEO_LINH_VUC)
  Future<ThongKeLinhVucResponse> getLichHopTheoLinhVuc(
    @Query('startDate') String dateFrom,
    @Query('endDate') String dateTo,
  );
}
