import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/check_trung_lich_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_di_thay_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/cu_can_bo_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/thu_hoi_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tinh_huyen_xa_request.dart';
import 'package:ccvc_mobile/data/request/them_y_kien_repuest/them_y_kien_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/data_config_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/delete_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/huy_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/trang_thai/trang_thai_lv_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/event_calendar_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/check_trung_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/cu_can_bo_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_lich_lam_viec_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/menu_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/sua_lich_lam_viec_response.dart';
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
import 'package:ccvc_mobile/domain/model/lich_hop/time_config.dart';
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
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/calendar_work_repository.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/cu_can_bo_di_thay_lich_lam_viec_widget.dart';
import 'package:dio/dio.dart';

class CreateWorkCalendarRepositoryImpl implements CalendarWorkRepository {
  WorkCalendarService workCalendarService;

  CreateWorkCalendarRepositoryImpl(this.workCalendarService);

  @override
  Future<Result<DashBoardLichHopModel>> getLichLv(
    String startTime,
    String endTime,
  ) {
    return runCatchingAsync<LichLamViecDashBroadResponse,
        DashBoardLichHopModel>(
      () => workCalendarService.getLichLamViec(startTime, endTime),
      (response) => response.data?.toDomain() ?? DashBoardLichHopModel.empty(),
    );
  }

