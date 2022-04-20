import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/so_luong_phat_bieu_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/add_file_tao_lich_hop.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/chi_tiet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_nhiem_vu_Chi_tiet_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_nhiem_vu_kl_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_y_kien_lich_hop.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/status_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thiet_bi_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thong_tin_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/xem_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chon_bien_ban_cuoc_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/co_cau_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_bieu_quyet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phat_bieu_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dash_board_lh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dashborad_thong_ke_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/event_calendar_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/gui_mail_ket_luat-response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/moi_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/select_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/statistic_by_month_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_ket_luan_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_moi_bieu_quayet_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/ti_le_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/to_chuc_boi_don_vi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tong_phien_hop_respone.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/danh_sach_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/list_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/menu_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/lich_hop/hop_services.dart';
import 'package:ccvc_mobile/domain/model/add_file_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/bieu_quyet_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/gui_mail_ket_luat_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/select_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/them_y_kiem_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/co_cau_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';

class HopRepositoryImpl implements HopRepository {
  final HopServices _hopServices;

  HopRepositoryImpl(this._hopServices);

  @override
  Future<Result<DashBoardLichHopModel>> getDashBoardLichHop(
    String dateStart,
    String dateTo,
  ) {
    return runCatchingAsync<DashBoardLichHopResponse, DashBoardLichHopModel>(
      () => _hopServices.getData(dateStart, dateTo),
      (response) => response.data?.toModel() ?? DashBoardLichHopModel.empty(),
    );
  }

  @override
  Future<Result<DanhSachLichHopModel>> postDanhSachLichHop(
    DanhSachLichHopRequest body,
  ) {
    return runCatchingAsync<DanhSachLichHopResponse, DanhSachLichHopModel>(
      () => _hopServices.postData(body),
      (response) => response.data?.toModel() ?? DanhSachLichHopModel.empty(),
    );
  }

