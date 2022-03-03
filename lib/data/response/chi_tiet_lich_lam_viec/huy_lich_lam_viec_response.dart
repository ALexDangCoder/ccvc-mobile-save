import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/cancel_lich_lam_viec_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'huy_lich_lam_viec_response.g.dart';

@JsonSerializable()
class CancelCalenderWorkResponse extends Equatable {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  CancelCalenderWorkResponse(this.succeeded, this.code, this.message);

  factory CancelCalenderWorkResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CancelCalenderWorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelCalenderWorkResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CancelLichLamViecModel toSucceeded() => CancelLichLamViecModel(
        succeeded: succeeded,
        code: code,
        message: message,
      );
}
