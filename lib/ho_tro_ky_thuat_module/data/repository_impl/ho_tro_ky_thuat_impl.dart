import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/group_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/response/support_detail_response.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/services/ho_tro_ky_thuat_service.dart';
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
  Future<Result<SupportDetail>> getSupportDetail(String id) {
    return runCatchingAsync<SupportDetailResponse, SupportDetail>(
      () => _hoTroKyThuatService.getSupportDetail(
        id,
      ),
      (res) => res.data?.toDomain() ?? SupportDetail(),
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


}
