import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class LichSuCapNhatTHTHModel {
  String id = '';
  String nguoiCapNhat = '';
  String donViCapNhat = '';
  String thoiGian = '';
  String noiDungCapNhat = '';
  String dvBiTraLai = '';
  String trangThai = '';

  LichSuCapNhatTHTHModel.empty();

  LichSuCapNhatTHTHModel({
    required this.id,
    required this.nguoiCapNhat,
    required this.donViCapNhat,
    required this.thoiGian,
    required this.noiDungCapNhat,
    required this.dvBiTraLai,
    required this.trangThai,
  });

  List<RowDataExpandModel> listLSCNTHTH() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.nguoi_cap_nhat,
        value: nguoiCapNhat,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_cap_nhat,
        value: donViCapNhat,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian,
        value: thoiGian,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_cap_nhat,
        value: noiDungCapNhat,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.dv_bi_tra_lai,
        value: dvBiTraLai,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.trang_thai,
        value: trangThai,
        type: TypeDataNV.status,
      ),
    ];
    return listData;
  }
}
