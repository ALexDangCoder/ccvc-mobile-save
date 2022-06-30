import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/bang_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/dang_ky_thong_tin_xe_moi_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/danh_sach_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/thong_ke_diem_danh_ca_nhan_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/message_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/xoa_bien_so_xe_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/post_file_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/thong_ke_diem_danh_ca_nhan_model.dart';

mixin DiemDanhRepository {
  Future<Result<ThongKeDiemDanhCaNhanModel>> thongKeDiemDanh(
    ThongKeDiemDanhCaNhanRequest thongKeDiemDanhCaNhanRequest,
  );

  Future<Result<ListItemBangDiemDanhCaNhanModel>> bangDiemDanh(
    BangDiemDanhCaNhanRequest bangDiemDanhCaNhanRequest,
  );

  Future<Result<ListItemChiTietBienSoXeModel>> danhSachBienSoXe(
    DanhSachBienSoXeRequest danhSachBienSoXeRequest,
  );

  Future<Result<XoaBienSoXeModel>> deleteBienSoXe(String id);

  Future<Result<GetAllFilesIdModel>> getAllFilesId(GetAllFilesRequest body);

  Future<Result<PostFileModel>> postFileModel(
    String entityId,
    String fileTypeUpload,
    String entityName,
    bool isPrivate,
    List<File> files,
  );

  Future<Result<ChiTietBienSoXeModel>> dangKyThongTinXeMoi(
    DangKyThongTinXeMoiRequest dangKyThongTinXeMoiRequest,
  );

  Future<Result<MessageModel>> deleteImage(String id);
}
