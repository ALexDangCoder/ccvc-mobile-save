import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/linh_vuc_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/tao_lich_hop/linh_vuc.dart';

mixin HopRepository {
  Future<Result<DashBoardLichHopModel>> getDashBoardLichHop(
    String dateStart,
    String dateTo,
  );

  Future<Result<DanhSachLichHopModel>> postDanhSachLichHop(
    DanhSachLichHopRequest body,
  );

  Future<Result<List<LoaiSelectModel>>> getLoaiHop(
    CatogoryListRequest catogoryListRequest,
  );

  Future<Result<List<LoaiSelectModel>>> getLinhVuc(
    CatogoryListRequest catogoryListRequest,
  );

  Future<Result<List<NguoiChutriModel>>> getNguoiChuTri(
    NguoiChuTriRequest nguoiChuTriRequest,
  );

  Future<Result<List<NguoiChutriModel>>> getDanhSachNguoiChuTriPhienHop(
    String id,
  );

  Future<Result<LinhVucModel>> postLinhVucTaoLichHop(LinhVucRequest body);
}
