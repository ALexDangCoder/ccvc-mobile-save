import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';

mixin KetNoiRepository {
  Future<Result<DataDanhSachChungModel>> ketNoiListChung(
    int pageIndex,
    int pageSize,
    String type,
  );
}
