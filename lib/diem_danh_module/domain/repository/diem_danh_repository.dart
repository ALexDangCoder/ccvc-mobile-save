import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';

mixin DiemDanhRepository {
  Future<Result<ThongKeDiemDanhCaNhanModel>> thongKeDiemDanh(
    ThongKeDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest,
  );

  Future<Result<ListItemBangDiemDanhCaNhanModel>> bangDiemDanh(
    BangDiemDanhCaNhanRequest bangDiemDanhCaNhanRequest,
  );

  Future<Result<GetAllFilesIdModel>> getAllFilesId(GetAllFilesRequest body);
}
