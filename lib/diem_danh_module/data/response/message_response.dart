import 'package:ccvc_mobile/diem_danh_module/domain/model/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_response.g.dart';

@JsonSerializable()
class MessageResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  MessageResponse({
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  MessageModel get toModel => MessageModel(
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}
