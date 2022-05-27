import 'package:json_annotation/json_annotation.dart';

part 'quan_ly_widget_request.g.dart';

@JsonSerializable()
class QuanLyWidgetRequest {
  @JsonKey(name: 'widgetConfigData')
  final String widgetConfigData;

  QuanLyWidgetRequest({
    required this.widgetConfigData,
  });

  factory QuanLyWidgetRequest.fromJson(Map<String, dynamic> json) =>
      _$QuanLyWidgetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuanLyWidgetRequestToJson(this);
}
