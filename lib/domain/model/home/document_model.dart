import 'package:ccvc_mobile/utils/constants/app_constants.dart';

class DocumentModel {
  final String id;
  final String kyHieu;
  final String noiGui;
  final String status;
  final String code;
  final String title;
  late final DocumentStatus documentStatus;

  DocumentModel(
      {required this.kyHieu,
      required this.noiGui,
      required this.status,
      required this.code,
      required this.title,
      this.id = ''}) {
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
    }
    return DocumentStatus.THAM_GIA;
  }
}
