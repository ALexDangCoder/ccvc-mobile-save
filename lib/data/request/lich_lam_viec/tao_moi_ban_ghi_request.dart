import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_moi_ban_ghi_request.g.dart';

@JsonSerializable()
class TaoMoiBanGhiRequest extends Equatable {
  String? scheduleId;
  String? phienHopId;
  String? content;
  String? scheduleOpinionId;

  TaoMoiBanGhiRequest({
    this.scheduleId,
    this.phienHopId,
    this.content,
    this.scheduleOpinionId,
  });

  factory TaoMoiBanGhiRequest.fromJson(Map<String, dynamic> json) =>
      _$TaoMoiBanGhiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaoMoiBanGhiRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
