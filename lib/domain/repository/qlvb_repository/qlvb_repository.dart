import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
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
      DanhSachVBRequest danhSachVBRequest);

  Future<Result<DanhSachVanBanModel>> getDanhSachVbDi(
      String startDate, String endDate, int index, int size);

  Future<Result<ChiTietVanBanDiModel>> getDataChiTietVanBanDi(String id);

  Future<Result<ChiTietVanBanDenModel>> getDataChiTietVanBanDen(
      String processId, String taskId, bool isYKien);
  Future<Result<DataThongTinGuiNhanModel>> getDataThongTinGuiNhan(String id);

  Future<Result<DataLichSuVanBanModel>>getDataLichSuVanBanDen (String processId, String type);

}
