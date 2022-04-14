import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ket_noi_module/data/response/detail_chung_ket_noi_response.dart';
import 'package:ccvc_mobile/ket_noi_module/data/response/list_chung_ket_noi_response.dart';
import 'package:ccvc_mobile/ket_noi_module/data/response/loai_bai_viet_response.dart';
import 'package:ccvc_mobile/ket_noi_module/data/response/tao_su_kien_response.dart';
import 'package:ccvc_mobile/ket_noi_module/data/response/trong_nuoc_response.dart';
import 'package:ccvc_mobile/ket_noi_module/data/service/ket_noi_service.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/detail_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/tao_su_kien_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';
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

  @override
  Future<Result<TrongNuocModel>> getDataTrongNuoc(
    int pageIndex,
    int pageSize,
    String category,
    bool fullSize,
  ) {
    return runCatchingAsync<TrongNuocResponse, TrongNuocModel>(
      () => _ketNoiService.getListTrongNuoc(
        pageIndex,
        pageSize,
        category,
        fullSize,
      ),
      (response) => response.data.toModel(),
    );
  }

  @override
  Future<Result<DetailChungModel>> detailChungKetNoi(String id) {
    return runCatchingAsync<DetailKetNoiResponse, DetailChungModel>(
      () => _ketNoiService.getDetailChungKetNoi(id),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<List<LoaiBaiVietModel>>> loaiBaiViet(String type) {
    return runCatchingAsync<LoaiBaiVietResponse, List<LoaiBaiVietModel>>(
      () => _ketNoiService.getLoaiBaiViet(type),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<TaoSuKienModel>> postTaoSuKien(
    String loaiBaiViet,
    String tieuDe,
    String ngayBatDau,
    String diaDiem,
    bool coXuatBan,
    String noiDung,
    Map<String, String> thongTinLienHe,
    String type,
  ) {
    return runCatchingAsync<TaoSuKienResponse, TaoSuKienModel>(
      () => _ketNoiService.postTaoSuKien(loaiBaiViet, tieuDe, ngayBatDau,
          diaDiem, coXuatBan, noiDung, thongTinLienHe, type),
      (response) => response.toDoMain(),
    );
  }

  @override
  Future<Result<DataDanhSachChungModel>> listCategory(
    int pageIndex,
    int pageSize,
    String idDauMucSuKien,
    String type,
  ) {
    return runCatchingAsync<ListChungKetNoiResponse, DataDanhSachChungModel>(
      () => _ketNoiService.getListCategory(
        pageIndex,
        pageSize,
        idDauMucSuKien,
        type,
      ),
      (response) => response.data.toDomain(),
    );
  }
}
