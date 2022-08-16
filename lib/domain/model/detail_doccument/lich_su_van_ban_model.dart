import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class DataLichSuVanBanModel {
  String? messages;
  List<LichSuVanBanModel>? data;
  String? validationResult;
  bool? isSuccess;

  DataLichSuVanBanModel({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });
}

class LichSuVanBanModel {
  String? nguoiTaoXuLy;
  String? donViTaoXuLy;
  String? thoiGianTao;
  String? noiDung;
  String? nguoiXuLy;
  String? donViXuLy;
  List<FileDinhKems>? fileDinhKems;
  String? hoatDong;

  LichSuVanBanModel({
    this.nguoiTaoXuLy,
    this.donViTaoXuLy,
    this.thoiGianTao,
    this.noiDung,
    this.nguoiXuLy,
    this.donViXuLy,
    this.fileDinhKems,
    this.hoatDong,
  });

  List<DocumentDetailRow> toListRowLichSuCapNhat() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_cap_nhat,
        nguoiTaoXuLy ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi,
        donViTaoXuLy ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGianTao?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DATE_DD_MM_YYYY,
            ) ??
            '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noidung,
        noiDung ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.file_dinh_kem,
        fileDinhKems ?? [],
        TypeDocumentDetailRow.fileActacks,
      ),
    ];

    return list;
  }

  List<DocumentDetailRow> toListRowLichSuTraLai() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_tra_lai,
        nguoiXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_tra_lai,
        donViXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGianTao??
            '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noi_dung_tra_lai,
        noiDung,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_bi_tra_lai,
        nguoiTaoXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_bi_tra_lai,
        donViTaoXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.file_dinh_kem,
        fileDinhKems ?? [],
        TypeDocumentDetailRow.fileActacks,
      ),
    ];
    return list;
  }

  List<DocumentDetailRow> toListRowLichSuThuHoi() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_thu_hoi,
        nguoiTaoXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_thu_hoi,
        noiDung,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGianTao?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DATE_TIME_23,
            ) ??
            '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noi_dung_thu_hoi,
        donViTaoXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_bi_thu_hoi,
        nguoiXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_bi_thu_hoi,
        donViXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.file_dinh_kem,
        fileDinhKems,
        TypeDocumentDetailRow.fileActacks,
      ),
    ];
    return list;
  }

  List<DocumentDetailRow> toListRowLichSuVanBanLienThong() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_thu_hoi,
        nguoiTaoXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noi_dung_thu_hoi,
        donViTaoXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_thu_hoi,
        noiDung,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGianTao?.changeToNewPatternDate(
              DateTimeFormat.DATE_BE_RESPONSE_FORMAT,
              DateTimeFormat.DATE_DD_MM_YYYY,
            ) ??
            '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_bi_thu_hoi,
        nguoiXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_bi_thu_hoi,
        donViXuLy,
        TypeDocumentDetailRow.text,
      ),
    ];
    return list;
  }
}

class FileDinhKems {
  String? id;
  String? idFileGoc;
  String? processId;
  String? ten;
  String? duongDan;
  String? duoiMoRong;
  String? dungLuong;
  String? kieuDinhKem;
  bool? isSign;
  String? qrCreated;
  int? index;
  String? nguoiTaoId;
  String? nguoiTao;
  String? pathIOC;

  FileDinhKems({
    this.id,
    this.idFileGoc,
    this.processId,
    this.ten,
    this.duongDan,
    this.duoiMoRong,
    this.dungLuong,
    this.kieuDinhKem,
    this.isSign,
    this.qrCreated,
    this.index,
    this.nguoiTaoId,
    this.nguoiTao,
    this.pathIOC,
  });
}
