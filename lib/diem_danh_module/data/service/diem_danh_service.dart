import 'dart:io';

import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/cap_nhat_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/dang_ky_thong_tin_xe_moi_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/danh_sach_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/bang_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/cap_nhat_bien_so_xe_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/dang_ky_thong_tin_xe_moi_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/danh_sach_bien_so_xe_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/get_all_files_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/message_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/post_file_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/thong_ke_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/xoa_bien_so_xe_response.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'diem_danh_service.g.dart';

@RestApi()
abstract class DiemDanhService {
  @factoryMethod
  factory DiemDanhService(Dio dio, {String baseUrl}) = _DiemDanhService;

  @POST(ApiConstants.DIEM_DANH_CA_NHAN_THONG_KE)
  Future<DataThongKeDiemDanhCaNhanResponse> thongKeDiemDanhCaNhan(
    @Body() ThongKeDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest,
  );

  @POST(ApiConstants.DIEM_DANH_CA_NHAN_BANG_DIEM_DANH)
  Future<DataListItemThongKeDiemDanhCaNhanModelResponse> bangDiemDanhCaNhan(
    @Body() BangDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest,
  );

  @POST(ApiConstants.GET_ALL_FILE)
  Future<GetAllFilesResponse> getAllFilesId(
    @Body() GetAllFilesRequest body,
  );

  @POST(ApiConstants.DANH_SACH_BIEN_SO_XE)
  Future<DataListItemChiTietBienSoXeModelResponse> danhSachBienSoXe(
    @Body() DanhSachBienSoXeRequest danhSachBienSoXeRequest,
  );

  @POST(ApiConstants.POST_FILE)
  @MultiPart()
  Future<PostFileResponse> postFile(
    @Query('entityId') String entityId,
    @Query('fileTypeUpload') String fileTypeUpload,
    @Query('entityName') String entityName,
    @Query('isPrivate') bool isPrivate,
    @Part(value: 'files') List<File> files,
  );

  @GET(ApiConstants.XOA_BIEN_XO_XE)
  Future<XoaBienSoXeResponse> xoaBienSoXe(
    @Path('id') String id,
  );

  @POST(ApiConstants.DANG_KY_THONG_TIN_XE_MOI)
  Future<DangKyThongTinXeMoiResponse> dangKyThongTinXeMoi(
    @Body() DangKyThongTinXeMoiRequest dangKyThongTinXeMoiRequest,
  );

  @POST(ApiConstants.CAP_NHAT_THONG_TIN_XE_MOI)
  Future<DataCapNhatBienSoXeResponse> capNhatBienSoXe(
    @Body() CapNhatBienSoXeRequest capNhatBienSoXeRequest,
  );

  @DELETE(ApiConstants.DELETE_IMAGE)
  Future<MessageResponse> deleteImage(@Path('id') String id);
}
