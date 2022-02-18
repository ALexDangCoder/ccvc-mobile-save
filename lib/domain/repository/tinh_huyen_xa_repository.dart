import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/tinh_huyen_xa/tinh_huyen_xa_model.dart';

mixin TinhHuyenXaRepository {
  Future<Result<List<TinhHuyenXaModel>>> getData();

  Future<Result<List<TinhHuyenXaModel>>> getDataChild(
    String parentId,
  );
}
