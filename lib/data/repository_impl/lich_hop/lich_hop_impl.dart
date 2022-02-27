import 'dart:io';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/so_luong_phat_bieu_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/catogory_list_response.dart';

import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/chi_tiet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/list_ket_luan_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thiet_bi_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/thong_tin_phong_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chi_tiet_lich_hop/xem_ket_luan_hop_response.dart';

import 'package:ccvc_mobile/data/response/lich_hop/chon_bien_ban_cuoc_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/chuong_trinh_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_bieu_quyet_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_phat_bieu_lich_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/dash_board_lh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/gui_mail_ket_luat-response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/moi_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/nguoi_chu_trinh_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/select_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/sua_ket_luan_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_moi_bieu_quayet_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tong_phien_hop_respone.dart';
import 'package:ccvc_mobile/data/response/lich_hop/them_y_kien_response.dart';
import 'package:ccvc_mobile/data/response/lich_hop/tao_phien_hop_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/list_phien_hop_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/lich_hop/hop_services.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/bieu_quyet_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/gui_mail_ket_luat_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/select_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';

import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';

import 'package:ccvc_mobile/domain/model/lich_hop/them_y_kiem_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
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
    TaoPhienHopRepuest taoPhienHopRepuest,
  ) {
    return runCatchingAsync<TaoPhienHopResponse, List<TaoPhienHopModel>>(
      () => _hopServices.getThemPhienHop(lichHopId, taoPhienHopRepuest),
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
      String idLichHop) {
    return runCatchingAsync<ThongTinPhongHopResponse, ThongTinPhongHopModel>(
      () => _hopServices.getDanhSachPhongHop(idLichHop),
      (res) => res.data?.toDomain() ?? ThongTinPhongHopModel(),
    );
  }

  Future<Result<List<DanhSachPhatBieuLichHopModel>>> getDanhSachPhatBieuLichHop(
    String lichHopId,
  ) {
    return runCatchingAsync<DanhSachPhatBieuLichHopDataResponse,
        List<DanhSachPhatBieuLichHopModel>>(
      () => _hopServices.getDanhSachPhatBieuLichHop(lichHopId),
      (res) => res.toModel(),
    );
  }

  Future<Result<List<DanhSachBieuQuyetLichHopModel>>>
      getDanhSachBieuQuyetLichHop(
    String id,
  ) {
    return runCatchingAsync<DanhSachBieuQuyetLichHopDataResponse,
        List<DanhSachBieuQuyetLichHopModel>>(
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
  Future<Result<XemKetLuanHopModel>> getXemKetLuanHop(String id) {
    return runCatchingAsync<XemKetLuanHopDataResponse, XemKetLuanHopModel>(
      () => _hopServices.getXemKetLuanHop(id),
      (res) => res.data!.toModel(),
    );
  }

  Future<Result<List<DanhSachKetLuanHopModel>>> getDanhSachKetLuanHop(
    String id,
  ) {
    return runCatchingAsync<ListKetLuanHopResponse,
        List<DanhSachKetLuanHopModel>>(
      () => _hopServices.getDanhSachKetLuanHop(id),
      (res) => res.toModel(),
    );
  }
}
