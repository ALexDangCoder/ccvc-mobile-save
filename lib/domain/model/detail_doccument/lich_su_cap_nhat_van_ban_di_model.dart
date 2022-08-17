import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_thu_hoi_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class DataLichSuCapNhatVanBanDi {
  String? messages;
  List<LichSuCapNhatVanBanDi>? data;
  String? validationResult;
  bool? isSuccess;

  DataLichSuCapNhatVanBanDi({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });
}

class LichSuCapNhatVanBanDi {
  String? nguoiCapNhat;
  String? donViCapNhat;
  String? thoiGian;
  String? noiDungCapNhat;
  int? trangThai;
  List<Files>? files;

  LichSuCapNhatVanBanDi({
    this.nguoiCapNhat,
    this.donViCapNhat,
    this.thoiGian,
    this.noiDungCapNhat,
    this.trangThai,
    this.files,
  });

  List<DocumentDetailRow> toListRowCapNhat() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_cap_nhat,
        nguoiCapNhat ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi,
        donViCapNhat ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGian?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DAY_MONTH_YEAR,
            ) ??
            '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noidung,
        noiDungCapNhat ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.trang_thai,
        trangThaiDuyet(trangThai ?? 0),
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

  String trangThaiDuyet(int number) {
    switch (number) {
      case 0:
        return S.current.trinh_ky;
      case 1:
        return S.current.duyet;
      case 2:
        return S.current.huy_duyet;
      case 3:
        return S.current.thu_hoi;
      case 4:
        return S.current.tra_lai;
      case 5:
        return S.current.cap_so;
      case 6:
        return S.current.ban_hanh;
      case 7:
        return S.current.thu_hoi_van_ban_di_da_ban_hanh;
      case 8:
        return S.current.huy_trinh_ky;
      case 9:
        return S.current.trinh_ky_tiep_theo;
      case 10:
        return S.current.khoi_tao_van_ban;
      case 11:
        return S.current.cap_nhat_van_ban;
    }
    return '';
  }
}
