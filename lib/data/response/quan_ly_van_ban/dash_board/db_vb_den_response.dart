import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/dash_board_vb_den_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'db_vb_den_response.g.dart';

@JsonSerializable()
class DoashBoashVBDenResponse {
  @JsonKey(name: 'Data')
  List<DataResponseDoashBoashVBDi> dataDashBoardVBDen;

  DoashBoashVBDenResponse(this.dataDashBoardVBDen);

  factory DoashBoashVBDenResponse.fromJson(Map<String, dynamic> json) =>
      _$DoashBoashVBDenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoashBoashVBDenResponseToJson(this);

  DocumentDashboardModel toDomain() {
    final Map<String, int> mapData = {};
    DocumentDashboardModel documentDashboardModel = DocumentDashboardModel();
    if (dataDashBoardVBDen.isNotEmpty) {
      for (final element in dataDashBoardVBDen) {
        mapData['${element.code}'] = element.value ?? 0;
      }
      documentDashboardModel = DocumentDashboardModel(
        soLuongChoXuLy: mapData[VBDenDocumentType.CHO_XU_LY.getName()],
        soLuongDangXuLy: mapData[VBDenDocumentType.DANG_XU_LY.getName()],
        soLuongDaXuLy: mapData[VBDenDocumentType.DA_XU_LY.getName()],
        soLuongChoVaoSo: mapData[VBDenDocumentType.CHO_VAO_SO.getName()],
        soLuongTrongHan: mapData[VBDenDocumentType.TRONG_HAN.getName()],
        soLuongQuaHan: mapData[VBDenDocumentType.QUA_HAN.getName()],
        soLuongThuongKhan: mapData[VBDenDocumentType.THUONG_KHAN.getName()],
      );
    }

    return documentDashboardModel;
  }

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponseDoashBoashVBDi {
  @JsonKey(name: 'Id')
  String? iD;
  @JsonKey(name: 'Code')
  String? code;
  @JsonKey(name: 'Value')
  int? value;

  DataResponseDoashBoashVBDi(this.iD, this.code, this.value);

  factory DataResponseDoashBoashVBDi.fromJson(Map<String, dynamic> json) =>
      _$DataResponseDoashBoashVBDiFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseDoashBoashVBDiToJson(this);

  DashBoardVbDen toDomain() => DashBoardVbDen(
        id: iD,
        code: code,
        vaulue: value,
      );

  @override
  List<Object?> get props => [];
}
