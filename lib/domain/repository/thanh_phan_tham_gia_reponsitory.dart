import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

abstract class ThanhPhanThamGiaReponsitory {
  Future<Result<List<Node<DonViModel>>>> getTreeDonVi({bool getAll = true});

  Future<Result<List<DonViModel>>> getSeachCanBo(
      SearchCanBoRequest searchCanBoRequest);
}
