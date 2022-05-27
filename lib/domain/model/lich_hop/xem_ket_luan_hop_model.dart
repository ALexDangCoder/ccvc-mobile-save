import 'file_model.dart';

class XemKetLuanHopModel {
  String? id;
  String? scheduleId;
  String? reportStatusId;
  String? startDate;
  String? endDate;
  String? content;
  int? status;
  String? statusName;
  String? scheduleTitle;
  String? reportStatus;
  String? reportStatusCode;
  String? createBy;
  String? canBoChuTriId;
  String? nguoiTao;
  String? nguoiChuTri;
  List<FileDetailMeetModel>? files;
  String? reportTemplateId;
  String? noiDungHuy;
  String? title;

  XemKetLuanHopModel.emty();

  XemKetLuanHopModel({
    required this.id,
    required this.scheduleId,
    required this.reportStatusId,
    required this.startDate,
    required this.endDate,
    required this.content,
    required this.status,
    required this.statusName,
    required this.scheduleTitle,
    required this.reportStatus,
    required this.reportStatusCode,
    required this.createBy,
    required this.canBoChuTriId,
    required this.nguoiTao,
    required this.nguoiChuTri,
    required this.files,
    required this.reportTemplateId,
    required this.noiDungHuy,
    required this.title,
  });
}
