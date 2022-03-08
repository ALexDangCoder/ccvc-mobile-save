class DanhSachPhatBieuLichHopData {
  List<DanhSachPhatBieuLichHopModel>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DanhSachPhatBieuLichHopData({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });
}

class DanhSachPhatBieuLichHopModel {
  String? chuTriCanBoId;
  String? chuTriDonViId;
  String? id;
  String? userId;
  String? donViId;
  String? phienHopId;
  String? personName;
  String? unitName;
  String? time;
  int? meetingSection;
  int? status;
  String? content;
  String? lichHopId;
  String? tenPhienHop;
  String? createdBy;

  DanhSachPhatBieuLichHopModel({
    this.chuTriCanBoId,
    this.chuTriDonViId,
    this.id,
    this.userId,
    this.donViId,
    this.phienHopId,
    this.personName,
    this.unitName,
    this.time,
    this.meetingSection,
    this.status,
    this.content,
    this.lichHopId,
    this.tenPhienHop,
    this.createdBy,
  });
}
