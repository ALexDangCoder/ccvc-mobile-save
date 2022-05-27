import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

class DashBoardVBDenResponse {
  String? messages;
  List<Data>? data;
  String? validationResult;
  bool? isSuccess;

  DashBoardVBDenResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  DashBoardVBDenResponse.fromJson(Map<String, dynamic> json) {
    messages = json['Messages'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    validationResult = json['ValidationResult'];
    isSuccess = json['IsSuccess'];
  }

  DocumentDashboardModel toDomain() {
    return DocumentDashboardModel()
      ..soLuongChoXuLy = getValue(DocumentState.CHO_XU_LY)
      ..soLuongDangXuLy = getValue(DocumentState.DANG_XU_LY)
      ..soLuongDaXuLy = getValue(DocumentState.DA_XU_LY)
      ..soLuongChoVaoSo = getValue(DocumentState.CHO_VAO_SO);
  }

  int getValue(String codeValue) {
    if (data != null) {
      final result = data!.where((element) => element.code == codeValue);
      if (result.isNotEmpty) {
        return result.first.value ?? 0;
      }
    }
    return 0;
  }
}

class Data {
  String? id;
  String? code;
  String? name;
  int? value;
  int? specialId;
  String? typeCode;

  Data({
    this.id,
    this.code,
    this.name,
    this.value,
    this.specialId,
    this.typeCode,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
    value = json['Value'];
    specialId = json['SpecialId'];
    typeCode = json['TypeCode'];
  }
}
