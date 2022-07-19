import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/cap_nhat_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/dang_ky_thong_tin_xe_moi_request.dart';
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
import 'package:ccvc_mobile/diem_danh_module/data/service/diem_danh_service.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/message_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/xoa_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/post_file_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';

class DiemDanhRepoImpl implements DiemDanhRepository {
  final DiemDanhService _diemDanhService;

  DiemDanhRepoImpl(this._diemDanhService);

  @override
  Future<Result<ThongKeDiemDanhCaNhanModel>> thongKeDiemDanh(
    ThongKeDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest,
  ) {
    return runCatchingAsync<DataThongKeDiemDanhCaNhanResponse,
        ThongKeDiemDanhCaNhanModel>(
      () =>
          _diemDanhService.thongKeDiemDanhCaNhan(thongKeDiemDanhCaNhanRequest),
      (response) => response.data?.toModel() ?? ThongKeDiemDanhCaNhanModel(),
    );
  }

  @override
  Future<Result<ListItemBangDiemDanhCaNhanModel>> bangDiemDanh(
    BangDiemDanhCaNhanRequest bangDiemDanhCaNhanRequest,
  ) {
    return runCatchingAsync<DataListItemThongKeDiemDanhCaNhanModelResponse,
        ListItemBangDiemDanhCaNhanModel>(
      () => _diemDanhService.bangDiemDanhCaNhan(bangDiemDanhCaNhanRequest),
      (response) =>
          response.data?.toModel() ?? ListItemBangDiemDanhCaNhanModel(),
    );
  }

  @override
  Future<Result<GetAllFilesIdModel>> getAllFilesId(GetAllFilesRequest body) {
    return runCatchingAsync<GetAllFilesResponse, GetAllFilesIdModel>(
      () => _diemDanhService.getAllFilesId(body),
      (res) => res.data?.toModel ?? GetAllFilesIdModel.empty(),
    );
  }

  @override
  Future<Result<ListItemChiTietBienSoXeModel>> danhSachBienSoXe(
    String userId,
    int pageIndex,
    int pageSize,
  ) {
    return runCatchingAsync<DataListItemChiTietBienSoXeModelResponse,
        ListItemChiTietBienSoXeModel>(
      () => _diemDanhService.danhSachBienSoXe(userId, pageIndex, pageSize),
      (response) => response.data?.toModel() ?? ListItemChiTietBienSoXeModel(),
    );
  }

  @override
  Future<Result<PostFileModel>> postFileModel(
    String entityId,
    String fileTypeUpload,
    String entityName,
    bool isPrivate,
    List<File> files,
  ) {
    return runCatchingAsync<PostFileResponse, PostFileModel>(
      () => _diemDanhService.postFile(
        entityId,
        fileTypeUpload,
        entityName,
        isPrivate,
        files,
      ),
      (res) => res.toModel,
    );
  }

  @override
  Future<Result<XoaBienSoXeModel>> deleteBienSoXe(String id) {
    return runCatchingAsync<XoaBienSoXeResponse, XoaBienSoXeModel>(
      () => _diemDanhService.xoaBienSoXe(id),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ChiTietBienSoXeModel>> dangKyThongTinXeMoi(
    DangKyThongTinXeMoiRequest dangKyThongTinXeMoiRequest,
  ) {
    return runCatchingAsync<DangKyThongTinXeMoiResponse, ChiTietBienSoXeModel>(
      () => _diemDanhService.dangKyThongTinXeMoi(dangKyThongTinXeMoiRequest),
      (response) => response.data?.toModel() ?? ChiTietBienSoXeModel(),
    );
  }

  @override
  Future<Result<MessageModel>> deleteImage(String id) {
    return runCatchingAsync<MessageResponse, MessageModel>(
      () => _diemDanhService.deleteImage(
        id,
      ),
      (res) => res.toModel,
    );
  }

  @override
  Future<Result<ChiTietBienSoXeModel>> capNhatBienSoXe(
      CapNhatBienSoXeRequest capNhatBienSoXeRequest) {
    return runCatchingAsync<DataCapNhatBienSoXeResponse, ChiTietBienSoXeModel>(
      () => _diemDanhService.capNhatBienSoXe(capNhatBienSoXeRequest),
      (response) => response.data?.toModel() ?? ChiTietBienSoXeModel(),
    );
  }
}
