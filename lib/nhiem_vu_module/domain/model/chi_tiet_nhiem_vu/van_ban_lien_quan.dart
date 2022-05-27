
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class VanBanLienQuanNhiemVuModel {
  String? id;
  String? vanBanId;
  String? nhiemVuId;
  String? soVanBan;
  String? ngayVanBan;
  String? ngayBanHanh;
  String? trichYeu;
  bool? daGanVanBan;
  String? donViChuTriXuLyId;
  String? donViChuTriXuLy;
  String? hinhThucVanBan;
  List<FileDinhKems>? file;
  int? nguonDuLieuVanBanNhiemVu;

  VanBanLienQuanNhiemVuModel.empty();

  VanBanLienQuanNhiemVuModel({
    this.id,
    this.vanBanId,
    this.nhiemVuId,
    this.soVanBan,
    this.ngayVanBan,
    this.ngayBanHanh,
    this.trichYeu,
    this.daGanVanBan,
    this.donViChuTriXuLyId,
    this.donViChuTriXuLy,
    this.hinhThucVanBan,
    this.file,
    this.nguonDuLieuVanBanNhiemVu,
  });

  List<RowDataExpandModel> dataRowVBLQ() {
    final List<RowDataExpandModel> list = [
      RowDataExpandModel(
        key: S.current.so_ky_hieu,
        value: soVanBan ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.ngay_vb,
        value: ngayVanBan ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.trich_yeu,
        value: trichYeu ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.file_dinh_kem,
        value: file ?? [],
        type: TypeDataNV.file,
      ),
    ];
    return list;
  }
}

class RowDataExpandModel {
  String key;
  dynamic value;
  TypeDataNV type;

  RowDataExpandModel({
    required this.key,
    required this.value,
    required this.type,
  });
}
