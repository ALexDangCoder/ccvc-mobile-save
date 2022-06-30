import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/danh_sach_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/services/ho_tro_ky_thuat_service.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';

class HoTroKyThuatImpl implements HoTroKyThuatRepository {
  final HoTroKyThuatService _hoTroKyThuatService;

  HoTroKyThuatImpl(
    this._hoTroKyThuatService,
  );

  @override
  Future<Result<List<DanhSachSuCoModel>>> postDanhSachSuCo(
    int pageIndex,
    int pageSize,
  ) {
    return runCatchingAsync<DanhSachSuCoResponse, List<DanhSachSuCoModel>>(
      () => _hoTroKyThuatService.postDanhSachSuCo(
        pageIndex,
        pageSize,
      ),
      (res) => res.data?.pageData?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
