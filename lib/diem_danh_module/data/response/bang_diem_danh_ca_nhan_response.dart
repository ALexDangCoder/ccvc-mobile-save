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
  @JsonKey(name: 'time_in')
  String? timeIn;
  @JsonKey(name: 'time_out')
  String? timeOut;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'day_wage')
  double? dayWage;
  @JsonKey(name: 'leave')
  double? leave;
  @JsonKey(name: 'is_leave_request')
  int? isLeaveRequest;
  @JsonKey(name: 'leave_request_reason_code')
  String? leaveRequestReasonCode;
  @JsonKey(name: 'leave_request_reason_take_leave_code')
  String? leaveRequestReasonTakeLeaveCode;
  @JsonKey(name: 'leave_request_reason_name')
  String? leaveRequestReasonName;
  @JsonKey(name: 'is_late')
  bool? isLate;
  @JsonKey(name: 'is_come_back_early')
  bool? isComeBackEarly;
  @JsonKey(name: 'leave_type')
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
