import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/add_task_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/request/task_processing.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/category_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/chart_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/danh_sach_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/delete_task_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/nguoi_tiep_nhan_yeu_cau_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/post_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/tong_dai_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/services/ho_tro_ky_thuat_service.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/add_task_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/nguoi_tiep_nhan_yeu_cau_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/group_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/support_detail_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';

class HoTroKyThuatImpl implements HoTroKyThuatRepository {
  final HoTroKyThuatService _hoTroKyThuatService;

  HoTroKyThuatImpl(
    this._hoTroKyThuatService,
  );

  @override
  Future<Result<List<SuCoModel>>> postDanhSachSuCo({
    required int pageIndex,
    required int pageSize,
    String? codeUnit,
    String? createOn,
    String? finishDay,
    String? userRequestId,
    String? districtId,
    String? buildingId,
    String? room,
    String? processingCode,
    String? handlerId,
    String? keyWord,
  }) {
    return runCatchingAsync<DanhSachSuCoResponse, List<SuCoModel>>(
      () => _hoTroKyThuatService.postDanhSachSuCo(
        pageIndex,
        pageSize,
        codeUnit,
        createOn,
        finishDay,
        userRequestId,
        districtId,
        buildingId,
        room,
        processingCode,
        handlerId,
        keyWord,
      ),
      (res) => res.data?.pageData?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<SupportDetail>> getSupportDetail(String id) {
    return runCatchingAsync<SupportDetailResponse, SupportDetail>(
      () => _hoTroKyThuatService.getSupportDetail(
        id,
      ),
      (res) => res.data?.toDomain() ?? SupportDetail(),
    );
  }

  @override
  Future<Result<List<TongDaiModel>>> getTongDai() {
    return runCatchingAsync<TongDaiResponse, List<TongDaiModel>>(
      () => _hoTroKyThuatService.getTongDai(),
      (res) => res.data?.configValue?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<ThanhVien>>> getNguoiXuLy() {
    return runCatchingAsync<GroupImplResponse, List<ThanhVien>>(
      () => _hoTroKyThuatService.getListThanhVien(
        '2dd34d4d-6a11-4e34-9d80-5f39d456c5a5',
        ApiConstants.PAGE_BEGIN.toString(),
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
      (res) => res.data?.toListThanhVien() ?? [],
    );
  }

  @override
  Future<Result<List<CategoryModel>>> getCategory(
    String code,
  ) {
    return runCatchingAsync<CategoryResponse, List<CategoryModel>>(
      () => _hoTroKyThuatService.getCategory(
        code,
      ),
      (res) => res.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<ChartSuCoModel>>> getChartSuCo() {
    return runCatchingAsync<ChartSuCoResponse, List<ChartSuCoModel>>(
      () => _hoTroKyThuatService.getChartSuCo(),
      (res) => res.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NguoiTiepNhanYeuCauModel>>> getNguoiTiepNhanYeuCau() {
    return runCatchingAsync<NguoiTiepNhanYeuCauResponse,
        List<NguoiTiepNhanYeuCauModel>>(
      () => _hoTroKyThuatService.getNguoiTiepNhanYeuCau(),
      (res) => res.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<bool>> deleteTask(List<String> listId) {
    return runCatchingAsync<DeleteTaskResponse, bool>(
      () => _hoTroKyThuatService.deleteTask(
        listId,
      ),
      (res) {
        if (res.data ?? false) {
          return true;
        } else {
          return false;
        }
      },
    );
  }

  @override
  Future<Result<AddTaskResponseModel>> addTask(
      {required String? id,
      required String? userRequestId,
      required String? phone,
      required String? description,
      required String? districtId,
      required String? districtName,
      required String? buildingId,
      required String? buildingName,
      required String? room,
      required String? name,
      required List<String>? danhSachSuCo,
      required String? userInUnit,
      required List<File> fileUpload}) {
    return runCatchingAsync<AddTaskResponse, AddTaskResponseModel>(
        () => _hoTroKyThuatService.addTask(
            id,
            userRequestId,
            phone,
            description,
            districtId,
            districtName,
            buildingId,
            buildingName,
            room,
            name,
            danhSachSuCo,
            userInUnit,
            fileUpload), (res) {
      return res.toModel();
    });
  }

  @override
  Future<Result<String>> updateTaskProcessing(TaskProcessing task) {
    return runCatchingAsync<PostResponse, String>(
      () => _hoTroKyThuatService.updateTaskProcessing(
        task,
      ),
      (res) => res.message ?? '',
    );
  }

  @override
  Future<Result<String>> commentTask(String idTask, String comment) {
    return runCatchingAsync<PostResponse, String>(
      () => _hoTroKyThuatService.commentTaskProcessing(
        idTask,
        comment,
      ),
      (res) => res.message ?? '',
    );
  }

  @override
  Future<Result<AddTaskResponseModel>> editTaskHTKT({
    required String? id,
    required String? userRequestId,
    required String? phone,
    required String? description,
    required String? districtId,
    required String? districtName,
    required String? buildingId,
    required String? buildingName,
    required String? room,
    required String? name,
    required List<String>? danhSachSuCo,
    required String? userInUnit,
    required List<File> fileUpload,
    required List<String>? lstFileId,
  }) {
    return runCatchingAsync<AddTaskResponse, AddTaskResponseModel>(
        () => _hoTroKyThuatService.editTaskHTKT(
            id,
            userRequestId,
            phone,
            description,
            districtId,
            districtName,
            buildingId,
            buildingName,
            room,
            name,
            danhSachSuCo,
            userInUnit,
            fileUpload,
            lstFileId,
        ), (res) {
      return res.toModel();
    });
  }
}
