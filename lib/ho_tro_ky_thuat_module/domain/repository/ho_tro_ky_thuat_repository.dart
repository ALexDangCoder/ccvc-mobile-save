import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';

mixin HoTroKyThuatRepository {
  Future<Result<List<DanhSachSuCoModel>>> postDanhSachSuCo(
    int pageIndex,
    int pageSize,
  );

  Future<Result<List<TongDaiModel>>> getTongDai();
}
