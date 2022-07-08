import 'package:json_annotation/json_annotation.dart';

part 'delete_task_response.g.dart';

@JsonSerializable()
class DeleteTaskResponse {
  @JsonKey(name: 'data')
  bool? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'succeeded')
  bool? succeeded;

  DeleteTaskResponse(
    this.data,
    this.statusCode,
    this.message,
    this.code,
    this.succeeded,
  );

  factory DeleteTaskResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DeleteTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTaskResponseToJson(this);
}
