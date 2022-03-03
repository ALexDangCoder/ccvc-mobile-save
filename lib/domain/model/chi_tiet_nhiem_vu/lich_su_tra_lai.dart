import 'dart:io';

import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class LichSuTraLaiModel {
  String id = '';
  String nguoiCapNhat = '';
  String donViTraLai = '';
  String thoiGian = '';
  String noiDungTraLai = '';
  String nguoiBiTraLai = '';
  String dvBiTraLai = '';
  File fileDinhKem = File('');

  LichSuTraLaiModel.empty();

  LichSuTraLaiModel({
    required this.id,
    required this.nguoiCapNhat,
    required this.donViTraLai,
    required this.thoiGian,
    required this.noiDungTraLai,
    required this.nguoiBiTraLai,
    required this.dvBiTraLai,
    required this.fileDinhKem,
  });

  List<RowDataExpandModel> listLSTL() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.nguoi_cap_nhat,
        value: nguoiCapNhat,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_tra_lai,
        value: donViTraLai,
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
        key: S.current.nguoi_bi_tra_lai,
        value: nguoiBiTraLai,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_bi_tra_lai,
        value: dvBiTraLai,
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.file_dinh_kem,
        value: fileDinhKem,
        type: TypeDataNV.file,
      ),
    ];
    return listData;
  }
}
