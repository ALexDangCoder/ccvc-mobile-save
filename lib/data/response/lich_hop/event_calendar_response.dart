import 'package:json_annotation/json_annotation.dart';

part 'event_calendar_response.g.dart';

@JsonSerializable()
class EventCalendarResponse {
  @JsonKey(name: 'data')
  List<String?> data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  EventCalendarResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory EventCalendarResponse.fromJson(Map<String, dynamic> json) =>
      _$EventCalendarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventCalendarResponseToJson(this);

  List<String> toModel() {
    final List<String> dataEvent = [];

    data.forEach((element) {
      if (element != null) {
        dataEvent.add(element);
      }
    });

    return dataEvent;
  }
}
