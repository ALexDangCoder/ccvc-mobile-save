import '/home_module/utils/constants/app_constants.dart';

const _HOA_TOC = 'HoaToc';
const _THUONG_KHAN = 'ThuongKhan';
const _KHAN = 'Khan';
const _BINH_THUONG = 'BinhThuong';

class DocumentModel {
  final String id;
  final String kyHieu;
  final String noiGui;
  final String status;
  final String code;
  final String title;
  final String taskId;
  late final DocumentStatus documentStatus;

  DocumentModel({
    required this.kyHieu,
    required this.noiGui,
    required this.status,
    required this.code,
    required this.title,
    this.id = '',
    this.taskId = '',
  }) {
    documentStatus = byStatus();
  }

  DocumentStatus byStatus() {
    switch (code) {
      case HOAN_THANH:
        return DocumentStatus.HOAN_THANH;
      case QUA_HAN:
        return DocumentStatus.QUA_HAN;
      case CHO_TIEP_NHAN:
        return DocumentStatus.CHO_TIEP_NHAN;
      case THAM_GIA:
        return DocumentStatus.THAM_GIA;
      case _BINH_THUONG:
        return DocumentStatus.BINH_THUONG;
      case _KHAN:
        return DocumentStatus.KHAN;
      case _THUONG_KHAN:
        return DocumentStatus.THUONG_KHAN;
      case _HOA_TOC:
        return DocumentStatus.HOA_TOC;
    }
    return DocumentStatus.THAM_GIA;
  }
}
