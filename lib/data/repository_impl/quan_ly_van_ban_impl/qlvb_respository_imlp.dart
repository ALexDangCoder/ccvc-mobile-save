import 'package:ccvc_mobile/data/request/quan_ly_van_ban/danh_sach_vb_di_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/dash_board_vb_den_request.dart';
import 'package:ccvc_mobile/data/request/quan_ly_van_ban/dash_board_vb_di_request.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_di_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbden_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/danh_sach_van_ban/ds_vbdi_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_den_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/dash_board/db_vb_di_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/quan_ly_van_ban/qlvb_service.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/chi_tiet_van_ban_den_response.dart';
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
        VBDenRequest(
          ngayDauTien: startTime,
          ngayCuoiCung: endTime,
        ),
      ),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<DocumentDashboardModel>> getVBDi(
      String startTime, String endTime) {
    return runCatchingAsync<DoashBoashVBDiResponse, DocumentDashboardModel>(
      () => _quanLyVanBanClient
          .getVbDi(VBDiRequest(ngayDauTien: startTime, ngayCuoiCung: endTime)),
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
      String startDate, String endDate, int index, int size) {
    return runCatchingAsync<DanhSachVBDenResponse, DanhSachVanBanModel>(
        () => _quanLyVanBanClient.getDanhSachVanBanDen(
              DanhSachVBDiRequest(
                thoiGianStartFilter: startDate,
                thoiGianEndFilter: endDate,
                size: size,
                index: index,
              ),
            ), (response) {
      return response.danhSachVB.toDomain();
    });
  }

  @override
  Future<Result<DanhSachVanBanModel>> getDanhSachVbDi(
      String startDate, String endDate, int index, int size) {
    return runCatchingAsync<DanhSachVBDiResponse, DanhSachVanBanModel>(
        () => _quanLyVanBanClient.getDanhSachVanBanDi(
              DanhSachVBDiRequest(
                thoiGianStartFilter: startDate,
                thoiGianEndFilter: endDate,
                size: size,
                index: index,
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
}
