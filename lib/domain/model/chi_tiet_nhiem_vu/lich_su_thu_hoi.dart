import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class LichSuThuHoiModel {
  String id = '';
  String nguoiThuHoi = '';
  String donViThuHoi = '';
  String thoiGian = '';
  String noiDungTraLai = '';
  String nguoiBiThuHoi = '';
  String donViBiThuHoi = '';

  LichSuThuHoiModel.empty();

  LichSuThuHoiModel({
    required this.id,
    required this.nguoiThuHoi,
    required this.donViThuHoi,
    required this.thoiGian,
    required this.noiDungTraLai,
    required this.nguoiBiThuHoi,
    required this.donViBiThuHoi,
  });

  List<RowDataExpandModel> listLSTH() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.nguoi_thu_hoi,
        value: nguoiThuHoi,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_thu_hoi,
        value: donViThuHoi,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian,
        value: thoiGian,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_tra_lai,
        value: noiDungTraLai,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_bi_thu_hoi,
        value: nguoiBiThuHoi,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_bi_thu_hoi,
        value: donViBiThuHoi,
        type: TypeDataNV.text,
      ),
    ];
    return listData;
  }
}
