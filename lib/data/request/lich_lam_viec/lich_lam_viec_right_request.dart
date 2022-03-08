import 'package:json_annotation/json_annotation.dart';

part 'lich_lam_viec_right_request.g.dart';

@JsonSerializable()
class LichLamViecRightRequest {
  String dateFrom;
  String dateTo;
  int type;

  LichLamViecRightRequest({
    required this.dateFrom,
    required this.dateTo,
    required this.type,
  });

  factory LichLamViecRightRequest.fromJson(Map<String, dynamic> json) =>
      _$LichLamViecRightRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LichLamViecRightRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
