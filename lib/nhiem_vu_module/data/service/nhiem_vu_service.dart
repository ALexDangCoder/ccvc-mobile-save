import 'dart:io';

import 'package:ccvc_mobile/nhiem_vu_module/data/request/danh_sach_cong_viec_request.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/request/danh_sach_nhiem_vu_request.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/request/ngay_tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/bieu_do_theo_don_vi_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/chi_tiet_cong_viec_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/chi_tiet_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/danh_sach_cong_viec_chi_tiet_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/danh_sach_cong_viec_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/danh_sach_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/dash_broash_cong_viec_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/dash_broash_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/lich_su_cap_nhat_thth_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/lich_su_don_doc_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/lich_su_phan_xu_ly_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/lich_su_thu_hoi_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/lich_su_tra_lai_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/van_ban_lien_quan_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/xem_luong_xu_ly_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/data/response/y_kien_su_ly_nhiem_vu_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'nhiem_vu_service.g.dart';

@RestApi()
abstract class NhiemVuService {
  @factoryMethod
  factory NhiemVuService(Dio dio, {String baseUrl}) = _NhiemVuService;

  @POST(ApiConstants.DANHSACHNHIEMVU)
  @FormUrlEncoded()
  Future<DanhSachNhiemVuResponse> danhSachNhiemVu(
    @Body() DanhSachNhiemVuRequest danhSachNhiemVuRequest,
  );

  @POST(ApiConstants.DANHSACHCONGVIEC)
  @FormUrlEncoded()
  Future<DanhSachCongViecResponse> danhSachCongViec(
    @Body() DanhSachCongViecRequest danhSachCongViecRequest,
  );

  @GET(ApiConstants.GETDASHBROASHNHIEMVU)
  @FormUrlEncoded()
  Future<DashBroashResponse> getDashBroashNhiemVu(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @GET(ApiConstants.GETDASHBROASHCONGVIEC)
  @FormUrlEncoded()
  Future<DashBroashCongViecResponse> getDashBroashCongViec(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @GET(ApiConstants.GETDASHBROASHNHIEMVUCANHAN)
  @FormUrlEncoded()
  Future<DashBroashResponse> getDashBroashNhiemVuCaNhan(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @GET(ApiConstants.GETDASHBROASHCONGVIECCANHAN)
  @FormUrlEncoded()
  Future<DashBroashCongViecResponse> getDashBroashCongViecCaNhan(
    @Query('NgayDauTien') String ngayDauTien,
    @Query('NgayCuoiCung') String ngayCuoiCung,
  );

  @GET(ApiConstants.GET_CHI_TIET_NHIEM_VU)
  Future<DataChiTietNhiemVuResponse> getChiTietNhiemVu(
    @Query('nhiemVuId') String nhiemVuId,
    @Query('isCaNhan') bool isCaNhan,
    @Query('DonViId') String? donViId,
  );

  @GET(ApiConstants.GET_LICH_SU_PHAN_XU_LY_NHIEM_VU)
  Future<DataLichSuPhanXuLyNhiemVuModelResponse> getLichSuPhanXuLy(
    @Query('nhiemVuId') String nhiemVuId,
  );

  @GET(ApiConstants.GET_Y_KIEN_XU_LY)
  Future<DataYKienXuLyFileDinhKemResponse> getYKienXuLyNhiemVu(
    @Path('id') String nhiemVuId,
  );

  @GET(ApiConstants.GET_DANH_SACH_CONG_VIEC_CHI_TIET_NHIEM_VU)
  Future<DataDanhSachCongViecChiTietNhiemVuModelResponse>
      getDanhSachCongViecChiTietNhiemVu(
    @Query('nhiemVuId') String nhiemVuId,
    @Query('isCaNhan') bool isCaNhan,
  );

  @GET(ApiConstants.GET_LICH_SU_GIAO_VIEC)
  Future<DataDanhSachCongViecChiTietNhiemVuModelResponse> getLichSuGiaoViec(
    @Query('congViecId') String congViecId,
  );

  @GET(ApiConstants.GET_LICH_SU_TDTT)
  Future<DataDanhSachCongViecChiTietNhiemVuModelResponse> getLichSuTDTT(
    @Query('congViecId') String congViecId,
  );

  @GET(ApiConstants.GET_LICH_SU_TRA_LAI_NHIEM_VU)
  Future<DataLichSuTraLaiNhiemVuResponse> getLichSuTraLaiNhiemVu(
    @Path('id') String nhiemVuId,
  );

  @GET(ApiConstants.GET_LICH_SU_TINH_HINH_THUC_HIEN)
  Future<DataLichSuCapNhatTHTHModelResponse> getLichSuCapNhatThth(
    @Path('id') String nhiemVuId,
  );

  @GET(ApiConstants.GET_LICH_SU_THU_HOI_NHIEM_VU)
  Future<DataLichSuThuHoiNhiemVuModelResponse> getLichSuThuHoiNhiemVu(
    @Query('nhiemVuId') String nhiemVuId,
  );

  @GET(ApiConstants.GET_LICH_SU_DON_DOC_NHIEM_VU)
  Future<DataLichSuDonDocNhiemVuModelResponse> getLichSuDonDocNhiemVu(
    @Query('nhiemVuId') String nhiemVuId,
  );

  @GET(ApiConstants.GET_CHI_TIET_CONG_VIEC)
  Future<DataChiTietCongViecNhiemVuModelResponse> getChiTietCongViec(
    @Query('congViecId') String congViecId,
  );

  @GET(ApiConstants.GET_VAN_BAN_LIEN_QUAN_NHIEM_VU)
  Future<DataVanBanLienQuanNhiemVuResponse> getVanBanLienQuanNhiemVu(
    @Path('id') String id,
  );

  @GET(ApiConstants.GET_LUONG_XU_LY_NHIEM_VU)
  Future<XemLuongXuLyNhiemVuResponse> getLuongXuLyNhiemVu(
      @Query('nhiemVuId') String id);

  @POST(ApiConstants.POST_Y_KIEN_XU_LY_NHIEM_VU)
  Future<PostYKienResponse> postYKienXULy(
    @Body() Map<String, dynamic> map,
  );

  @GET(ApiConstants.DOWNLOAD_FILE)
  Future<PostYKienResponse> downloadFile(
    @Query('fileId') String fileId,
    @Query('token') String token,
  );

  @POST(ApiConstants.UPLOAD_FILE)
  @MultiPart()
  Future<PostYKienResponse> postFile(
    @Part() List<File> path,
  );

  @POST(ApiConstants.POST_BIEU_DO_THEO_DON_VI)
  Future<BieuDoTheoDonViResponse> postBieuDoTheoDonVi(
    @Body() NgayTaoNhiemVuRequest ngayTaoNhiemVuRequest,
  );
}
