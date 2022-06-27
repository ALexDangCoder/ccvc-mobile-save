import 'package:json_annotation/json_annotation.dart';

part 'share_report_request.g.dart';

@JsonSerializable()
class ShareReport {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'groupId')
  String? groupId;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'expiredDate')
  String? expiredDate;
  @JsonKey(name: 'newUser')
  Map<String, String>? newUser;

  ShareReport({
    this.userId,
    this.groupId,
    this.type,
    this.expiredDate,
    this.newUser,
  });

  Map<String, dynamic> toJson() => _$ShareReportToJson(this);
}
