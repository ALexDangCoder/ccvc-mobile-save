import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/detail_chung_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/tao_su_kien_model.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';

mixin KetNoiRepository {
  Future<Result<DataDanhSachChungModel>> ketNoiListChung(
    int pageIndex,
    int pageSize,
    String type,
  );

  Future<Result<DataDanhSachChungModel>> listCategory(
    int pageIndex,
    int pageSize,
    String idDauMucSuKien,
    String type,
  );

  Future<Result<TrongNuocModel>> getDataTrongNuoc(
    int pageIndex,
    int pageSize,
    String category,
    bool fullSize,
  );

  Future<Result<DetailChungModel>> detailChungKetNoi(String id);

  Future<Result<List<LoaiBaiVietModel>>> loaiBaiViet(String type);

  Future<Result<TaoSuKienModel>> postTaoSuKien(
    String loaiBaiViet,
    String tieuDe,
    String ngayBatDau,
    String diaDiem,
    bool coXuatBan,
    String noiDung,
    Map<String, String> thongTinLienHe,
    String type,
  );
}
