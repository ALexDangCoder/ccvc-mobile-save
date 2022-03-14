import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';

mixin KetNoiRepository {
  Future<Result<DataDanhSachChungModel>> ketNoiListChung(
    int pageIndex,
    int pageSize,
    String type,
  );

  Future<Result<TrongNuocModel>> getDataTrongNuoc(
    int pageIndex,
    int pageSize,
    String category,
    bool fullSize,
  );
}
