import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/nguoi_tiep_nhan_yeu_cau_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';

mixin HoTroKyThuatRepository {
  Future<Result<List<SuCoModel>>> postDanhSachSuCo({
    required int pageIndex,
    required int pageSize,
    String? codeUnit,
    String? createOn,
    String? finishDay,
    String? userRequestId,
    String? districtId,
    String? buildingId,
    String? room,
    String? processingCode,
    String? handlerId,
    String? keyWord,
  });

  Future<Result<List<TongDaiModel>>> getTongDai();

  Future<Result<SupportDetail>> getSupportDetail(String id);

  Future<Result<List<ThanhVien>>> getNguoiXuLy();

  Future<Result<List<CategoryModel>>> getCategory(
    String code,
  );

  Future<Result<List<ChartSuCoModel>>> getChartSuCo();

  Future<Result<List<NguoiTiepNhanYeuCauModel>>> getNguoiTiepNhanYeuCau();

  Future<Result<bool>> deleteTask(
    List<String> listId,
  );
}
