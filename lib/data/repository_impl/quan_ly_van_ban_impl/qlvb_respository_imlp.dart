import 'package:ccvc_mobile/data/request/quan_ly_van_ban/danh_sach_vb_di_request.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/ds_vbden_response.dart';
import 'package:ccvc_mobile/data/response/quan_ly_van_ban/ds_vbdi_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/quan_ly_van_ban/qlvb_service.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
class QLVBImlp implements QLVBRepository {
  final QuanLyVanBanClient _quanLyVanBanClient;

  QLVBImlp(this._quanLyVanBanClient);

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
              ThoiGianStartFilter: startDate,
              ThoiGianEndFilter: endDate,
              Size: size,
              Index: index,),
        ), (response) {
      return response.danhSachVB.toDomain();
    });
  }
  @override
  Future<Result<DanhSachVanBanDiModel>> getDanhSachVbDi(
      String startDate, String endDate, int index, int size) {
    return runCatchingAsync<DanhSachVBDiResponse, DanhSachVanBanDiModel>(
        () => _quanLyVanBanClient.getDanhSachVanBanDi(
              DanhSachVBDiRequest(
                  ThoiGianStartFilter: startDate,
                  ThoiGianEndFilter: endDate,
                  Size: size,
                  Index: index,),
            ), (response) {
      return response.danhSachVB.toDomain();
    });
  }
// @override
// Future<Result<PageVBDiModel>> getDanhSachVbDi(
//     String startDate, String endDate, int index, int size,) {
//   return runCatchingAsync<DanhSachVBDiResponse, PageVBDiModel>(
//     () => _quanLyVanBanClient.getListVBDi(DanhSachVBDiRequest(
//         ThoiGianStartFilter: startDate,
//         ThoiGianEndFilter: endDate,
//         Size: size,
//         Index: index,
//        ),),
//     (response) {
//       return response.toDomain();
//     },
//   );
// }
}
