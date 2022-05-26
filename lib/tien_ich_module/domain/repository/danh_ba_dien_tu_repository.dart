import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/sua_danh_sach_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/them_danh_ba_ca_nhan_request.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_to_chuc_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/them_moi_danh_ba_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/xoa_danh_ba_model.dart';

mixin DanhBaDienTuRepository {
  Future<Result<DanhBaDienTuModel>> getListDanhBaCaNhan(
    int pageIndex,
    int pageSize,
  );

  Future<Result<ThemMoiDanhBaModel>> postThemMoiDanhBa(
    ThemDanhBaCaNhanRequest themDanhBaCaNhanRequest,
  );

  Future<Result<ThemMoiDanhBaModel>> putSuaDanhBa(
    SuaDanhBaCaNhanRequest suaDanhBaCaNhanRequest,
  );

  Future<Result<XoaDanhBaModel>> xoaDanhBa(
    String id,
  );

  Future<Result<DanhBaDienTuModel>> searchListDanhBaCaNhan(
    int pageIndex,
    int pageSize,
    String keyword,
  );

  Future<Result<DataDanhBaToChuc>> getListDanhBaToChuc(
    int pageIndex,
    int pageSize,
    String filterBy,
    String idDonVi,
  );
}
