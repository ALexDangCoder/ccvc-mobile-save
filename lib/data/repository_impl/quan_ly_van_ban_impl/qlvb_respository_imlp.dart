import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/danh_sach_vb_di_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_den_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/danh_sach_y_kien_xu_ly_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_cap_nhat_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_huy_duyet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_ky_duyet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_thu_hoi_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_tra_lai_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/thong_tin_gui_nhan_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbden_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbdi_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_den_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_di_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/quan_ly_van_ban/qlvb_service.dart';
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
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';

class QLVBImlp implements QLVBRepository {
  final QuanLyVanBanClient _quanLyVanBanClient;

  QLVBImlp(this._quanLyVanBanClient);

  @override
  Future<Result<DocumentDashboardModel>> getVBDen(
      String startTime, String endTime) {
    return runCatchingAsync<DoashBoashVBDenResponse, DocumentDashboardModel>(
      () => _quanLyVanBanClient.getVbDen(
        startTime,
        endTime,
      ),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getVBDi(
      String startTime, String endTime) {
    return runCatchingAsync<DoashBoashVBDiResponse, DocumentDashboardModel>(
      () => _quanLyVanBanClient.getVbDi(
        startTime,
        endTime,
      ),
      (response) {
        return response.danhSachVB.toDomain();
      },
    );
  }

  @override
  Future<Result<DanhSachVanBanModel>> getVanBanModel() {
    return runCatchingAsync<DanhSachVBDenResponse, DanhSachVanBanModel>(
      () => _quanLyVanBanClient.getListVBDen(),
      (response) {
        return response.danhSachVB.toDomain();
      },
    );
  }

  @override
  Future<Result<DanhSachVanBanModel>> getDanhSachVbDen(
    DanhSachVBRequest danhSachVBRequest,
  ) {
    return runCatchingAsync<DanhSachVBDenResponse, DanhSachVanBanModel>(
        () => _quanLyVanBanClient.getDanhSachVanBanDen(danhSachVBRequest),
        (response) {
      return response.danhSachVB.toDomain();
    });
  }

  @override
  Future<Result<DanhSachVanBanModel>> getDanhSachVbDi(
    String startDate,
    String endDate,
    int index,
    int size, [
    String keySearch = '',
  ]) {
    return runCatchingAsync<DanhSachVBDiResponse, DanhSachVanBanModel>(
        () => _quanLyVanBanClient.getDanhSachVanBanDi(
              DanhSachVBDiRequest(
                thoiGianStartFilter: startDate,
                thoiGianEndFilter: endDate,
                size: size,
                index: index,
                keySearch: keySearch,
              ),
            ), (response) {
      return response.danhSachVB.toDomain();
    });
  }

  @override
  Future<Result<ChiTietVanBanDiModel>> getDataChiTietVanBanDi(String id) {
    return runCatchingAsync<ChiTietVanBanDiDataResponse, ChiTietVanBanDiModel>(
        () => _quanLyVanBanClient.getDataChiTietVanBanDi(id),
        (response) => response.data.toModel());
  }

  @override
  Future<Result<ChiTietVanBanDenModel>> getDataChiTietVanBanDen(
      String processId, String taskId, bool isYKien) {
    return runCatchingAsync<ChiTietVanBanDenDataResponse,
            ChiTietVanBanDenModel>(
        () => _quanLyVanBanClient.getDataChiTietVanBanDen(
            processId, taskId, isYKien),
        (response) => response.data!.toModel());
  }

  @override
  Future<Result<DataThongTinGuiNhanModel>> getDataThongTinGuiNhan(String id) {
    return runCatchingAsync<ThongTinGuiNhanDataResponse,
            DataThongTinGuiNhanModel>(
        () => _quanLyVanBanClient.getDataThongTinGuiNhan(id),
        (response) => response.toModel());
  }

  @override
  Future<Result<DataLichSuVanBanModel>> getDataLichSuVanBanDen(
      String processId, String type) {
    return runCatchingAsync<DataLichSuVanBanResponse, DataLichSuVanBanModel>(
        () => _quanLyVanBanClient.getDataLichSuVanBanDen(processId, type),
        (response) => response.toModel());
  }

  @override
  Future<Result<DataDanhSachYKienXuLy>> getDataDanhSachYKien(
      String vanBanId) {
    return runCatchingAsync<DataDanhSachYKienXuLyResponse, DataDanhSachYKienXuLy>(
            () => _quanLyVanBanClient.getDataDanhSachYKien(vanBanId),
            (response) => response.toModel());
  }
  @override
  Future<Result<DataLichSuThuHoiVanBanDi>> getLichSuThuHoiVanBanDi(String id,
      String vanBanId) {
    return runCatchingAsync<DataLichSuThuHoiVanBanDiResponse, DataLichSuThuHoiVanBanDi>(
            () => _quanLyVanBanClient.getLichSuThuHoiVanBanDi(id,vanBanId),
            (response) => response.toModel());
  }
  @override
  Future<Result<DataLichSuTraLaiVanBanDi>> getLichSuTraLaiVanBanDi(String id,
      String vanBanId) {
    return runCatchingAsync<DataLichSuTraLaiVanBanDiResponse, DataLichSuTraLaiVanBanDi>(
            () => _quanLyVanBanClient.getLichSuTraLaiVanBanDi(id,vanBanId),
            (response) => response.toModel());
  }
  @override
  Future<Result<DataLichSuKyDuyetVanBanDi>> getLichSuKyDuyetVanBanDi(String id,
      String vanBanId) {
    return runCatchingAsync<DataLichSuKyDuyetVanBanDiResponse, DataLichSuKyDuyetVanBanDi>(
            () => _quanLyVanBanClient.getLichSuKyDuyetVanBanDi(id,vanBanId),
            (response) => response.toModel());
  }
  @override
  Future<Result<DataLichSuHuyDuyetVanBanDi>> getLichSuHuyDuyetVanBanDi(String id,
      String vanBanId) {
    return runCatchingAsync<DataLichSuHuyDuyetVanBanDiResponse, DataLichSuHuyDuyetVanBanDi>(
            () => _quanLyVanBanClient.getLichSuHuyDuyetVanBanDi(id,vanBanId),
            (response) => response.toModel());
  }
  @override
  Future<Result<DataLichSuCapNhatVanBanDi>> getLichSuCapNhatVanBanDi(String id,
      String vanBanId) {
    return runCatchingAsync<DataLichSuCapNhatVanBanDiResponse, DataLichSuCapNhatVanBanDi>(
            () => _quanLyVanBanClient.getLichSuCapNhatVanBanDi(id,vanBanId),
            (response) => response.toModel());
  }
}
