import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/check_trung_lich_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tinh_huyen_xa_request.dart';
import 'package:ccvc_mobile/data/request/them_y_kien_repuest/them_y_kien_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/delete_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/huy_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/trang_thai/trang_thai_lv_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/event_calendar_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/check_trung_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/menu_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tao_moi_ban_ghi_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tinh_huyen_xa_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/tinh_trang_bao_cao_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
import 'package:ccvc_mobile/data/response/list_lich_lv/list_lich_lv_response.dart';
import 'package:ccvc_mobile/data/response/them_y_kien_response/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/lich_lam_viec_service/lich_lam_viec_service.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/cancel_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/them_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/trang_thai_lv.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/xoa_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/danh_sach_lich_lam_viec.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:dio/dio.dart';

class LichLamViecImlp implements LichLamViecRepository {
  LichLamViecService lichLamViecService;

  LichLamViecImlp(this.lichLamViecService);

  @override
  Future<Result<DashBoardLichHopModel>> getLichLv(
    String startTime,
    String endTime,
  ) {
    return runCatchingAsync<LichLamViecDashBroadResponse,
        DashBoardLichHopModel>(
      () => lichLamViecService.getLichLamViec(startTime, endTime),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<List<LichLamViecDashBroadItem>>> getLichLvRight(
      LichLamViecRightRequest lamViecRightRequest) {
    return runCatchingAsync<LichLamViecDashBroadRightResponse,
        List<LichLamViecDashBroadItem>>(
      () => lichLamViecService.getLichLamViecRight(lamViecRightRequest),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DanhSachLichlamViecModel>> postDanhSachLichLamViec(
    DanhSachLichLamViecRequest body,
  ) {
    return runCatchingAsync<DanhSachLichLamViecResponse,
        DanhSachLichlamViecModel>(
      () => lichLamViecService.postData(body),
      (response) =>
          response.data?.toModel() ?? DanhSachLichlamViecModel.empty(),
    );
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
      (response) => response.data.toDomain(),
    );
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
    DanhSachLichLamViecRequest danhSachLichLamViecRequest,
  ) {
    return runCatchingAsync<ListLichLvResponse, DataLichLvModel>(
      () => lichLamViecService.getListLichLv(danhSachLichLamViecRequest),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<DeleteTietLichLamViecModel>> deleteCalenderWork(
      String id, bool only, bool isLichLap) {
    return runCatchingAsync<DeleteCalenderWorkResponse,
        DeleteTietLichLamViecModel>(
      () => lichLamViecService.deleteCalenderWork(id, only, isLichLap),
      (response) => response.toDelete(),
    );
  }

  @override
  Future<Result<CancelLichLamViecModel>> cancelCalenderWork(
      String id, int statusId, bool isMulti) {
    return runCatchingAsync<CancelCalenderWorkResponse, CancelLichLamViecModel>(
      () => lichLamViecService.cancelCalenderWork(id, statusId, isMulti),
      (response) => response.toSucceeded(),
    );
  }

  @override
  Future<Result<List<YKienModel>>> getDanhSachYKien(String id) {
    return runCatchingAsync<DanhSachYKienResponse, List<YKienModel>>(
      () => lichLamViecService.getDanhSachYKien(id),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<MessageModel>> updateBaoCaoKetQua(
    String reportStatusId,
    String scheduleId,
    String content,
    List<File> files,
    List<String> filesDelete,
    String id,
  ) {
    return runCatchingAsync<ChinhSuaBaoCaoKetQuaResponse, MessageModel>(
      () => lichLamViecService.updateBaoCaoKetQua(
        reportStatusId,
        scheduleId,
        content,
        files,
        filesDelete,
        id,
      ),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<TinhTrangBaoCaoModel>>> getListTinhTrangBaoCao() {
    return runCatchingAsync<ListTinhTrangResponse, List<TinhTrangBaoCaoModel>>(
      () => lichLamViecService.getListTinhTrangBaoCao(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  Future<Result<List<TrangThaiLvModel>>> trangThaiLV() {
    return runCatchingAsync<TrangThaiLVResponse, List<TrangThaiLvModel>>(
      () => lichLamViecService.detailTrangThai(),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> taoLichHop(String id) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => lichLamViecService.deleteBaoCaoKetQua(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<String>>> postEventCalendar(EventCalendarRequest request) {
    return runCatchingAsync<EventCalendarResponse, List<String>>(
      () => lichLamViecService.postEventCalendar(request),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<MessageModel>> taoLichLamViec(
    String title,
    String typeScheduleId,
    String linhVucId,
    String tinhId,
    String TenTinh,
    String huyenId,
    String TenHuyen,
    String xaId,
    String TenXa,
    String country,
    String countryId,
    String dateFrom,
    String timeFrom,
    String dateTo,
    String timeTo,
    String content,
    String location,
    String vehicle,
    String expectedResults,
    String results,
    int status,
    String rejectReason,
    bool publishSchedule,
    String tags,
    bool isLichDonVi,
    bool isLichLanhDao,
    String canBoChuTriId,
    String donViId,
    String note,
    bool isAllDay,
    bool isSendMail,
    List<DonViModel> scheduleCoperativeRequest,
    int typeRemider,
    int typeRepeat,
    String dateRepeat,
    String dateRepeat1,
    bool only,
    List<int> days,
  ) {
    final _data = FormData();
    _data.fields.add(MapEntry('title', title));
    _data.fields.add(MapEntry('typeScheduleId', typeScheduleId));
    _data.fields.add(MapEntry('linhVucId', linhVucId));
    _data.fields.add(MapEntry('tinhId', tinhId));
    _data.fields.add(MapEntry('TenTinh', TenTinh));
    _data.fields.add(MapEntry('huyenId', huyenId));
    _data.fields.add(MapEntry('TenHuyen', TenHuyen));
    _data.fields.add(MapEntry('xaId', xaId));
    _data.fields.add(MapEntry('TenXa', TenXa));
    _data.fields.add(MapEntry('country', country));
    _data.fields.add(MapEntry('countryId', countryId));
    _data.fields.add(MapEntry('dateFrom', dateFrom));
    _data.fields.add(MapEntry('timeFrom', timeFrom));
    _data.fields.add(MapEntry('dateTo', dateTo));
    _data.fields.add(MapEntry('timeTo', timeTo));
    _data.fields.add(MapEntry('content', content));
    _data.fields.add(MapEntry('location', location));
    _data.fields.add(MapEntry('vehicle', vehicle));
    _data.fields.add(MapEntry('expectedResults', expectedResults));
    _data.fields.add(MapEntry('results', results));
    _data.fields.add(MapEntry('status', status.toString()));
    _data.fields.add(MapEntry('rejectReason', rejectReason));
    _data.fields.add(MapEntry('publishSchedule', publishSchedule.toString()));
    _data.fields.add(MapEntry('tags', tags));
    _data.fields.add(MapEntry('isLichDonVi', isLichDonVi.toString()));
    _data.fields.add(MapEntry('isLichLanhDao', isLichLanhDao.toString()));
    _data.fields.add(MapEntry('canBoChuTriId', canBoChuTriId));
    _data.fields.add(MapEntry('donViId', donViId));
    _data.fields.add(MapEntry('note', note));
    _data.fields.add(MapEntry('isAllDay', isAllDay.toString()));
    _data.fields.add(MapEntry('isSendMail', isSendMail.toString()));

    for (int i = 0; i < scheduleCoperativeRequest.length; i++) {
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].donViId',
          scheduleCoperativeRequest[i].id,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].canBoId',
          scheduleCoperativeRequest[i].canBoId,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].taskContent',
          scheduleCoperativeRequest[i].noidung,
        ),
      );
    }

    _data.fields
        .add(MapEntry('repeatCalendar.typeRepeat', typeRepeat.toString()));
    _data.fields.add(MapEntry(
        'scheduleReminderRequest.typeRemider', typeRemider.toString()));
    final dateRepeats = [dateRepeat, dateRepeat1];
    for (int i = 0; i < dateRepeats.length; i++) {
      _data.fields.add(
          MapEntry('repeatCalendar.dateRepeat[$i]', dateRepeats[i].toString()));
    }
    _data.fields.add(MapEntry('repeatCalendar.only', only.toString()));
    for (int i = 0; i < days.length; i++) {
      _data.fields.add(MapEntry('repeatCalendar.days[$i]', days[i].toString()));
    }

    return runCatchingAsync<TaoLichLamViecResponse, MessageModel>(
      () => lichLamViecService.taoLichLamviec(_data),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> suaLichLamViec(
    String title,
    String typeScheduleId,
    String linhVucId,
    String TenTinh,
    String TenHuyen,
    String TenXa,
    String dateFrom,
    String timeFrom,
    String dateTo,
    String timeTo,
    String content,
    String location,
    String vehicle,
    String expectedResults,
    String results,
    int status,
    String rejectReason,
    bool publishSchedule,
    String tags,
    bool isLichDonVi,
    String canBoChuTriId,
    String donViId,
    String note,
    String id,
    bool isAllDay,
    bool isSendMail,
    List<DonViModel> scheduleCoperativeRequest,
    int typeRemider,
    int typeRepeat,
    String dateRepeat,
    String dateRepeat1,
    bool only,
    List<int> days,
  ) {
    final _data = FormData();
    _data.fields.add(MapEntry('title', title));
    _data.fields.add(MapEntry('typeScheduleId', typeScheduleId));
    _data.fields.add(MapEntry('linhVucId', linhVucId));
    _data.fields.add(MapEntry('TenTinh', TenTinh));
    _data.fields.add(MapEntry('TenHuyen', TenHuyen));
    _data.fields.add(MapEntry('TenXa', TenXa));
    _data.fields.add(MapEntry('dateFrom', dateFrom));
    _data.fields.add(MapEntry('timeFrom', timeFrom));
    _data.fields.add(MapEntry('dateTo', dateTo));
    _data.fields.add(MapEntry('timeTo', timeTo));
    _data.fields.add(MapEntry('content', content));
    _data.fields.add(MapEntry('vehicle', vehicle));
    _data.fields.add(MapEntry('expectedResults', expectedResults));
    _data.fields.add(MapEntry('results', results));
    _data.fields.add(MapEntry('status', status.toString()));
    _data.fields.add(MapEntry('rejectReason', rejectReason));
    _data.fields.add(MapEntry('publishSchedule', publishSchedule.toString()));
    _data.fields.add(MapEntry('tags', tags));
    _data.fields.add(MapEntry('isLichDonVi', isLichDonVi.toString()));
    _data.fields.add(MapEntry('canBoChuTriId', canBoChuTriId));
    _data.fields.add(MapEntry('donViId', donViId));
    _data.fields.add(MapEntry('note', note));
    _data.fields.add(MapEntry('id', id));
    _data.fields.add(MapEntry('isAllDay', isAllDay.toString()));
    _data.fields.add(MapEntry('isSendMail', isSendMail.toString()));

    for (int i = 0; i < scheduleCoperativeRequest.length; i++) {
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].donViId',
          scheduleCoperativeRequest[i].id,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].canBoId',
          scheduleCoperativeRequest[i].canBoId,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].taskContent',
          scheduleCoperativeRequest[i].noidung,
        ),
      );
    }

    _data.fields
        .add(MapEntry('repeatCalendar.typeRepeat', typeRepeat.toString()));
    _data.fields.add(MapEntry(
        'scheduleReminderRequest.typeRemider', typeRemider.toString()));
    final dateRepeats = [dateRepeat, dateRepeat1];
    for (int i = 0; i < dateRepeats.length; i++) {
      _data.fields.add(
          MapEntry('repeatCalendar.dateRepeat[$i]', dateRepeats[i].toString()));
    }
    _data.fields.add(MapEntry('repeatCalendar.only', only.toString()));
    for (int i = 0; i < days.length; i++) {
      _data.fields.add(MapEntry('repeatCalendar.days[$i]', days[i].toString()));
    }

    return runCatchingAsync<TaoLichLamViecResponse, MessageModel>(
      () => lichLamViecService.suaLichLamviec(_data),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> suaLichLamViecNuocNgoai(
    String title,
    String typeScheduleId,
    String linhVucId,
    String TenTinh,
    String TenHuyen,
    String TenXa,
    String countryId,
    String dateFrom,
    String timeFrom,
    String dateTo,
    String timeTo,
    String content,
    String location,
    String vehicle,
    String expectedResults,
    String results,
    int status,
    String rejectReason,
    bool publishSchedule,
    String tags,
    bool isLichDonVi,
    String canBoChuTriId,
    String donViId,
    String note,
    String id,
    bool isAllDay,
    bool isSendMail,
    List<DonViModel> scheduleCoperativeRequest,
    int typeRemider,
    int typeRepeat,
    String dateRepeat,
    String dateRepeat1,
    bool only,
    List<int> days,
  ) {
    final _data = FormData();
    _data.fields.add(MapEntry('title', title));
    _data.fields.add(MapEntry('typeScheduleId', typeScheduleId));
    _data.fields.add(MapEntry('linhVucId', linhVucId));
    _data.fields.add(MapEntry('TenTinh', TenTinh));
    _data.fields.add(MapEntry('TenHuyen', TenHuyen));
    _data.fields.add(MapEntry('TenXa', TenXa));
    _data.fields.add(MapEntry('countryId', countryId));
    _data.fields.add(MapEntry('dateFrom', dateFrom));
    _data.fields.add(MapEntry('timeFrom', timeFrom));
    _data.fields.add(MapEntry('dateTo', dateTo));
    _data.fields.add(MapEntry('timeTo', timeTo));
    _data.fields.add(MapEntry('content', content));
    _data.fields.add(MapEntry('vehicle', vehicle));
    _data.fields.add(MapEntry('expectedResults', expectedResults));
    _data.fields.add(MapEntry('results', results));
    _data.fields.add(MapEntry('status', status.toString()));
    _data.fields.add(MapEntry('rejectReason', rejectReason));
    _data.fields.add(MapEntry('publishSchedule', publishSchedule.toString()));
    _data.fields.add(MapEntry('tags', tags));
    _data.fields.add(MapEntry('isLichDonVi', isLichDonVi.toString()));
    _data.fields.add(MapEntry('canBoChuTriId', canBoChuTriId));
    _data.fields.add(MapEntry('donViId', donViId));
    _data.fields.add(MapEntry('note', note));
    _data.fields.add(MapEntry('id', id));
    _data.fields.add(MapEntry('isAllDay', isAllDay.toString()));
    _data.fields.add(MapEntry('isSendMail', isSendMail.toString()));

    for (int i = 0; i < scheduleCoperativeRequest.length; i++) {
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].donViId',
          scheduleCoperativeRequest[i].id,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].canBoId',
          scheduleCoperativeRequest[i].canBoId,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].taskContent',
          scheduleCoperativeRequest[i].noidung,
        ),
      );
    }

    _data.fields
        .add(MapEntry('repeatCalendar.typeRepeat', typeRepeat.toString()));
    _data.fields.add(MapEntry(
        'scheduleReminderRequest.typeRemider', typeRemider.toString()));
    final dateRepeats = [dateRepeat, dateRepeat1];
    for (int i = 0; i < dateRepeats.length; i++) {
      _data.fields.add(
          MapEntry('repeatCalendar.dateRepeat[$i]', dateRepeats[i].toString()));
    }
    _data.fields.add(MapEntry('repeatCalendar.only', only.toString()));
    for (int i = 0; i < days.length; i++) {
      _data.fields.add(MapEntry('repeatCalendar.days[$i]', days[i].toString()));
    }

    return runCatchingAsync<TaoLichLamViecResponse, MessageModel>(
      () => lichLamViecService.suaLichLamviec(_data),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> taoBaoCaoKetQua(
    String reportStatusId,
    String scheduleId,
    List<File> files,
  ) {
    return runCatchingAsync<TaoBaoCaoKetQuaResponse, MessageModel>(
      () =>
          lichLamViecService.taoBaoCaoKetQua(reportStatusId, scheduleId, files),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> postTaoMoiBanGhi(TaoMoiBanGhiRequest body) {
    return runCatchingAsync<TaoMoiBanGhiResponse, MessageModel>(
      () => lichLamViecService.taoMoiBanGhi(body),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<List<MenuModel>>> getDataMenu(
      String startTime, String endTime) {
    return runCatchingAsync<MenuResponse, List<MenuModel>>(
      () => lichLamViecService.getMenuLichLV(startTime, endTime),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ThemYKienModel>> themYKien(ThemYKienRequest themYKienRequest) {
    return runCatchingAsync<ThemYKienResponse, ThemYKienModel>(
      () => lichLamViecService.themYKien(themYKienRequest),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DaTaTinhSelectModel>> tinhSelect(
      TinhSelectRequest tinhSelectRequest) {
    return runCatchingAsync<PageDaTaTinhSelectModelResponse,
        DaTaTinhSelectModel>(
      () => lichLamViecService.tinhSelect(tinhSelectRequest),
      (response) => response.data?.toModel() ?? DaTaTinhSelectModel(),
    );
  }

  @override
  Future<Result<DaTaHuyenSelectModel>> huyenSelect(
      HuyenSelectRequest huyenSelectRequest) {
    return runCatchingAsync<PageDaTaHuyenSelectModelResponse,
        DaTaHuyenSelectModel>(
      () => lichLamViecService.huyenSelect(huyenSelectRequest),
      (response) => response.data?.toModel() ?? DaTaHuyenSelectModel(),
    );
  }

  @override
  Future<Result<DaTaXaSelectModel>> xaSelect(XaSelectRequest xaSelectRequest) {
    return runCatchingAsync<PageDaTaXaSelectModelResponse, DaTaXaSelectModel>(
      () => lichLamViecService.xaSelect(xaSelectRequest),
      (response) => response.data?.toModel() ?? DaTaXaSelectModel(),
    );
  }

  @override
  Future<Result<DataDatNuocSelectModel>> datNuocSelect(
      DatNuocSelectRequest datNuocSelectRequest) {
    return runCatchingAsync<PageDataDatNuocSelectModelResponse,
        DataDatNuocSelectModel>(
      () => lichLamViecService.datNuocSelect(datNuocSelectRequest),
      (response) => response.data?.toModel() ?? DataDatNuocSelectModel(),
    );
  }

  @override
  Future<Result<MessageModel>> checkTrungLichLamviec(
      CheckTrungLichRequest body) {
    return runCatchingAsync<CheckTrungLichLamViecResponse, MessageModel>(
        () => lichLamViecService.checkTrungLichLamviec(body),
        (response) => response.toDomain());
  }
}
