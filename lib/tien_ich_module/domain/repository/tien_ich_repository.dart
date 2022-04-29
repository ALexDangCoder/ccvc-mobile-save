import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/todo_model.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/to_do_list_request.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_sach_title_hdsd.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nguoi_thuc_hien_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
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
    bool isGetAll,
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

  Future<Result<List<TreeDonViDanhBA>>> TreeDanhBa(
    int soCap,
  );

  Future<Result<PageTraCuuVanBanPhapLuatModel>> getTraCuuVanBanPhapLuat(
    String title,
    int pageIndex,
    int pageSize,
  );

  Future<Result<List<NhomCVMoiModel>>> nhomCVMoi();

  Future<Result<List<TodoDSCVModel>>> getListTodoDSCV();

  Future<Result<List<TodoDSCVModel>>> getListDSCVGanChoToi();
}
