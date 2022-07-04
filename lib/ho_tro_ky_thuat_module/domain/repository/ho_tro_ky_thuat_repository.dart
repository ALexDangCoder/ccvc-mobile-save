import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';

mixin HoTroKyThuatRepository {
  Future<Result<SupportDetail>> getSupportDetail(String id);

  Future<Result<List<ThanhVien>>> getNguoiXuLy();
}
