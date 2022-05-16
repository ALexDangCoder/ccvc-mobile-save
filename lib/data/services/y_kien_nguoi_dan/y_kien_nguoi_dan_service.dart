import 'dart:io';

import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/bao_cao_thong_ke_yknd_request/bao_cao_yknd_request.dart';
import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/chi_tiet_kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/y_kien_nguoi_dan/danh_sach_y_kien_pakn_request.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_don_vi_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_linh_vuc_khac_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/chart_so_luong_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/bao_cao_thong_ke/dash_board_bao_cao_yknd.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/chi_tiet_kien_nghi_respnse.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_ket_qua_y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/dash_board_phan_loai_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/dash_board_yknd_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/ket_qua_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/search_y_kien_nguoi_dan_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/thong_tin_y_kien_nguoi_dan_resopnse.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/tien_trinh_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'y_kien_nguoi_dan_service.g.dart';

@RestApi()
abstract class YKienNguoiDanService {
  @factoryMethod
  factory YKienNguoiDanService(Dio dio, {String baseUrl}) =
      _YKienNguoiDanService;

  @GET(ApiConstants.DASH_BOARD_TINH_HINH_XU_LY)
  Future<DashBoashTinhHinhXuLyResponse> getDashBoardTinhHinhXuLy(
    @Query('donViId') String donViId,
    @Query('TuNgay') String TuNgay,
    @Query('DenNgay') String DenNgay,
  );

  @GET(ApiConstants.DASH_BOARD_PHAN_LOAI)
  Future<DashBoashPhanLoaiResponse> getDashBoardPhanLoai(
    @Query('donViId') String donViId,
    @Query('TuNgay') String TuNgay,
    @Query('DenNgay') String DenNgay,
  );

  @GET(ApiConstants.THONG_TIN_Y_KIEN_NGUOI_DAN)
  Future<ThongTinYKienNguoiDanResponse> getThongTinYKienNguoiDan(
    @Query('donViId') String donViId,
    @Query('TuNgay') String TuNgay,
    @Query('DenNgay') String DenNgay,
  );

  @GET(ApiConstants.DANH_SACH_Y_KIEN_NGUOI_DAN)
  Future<DanhSachYKienNguoiDanResponse> getDanhSachYKienNguoiDan(
    @Query('TuNgay') String tuNgay,
    @Query('DenNgay') String denNgay,
    @Query('trangThai') String trangThai,
    @Query('PageSize') int pageSize,
    @Query('PageNumber') int pageNumber,
    @Query('userId') String userId,
    @Query('donViId') String donViId,
  );

  @POST(ApiConstants.CHI_TIET_Y_KIEN_NGUOI_DAN)
  Future<ChiTietKienNghiResponse> chiTietYKienNguoiDan(
    @Body() ChiTietKienNghiRequest chiTietKienNghiRequest,
  );

  @GET(ApiConstants.SEARCH_Y_KIEN_NGUOI_DAN)
  Future<SearchYKienNguoiDanResponse> searchDanhSachYKienNguoiDan(
    @Query('TuNgay') String tuNgay,
    @Query('DenNgay') String denNgay,
    @Query('trangThai') String trangThai,
    @Query('PageSize') int pageSize,
    @Query('PageNumber') int pageNumber,
    @Query('TuKhoa') String tuKhoa,
    @Query('userId') String userId,
    @Query('donViId') String donViId,
  );

  @POST(ApiConstants.GET_DANH_SACH_Y_KIEN_PAKN)
  Future<DanhSachKetQuaYKXLModelResponse> getDanhSachYKienPAKN(
    @Body() DanhSachYKienPAKNRequest danhSachYKienPAKNRequest,
  );

  @POST(ApiConstants.BAO_CAO_YKND)
  Future<BaoCaoYKNDResponse> getBaoCaoYKND(
    @Body() BaoCaoYKNDRequest baoCaoYKNDRequest,
  );

  @POST(ApiConstants.DASH_BOARD_BAO_CAO_YKND)
  Future<DashBoardBaoCaoYKNDResponse> getDashBoardBaoCaoYKND(
    @Body() BaoCaoYKNDRequest baoCaoYKNDRequest,
  );

  @POST(ApiConstants.BAO_CAO_LINH_VUC_KHAC)
  Future<LinhVucKhacResponse> getDashBoardLinhVucKhac(
    @Body() BaoCaoYKNDRequest baoCaoYKNDRequest,
  );

  @POST(ApiConstants.DON_VI_XU_LY)
  Future<DonViXuLyResponse> getDashBoardDonViXuLy(
    @Body() BaoCaoYKNDRequest baoCaoYKNDRequest,
  );

  @POST(ApiConstants.SO_LUONG_BY_MONTH)
  Future<SoLuongYKNDBtMonthResponse> getDashBoardSoLuongYKND(
    @Body() BaoCaoYKNDRequest baoCaoYKNDRequest,
  );

  @GET(ApiConstants.TIEN_TRINH_XU_LY)
  Future<TienTrinhXuLyResponse> getTienTrinhXuLyYKND(
    @Query('paknId') String paknId,
  );

  @GET(ApiConstants.KET_QUA_XU_LY)
  Future<KetQuaXuLyResponse> getKetQuaXuLyYKND(
    @Query('KienNghiId') String kienNghiId,
    @Query('TaskId') String taskId,
  );

  @POST(ApiConstants.POST_Y_KIEN_XU_LY)
  @MultiPart()
  Future<YKienXuLyResponse> postYKienXuLy(
    @Part() String NguoiChoYKien,
    @Part() String KienNghiId,
    @Part() String NoiDung,
    @Part() List<File> DinhKem,
  );
}
