import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/bang_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/response/thong_ke_diem_danh_ca_nhan_response.dart';
import 'package:ccvc_mobile/diem_danh_module/data/service/diem_danh_service.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';

class DiemDanhRepoImpl implements DiemDanhRepository {
  final DiemDanhService _diemDanhService;

  DiemDanhRepoImpl(this._diemDanhService);

  @override
  Future<Result<ThongKeDiemDanhCaNhanModel>> thongKeDiemDanh(
      ThongKeDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest) {
    return runCatchingAsync<DataThongKeDiemDanhCaNhanResponse,
        ThongKeDiemDanhCaNhanModel>(
      () =>
          _diemDanhService.thongKeDiemDanhCaNhan(thongKeDiemDanhCaNhanRequest),
      (response) => response.data?.toModel() ?? ThongKeDiemDanhCaNhanModel(),
    );
  }

  @override
  Future<Result<ListItemBangDiemDanhCaNhanModel>> bangDiemDanh(
      BangDiemDanhCaNhanRequest bangDiemDanhCaNhanRequest) {
    return runCatchingAsync<DataListItemThongKeDiemDanhCaNhanModelResponse,
        ListItemBangDiemDanhCaNhanModel>(
      () => _diemDanhService.bangDiemDanhCaNhan(bangDiemDanhCaNhanRequest),
      (response) =>
          response.data?.toModel() ?? ListItemBangDiemDanhCaNhanModel(),
    );
  }
}
