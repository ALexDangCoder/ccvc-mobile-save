import 'package:json_annotation/json_annotation.dart';

part 'confirm_officer_request.g.dart';

@JsonSerializable()
class ConfirmOfficerRequest {
  @JsonKey(name: 'lichId')
  String? lichId;
  @JsonKey(name: 'isThamGia')
  bool? isThamGia;
  @JsonKey(name: 'lyDo')
  String? lyDo;

  ConfirmOfficerRequest({this.lichId, this.isThamGia, this.lyDo});

  factory ConfirmOfficerRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOfficerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOfficerRequestToJson(this);
}
