import 'package:ccvc_mobile/diem_danh_module/domain/model/bang_diem_danh_ca_nhan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bang_diem_danh_ca_nhan_response.g.dart';

@JsonSerializable()
class DataListItemThongKeDiemDanhCaNhanModelResponse {
  @JsonKey(name: 'data')
  ListItemThongKeDiemDanhCaNhanModelResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataListItemThongKeDiemDanhCaNhanModelResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DataListItemThongKeDiemDanhCaNhanModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataListItemThongKeDiemDanhCaNhanModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataListItemThongKeDiemDanhCaNhanModelResponseToJson(this);
}

@JsonSerializable()
class ListItemThongKeDiemDanhCaNhanModelResponse {
  @JsonKey(name: 'items')
  List<ThongKeDiemDanhCaNhanModelResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  ListItemThongKeDiemDanhCaNhanModelResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory ListItemThongKeDiemDanhCaNhanModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ListItemThongKeDiemDanhCaNhanModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListItemThongKeDiemDanhCaNhanModelResponseToJson(this);

  ListItemBangDiemDanhCaNhanModel toModel() => ListItemBangDiemDanhCaNhanModel(
        items: items?.map((e) => e.toModel()).toList(),
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );
}

@JsonSerializable()
class ThongKeDiemDanhCaNhanModelResponse {
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'timeIn')
  String? timeIn;
  @JsonKey(name: 'timeOut')
  String? timeOut;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'dayWage')
  double? dayWage;
  @JsonKey(name: 'leave')
  double? leave;
  @JsonKey(name: 'isLeaveRequest')
  int? isLeaveRequest;
  @JsonKey(name: 'leaveRequestReasonCode')
  String? leaveRequestReasonCode;
  @JsonKey(name: 'leaveRequestReasonTakeLeaveCode')
  String? leaveRequestReasonTakeLeaveCode;
  @JsonKey(name: 'leaveRequestReasonName')
  String? leaveRequestReasonName;
  @JsonKey(name: 'isLate')
  bool? isLate;
  @JsonKey(name: 'isComeBackEarly')
  bool? isComeBackEarly;
  @JsonKey(name: 'leaveType')
  String? leaveType;

  ThongKeDiemDanhCaNhanModelResponse({
    this.date,
    this.timeIn,
    this.timeOut,
    this.type,
    this.dayWage,
    this.leave,
    this.isLeaveRequest,
    this.leaveRequestReasonCode,
    this.leaveRequestReasonTakeLeaveCode,
    this.leaveRequestReasonName,
    this.isLate,
    this.isComeBackEarly,
    this.leaveType,
  });

  factory ThongKeDiemDanhCaNhanModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ThongKeDiemDanhCaNhanModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ThongKeDiemDanhCaNhanModelResponseToJson(this);

  BangDiemDanhCaNhanModel toModel() => BangDiemDanhCaNhanModel(
        date: date,
        timeIn: timeIn,
        timeOut: timeOut,
        type: type,
        dayWage: dayWage,
        leave: leave,
        isLeaveRequest: isLeaveRequest,
        leaveRequestReasonCode: leaveRequestReasonCode,
        leaveRequestReasonTakeLeaveCode: leaveRequestReasonTakeLeaveCode,
        leaveRequestReasonName: leaveRequestReasonName,
        isLate: isLate,
        isComeBackEarly: isComeBackEarly,
        leaveType: leaveType,
      );
}
