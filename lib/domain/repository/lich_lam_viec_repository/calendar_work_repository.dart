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
import 'package:ccvc_mobile/data/result/result.dart';
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

mixin CalendarWorkRepository {
  Future<Result<DashBoardLichHopModel>> getLichLv(
    String startTime,
    String endTime,
  );

  Future<Result<List<MenuModel>>> getDataMenu(String startTime, String endTime);

  Future<Result<List<LichLamViecDashBroadItem>>> getLichLvRight(
      LichLamViecRightRequest lamViecRightRequest);

  Future<Result<DanhSachLichlamViecModel>> postDanhSachLichLamViec(
    DanhSachLichLamViecRequest body,
  );

  Future<Result<List<String>>> postEventCalendar(EventCalendarRequest request);

  Future<Result<List<LoaiSelectModel>>> getLoaiLich(
    CatogoryListRequest catogoryListRequest,
  );

  Future<Result<List<NguoiChutriModel>>> getNguoiChuTri(
      NguoiChuTriRequest nguoiChuTriRequest);

  Future<Result<List<LoaiSelectModel>>> getLinhVuc(
    CatogoryListRequest catogoryListRequest,
  );

  Future<Result<ChiTietLichLamViecModel>> detailCalenderWork(
    String id,
  );

  Future<Result<List<BaoCaoModel>>> getDanhSachBaoCao(String scheduleId);

  Future<Result<MessageModel>> deleteBaoCaoKetQua(String id);

  Future<Result<MessageModel>> recallWorkCalendar(
    bool isMulti,
    List<RecallRequest> request,
  );

  Future<Result<DataLichLvModel>> getListLichLamViec(
    DanhSachLichLamViecRequest danhSachLichLamViecRequest,
  );

  Future<Result<DeleteTietLichLamViecModel>> deleteCalenderWork(
    String id,
    bool only,
  );

  Future<Result<CancelLichLamViecModel>> cancelCalenderWork(
    String id,
    int statusId,
    bool isMulti,
  );

  Future<Result<List<YKienModel>>> getDanhSachYKien(String id);

  Future<Result<MessageModel>> updateBaoCaoKetQua(
    String reportStatusId,
    String scheduleId,
    String content,
    List<File> files,
    List<String> filesDelete,
    String id,
  );

  Future<Result<List<TrangThaiLvModel>>> trangThaiLV();

  Future<Result<MessageModel>> postTaoMoiBanGhi(TaoMoiBanGhiRequest body);

  Future<Result<List<TinhTrangBaoCaoModel>>> getListTinhTrangBaoCao();

  Future<Result<MessageModel>> checkDuplicate(CheckTrungLichRequest body);

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
    required int typeRepeat,
    required String dateRepeat,
    required String dateRepeat1,
    required bool only,
    required List<int> days,
  });

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
    required List<String> filesDelete,
    required List<DonViModel> scheduleCoperativeRequest,
    required int? typeRemider,
    required int typeRepeat,
    required String dateRepeat,
    required String dateRepeat1,
    required bool only,
    required List<int> days,
  });

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
    required List<String> filesDelete,
    required List<DonViModel> scheduleCoperativeRequest,
    required int typeRemider,
    required int typeRepeat,
    required String dateRepeat,
    required String dateRepeat1,
    required bool only,
    required List<int> days,
  });

  Future<Result<MessageModel>> taoBaoCaoKetQua(
    String reportStatusId,
    String scheduleId,
    String content,
    List<File> files,
  );

  Future<Result<MessageModel>> suaBaoCaoKetQua(
      {required String id,
      required String reportStatusId,
      required String scheduleId,
      required String content,
      required List<File> files,
      required List<String> idFileDelele});

  Future<Result<ThemYKienModel>> themYKien(ThemYKienRequest themYKienRequest);

  Future<Result<DaTaTinhSelectModel>> tinhSelect(
      TinhSelectRequest tinhSelectRequest);

  Future<Result<DaTaHuyenSelectModel>> getDistrict(
      HuyenSelectRequest huyenSelectRequest);

  Future<Result<DaTaXaSelectModel>> getWard(WardRequest xaSelectRequest);

  Future<Result<DataDatNuocSelectModel>> getCountry(
      DatNuocSelectRequest datNuocSelectRequest);

  Future<Result<TimeConfig>> getConfigTime();

  Future<Result<bool>> cuCanBoDiThayLichLamViec(
    DataCuCanBoDiThayLichLamViecRequest cuCanBoDiThayLichLamViecRequest,
  );

  Future<Result<bool>> cuCanBoLichLamViec(
    DataCuCanBoLichLamViecRequest cuCanBoLichLamViecRequest,
  );
}
