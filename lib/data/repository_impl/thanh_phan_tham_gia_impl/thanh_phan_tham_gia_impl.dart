import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/response/thanh_phan_tham_gia/can_bo_response.dart';
import 'package:ccvc_mobile/data/response/thanh_phan_tham_gia/tree_don_vi_tham_gia_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/thanh_phan_tham_gia/thanh_phan_tham_gia_service.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';

class ThanhPhanThamGiaImpl extends ThanhPhanThamGiaReponsitory {
  final ThanhPhanThamGiaService _service;

  ThanhPhanThamGiaImpl(this._service);

  @override
  Future<Result<List<Node<DonViModel>>>> getTreeDonVi({bool getAll = true}) {
    return runCatchingAsync<TreeDonViThamGiaResponse, List<Node<DonViModel>>>(
      () => _service.getTreeDonVi(getAll),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<DonViModel>>> getSeachCanBo(
    SearchCanBoRequest searchCanBoRequest,
  ) {
    return runCatchingAsync<SearchCanBoResponse, List<DonViModel>>(
      () => _service.searchCanBo(searchCanBoRequest),
      (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
