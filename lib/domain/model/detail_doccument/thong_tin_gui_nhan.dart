import 'document_detail_row.dart';

class DetailDocumentProfileSend {
  String? nguoiGui = '';
  String? donViGui = '';
  String? thoiGian = '';
  String? nguoiNhan = '';
  String? donViNhan = '';
  String? vaiTro = '';
  String? trangThai = '';
  String? tenPhong = '';
  String? sucChua = '';
  String? diaDiem = '';
  String? loaiThietBi = '';
  String? soLuong = '';

  DetailDocumentProfileSend({
    required this.nguoiGui,
    required this.donViGui,
    required this.donViNhan,
    required this.trangThai,
    required this.nguoiNhan,
    required this.thoiGian,
    required this.vaiTro,
  });

  DetailDocumentProfileSend.fromDetail();

  factory DetailDocumentProfileSend.fromJson(Map<String, dynamic> json) {
    return DetailDocumentProfileSend(
      nguoiGui: json[''],
      donViGui: json[''],
      thoiGian: json[''],
      nguoiNhan: json[''],
      donViNhan: json[''],
      vaiTro: json[''],
      trangThai: json[''].trim(),
    );
  }

  List<DocumentDetailRow> toListRow() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow('Sổ văn bản', nguoiGui, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số đến', donViGui, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số phụ', thoiGian, TypeDocumentDetailRow.text),
      DocumentDetailRow('Nơi gửi', nguoiNhan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Loại văn bản', donViNhan, TypeDocumentDetailRow.text),
      DocumentDetailRow('Số ký hiệu', vaiTro, TypeDocumentDetailRow.text),
      DocumentDetailRow('Ngày BH', trangThai, TypeDocumentDetailRow.status),
    ];
    return list;
  }
}
