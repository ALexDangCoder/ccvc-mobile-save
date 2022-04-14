import 'package:ccvc_mobile/domain/model/account/change_pass_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_pass_response.g.dart';

@JsonSerializable()
class ChangePassResponse {
  @JsonKey(name: 'messages')
  List<String>? messages;
  @JsonKey(name: 'data')
  bool? data;
  @JsonKey(name: 'isSuccess')
  bool? isSuccess;

  ChangePassResponse({
    this.messages,
    this.data,
    this.isSuccess,
  });

  factory ChangePassResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePassResponseToJson(this);

  ChangePassModel toModel() => ChangePassModel(
        messages: messages,
        data: data,
        isSuccess: isSuccess,
      );
}
