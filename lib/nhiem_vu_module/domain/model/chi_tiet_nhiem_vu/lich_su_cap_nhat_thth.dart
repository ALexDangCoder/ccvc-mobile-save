import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/string_extension.dart';

class LichSuCapNhatTHTHModel {
  String? id;
  String? nguoiCapNhat;
  String? donViCapNhat;
  String? thoiGian;
  String? noiDungCapNhat;
  String? trangThai;
  String? trangThaiId;
  List<FileDinhKems>? fileDinhKems;

  LichSuCapNhatTHTHModel.empty();

  LichSuCapNhatTHTHModel({
    this.id,
    this.nguoiCapNhat,
    this.donViCapNhat,
    this.thoiGian,
    this.noiDungCapNhat,
    this.trangThai,
    this.trangThaiId,
    this.fileDinhKems,
  });

  List<RowDataExpandModel> listLSCNTHTH() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.nguoi_cap_nhat,
        value: nguoiCapNhat ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_cap_nhat,
        value: donViCapNhat ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian,
        value: thoiGian ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_cap_nhat,
        value: noiDungCapNhat?.parseHtml() ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.file_dinh_kem,
        value: fileDinhKems ?? '',
        type: TypeDataNV.file,
      ),
      RowDataExpandModel(
        key: S.current.trang_thai,
        value:
            trangThai?.split(' ').join('_').toUpperCase().vietNameseParse() ??
                '',
        type: TypeDataNV.status,
      ),
    ];
    return listData;
  }
}
