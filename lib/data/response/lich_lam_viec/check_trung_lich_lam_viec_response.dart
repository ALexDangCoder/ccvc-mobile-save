import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_trung_lich_lam_viec_response.g.dart';

@JsonSerializable()
class CheckTrungLichLamViecResponse extends Equatable {
  @JsonKey(name: 'data')
  bool? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  CheckTrungLichLamViecResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  factory CheckTrungLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckTrungLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckTrungLichLamViecResponseToJson(this);

  MessageModel toDomain() {
    return MessageModel(
      code: code ?? '',
      succeeded: succeeded ?? false,
      data: data,
    );
  }

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
