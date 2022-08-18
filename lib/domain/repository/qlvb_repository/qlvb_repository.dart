// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/cho_y_kien_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/comment_document_income_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_huy_duyet_van_ban_di.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_ky_duyet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_tra_lai_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/domain/model/document/luong_xu_ly_vb_di.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_don_vi_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';

mixin QLVBRepository {
  Future<Result<DocumentDashboardModel>> getVBDen(
    String startTime,
    String endTime,
  );

  //
  Future<Result<DocumentDashboardModel>> getVBDi(
    String startTime,
    String endTime,
  );

  Future<Result<DanhSachVanBanModel>> getVanBanModel();

  Future<Result<DanhSachVanBanModel>> getDanhSachVbDen(
    DanhSachVBRequest danhSachVBRequest,
  );

  Future<Result<bool>> updateComment(
    UpdateCommentRequest comments,
  );

  Future<Result<bool>> giveComment(
    GiveCommentRequest comments,
  );

  Future<Result<bool>> relayCommentDocumentIncome(
    RelayCommentRequest relay,
  );

  Future<Result<DanhSachVanBanModel>> getDanhSachVbDi({
    required String startDate,
    required String endDate,
    required int index,
    bool? isDanhSachChoTrinhKy,
    bool? isDanhSachChoXuLy,
    bool? isDanhSachDaXuLy,
    bool? isDanhSachChoCapSo,
    bool? isDanhSachChoBanHanh,
    List<int>? trangThaiFilter,
    required int size,
    String searchTitle = '',
  });

  Future<Result<DanhSachVanBanModel>> getDanhSachVbDiDashBoard(
    String startDate,
    String endDate,
    bool isDanhSachChoXuLy,
    bool isDanhSachDaXuLy,
    bool isDanhSachChoTrinhKy,
    List<int> trangThaiFilter,
    int index,
    int size, [
    String keySearch = '',
  ]);

  Future<Result<ChiTietVanBanDiModel>> getDataChiTietVanBanDi(String id);

  Future<Result<List<DanhSachChoYKien>>> getYKienXuLyVBDi(String id);

  Future<Result<ChiTietVanBanDenModel>> getDataChiTietVanBanDen(
      String processId, String taskId,
      {bool? isYKien});

  Future<Result<DataThongTinGuiNhanModel>> getDataThongTinGuiNhan(String id);

  Future<Result<List<VanBanHoiBaoModel>?>> getHoiBaoVanBanDen(String processId);

  Future<Result<DataLichSuVanBanModel>> getDataLichSuVanBanDen(
    String processId,
    String type,
  );

  Future<Result<String>> postFile({required File path});

  Future<Result<List<dynamic>>> getTheoDoiVanBan(String id);

  Future<Result<DataDanhSachYKienXuLy>> getDataDanhSachYKien(String vanBanId);

  Future<Result<DataDanhSachYKienXuLy>> getLichSuXinYKien(String vanBanId);

  Future<Result<DataLichSuThuHoiVanBanDi>> getLichSuThuHoiVanBanDi(
      String id, String vanBanId);

  Future<Result<DataLichSuTraLaiVanBanDi>> getLichSuTraLaiVanBanDi(
      String id, String vanBanId);

  Future<Result<DataLichSuKyDuyetVanBanDi>> getLichSuKyDuyetVanBanDi(
      String id, String vanBanId);

  Future<Result<DataLichSuHuyDuyetVanBanDi>> getLichSuHuyDuyetVanBanDi(
      String id, String vanBanId);

  Future<Result<DataLichSuCapNhatVanBanDi>> getLichSuCapNhatVanBanDi(
      String id, String vanBanId);

  Future<Result<List<LuongXuLyVBDiModel>>> getLuongXuLyVanBanDi(String id);

  Future<Result<NodePhanXuLy<DonViLuongModel>?>> getLuongXuLyVanBanDen(
      String id);

  Future<Result<List<VanBanDonViModel>?>> getDataVanBanDonVi(
    VanBanDonViRequest request,
  );
}
