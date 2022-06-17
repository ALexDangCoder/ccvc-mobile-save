import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';

mixin DiemDanhRepository {
  Future<Result<ThongKeDiemDanhCaNhanModel>> thongKeDiemDanh(
      ThongKeDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest);
}
