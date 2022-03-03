import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class DanhSachCongViecModel {
  String id = '';
  int stt = 1;
  String nguoiXuLy = '';
  String donViXuLy = '';
  String thoiGianGiaoViec = '';
  String hanXuLy = '';
  String ndCongViec = '';
  String nguoiGiaoViec = '';
  String trangThai = '';

  DanhSachCongViecModel.empty();

  DanhSachCongViecModel({
    required this.id,
    required this.stt,
    required this.nguoiXuLy,
    required this.donViXuLy,
    required this.thoiGianGiaoViec,
    required this.hanXuLy,
    required this.ndCongViec,
    required this.nguoiGiaoViec,
    required this.trangThai,
  });

  List<RowDataExpandModel> listDSCV() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.stt,
        value: stt.toString(),
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_xu_ly,
        value: nguoiXuLy,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_xu_ly,
        value: donViXuLy,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian_giao_viec,
        value: thoiGianGiaoViec,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.han_xu_ly,
        value: hanXuLy,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_cong_viec,
        value: ndCongViec,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_giao_viec,
        value: nguoiGiaoViec,
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
