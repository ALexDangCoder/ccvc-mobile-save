import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/category_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/chart_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/danh_sach_su_co_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/tong_dai_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/services/ho_tro_ky_thuat_service.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/group_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/support_detail_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/api_constants.dart';

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

  @override
  Future<Result<SupportDetail>> getSupportDetail(String id) {
    return runCatchingAsync<SupportDetailResponse, SupportDetail>(
      () => _hoTroKyThuatService.getSupportDetail(
        id,
      ),
      (res) => res.data?.toDomain() ?? SupportDetail(),
    );
  }

  @override
  Future<Result<List<TongDaiModel>>> getTongDai() {
    return runCatchingAsync<TongDaiResponse, List<TongDaiModel>>(
      () => _hoTroKyThuatService.getTongDai(),
      (res) => res.data?.configValue?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<ThanhVien>>> getNguoiXuLy() {
    return runCatchingAsync<GroupImplResponse, List<ThanhVien>>(
      () => _hoTroKyThuatService.getListThanhVien(
        '2dd34d4d-6a11-4e34-9d80-5f39d456c5a5',
        ApiConstants.PAGE_BEGIN.toString(),
        ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      ),
      (res) => res.data?.toListThanhVien() ?? [],
    );
  }

  @override
  Future<Result<List<CategoryModel>>> getCategory(
    String code,
  ) {
    return runCatchingAsync<CategoryResponse, List<CategoryModel>>(
      () => _hoTroKyThuatService.getCategory(
        code,
      ),
      (res) => res.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<ChartSuCoModel>> getChartSuCo() {
    return runCatchingAsync<ChartSuCoResponse, ChartSuCoModel>(
      () => _hoTroKyThuatService.getChartSuCo(),
      (res) => res.data?.toModel() ?? ChartSuCoModel(),
    );
  }
}
