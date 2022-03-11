import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ket_noi_module/data/response/list_chung_ket_noi_response.dart';
import 'package:ccvc_mobile/ket_noi_module/data/service/ket_noi_service.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/repository/ket_noi_repository.dart';

class KetNoiRepoImpl implements KetNoiRepository {
  final KetNoiService _ketNoiService;

  KetNoiRepoImpl(this._ketNoiService);

  @override
  Future<Result<DataDanhSachChungModel>> ketNoiListChung(
    int pageIndex,
    int pageSize,
    String type,
  ) {
    return runCatchingAsync<ListChungKetNoiResponse, DataDanhSachChungModel>(
      () => _ketNoiService.getListChungKetNoi(pageIndex, pageSize, type),
      (response) => response.data.toDomain(),
    );
  }
}
