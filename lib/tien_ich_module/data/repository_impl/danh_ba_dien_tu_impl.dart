import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/sua_danh_sach_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/request/them_danh_ba_ca_nhan_request.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/danh_ba_dien_tu_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/danh_ba_to_chuc_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/them_danh_ba_ca_nhan_response.dart';
import 'package:ccvc_mobile/tien_ich_module/data/response/xoa_danh_ba_reponse.dart';
import 'package:ccvc_mobile/tien_ich_module/data/service/danh_ba_dien_tu_service.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_to_chuc_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/them_moi_danh_ba_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/xoa_danh_ba_model.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/danh_ba_dien_tu_repository.dart';

class DanhBaDienTuImpl implements DanhBaDienTuRepository {
  final DanhBaDienTuService danhBaDienTuService;

  DanhBaDienTuImpl(this.danhBaDienTuService);

  @override
  Future<Result<DanhBaDienTuModel>> getListDanhBaCaNhan(
    int pageIndex,
    int pageSize,
  ) {
    return runCatchingAsync<DanhBaResponse, DanhBaDienTuModel>(
        () => danhBaDienTuService.getListDanhBaCaNhan(pageIndex, pageSize),
        (response) {
      return response.data?.toDomain() ?? DanhBaDienTuModel();
    });
  }

  @override
  Future<Result<ThemMoiDanhBaModel>> postThemMoiDanhBa(
    ThemDanhBaCaNhanRequest themDanhBaCaNhanRequest,
  ) {
    return runCatchingAsync<ThemDanhBaCaNhanResponse, ThemMoiDanhBaModel>(
        () => danhBaDienTuService.postThemDanhBaCaNhan(themDanhBaCaNhanRequest),
        (response) {
      return response.dataResponse?.toModel() ?? ThemMoiDanhBaModel();
    });
  }

  @override
  Future<Result<ThemMoiDanhBaModel>> putSuaDanhBa(
    SuaDanhBaCaNhanRequest suaDanhBaCaNhanRequest,
  ) {
    return runCatchingAsync<ThemDanhBaCaNhanResponse, ThemMoiDanhBaModel>(
        () => danhBaDienTuService.putDanhBaCaNhan(suaDanhBaCaNhanRequest),
        (response) {
      return response.dataResponse?.toModel() ?? ThemMoiDanhBaModel();
    });
  }

  @override
  Future<Result<XoaDanhBaModel>> xoaDanhBa(
    String id,
  ) {
    return runCatchingAsync<XoaDanhBaResponse, XoaDanhBaModel>(
        () => danhBaDienTuService.xoaDanhBaCaNhan(id), (response) {
      return response.toDomain();
    });
  }

  @override
  Future<Result<DanhBaDienTuModel>> searchListDanhBaCaNhan(
    int pageIndex,
    int pageSize,
    String keyword,
  ) {
    return runCatchingAsync<DanhBaResponse, DanhBaDienTuModel>(
        () => danhBaDienTuService.searchListDanhBaCaNhan(
              pageIndex,
              pageSize,
              keyword,
            ), (response) {
      return response.data?.toDomain() ?? DanhBaDienTuModel();
    });
  }

  @override
  Future<Result<DataDanhBaToChuc>> getListDanhBaToChuc(
    int pageIndex,
    int pageSize,
    String filterBy,
    String idDonVi,
  ) {
    return runCatchingAsync<DanhBaToChucResponse, DataDanhBaToChuc>(
        () => danhBaDienTuService.getListDanhBaToChuc(
              pageIndex,
              pageSize,
              filterBy,
              idDonVi,
              true,
            ), (response) {
      return response.data?.toDomain() ?? DataDanhBaToChuc();
    });
  }
}
