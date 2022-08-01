import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/confirm_officer_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/calendar/officer_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

abstract class ThanhPhanThamGiaReponsitory {
  Future<Result<List<Node<DonViModel>>>> getTreeDonVi({bool? getAll});

  Future<Result<List<DonViModel>>> getSeachCanBo(
      SearchCanBoRequest searchCanBoRequest);

  Future<Result<List<Officer>>> getOfficerJoin(
    String id,
  );

  Future<Result<MessageModel>> confirmOfficer(
    ConfirmOfficerRequest request,
  );
}
