import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class LichSuPhanXuLyModel {
  String id = '';
  int stt = 1;
  String nguoiGui = '';
  String thoiGian = '';
  String nguoiNhan = '';
  String donViNhan = '';
  String vaiTroXuLy = '';
  String trangThai = '';

  LichSuPhanXuLyModel.empty();

  LichSuPhanXuLyModel({
    required this.id,
    required this.stt,
    required this.nguoiGui,
    required this.thoiGian,
    required this.nguoiNhan,
    required this.donViNhan,
    required this.vaiTroXuLy,
    required this.trangThai,
  });

  List<RowDataExpandModel> listLSPXL() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.stt,
        value: stt.toString(),
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_gui,
        value: nguoiGui,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian,
        value: thoiGian,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_nhan,
        value: nguoiNhan,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_nhan,
        value: donViNhan,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.vai_tro_xu_ly,
        value: vaiTroXuLy,
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
