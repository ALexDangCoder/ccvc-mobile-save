import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  @JsonKey(name: 'data')
  bool? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'statusCode')
  int? statusCode;

  PostResponse(
    this.data,
    this.message,
    this.succeeded,
    this.code,
    this.statusCode,
  );
  factory PostResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}
