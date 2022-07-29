import 'package:json_annotation/json_annotation.dart';

part 'device_request.g.dart';

@JsonSerializable()
class DeviceRequest {
  @JsonKey(name: 'registationId')
  String? registationId;
  @JsonKey(name: 'deviceType')
  String? deviceType;
  @JsonKey(name: 'isActive')
  bool? isActive;

  DeviceRequest({
    required this.registationId,
    this.deviceType,
    required this.isActive,
  });

  factory DeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRequestToJson(this);
}
