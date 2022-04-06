import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/string_extension.dart';

class LichSuThuHoiNhiemVuModel {
  String? nguoiTaoXuLy;
  String? donViTaoXuLy;
  String? thoiGianTao;
  String? noiDung;
  String? nguoiXuLy;
  String? donViXuLy;

  LichSuThuHoiNhiemVuModel.empty();

  LichSuThuHoiNhiemVuModel({
    this.nguoiTaoXuLy,
    this.donViTaoXuLy,
    this.thoiGianTao,
    this.noiDung,
    this.nguoiXuLy,
    this.donViXuLy,
  });

  List<RowDataExpandModel> listLSTH() {
    final List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.nguoi_thu_hoi,
        value: nguoiTaoXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_thu_hoi,
        value: donViTaoXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian,
        value: thoiGianTao ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_thu_hoi,
        value: noiDung?.parseHtml() ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_bi_thu_hoi,
        value: nguoiXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_bi_thu_hoi,
        value: donViXuLy ?? '',
        type: TypeDataNV.text,
      ),
    ];
    return listData;
  }
}
