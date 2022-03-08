import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';

class PhatBieuModel {
  String? phienHop = '';
  String? nguoiPhatBieu = '';
  String? ndPhatBieu = '';
  String? tthoiGian = '';

  PhatBieuModel({
    required this.phienHop,
    required this.nguoiPhatBieu,
    required this.ndPhatBieu,
    required this.tthoiGian,
  });

  PhatBieuModel.fromDetail();
}
