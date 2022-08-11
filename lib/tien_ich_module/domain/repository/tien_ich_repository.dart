import 'dart:io';

import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/ChuyenVBThanhGiong.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/post_anh_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/topic_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/tra_cuu_van_ban_phap_luat_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';

mixin TienIchRepository {
  Future<Result<List<TopicHDSD>>> getTopicHDSD();

  Future<Result<TodoDSCVModel>> upDateTodo(
    ToDoListRequest toDoListRequest,
  );

  Future<Result<TodoDSCVModel>> createTodo(CreateToDoRequest createToDoRequest);

  Future<Result<ItemChonBienBanCuocHopModel>> getListNguoiThucHien(
    String hoTen,
    int pageSize,
    int pageIndex,
  );

  Future<Result<DataDanhSachTitleHDSD>> getDanhSachHDSD(
    int pageIndex,
    int pageSize,
    String topicId,
    String type,
    String searchKeyword,
  );

  Future<Result<DetailHuongDanSuDung>> getDetailHuongDanSuDung(
    String id,
  );

  Future<Result<LichAmDuong>> getLichAmDuong(
    String date,
  );

  Future<Result<List<TreeDonViDanhBA>>> treeDanhBa(
    int soCap,
    String idDonViCha,
  );

  Future<Result<PageTraCuuVanBanPhapLuatModel>> getTraCuuVanBanPhapLuat(
    String title,
    int pageIndex,
    int pageSize,
  );

  Future<Result<List<NhomCVMoiModel>>> nhomCVMoi();

  Future<Result<List<TodoDSCVModel>>> getListTodoDSCV();

  Future<Result<List<TodoDSCVModel>>> getListDSCVGanChoToi();

  Future<Result<TodoDSCVModel>> xoaCongViec(String id);

  Future<Result<NhomCVMoiModel>> createNhomCongViecMoi(String label);

  Future<Result<NhomCVMoiModel>> updateLabelTodoList(String id, String label);

  Future<Result<NhomCVMoiModel>> deleteGroupTodoList(String id);

  Future<Result<ChuyenVBThanhGiongModel>> chuyenVBSangGiongNoi(
    String text,
    String voiceTone,
  );

  Future<Result<String>> translateDocument(
    String document,
    String target,
    String source,
  );

  Future<Result<String>> translateFile(
    File file,
    String target,
    String source,
  );

  Future<Result<PostAnhModel>> uploadFile(File files);

  Future<Result<PostAnhModel>> uploadFileDSCV(File files);

  Future<Result<List<TodoDSCVModel>>> getListDSCVGanChoNguoiKhac();

  Future<Result<List<TodoDSCVModel>>> getAllListDSCVWithFilter(
    int? pageIndex,
    int? pageSize,
    String? searchWord,
    bool? isImportant,
    bool? inUsed,
    bool? isTicked,
    String? groupId,
    bool? isGiveOther,
  );

  Future<Result<List<CountTodoModel>>> getCountTodo();
}
