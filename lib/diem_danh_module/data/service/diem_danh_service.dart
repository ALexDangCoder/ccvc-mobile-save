import 'dart:io';

import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/bang_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/get_all_files_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/post_file_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/thong_ke_diem_danh_ca_nhan_response.dart';
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

  @POST(ApiConstants.POST_FILE)
  Future<PostFileResponse> postFile(
    @Query('entityId') String entityId,
    @Query('fileTypeUpload') String fileTypeUpload,
    @Query('entityName') String entityName,
    @Query('isPrivate') bool isPrivate,
    @Field('files') List<File> files,
  );
}
