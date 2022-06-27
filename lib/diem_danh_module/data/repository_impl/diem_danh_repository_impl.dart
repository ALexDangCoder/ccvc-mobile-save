import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/danh_sach_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/bang_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/danh_sach_bien_so_xe_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/get_all_files_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/post_file_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/thong_ke_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/service/diem_danh_service.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
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
      DanhSachBienSoXeRequest danhSachBienSoXeRequest) {
    return runCatchingAsync<
        DataListItemChiTietBienSoXeModelResponse,
        ListItemChiTietBienSoXeModel>(() =>
        _diemDanhService.danhSachBienSoXe(danhSachBienSoXeRequest), (
        response) =>
    response.data?.toModel() ?? ListItemChiTietBienSoXeModel());
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
}
