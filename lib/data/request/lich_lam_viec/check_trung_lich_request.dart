import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_trung_lich_request.g.dart';

@JsonSerializable()
class CheckTrungLichRequest extends Equatable {
  String? dateFrom;
  String? dateTo;
  String? donViId;
  String? timeFrom;
  String? timeTo;
  String? userId;
  String? scheduleId;

  CheckTrungLichRequest({
    this.dateFrom,
    this.dateTo,
    this.donViId,
    this.timeFrom,
    this.timeTo,
    this.userId,
    this.scheduleId,
  });

  factory CheckTrungLichRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckTrungLichRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckTrungLichRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
