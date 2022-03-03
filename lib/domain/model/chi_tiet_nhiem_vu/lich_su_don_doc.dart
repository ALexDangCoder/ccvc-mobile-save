import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class LichSuDonDocModel {
  String id = '';
  String nguoiDonDoc = '';
  String donViDonDoc = '';
  String thoiGian = '';
  String noiDungDonDoc = '';
  String nguoiBiDonDoc = '';
  String donViBiDonDoc = '';

  LichSuDonDocModel.empty();

  LichSuDonDocModel({
    required this.id,
    required this.nguoiDonDoc,
    required this.donViDonDoc,
    required this.thoiGian,
    required this.noiDungDonDoc,
    required this.nguoiBiDonDoc,
    required this.donViBiDonDoc,
  });

  List<RowDataExpandModel> listLSDD() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
          key: S.current.nguoi_don_doc,
          value: nguoiDonDoc,
          type: TypeDataNV.text,),
      RowDataExpandModel(
          key: S.current.don_vi_don_doc,
          value: donViDonDoc,
          type: TypeDataNV.text,),
      RowDataExpandModel(
          key: S.current.thoi_gian,
          value: thoiGian,
          type: TypeDataNV.text,),
      RowDataExpandModel(
          key: S.current.noi_dung_don_doc,
          value: noiDungDonDoc,
          type: TypeDataNV.text,),
      RowDataExpandModel(
          key: S.current.nguoi_bi_don_doc,
          value: nguoiBiDonDoc,
          type: TypeDataNV.text,),
      RowDataExpandModel(
          key: S.current.don_vi_bi_don_doc,
          value: donViBiDonDoc,
          type: TypeDataNV.text,),
    ];
    return listData;
  }
}
