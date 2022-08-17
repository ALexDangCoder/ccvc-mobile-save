import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

class DataLichSuTraLaiVanBanDi {
  String? messages;
  List<LichSuTraLaiVanBanDi>? data;
  String? validationResult;
  bool? isSuccess;

  DataLichSuTraLaiVanBanDi({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });
}

class LichSuTraLaiVanBanDi {
  String? nguoiTraLai;
  String? donViTraLai;
  String? thoiGian;
  String? noiDungTraLai;
  String? nguoiBiTraLai;
  String? donViBiTraLai;
  List<Files>? files;

  LichSuTraLaiVanBanDi({
    this.nguoiTraLai,
    this.donViTraLai,
    this.thoiGian,
    this.noiDungTraLai,
    this.nguoiBiTraLai,
    this.donViBiTraLai,
    this.files,
  });

  List<DocumentDetailRow> toListRowTraLai() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_tra_lai,
        nguoiTraLai ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_tra_lai,
        donViTraLai ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGian ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noi_dung_tra_lai,
        noiDungTraLai ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_bi_tra_lai,
        nguoiBiTraLai ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.dv_bi_tra_lai,
        donViBiTraLai ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.file_dinh_kem,
        files ?? [],
        TypeDocumentDetailRow.fileVanBanDi,
      ),
    ];
    return list;
  }
}
