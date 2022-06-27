import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/cu_can_bo_di_thay_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_thong_ke_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_theo_doi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/phan_cong_thu_ky_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/so_luong_phat_bieu_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/add_file_tao_lich_hop.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/chi_tiet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_nhiem_vu_Chi_tiet_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_nhiem_vu_kl_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/danh_sach_y_kien_lich_hop.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/phan_cong_thu_ky_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/status_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thiet_bi_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thong_tin_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/xem_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chon_bien_ban_cuoc_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/co_cau_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/cu_can_bo_di_thay_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_bieu_quyet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_nguoi_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phat_bieu_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dash_board_lh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dashborad_thong_ke_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/duyet_lich_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/event_calendar_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/gui_mail_ket_luat-response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_dang_theo_doi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_theo_doi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/select_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/statistic_by_month_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_ket_luan_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_hop/danh_sach_don_vi_con_phong_res.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_hop/phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_hop/them_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/thanh_phan_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_moi_bieu_quayet_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/ti_le_tham_gia_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/to_chuc_boi_don_vi_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tong_phien_hop_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/xoa_chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/list_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/menu_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/xoa_bao_cao_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/lich_hop/hop_services.dart';
import 'package:ccvc_mobile/domain/model/add_file_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/them_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/bieu_quyet_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/duyet_lich_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/gui_mail_ket_luat_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_dang_theo_doi.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_theo_doi.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/responseModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/select_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/don_vi_con_phong_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/them_y_kiem_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/co_cau_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/dashboard_thong_ke_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart';

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
      () => _hopServices.getDanhSachChuTri(
        id,
      ),
      (res) => res.data?.listCanBo?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NguoiChutriModel>>> getDanhSachThuHoi(
    String id,
    bool except,
  ) {
    return runCatchingAsync<DanhSachCanBoHopResponse, List<NguoiChutriModel>>(
      () => _hopServices.getDanhSachThuHoi(id, except),
      (res) => res.data?.listCanBo?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<AddFileModel>>> postFileTaoLichHop(
    int? entityType,
    String? entityName,
    String? entityId,
    bool isMutil,
    List<File> files,
  ) {
    return runCatchingAsync<UploadFileWithMeetingResponse, List<AddFileModel>>(
      () => _hopServices.postFile(
        entityType,
        entityName,
        entityId,
        isMutil,
        files,
      ),
      (response) => response.toList(),
    );
  }

  @override
  Future<Result<List<ListPhienHopModel>>> getDanhSachPhienHop(
    String id,
  ) {
    return runCatchingAsync<ListPhienHopRespone, List<ListPhienHopModel>>(
      () => _hopServices.getDanhSachPhienHop(id),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<ChiTietLichHopModel>> getChiTietLichHop(String id) {
    return runCatchingAsync<ChiTietLichHopResponse, ChiTietLichHopModel>(
      () => _hopServices.getChiTietLichHop(id),
      (res) => res.data?.toDomain() ?? ChiTietLichHopModel(),
    );
  }

  @override
  Future<Result<List<TaoPhienHopModel>>> getThemPhienHop(
    String lichHopId,
    String canBoId,
    String donViId,
    int vaiTroThamGia,
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
        vaiTroThamGia,
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
  Future<Result<ThongTinPhongHopModel>> getListThongTinPhongHop(
    String idLichHop,
  ) {
    return runCatchingAsync<ThongTinPhongHopResponse, ThongTinPhongHopModel>(
      () => _hopServices.getDanhSachPhongHop(idLichHop),
      (res) => res.data?.toDomain() ?? ThongTinPhongHopModel(),
    );
  }

  @override
  Future<Result<List<PhatBieuModel>>> getDanhSachPhatBieuLichHop(
    int status,
    String lichHopId,
    String phienHop,
  ) {
    return runCatchingAsync<DanhSachPhatBieuLichHopDataResponse,
        List<PhatBieuModel>>(
      () =>
          _hopServices.getDanhSachPhatBieuLichHop(status, lichHopId, phienHop),
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
    BieuQuyetRequest bieuQuyetRequest,
  ) {
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
  Future<Result<List<CanBoModel>>> postMoiHop(
    String lichHopId,
    bool IsMultipe,
    bool isSendMail,
    List<MoiHopRequest> body,
  ) {
    return runCatchingAsync<ThanhPhanThamGiaResponse, List<CanBoModel>>(
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
    TaoLichHopRequest taoLichHopRequest,
  ) {
    return runCatchingAsync<ChiTietLichHopResponse, ChiTietLichHopModel>(
      () => _hopServices.createMetting(taoLichHopRequest),
      (res) => res.data?.toDomain() ?? ChiTietLichHopModel(),
    );
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
    String dateFrom,
    String dateTo,
  ) {
    return runCatchingAsync<ToChucBoiDonViResponse, List<ToChucBoiDonViModel>>(
      () => _hopServices.postToChucBoiDonVi(dateFrom, dateTo),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TiLeThamGiaModel>>> postTiLeThamGia(
    String dateFrom,
    String dateTo,
  ) {
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

  @override
  Future<Result<DanhSachLichHopModel>> postDanhSachThongKe(
      DanhSachThongKeRequest body) {
    return runCatchingAsync<DanhSachLichHopResponse, DanhSachLichHopModel>(
      () => _hopServices.postDataThongKe(body),
      (response) => response.data?.toModel() ?? DanhSachLichHopModel.empty(),
    );
  }

  @override
  Future<Result<ThemYKienModel>> suaChuongTrinhHop(
    String id,
    String lichHopId,
    String tieuDe,
    String thoiGianBatDau,
    String thoiGianKetThuc,
    String canBoId,
    String donViId,
    String noiDung,
    String hoTen,
    bool isMultipe,
    List<File> file,
  ) {
    return runCatchingAsync<SuaChuongTrinhHopResponse, ThemYKienModel>(
      () => _hopServices.suaChuongTrinhHop(
        id,
        lichHopId,
        tieuDe,
        thoiGianBatDau,
        thoiGianKetThuc,
        canBoId,
        donViId,
        noiDung,
        hoTen,
        isMultipe,
        file,
      ),
      (response) => response.toDomain(),
    );
  }

  Future<Result<ChuongTrinhHopModel>> getDanhSachCuocHopTPTH(String id) {
    return runCatchingAsync<ChuongTrinhHopResponse, ChuongTrinhHopModel>(
      () => _hopServices.getDanhSachCuocHopTPTH(id),
      (response) => response.data?.toModel() ?? ChuongTrinhHopModel.empty(),
    );
  }

  @override
  Future<Result<ThemYKienModel>> xoaChuongTrinhHop(String id) {
    return runCatchingAsync<XoaChuongTrinhHopResponse, ThemYKienModel>(
      () => _hopServices.xoaChuongTrinhHop(id),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<List<DanhSachNguoiThamGiaModel>>> getDanhSachNTGChuongTrinhHop(
    String id,
  ) {
    return runCatchingAsync<DanhSachNguoiThamGiaResponse,
        List<DanhSachNguoiThamGiaModel>>(
      () => _hopServices.getDanhSachNTGChuongTrinhHop(id),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<List<DanhSachBietQuyetModel>>> getDanhSachBieuQuyetLichHop(
    String idLichHop,
    String canBoId,
    String idPhienHop,
  ) {
    return runCatchingAsync<DanhSachBieuQuyetLichHopDataResponse,
        List<DanhSachBietQuyetModel>>(
      () => _hopServices.getDanhSachBieuQuyetLichHop(
        idLichHop,
        canBoId,
        idPhienHop,
      ),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> postPhanCongThuKy(
    PhanCongThuKyRequest phanCongThuKyRequest,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.postPhanCongThuKy(phanCongThuKyRequest),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<NguoiTheoDoiModel>> getNguoiTheoDoi(NguoiTheoDoiRequest body) {
    return runCatchingAsync<NguoiTheoDoiLHResponse, NguoiTheoDoiModel>(
      () => _hopServices.getNguoiTheoDoi(body),
      (res) => res.data?.toModel() ?? NguoiTheoDoiModel.empty(),
    );
  }

  @override
  Future<Result<List<NguoiDangTheoDoiModel>>> getNguoiDangTheoDoi(
      String type, String DateFrom, String DateTo) {
    return runCatchingAsync<NguoiDangTheoDoiResponse,
        List<NguoiDangTheoDoiModel>>(
      () => _hopServices.getNguoiDangTheoDoi(type, DateFrom, DateTo),
      (res) => res.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ResponseModel>> postTaoPhatBieu(
    TaoBieuQuyetRequest taoBieuQuyetRequest,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.postTaoPhatBieu(taoBieuQuyetRequest),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> postDuyetOrHuyDuyetPhatBieu(
    List<String> ids,
    String lichHopId,
    int type,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.postDuyetOrHuyDuyetPhatBieu(
        ids,
        lichHopId,
        type,
      ),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> postDiemDanh(
    List<String> data,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.postDiemDanh(data),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> postThuHoiHop(
    bool isMulti,
    List<ThuHoiHopRequest> thuHoiHopRequest,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.postThuHoiHop(isMulti, thuHoiHopRequest),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> postHuyDiemDanh(
    String data,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.postHuyDiemDanh(data),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<List<DonViConPhong>>> getDonViConPhongHop(String id) {
    return runCatchingAsync<DonViConPhongResponse, List<DonViConPhong>>(
      () => _hopServices.danhSachDVChaConPhong(id),
      (response) => response.toListModel(),
    );
  }

  @override
  Future<Result<List<PhongHopModel>>> getDanhSachPhongHop(
      String id, String from, String to, bool isTTDH) {
    return runCatchingAsync<DSPhongHopResponse, List<PhongHopModel>>(
      () => _hopServices.danhSachPhongHop(id, from, to, isTTDH),
      (response) => response.toListModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> huyOrDuyetPhongHop(
    String hopId,
    bool isDuyet,
    String lyDo,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.huyOrDuyetPhongHop(hopId, isDuyet, lyDo),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> thayDoiPhongHop(
    bool bit_TTDH,
    String lichHopId,
    String phongHopId,
    String tenPhong,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.thayDoiPhongHop(
        bit_TTDH,
        lichHopId,
        phongHopId,
        tenPhong,
      ),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ResponseModel>> duyetOrHuyDuyetThietBi(
    bool isDuyet,
    String lichHopId,
    String lyDo,
    String thietBiId,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.duyetOrHuyDuyetThietBi(
        isDuyet,
        lichHopId,
        lyDo,
        thietBiId,
      ),
      (response) => response.toModel(),
    );
  }

  Future<Result<String>> checkLichHopTrung(
    String? scheduleId,
    String donViId,
    String userId,
    String timeFrom,
    String timeTo,
    String dateFrom,
    String dateTo,
  ) {
    return runCatchingAsync<dynamic, String>(
      () => _hopServices.checkLichHopTrung(
        scheduleId,
        donViId,
        userId,
        timeFrom,
        timeTo,
        dateFrom,
        dateTo,
      ),
      (response) {
        try {
          return (response as Map<String, dynamic>)['code'];
        } catch (e) {
          return '';
        }
      },
    );
  }

  @override
  Future<Result<ResponseModel>> duyetOrHuyDuyetKyThuat(
    String hopId,
    bool isDuyet,
    String lyDo,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.duyetOrHuyDuyetKyThuat(hopId, isDuyet, lyDo),
      (response) => response.toModel(),
    );
  }

  Future<Result<List<CanBoModel>>> moiHop(String lichHopId, bool IsMultipe,
      bool isSendMail, List<MoiThamGiaHopRequest> body) {
    return runCatchingAsync<ThanhPhanThamGiaResponse, List<CanBoModel>>(
      () => _hopServices.moiHop(lichHopId, IsMultipe, isSendMail, body),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ResponseModel>> chonPhongHopMetting(
    TaoLichHopRequest taoLichHopRequest,
  ) {
    return runCatchingAsync<PhanCongThuKyResponse, ResponseModel>(
      () => _hopServices.chonPhongHopMetting(taoLichHopRequest),
      (res) => res.toModel(),
    );
  }

  Future<Result<bool>> themPhienHop(
      String lichHopId, List<TaoPhienHopRequest> phienHops) async {
    final _data = FormData();
    for (int i = 0; i < phienHops.length; i++) {
      if (phienHops[i].canBoId != null) {
        _data.fields.add(
          MapEntry('[$i].canBoId', phienHops[i].canBoId!),
        );
      }
      if (phienHops[i].canBoId != null) {
        _data.fields.add(
          MapEntry('[$i].donViId', phienHops[i].donViId!),
        );
      }
      _data.fields.add(
        MapEntry('[$i].thoiGian_BatDau', phienHops[i].thoiGian_BatDau),
      );
      _data.fields.add(
        MapEntry('[$i].thoiGian_KetThuc', phienHops[i].thoiGian_KetThuc),
      );
      _data.fields.add(
        MapEntry('[$i].noiDung', phienHops[i].noiDung),
      );
      _data.fields.add(
        MapEntry('[$i].tieuDe', phienHops[i].tieuDe),
      );
      _data.fields.add(
        MapEntry('[$i].hoTen', phienHops[i].hoTen),
      );
      _data.fields.add(
        MapEntry('[$i].IsMultipe', phienHops[i].IsMultipe.toString()),
      );
      if (phienHops[i].Files?.isNotEmpty ?? false) {
        for (int j = 0; j < phienHops[i].Files!.length; j++) {
          final MultipartFile file = await MultipartFile.fromFile(
            phienHops[i].Files![j].path,
          );
          _data.files.add(
            MapEntry(
              '[$i].Files',
              file,
            ),
          );
        }
      }
    }
    return runCatchingAsync<ThemPhienHopResponse, bool>(
      () => _hopServices.themPhienHop(lichHopId, _data),
      (response) => response.isSucces,
    );
  }

  @override
  Future<Result<DuyetLichModel>> huyAndDuyetLichHop(
    String lichHopId,
    bool isDuyet,
    String lyDo,
  ) {
    return runCatchingAsync<DuyetLichResponse, DuyetLichModel>(
      () => _hopServices.huyDuyetLichHop(lichHopId, isDuyet, lyDo),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<bool>> cuCanBoDiThay(
    CuCanBoDiThayRequest cuCanBoDiThayRequest,
  ) {
    return runCatchingAsync<CuCanBoDiThayResponse, bool>(
      () => _hopServices.cuCanBoDiThay(cuCanBoDiThayRequest),
      (res) => res.isSucces,
    );
  }

  @override
  Future<Result<bool>> xacNhanThamGiaHop(String lichHopId, bool isThamGia) {
    return runCatchingAsync<ThemPhienHopResponse, bool>(
      () => _hopServices.xacNhanThamGiaHop(lichHopId, isThamGia),
      (response) => response.isSucces,
    );
  }

  @override
  Future<Result<bool>> xacNhanHoacHuyKetLuanHop(
    String lichHopId,
    bool isDuyet,
    String noiDung,
  ) {
    return runCatchingAsync<ThemPhienHopResponse, bool>(
      () => _hopServices.xacNhanHoacHuyKetLuanHop(
        lichHopId,
        isDuyet,
        noiDung,
      ),
      (response) => response.isSucces,
    );
  }

  @override
  Future<Result<bool>> createKetLuanHop(
    String lichHopId,
    String scheduleId,
    String reportStatusId,
    String reportTemplateId,
    String startDate,
    String endDate,
    String content,
    List<String> files,
    List<String> filesDelete,
  ) {
    return runCatchingAsync<ThemPhienHopResponse, bool>(
      () => _hopServices.createKetLuanHop(
        lichHopId,
        scheduleId,
        reportStatusId,
        reportTemplateId,
        startDate,
        endDate,
        content,
        files,
        filesDelete,
      ),
      (response) => response.isSucces,
    );
  }
}
