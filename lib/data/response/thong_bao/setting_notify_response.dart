import 'package:ccvc_mobile/domain/model/thong_bao/setting_notify_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_notify_response.g.dart';

@JsonSerializable()
class SettingNotifyResponse {
  @JsonKey(name: 'data')
  SettingNotifyData data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  SettingNotifyResponse(
      this.data, this.statusCode, this.succeeded, this.code, this.message);

  factory SettingNotifyResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingNotifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SettingNotifyResponseToJson(this);
}

@JsonSerializable()
class SettingNotifyData {
  @JsonKey(name: 'id')
  String? id;
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
  @JsonKey(name: 'createBy')
  String? createBy;
  @JsonKey(name: 'updateAt')
  String? updateAt;
  @JsonKey(name: 'updateBy')
  String? updateBy;

  SettingNotifyData(
    this.id,
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
    this.createBy,
    this.updateAt,
    this.updateBy,
  );

  SettingNotifyModel toModel() => SettingNotifyModel(
        id: id,
        modeSilent: modeSilent,
        subSystem: (subSystem ?? '').split(','),
      );

  factory SettingNotifyData.fromJson(Map<String, dynamic> json) =>
      _$SettingNotifyDataFromJson(json);

  Map<String, dynamic> toJson() => _$SettingNotifyDataToJson(this);
}
