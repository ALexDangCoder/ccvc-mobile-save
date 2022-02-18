import 'package:ccvc_mobile/data/response/tinh_huyen_xa/tinh_huyen_xa_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/tinh_huyen_xa_service/tinh_huyen_xa_service.dart';
import 'package:ccvc_mobile/domain/model/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/repository/tinh_huyen_xa_repository.dart';

class TinhXaHuyenRepositoryImpl implements TinhHuyenXaRepository {
  final TinhHuyenXaService _tinhHuyenXaService;

  TinhXaHuyenRepositoryImpl(this._tinhHuyenXaService);

  @override
  Future<Result<List<TinhHuyenXaModel>>> getData() {
    return runCatchingAsync<TinhHuyenXaResponse, List<TinhHuyenXaModel>>(
      () => _tinhHuyenXaService.getData(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<TinhHuyenXaModel>>> getDataChild(String parentId) {
    return runCatchingAsync<TinhHuyenXaResponse, List<TinhHuyenXaModel>>(
      () => _tinhHuyenXaService.getDataChild(parentId),
      (response) => response.toDomain(),
    );
  }
}