  @override
  Future<Result<List<LoaiSelectModel>>> getLoaiHop(
    CatogoryListRequest catogoryListRequest,
  ) {
    return runCatchingAsync<CatogoryListResponse, List<LoaiSelectModel>>(
      () => _hopServices.getLoaiHop(catogoryListRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<LoaiSelectModel>>> getLinhVuc(
    CatogoryListRequest catogoryListRequest,
  ) {
    return runCatchingAsync<CatogoryListResponse, List<LoaiSelectModel>>(
      () => _hopServices.getLinhVuc(catogoryListRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NguoiChutriModel>>> getNguoiChuTri(
    NguoiChuTriRequest nguoiChuTriRequest,
  ) {
    return runCatchingAsync<NguoiChuTriResponse, List<NguoiChutriModel>>(
      () => _hopServices.getNguoiChuTri(nguoiChuTriRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NguoiChutriModel>>> getDanhSachNguoiChuTriPhienHop(
    String id,
  ) {
    return runCatchingAsync<DanhSachCanBoHopResponse, List<NguoiChutriModel>>(
      () => _hopServices.getDanhSachChuTri(id),
      (res) => res.data?.listCanBo?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<AddFileModel>> postFileTaoLichHop(
    int entityType,
    String entityName,
    String entityId,
    bool isMutil,
    List<File> files,
  ) {
    return runCatchingAsync<AddFileTaoLichHopResponse, AddFileModel>(
      () => _hopServices.postFile(
        entityType,
        entityName,
        entityId,
        isMutil,
        files,
      ),
      (response) => response.toModel(),
    );
  }

  Future<Result<List<ListPhienHopModel>>> getDanhSachPhienHop(
    String id,
  ) {
    return runCatchingAsync<ListPhienHopRespone, List<ListPhienHopModel>>(
      () => _hopServices.getDanhSachPhienHop(id),
      (res) => res.toDomain(),
    );
  }

  Future<Result<ChiTietLichHopModel>> getChiTietLichHop(String id) {
    return runCatchingAsync<ChiTietLichHopResponse, ChiTietLichHopModel>(
        () => _hopServices.getChiTietLichHop(id),
        (res) => res.data?.toDomain() ?? ChiTietLichHopModel());
  }

  Future<Result<List<TaoPhienHopModel>>> getThemPhienHop(
    String lichHopId,
    String canBoId,
    String donViId,
    String thoiGian_BatDau,
    String thoiGian_KetThuc,
    String noiDung,
    String tieuDe,
    String hoTen,
    bool IsMultipe,
    List<FilesRepuest> file,
  ) {
    return runCatchingAsync<TaoPhienHopResponse, List<TaoPhienHopModel>>(
      () => _hopServices.getThemPhienHop(
        lichHopId,
        canBoId,
        donViId,
        thoiGian_BatDau,
        thoiGian_KetThuc,
        noiDung,
        tieuDe,
        hoTen,
        IsMultipe,
        file,
      ),
      (res) => res.toMoDel(),
    );
  }

  @override
  Future<Result<ChuongTrinhHopModel>> getChuongTrinhHop(String id) {
    return runCatchingAsync<ChuongTrinhHopResponse, ChuongTrinhHopModel>(
      () => _hopServices.getChuongTrinhHop(id),
      (response) => response.data?.toModel() ?? ChuongTrinhHopModel.empty(),
    );
  }

  @override
  Future<Result<ThongTinPhongHopModel?>> getListThongTinPhongHop(
      String idLichHop) {
    return runCatchingAsync<ThongTinPhongHopResponse, ThongTinPhongHopModel?>(
      () => _hopServices.getDanhSachPhongHop(idLichHop),
      (res) => res.data?.toDomain(),
    );
  }

  @override
  Future<Result<List<PhatBieuModel>>> getDanhSachPhatBieuLichHop(
    int status,
    String lichHopId,
  ) {
    return runCatchingAsync<DanhSachPhatBieuLichHopDataResponse,
        List<PhatBieuModel>>(
      () => _hopServices.getDanhSachPhatBieuLichHop(status, lichHopId),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<List<PhatBieuModel>>> getDanhSachPhatBieuLichHopNoStatus(
    String lichHopId,
  ) {
    return runCatchingAsync<DanhSachPhatBieuLichHopDataResponse,
        List<PhatBieuModel>>(
      () => _hopServices.getDanhSachPhatBieuLichHopNoStatus(lichHopId),
      (res) => res.toModel(),
    );
  }

  Future<Result<List<PhatBieuModel>>> getDanhSachBieuQuyetLichHop(
    String id,
  ) {
    return runCatchingAsync<DanhSachBieuQuyetLichHopDataResponse,
        List<PhatBieuModel>>(
      () => _hopServices.getDanhSachBieuQuyetLichHop(id),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<ChuongTrinhHopModel>> getDanhSachCanBoTPTG(String id) {
    return runCatchingAsync<ChuongTrinhHopResponse, ChuongTrinhHopModel>(
      () => _hopServices.getChuongTrinhHop(id),
      (response) => response.data?.toModel() ?? ChuongTrinhHopModel.empty(),
    );
  }

  @override
  Future<Result<SoLuongPhatBieuModel>> getSoLuongPhatBieu(String id) {
    return runCatchingAsync<SoLuongPhatBieuResponse, SoLuongPhatBieuModel>(
      () => _hopServices.getSoLuongPhatBieu(id),
      (res) => res.data.toDomain(),
    );
  }

  @override
  Future<Result<TongPhienHopModel>> getTongPhienHop(String id) {
    return runCatchingAsync<TongPhienHopResponse, TongPhienHopModel>(
      () => _hopServices.getTongPhienHop(id),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<SelectPhienHopModel>> slectPhienHop(String id) {
    return runCatchingAsync<SelectPhienHopResponse, SelectPhienHopModel>(
      () => _hopServices.selectPhienHop(id),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<BieuQuyetModel>> themBieuQuyet(
      BieuQuyetRequest bieuQuyetRequest) {
    return runCatchingAsync<ThemMoiBieuQuyetResponse, BieuQuyetModel>(
      () => _hopServices.themBieuQuyet(bieuQuyetRequest),
      (response) => response.data.todoMain(),
    );
  }

  @override
  Future<Result<GuiMailKetLuatHopModel>> sendMailKetLuanHop(String id) {
    return runCatchingAsync<GuiMailKetLuanHopResponse, GuiMailKetLuatHopModel>(
      () => _hopServices.sendMailKetLuatHop(id),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ThemYKiemModel>> themYKienHop(
    ThemYKienRequest themYKienRequest,
  ) {
    return runCatchingAsync<ThemYKienResponse, ThemYKiemModel>(
      () => _hopServices.themYKien(themYKienRequest),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ChonBienBanCuocHopModel>> postChonMauBienBanHop(
    ChonBienBanHopRequest chonBienBanHopRequest,
  ) {
    return runCatchingAsync<ChonBienBanCuocHopResponse,
        ChonBienBanCuocHopModel>(
      () => _hopServices.postChonMauBienBan(chonBienBanHopRequest),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<List<MoiHopModel>>> postMoiHop(
    String lichHopId,
    bool IsMultipe,
    bool isSendMail,
    List<MoiHopRequest> body,
  ) {
    return runCatchingAsync<MoiHopResponse, List<MoiHopModel>>(
      () => _hopServices.postMoiHop(lichHopId, IsMultipe, isSendMail, body),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<MessageModel>> suaKetLuan(
    String scheduleId,
    String content,
    String reportStatusId,
    String reportTemplateId,
    List<File>? files,
  ) {
    return runCatchingAsync<SuaKetLuanResponse, MessageModel>(
      () => _hopServices.suaKetLuan(
        scheduleId,
        content,
        reportStatusId,
        reportTemplateId,
        files ?? [],
      ),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<List<ThietBiPhongHopModel>>> getListThietBiPhongHop(
      String lichHopId) {
    return runCatchingAsync<ThietBiPhongHopResponse,
        List<ThietBiPhongHopModel>>(
      () => _hopServices.getListThietBiPhongHop(lichHopId),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<ChiTietLichHopModel>> taoLichHop(
      TaoLichHopRequest taoLichHopRequest) {
    return runCatchingAsync<ChiTietLichHopResponse, ChiTietLichHopModel>(
        () => _hopServices.createMetting(taoLichHopRequest),
        (res) => res.data?.toDomain() ?? ChiTietLichHopModel());
  }

  @override
  Future<Result<XemKetLuanHopModel>> getXemKetLuanHop(String id) {
    return runCatchingAsync<XemKetLuanHopDataResponse, XemKetLuanHopModel>(
      () => _hopServices.getXemKetLuanHop(id),
      (res) => res.data!.toModel(),
    );
  }

  @override
  Future<Result<List<YkienCuocHopModel>>> getDanhSachYKien(
    String id,
    String phienHopId,
  ) {
    return runCatchingAsync<DanhSachYKienlichHopResponse,
        List<YkienCuocHopModel>>(
      () => _hopServices.getDanhSachYKien(id, phienHopId),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<String>>> postEventCalendar(EventCalendarRequest request) {
    return runCatchingAsync<EventCalendarResponse, List<String>>(
      () => _hopServices.postEventCalendar(request),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<List<StatusKetLuanHopModel>>> getListStatusKetLuanHop() {
    return runCatchingAsync<StatusKetLuanHopResponse,
        List<StatusKetLuanHopModel>>(
      () => _hopServices.getListStatusKetLuanHop(),
      (res) => res.data!.map((e) => e.toModel()).toList(),
    );
  }

  @override
  Future<Result<MessageModel>> deleteKetLuanHop(String id) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => _hopServices.deleteKetLuanHop(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> deleteChiTietLichHop(String id) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => _hopServices.deleteChiTietLichHop(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<MessageModel>> huyChiTietLichHop(
    String scheduleId,
    int statusId,
    bool isMulti,
  ) {
    return runCatchingAsync<XoaBaoCaoKetQuaResponse, MessageModel>(
      () => _hopServices.huyChiTietLichHop(scheduleId, statusId, isMulti),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<MenuModel>>> getDataMenu(
    String startTime,
    String endTime,
  ) {
    return runCatchingAsync<MenuResponse, List<MenuModel>>(
      () => _hopServices.getMenuLichHop(startTime, endTime),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<StatisticByMonthModel>>> postStatisticByMonth(
    String dateFrom,
    String dateTo,
  ) {
    return runCatchingAsync<StatisticByMonthResponse,
        List<StatisticByMonthModel>>(
      () => _hopServices.postStatisticByMonth(dateFrom, dateTo),
      (response) => response.data.map((e) => e.toModel()).toList(),
    );
  }

  @override
  Future<Result<List<DashBoardThongKeModel>>> getDashBoardThongKe(
    String dateFrom,
    String dateTo,
  ) {
    return runCatchingAsync<DashBoardThongKeResponse,
        List<DashBoardThongKeModel>>(
      () => _hopServices.getDashBoardThongKe(dateFrom, dateTo),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CoCauLichHopModel>>> postCoCauLichHop(
    String dateFrom,
    String dateTo,
  ) {
    return runCatchingAsync<CoCauLichHopResponse, List<CoCauLichHopModel>>(
      () => _hopServices.postCoCauLichHop(dateFrom, dateTo),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<ToChucBoiDonViModel>>> postToChucBoiDonVi(
      String dateFrom, String dateTo) {
    return runCatchingAsync<ToChucBoiDonViResponse, List<ToChucBoiDonViModel>>(
      () => _hopServices.postToChucBoiDonVi(dateFrom, dateTo),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TiLeThamGiaModel>>> postTiLeThamGia(
      String dateFrom, String dateTo) {
    return runCatchingAsync<TiLeThamGiaResponse, List<TiLeThamGiaModel>>(
      () => _hopServices.postTiLeThamGia(dateFrom, dateTo),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ChiTietLichHopModel>> postSuaLichHop(
    TaoLichHopRequest taoLichHopRequest,
  ) {
    return runCatchingAsync<ChiTietLichHopResponse, ChiTietLichHopModel>(
      () => _hopServices.postSuaLichHop(taoLichHopRequest),
      (response) => response.data?.toDomain() ?? ChiTietLichHopModel(),
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> getNhiemVuCHiTietHop(
    NhiemVuChiTietHopRequest nhiemVuChiTietHopRequest,
  ) {
    return runCatchingAsync<ListNhiemVuChiTietLichHopResponse,
        List<CalendarMeetingModel>>(
      () => _hopServices.getNhiemVuCHiTietHop(nhiemVuChiTietHopRequest),
      (res) => res.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<DanhSachLoaiNhiemVuLichHopModel>>>
      getDanhSachLoaiNhiemVu() {
    return runCatchingAsync<DanhSachNhiemVulichHopResponse,
        List<DanhSachLoaiNhiemVuLichHopModel>>(
      () => _hopServices.getDanhSachLoaiNhiemVu(),
      (response) => response.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CalendarMeetingModel>>> postThemNhiemVu(
    ThemNhiemVuRequest themNhiemVuRequest,
  ) {
    return runCatchingAsync<ListNhiemVuChiTietLichHopResponse,
        List<CalendarMeetingModel>>(
      () => _hopServices.postThemNhiemVu(themNhiemVuRequest),
      (res) => res.pageData?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
