import 'package:ccvc_mobile/domain/model/lich_hop/time_config.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_config_response.g.dart';

@JsonSerializable()
class TimeConfigResponse extends Equatable {
  @JsonKey(name: 'timeStart')
  String? timeStart;
  @JsonKey(name: 'timeEnd')
  String? timeEnd;

  TimeConfigResponse(this.timeStart, this.timeEnd);

  factory TimeConfigResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TimeConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TimeConfigResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

  TimeConfig toTimeModel() =>
      TimeConfig(timeEnd: timeEnd, timeStart: timeStart);
}
