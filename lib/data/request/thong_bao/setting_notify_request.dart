import 'package:json_annotation/json_annotation.dart';

part 'setting_notify_request.g.dart';

@JsonSerializable()

class SettingNotifyRequest {
  @JsonKey(name: 'modeSilent')
  bool? modeSilent;
  @JsonKey(name: 'messageShowNotRead')
  bool? messageShowNotRead;
  @JsonKey(name: 'messageShowPreview')
  bool? messageShowPreview;
  @JsonKey(name: 'messageShowNew')
  bool? messageShowNew;
  @JsonKey(name: 'sound')
  bool? sound;
  @JsonKey(name: 'soundVolume')
  int? soundVolume;
  @JsonKey(name: 'soundType')
  String? soundType;
  @JsonKey(name: 'noticeHideAuto')
  String? noticeHideAuto;
  @JsonKey(name: 'noticeLocation')
  String? noticeLocation;
  @JsonKey(name: 'subSystem')
  String? subSystem;
  @JsonKey(name: 'createdBy')
  String? createdBy;

  SettingNotifyRequest({
    this.modeSilent,
    this.messageShowNotRead,
    this.messageShowPreview,
    this.messageShowNew,
    this.sound,
    this.soundVolume,
    this.soundType,
    this.noticeHideAuto,
    this.noticeLocation,
    this.subSystem,
    this.createdBy,
  });

  factory SettingNotifyRequest.fromJson(Map<String, dynamic> json) =>
      _$SettingNotifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SettingNotifyRequestToJson(this);
}
