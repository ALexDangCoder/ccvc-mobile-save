import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class DataThongTinGuiNhanModel {
  String? messages;
  List<ThongTinGuiNhanModel>? data;
  String? validationResult;
  bool? isSuccess;

  DataThongTinGuiNhanModel({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });
}

class ThongTinGuiNhanModel {
  String? nguoiGui;

  String? donViGui;
  String? thoiGian;
  String? nguoiNhan;
  String? donViNhan;
  String? vaiTroXuLy;

  String? trangThai;

  ThongTinGuiNhanModel({
     this.nguoiGui,
     this.donViGui,
     this.donViNhan,
     this.trangThai,
     this.nguoiNhan,
     this.thoiGian,
     this.vaiTroXuLy,
  });

  ThongTinGuiNhanModel.fromDetail();

  List<DocumentDetailRow> toListRow() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.nguoi_gui,
        nguoiGui ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_gui,
        donViGui ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.thoi_gian,
        thoiGian ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_nhan,
        nguoiNhan ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.don_vi_nhan,
        donViNhan ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.vai_tro_xu_ly,
        vaiTroXuLy ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.trang_thai,
        trangThai?.split(' ').join('_').toUpperCase().vietNameseParse() ?? '',
        TypeDocumentDetailRow.status,
      ),
    ];
    return list;
  }
}
