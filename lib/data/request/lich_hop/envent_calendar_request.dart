import 'package:json_annotation/json_annotation.dart';

part 'envent_calendar_request.g.dart';

@JsonSerializable()
class EventCalendarRequest {
  String? DateFrom;
  String? DateTo;
  String? DonViId;
  int? PageIndex;
  int? PageSize;
  String? UserId;
  bool? isLichCuaToi;
  int? month;
  int? year;

  EventCalendarRequest({
    required this.DateFrom,
    required this.DateTo,
    required this.DonViId,
    required this.PageIndex,
    required this.PageSize,
    required this.UserId,
    required this.isLichCuaToi,
    required this.month,
    required this.year,
  });

  factory EventCalendarRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCalendarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventCalendarRequestToJson(this);
}
