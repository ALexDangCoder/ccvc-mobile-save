import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/string_extension.dart';

class LichSuTraLaiNhiemVuModel {
  String? nguoiTaoXuLy;
  String? donViTaoXuLy;
  String? thoiGianTao;
  String? noiDung;
  String? nguoiXuLy;
  String? donViXuLy;
  List<FileDinhKems>? fileDinhKems;
  String? hoatDong;

  LichSuTraLaiNhiemVuModel({
    this.nguoiTaoXuLy,
    this.donViTaoXuLy,
    this.thoiGianTao,
    this.noiDung,
    this.nguoiXuLy,
    this.donViXuLy,
    this.fileDinhKems,
    this.hoatDong,
  });

  List<RowDataExpandModel> toListRowLichSuTraLai() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.nguoi_tra_lai,
        value: nguoiXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_tra_lai,
        value: donViXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian,
        value: thoiGianTao ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_tra_lai,
        value: noiDung?.parseHtml() ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_bi_tra_lai,
        value: nguoiTaoXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_bi_tra_lai,
        value: donViTaoXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.file_dinh_kem,
        value: fileDinhKems ?? [],
        type: TypeDataNV.file,
      ),
    ];
    return listData;
  }
}
