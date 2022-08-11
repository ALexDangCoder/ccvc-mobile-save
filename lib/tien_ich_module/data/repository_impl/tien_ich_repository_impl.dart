import 'dart:convert';
import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/chuyen_vb_thanh_giong_noi_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/count_dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/danh_sach_hssd_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/detail_huong_dan_su_dung_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/lich_am_duong_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/list_nguoi_thuc_hien_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/nhom_cv_moi_dscv_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/post_anh_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/todo_list_get_all_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/todo_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/topic_hdsd_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/tra_cuu_van_ban_phap_luat_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/translate_document_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/tree_danh_ba_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/service/tien_ich_service.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/ChuyenVBThanhGiong.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/post_anh_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/topic_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/tra_cuu_van_ban_phap_luat_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';

class TienIchRepositoryImpl implements TienIchRepository {
  final TienIchService _tienIchService;
  final TienIchServiceCommon _tienIchServiceCommon;
  final TienIchServiceGateWay _tienIchServiceGateWay;

  TienIchRepositoryImpl(this._tienIchService,
      this._tienIchServiceCommon, this._tienIchServiceGateWay);

  @override
  Future<Result<List<TopicHDSD>>> getTopicHDSD() {
    return runCatchingAsync<DataTopicHDSDResponse, List<TopicHDSD>>(
      () => _tienIchService.getTopicHDSD(),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<TodoListModelTwo>> getListTodo() {
    return runCatchingAsync<ToDoListResponseTwo, TodoListModelTwo>(
      () => _tienIchService.getTodoList(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<TodoDSCVModel>> upDateTodo(ToDoListRequest toDoListRequest) {
    return runCatchingAsync<ToDoListUpdateResponseTwo, TodoDSCVModel>(
      () => _tienIchService.updateTodoList(toDoListRequest),
      (res) => res.data?.toDomain() ?? TodoDSCVModel(),
    );
  }

  @override
  Future<Result<TodoDSCVModel>> createTodo(
      CreateToDoRequest createToDoRequest) {
    return runCatchingAsync<ToDoListUpdateResponseTwo, TodoDSCVModel>(
      () => _tienIchService.createTodoList(createToDoRequest),
      (res) => res.data?.toDomain() ?? TodoDSCVModel(),
    );
  }

  @override
  Future<Result<ItemChonBienBanCuocHopModel>> getListNguoiThucHien(
    String hoTen,
    int pageSize,
    int pageIndex,
  ) {
    return runCatchingAsync<ListNguoiThucHienResponse,
        ItemChonBienBanCuocHopModel>(
      () => _tienIchServiceCommon.getListNguoiThucHien(
        hoTen,
        pageSize,
        pageIndex,
      ),
      (res) => res.data.toDomain(),
    );
  }

  @override
  Future<Result<DataDanhSachTitleHDSD>> getDanhSachHDSD(int pageIndex,
      int pageSize, String topicId, String type, String searchKeyword) {
    return runCatchingAsync<DataDanhSachHDSDResponse, DataDanhSachTitleHDSD>(
      () => _tienIchService.getDanhSachHDSD(
        pageIndex,
        pageSize,
        topicId,
        type,
        searchKeyword,
      ),
      (response) => response.data?.toModel() ?? DataDanhSachTitleHDSD.empty(),
    );
  }

  @override
  Future<Result<DetailHuongDanSuDung>> getDetailHuongDanSuDung(String id) {
    return runCatchingAsync<DataDetailHuongDanSuDungResponse,
            DetailHuongDanSuDung>(
        () => _tienIchService.getDetailHuongDanSuDung(id),
        (response) => response.data?.toModel() ?? DetailHuongDanSuDung());
  }

  @override
  Future<Result<LichAmDuong>> getLichAmDuong(String date) {
    return runCatchingAsync<DataLichAmDuongResponse, LichAmDuong>(
      () => _tienIchService.getLichAmDuong(date),
      (response) => response.data?.toModel() ?? LichAmDuong(),
    );
  }

  @override
  Future<Result<List<TreeDonViDanhBA>>> treeDanhBa(
      int soCap, String idDonViCha) {
    return runCatchingAsync<TreeDanhBaResponse, List<TreeDonViDanhBA>>(
      () => _tienIchServiceCommon.treeDanhBa(soCap, idDonViCha),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<PageTraCuuVanBanPhapLuatModel>> getTraCuuVanBanPhapLuat(
      String title, int pageIndex, int pageSize) {
    return runCatchingAsync<DataTraCuuVanBanPhapLuatResponse,
            PageTraCuuVanBanPhapLuatModel>(
        () =>
            _tienIchService.getTraCuuVanBanPhapLuat(title, pageIndex, pageSize),
        (response) =>
            response.data?.toModel() ?? PageTraCuuVanBanPhapLuatModel());
  }

  @override
  Future<Result<List<NhomCVMoiModel>>> nhomCVMoi() {
    return runCatchingAsync<NhomCVMoiDSCVResponse, List<NhomCVMoiModel>>(
      () => _tienIchService.NhomCVMoi(),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<List<TodoDSCVModel>>> getListTodoDSCV() {
    return runCatchingAsync<ToDoListDSCVResponse, List<TodoDSCVModel>>(
      () => _tienIchService.getTodoListDSCV(),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<List<TodoDSCVModel>>> getListDSCVGanChoToi() {
    return runCatchingAsync<ToDoListDSCVResponse, List<TodoDSCVModel>>(
      () => _tienIchService.getListDSCVGanChoToi(),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<TodoDSCVModel>> xoaCongViec(String id) {
    return runCatchingAsync<ToDoListUpdateResponseTwo, TodoDSCVModel>(
      () => _tienIchService.xoaCongViec(id),
      (response) => response.data?.toDomain() ?? TodoDSCVModel(),
    );
  }

  @override
  Future<Result<NhomCVMoiModel>> createNhomCongViecMoi(String label) {
    return runCatchingAsync<ThemNhomCVMoiDSCVResponse, NhomCVMoiModel>(
      () => _tienIchService.createNhomCongViecMoi(label),
      (response) => response.data?.toModel() ?? NhomCVMoiModel(),
    );
  }

  @override
  Future<Result<NhomCVMoiModel>> updateLabelTodoList(String id, String label) {
    return runCatchingAsync<ThemNhomCVMoiDSCVResponse, NhomCVMoiModel>(
      () => _tienIchService.updateLabelGroupTodoList(id, label),
      (response) => response.data?.toModel() ?? NhomCVMoiModel(),
    );
  }

  @override
  Future<Result<NhomCVMoiModel>> deleteGroupTodoList(String id) {
    return runCatchingAsync<ThemNhomCVMoiDSCVResponse, NhomCVMoiModel>(
      () => _tienIchService.deleteGroupTodoList(id),
      (response) => response.data?.toModel() ?? NhomCVMoiModel(),
    );
  }

  @override
  Future<Result<ChuyenVBThanhGiongModel>> chuyenVBSangGiongNoi(
    String text,
    String voiceTone,
  ) {
    return runCatchingAsync<ChuyenVBThanhGiongNoiResponse,
        ChuyenVBThanhGiongModel>(
      () => _tienIchService.chuyenVBSangGiongNoi(text, voiceTone),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<String>> translateDocument(
      String document, String target, String source) {
    return runCatchingAsync<String, String>(
        () => _tienIchServiceGateWay.translateDocument(
              document,
              target,
              source,
            ), (response) {
      try {
        return DataTranslateResponse.fromJson(json.decode(response))
                .data
                ?.translations
                ?.first
                .translatedText ??
            '';
      } catch (e) {
        return '';
      }
    });
  }

  @override
  Future<Result<String>> translateFile(
      File file, String target, String source) {
    return runCatchingAsync<String, String>(
        () => _tienIchService.translateFile(
              file,
              target,
              source,
            ), (response) {
      try {
        return DataTranslateResponse.fromJson(json.decode(response))
                .data
                ?.translations
                ?.first
                .translatedText ??
            '';
      } catch (e) {
        return '';
      }
    });
  }

  @override
  Future<Result<PostAnhModel>> uploadFile(File files) {
    return runCatchingAsync<PostAnhResponse, PostAnhModel>(
      () => _tienIchService.uploadFile(
        files,
      ),
      (res) => res.toMoDel(),
    );
  }

  @override
  Future<Result<PostAnhModel>> uploadFileDSCV(File files) {
    return runCatchingAsync<PostAnhResponse, PostAnhModel>(
      () => _tienIchService.uploadFileDSCV(
        files,
      ),
      (res) => res.toMoDel(),
    );
  }

  @override
  Future<Result<List<TodoDSCVModel>>> getListDSCVGanChoNguoiKhac() {
    return runCatchingAsync<ToDoListDSCVResponse, List<TodoDSCVModel>>(
      () => _tienIchService.getListDSCVGanChoNguoiKhac(),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<List<TodoDSCVModel>>> getAllListDSCVWithFilter(
    int? pageIndex,
    int? pageSize,
    String? searchWord,
    bool? isImportant,
    bool? inUsed,
    bool? isTicked,
    String? groupId,
    bool? isGiveOther,
  ) {
    return runCatchingAsync<TodoGetAllResponse, List<TodoDSCVModel>>(
      () => _tienIchService.getAllListDSCVWithFilter(
        pageIndex,
        pageSize,
        searchWord,
        isImportant,
        inUsed,
        isTicked,
        groupId,
        isGiveOther,
      ),
      (response) => response.data?.toModel() ?? [],
    );
  }

  @override
  Future<Result<List<CountTodoModel>>> getCountTodo() {
    return runCatchingAsync<CountTodoResponse, List<CountTodoModel>>(
      () => _tienIchService.getCountTodo(),
      (response) => response.toModel(),
    );
  }
}
