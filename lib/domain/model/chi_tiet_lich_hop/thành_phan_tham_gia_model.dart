import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';

class ThanhPhanThamGiaModel {
  String? tenDonVi = '';
  String? tebCanBo = '';
  String? vaiTro = '';
  String? ndCongViec = '';
  String? trangThai = '';
  String? diemDanh = '';

  ThanhPhanThamGiaModel({
    required this.tenDonVi,
    required this.tebCanBo,
    required this.vaiTro,
    required this.ndCongViec,
    required this.trangThai,
    required this.diemDanh,
  });

  ThanhPhanThamGiaModel.fromDetail();

  // factory CongTacChuanBiModel.fromJson(Map<String, dynamic> json) {
  //   return CongTacChuanBiModel(
  //     trangThai: json[''].trim(),
  //     tenPhong: json[''].trim(),
  //     sucChua: json[''].trim(),
  //     diaDiem: json[''].trim(),
  //     loaiThietBi: json[''].trim(),
  //   );
  // }

  List<DocumentDetailRow> toListRowThanhPhanThamGia() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow('Tên đơn vị', tenDonVi, TypeDocumentDetailRow.text),
      DocumentDetailRow('Tên cán bộ', tebCanBo, TypeDocumentDetailRow.text),
      DocumentDetailRow('Vai trò', vaiTro, TypeDocumentDetailRow.text),
      DocumentDetailRow('ND công việc', ndCongViec, TypeDocumentDetailRow.text),
      DocumentDetailRow(
          'Trạng thái', trangThai, TypeDocumentDetailRow.status),
      DocumentDetailRow(
          'Điểm danh', diemDanh, TypeDocumentDetailRow.status),
    ];
    return list;
  }

}
