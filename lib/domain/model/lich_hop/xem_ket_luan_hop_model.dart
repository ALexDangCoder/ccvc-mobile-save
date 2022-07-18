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
  String? createAt;

  XemKetLuanHopModel.emty();

  XemKetLuanHopModel({
    this.id,
    this.scheduleId,
    this.reportStatusId,
    this.startDate,
    this.endDate,
    this.content,
    this.status,
    this.statusName,
    this.scheduleTitle,
    this.reportStatus,
    this.reportStatusCode,
    this.createBy,
    this.canBoChuTriId,
    this.nguoiTao,
    this.nguoiChuTri,
    this.files,
    this.reportTemplateId,
    this.noiDungHuy,
    this.title,
    this.createAt
  });
}
