import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';

class CongTacChuanBiModel {
  String? trangThai = '';
  String? tenPhong = '';
  String? sucChua = '';
  String? diaDiem = '';
  String? loaiThietBi = '';



  CongTacChuanBiModel({
    required this.trangThai,
    required this.tenPhong,
    required this.sucChua,
    required this.diaDiem,
    required this.loaiThietBi,
  });

  CongTacChuanBiModel.fromDetail();

  // factory CongTacChuanBiModel.fromJson(Map<String, dynamic> json) {
  //   return CongTacChuanBiModel(
  //     trangThai: json[''].trim(),
  //     tenPhong: json[''].trim(),
  //     sucChua: json[''].trim(),
  //     diaDiem: json[''].trim(),
  //     loaiThietBi: json[''].trim(),
  //   );
  // }

  List<DocumentDetailRow> toListRowThongTinPhong() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow('Tên phòng', tenPhong, TypeDocumentDetailRow.text),
      DocumentDetailRow('Sức chứa', sucChua, TypeDocumentDetailRow.text),
      DocumentDetailRow('Địa điểm', diaDiem, TypeDocumentDetailRow.text),
      DocumentDetailRow('Trạng thái', trangThai, TypeDocumentDetailRow.status),
      DocumentDetailRow('Thiết bị có sẵn', loaiThietBi, TypeDocumentDetailRow.text),
    ];
    return list;
  }

  List<DocumentDetailRow> toListRowYeuCauThietBi() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow('Loại thiết bị', loaiThietBi, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số lượng', sucChua, TypeDocumentDetailRow.text),
      DocumentDetailRow('Trạng thái', trangThai, TypeDocumentDetailRow.status),
    ];
    return list;
  }

}