  @override
  Future<Result<List<LichLamViecDashBroadItem>>> getLichLvRight(
      LichLamViecRightRequest lamViecRightRequest) {
    return runCatchingAsync<LichLamViecDashBroadRightResponse,
        List<LichLamViecDashBroadItem>>(
      () => workCalendarService.getLichLamViecRight(lamViecRightRequest),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DanhSachLichlamViecModel>> postDanhSachLichLamViec(
    DanhSachLichLamViecRequest body,
  ) {
    return runCatchingAsync<DanhSachLichLamViecResponse,
        DanhSachLichlamViecModel>(
      () => workCalendarService.postData(body),
      (response) =>
          response.data?.toModel() ?? DanhSachLichlamViecModel.empty(),
    );
  }

  @override
  Future<Result<List<LoaiSelectModel>>> getLoaiLich(
    CatogoryListRequest catogoryListRequest,
  ) {
    return runCatchingAsync<CatogoryListResponse, List<LoaiSelectModel>>(
      () => workCalendarService.getLoaiLichLamViec(catogoryListRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<ChiTietLichLamViecModel>> detailCalenderWork(String id) {
    return runCatchingAsync<DetailCalenderWorkResponse,
        ChiTietLichLamViecModel>(
      () => workCalendarService.detailCalenderWork(id),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<List<BaoCaoModel>>> getDanhSachBaoCao(String scheduleId) {
    return runCatchingAsync<DanhSachBaoCaoResponse, List<BaoCaoModel>>(
      () => workCalendarService.getDanhSachBaoCaoKetQua(scheduleId),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NguoiChutriModel>>> getNguoiChuTri(
    NguoiChuTriRequest nguoiChuTriRequest,
  ) {
    return runCatchingAsync<NguoiChuTriResponse, List<NguoiChutriModel>>(
      () => workCalendarService.getNguoiChuTri(nguoiChuTriRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<LoaiSelectModel>>> getLinhVuc(
    CatogoryListRequest catogoryListRequest,
  ) {
    return runCatchingAsync<CatogoryListResponse, List<LoaiSelectModel>>(
      () => workCalendarService.getLinhVuc(catogoryListRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<MessageModel>> deleteBaoCaoKetQua(String id) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => workCalendarService.deleteBaoCaoKetQua(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DataLichLvModel>> getListLichLamViec(
    DanhSachLichLamViecRequest danhSachLichLamViecRequest,
  ) {
    return runCatchingAsync<ListLichLvResponse, DataLichLvModel>(
      () => workCalendarService.getListLichLv(danhSachLichLamViecRequest),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<DeleteTietLichLamViecModel>> deleteCalenderWork(
    String id,
    bool only,
  ) {
    return runCatchingAsync<MessageResponse, DeleteTietLichLamViecModel>(
      () => workCalendarService.deleteCalenderWork(id, only),
      (response) => response.toDelete(),
    );
  }

  @override
  Future<Result<CancelLichLamViecModel>> cancelCalenderWork(
    String id,
    int statusId,
    bool isMulti,
  ) {
    return runCatchingAsync<CancelCalenderWorkResponse, CancelLichLamViecModel>(
      () => workCalendarService.cancelCalenderWork(id, statusId, isMulti),
      (response) => response.toSucceeded(),
    );
  }

  @override
  Future<Result<List<YKienModel>>> getDanhSachYKien(String id) {
    return runCatchingAsync<DanhSachYKienResponse, List<YKienModel>>(
      () => workCalendarService.getDanhSachYKien(id),
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
      () => workCalendarService.updateBaoCaoKetQua(
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
      () => workCalendarService.getListTinhTrangBaoCao(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TrangThaiLvModel>>> trangThaiLV() {
    return runCatchingAsync<TrangThaiLVResponse, List<TrangThaiLvModel>>(
      () => workCalendarService.detailTrangThai(),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> taoLichHop(String id) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => workCalendarService.deleteBaoCaoKetQua(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<String>>> postEventCalendar(EventCalendarRequest request) {
    return runCatchingAsync<EventCalendarResponse, List<String>>(
      () => workCalendarService.postEventCalendar(request),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<MessageModel>> editWorkCalendarWorkAboard({
    required String title,
    required String typeScheduleId,
    required String linhVucId,
    required String TenTinh,
    required String TenHuyen,
    required String TenXa,
    required String countryId,
    required String dateFrom,
    required String timeFrom,
    required String dateTo,
    required String timeTo,
    required String content,
    required String location,
    required String vehicle,
    required String expectedResults,
    required String results,
    required int status,
    required String rejectReason,
    required bool publishSchedule,
    required String tags,
    required bool isLichDonVi,
    required String canBoChuTriId,
    required String donViId,
    required String note,
    required String id,
    required bool isAllDay,
    required bool isSendMail,
    required List<File>? files,
    required List<String>? filesDelete,
    required List<DonViModel> scheduleCoperativeRequest,
    required int typeRemider,
    required int typeRepeat,
    required String dateRepeat,
    required String dateRepeat1,
    required bool only,
    required List<int> days,
  }) {
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
    _data.fields.add(MapEntry('location', location));
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
          scheduleCoperativeRequest[i].donViId,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].canBoId',
          scheduleCoperativeRequest[i].userId,
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
    files?.forEach((element) async {
      final MultipartFile file = await MultipartFile.fromFile(
        element.path,
      );
      _data.files.add(MapEntry('Files', file));
    });
    for (int i = 0; i < (filesDelete ?? []).length; i++) {
      _data.fields
          .add(MapEntry('filesDelete', (filesDelete ?? [])[i].toString()));
    }

    return runCatchingAsync<SuaLichLamViecResponse, MessageModel>(
      () => workCalendarService.suaLichLamviec(_data),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> taoBaoCaoKetQua(
    String reportStatusId,
    String scheduleId,
    String content,
    List<File> files,
  ) {
    return runCatchingAsync<TaoBaoCaoKetQuaResponse, MessageModel>(
      () => workCalendarService.taoBaoCaoKetQua(
          reportStatusId, scheduleId, content, files),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> postTaoMoiBanGhi(TaoMoiBanGhiRequest body) {
    return runCatchingAsync<TaoMoiBanGhiResponse, MessageModel>(
      () => workCalendarService.taoMoiBanGhi(body),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<List<MenuModel>>> getDataMenu(
      String startTime, String endTime) {
    return runCatchingAsync<MenuResponse, List<MenuModel>>(
      () => workCalendarService.getMenuLichLV(startTime, endTime),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ThemYKienModel>> themYKien(ThemYKienRequest themYKienRequest) {
    return runCatchingAsync<ThemYKienResponse, ThemYKienModel>(
      () => workCalendarService.themYKien(themYKienRequest),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DaTaTinhSelectModel>> tinhSelect(
      TinhSelectRequest tinhSelectRequest) {
    return runCatchingAsync<PageDaTaTinhSelectModelResponse,
        DaTaTinhSelectModel>(
      () => workCalendarService.tinhSelect(tinhSelectRequest),
      (response) => response.data?.toModel() ?? DaTaTinhSelectModel(),
    );
  }

  @override
  Future<Result<DaTaHuyenSelectModel>> getDistrict(
      HuyenSelectRequest huyenSelectRequest) {
    return runCatchingAsync<PageDaTaHuyenSelectModelResponse,
        DaTaHuyenSelectModel>(
      () => workCalendarService.huyenSelect(huyenSelectRequest),
      (response) => response.data?.toModel() ?? DaTaHuyenSelectModel(),
    );
  }

  @override
  Future<Result<DaTaXaSelectModel>> getWard(WardRequest xaSelectRequest) {
    return runCatchingAsync<PageDaTaXaSelectModelResponse, DaTaXaSelectModel>(
      () => workCalendarService.xaSelect(xaSelectRequest),
      (response) => response.data?.toModel() ?? DaTaXaSelectModel(),
    );
  }

  @override
  Future<Result<DataDatNuocSelectModel>> getCountry(
      DatNuocSelectRequest datNuocSelectRequest) {
    return runCatchingAsync<PageDataDatNuocSelectModelResponse,
        DataDatNuocSelectModel>(
      () => workCalendarService.datNuocSelect(datNuocSelectRequest),
      (response) => response.data?.toModel() ?? DataDatNuocSelectModel(),
    );
  }

  @override
  Future<Result<MessageModel>> checkDuplicate(CheckTrungLichRequest body) {
    return runCatchingAsync<CheckTrungLichLamViecResponse, MessageModel>(
        () => workCalendarService.checkTrungLichLamviec(body),
        (response) => response.toDomain());
  }

  @override
  Future<Result<MessageModel>> suaBaoCaoKetQua(
      {required String id,
      required String reportStatusId,
      required String scheduleId,
      required String content,
      required List<File> files,
      required List<String> idFileDelele}) {
    return runCatchingAsync<TaoBaoCaoKetQuaResponse, MessageModel>(
      () => workCalendarService.suaBaoCaoKetQua(
          reportStatusId, scheduleId, content, files, idFileDelele, id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> createWorkCalendar({
    required String title,
    required String typeScheduleId,
    required String linhVucId,
    required String tinhId,
    required String TenTinh,
    required String huyenId,
    required String TenHuyen,
    required String xaId,
    required String TenXa,
    required String country,
    required String countryId,
    required String dateFrom,
    required String timeFrom,
    required String dateTo,
    required String timeTo,
    required String content,
    required String location,
    required String vehicle,
    required String expectedResults,
    required String results,
    required int status,
    required String rejectReason,
    required bool publishSchedule,
    required String tags,
    required bool isLichDonVi,
    required bool isLichLanhDao,
    required String canBoChuTriId,
    required String donViId,
    required String note,
    required bool isAllDay,
    required bool isSendMail,
    required List<File>? files,
    required List<DonViModel> scheduleCoperativeRequest,
    required int? typeRemider,
    required int? typeRepeat,
    required String dateRepeat,
    required String dateRepeat1,
    required bool only,
    required List<int> days,
  }) async {
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
          scheduleCoperativeRequest[i].donViId,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].canBoId',
          scheduleCoperativeRequest[i].userId,
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
    files?.forEach((element) async {
      final MultipartFile file = await MultipartFile.fromFile(
        element.path,
      );
      _data.files.add(MapEntry('Files', file));
    });

    return runCatchingAsync<TaoLichLamViecResponse, MessageModel>(
      () => workCalendarService.createWorkCalendar(_data, files ?? []),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> suaLichLamViec({
    required String title,
    required String typeScheduleId,
    required String linhVucId,
    required String TenTinh,
    required String TenHuyen,
    required String TenXa,
    required String dateFrom,
    required String timeFrom,
    required String dateTo,
    required String timeTo,
    required String content,
    required String location,
    required String vehicle,
    required String expectedResults,
    required String results,
    required int status,
    required String rejectReason,
    required bool publishSchedule,
    required String tags,
    required bool isLichDonVi,
    required String canBoChuTriId,
    required String donViId,
    required String note,
    required String id,
    required bool isAllDay,
    required bool isSendMail,
    required List<File>? files,
    required List<String>? filesDelete,
    required List<DonViModel> scheduleCoperativeRequest,
    required int? typeRemider,
    required int typeRepeat,
    required String dateRepeat,
    required String dateRepeat1,
    required bool only,
    required List<int> days,
  }) {
    final _data = FormData();
    _data.fields.add(MapEntry('title', title));
    _data.fields.add(MapEntry('typeScheduleId', typeScheduleId));
    _data.fields.add(MapEntry('linhVucId', linhVucId));
    _data.fields.add(MapEntry('TenTinh', TenTinh));
    _data.fields.add(MapEntry('TenHuyen', TenHuyen));
    _data.fields.add(MapEntry('TenXa', TenXa));
    _data.fields.add(MapEntry('location', location));
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
          scheduleCoperativeRequest[i].donViId,
        ),
      );
      _data.fields.add(
        MapEntry(
          'ScheduleCoperativeRequest[$i].canBoId',
          scheduleCoperativeRequest[i].userId,
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
    files?.forEach((element) async {
      final MultipartFile file = await MultipartFile.fromFile(
        element.path,
      );
      _data.files.add(MapEntry('Files', file));
    });
    for (int i = 0; i < (filesDelete ?? []).length; i++) {
      _data.fields
          .add(MapEntry('filesDelete', (filesDelete ?? [])[i].toString()));
    }

    return runCatchingAsync<SuaLichLamViecResponse, MessageModel>(
      () => workCalendarService.suaLichLamviec(_data),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> recallWorkCalendar(
    bool isMulti,
    List<RecallRequest> request,
  ) {
    return runCatchingAsync<MessageResponse, MessageModel>(
      () => workCalendarService.recallWorkCalendar(request, isMulti),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<TimeConfig>> getConfigTime() {
    return runCatchingAsync<DataConfigResponse, TimeConfig>(
      () => workCalendarService.getConfigTime(),
      (res) => res.data?.first.toTimeModel() ?? TimeConfig(),
    );
  }

  @override
  Future<Result<bool>> cuCanBoDiThayLichLamViec(
      DataCuCanBoDiThayLichLamViecRequest dataCuCanBoDiThayLichLamViecRequest) {
    return runCatchingAsync<CuCanBoLichLamViecResponse, bool>(
          () =>
          workCalendarService
              .cuCanBoDiThayLichLamViec(dataCuCanBoDiThayLichLamViecRequest),
          (response) => response.isSuccess,
    );
  }

  @override
  Future<Result<bool>> cuCanBoLichLamViec(
      DataCuCanBoLichLamViecRequest dataCuCanBoLichLamViecRequest) {
    return runCatchingAsync<CuCanBoLichLamViecResponse, bool>(
          () =>
          workCalendarService.cuCanBoLichLamViec(dataCuCanBoLichLamViecRequest),
          (response) => response.isSuccess,
    );
  }
}
