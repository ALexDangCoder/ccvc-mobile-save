
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_lich_lam_viec_response.dart';

import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
import 'package:ccvc_mobile/data/request/list_lich_lv/list_lich_lv_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/delete_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/list_lich_lv/list_lich_lv_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/lich_lam_viec_service/lich_lam_viec_service.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/xoa_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/huy_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/danh_sach_lich_lam_viec.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/cancel_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';

class LichLamViecImlp implements LichLamViecRepository {
  LichLamViecService lichLamViecService;

  LichLamViecImlp(this.lichLamViecService);

  @override
  Future<Result<LichLamViecDashBroad>> getLichLv(
    String startTime,
    String endTime,
  ) {
    return runCatchingAsync<LichLamViecDashBroadResponse, LichLamViecDashBroad>(
      () => lichLamViecService.getLichLamViec(startTime, endTime),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<List<LichLamViecDashBroadItem>>> getLichLvRight(
    String dateStart,
    String dateTo,
    int type,
  ) {
    return runCatchingAsync<LichLamViecDashBroadRightResponse,
        List<LichLamViecDashBroadItem>>(
      () => lichLamViecService.getLichLamViecRight(
        dateStart,
        dateTo,
        type,
      ),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DanhSachLichlamViecModel>> postDanhSachLichLamViec(
      DanhSachLichLamViecRequest body) {
    return runCatchingAsync<DanhSachLichLamViecResponse,
            DanhSachLichlamViecModel>(
        () => lichLamViecService.postData(body),
        (response) =>
            response.data?.toModel() ?? DanhSachLichlamViecModel.empty());
  }

  @override
  Future<Result<List<LoaiSelectModel>>> getLoaiLich(
    CatogoryListRequest catogoryListRequest,
  ) {
return runCatchingAsync<CatogoryListResponse, List<LoaiSelectModel>>(
() => lichLamViecService.getLoaiLichLamViec(catogoryListRequest),
(res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
);
}

@override
  Future<Result<ChiTietLichLamViecModel>> detailCalenderWork(String id) {
    return runCatchingAsync<DetailCalenderWorkResponse,
            ChiTietLichLamViecModel>(
        () => lichLamViecService.detailCalenderWork(id),
        (response) => response.data.toModel());
  }

  @override
  Future<Result<List<BaoCaoModel>>> getDanhSachBaoCao(String scheduleId) {
    return runCatchingAsync<DanhSachBaoCaoResponse, List<BaoCaoModel>>(
      () => lichLamViecService.getDanhSachBaoCaoKetQua(scheduleId),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NguoiChutriModel>>> getNguoiChuTri(
    NguoiChuTriRequest nguoiChuTriRequest,
  ) {
    return runCatchingAsync<NguoiChuTriResponse, List<NguoiChutriModel>>(
      () => lichLamViecService.getNguoiChuTri(nguoiChuTriRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<LoaiSelectModel>>> getLinhVuc(
    CatogoryListRequest catogoryListRequest,
  ) {
    return runCatchingAsync<CatogoryListResponse, List<LoaiSelectModel>>(
      () => lichLamViecService.getLinhVuc(catogoryListRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<MessageModel>> deleteBaoCaoKetQua(String id) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => lichLamViecService.deleteBaoCaoKetQua(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DataLichLvModel>> getListLichLamViec(
      ListLichLvRequest lichLvRequest) {
    return runCatchingAsync<ListLichLvResponse, DataLichLvModel>(
      () => lichLamViecService.getListLichLv(lichLvRequest),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<DeleteTietLichLamViecModel>> deleteCalenderWork(String id) {
    return runCatchingAsync<DeleteCalenderWorkResponse,
        DeleteTietLichLamViecModel>(
      () => lichLamViecService.deleteCalenderWork(id),
      (response) => response.toDelete(),
    );
  }

  @override
  Future<Result<CancelLichLamViecModel>> cancelCalenderWork(String id) {
    return runCatchingAsync<CancelCalenderWorkResponse, CancelLichLamViecModel>(
        () => lichLamViecService.cancelCalenderWork(id),
        (response) => response.toSucceeded());
  }
}
