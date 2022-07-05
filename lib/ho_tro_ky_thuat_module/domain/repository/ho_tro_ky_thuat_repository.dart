import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';

mixin HoTroKyThuatRepository {
  Future<Result<List<DanhSachSuCoModel>>> postDanhSachSuCo(
    int pageIndex,
    int pageSize,
  );

  Future<Result<List<TongDaiModel>>> getTongDai();

  Future<Result<SupportDetail>> getSupportDetail(String id);

  Future<Result<List<ThanhVien>>> getNguoiXuLy();

  Future<Result<List<CategoryModel>>> getCategory(
    String code,
  );
}
