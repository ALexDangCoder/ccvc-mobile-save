import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_lich_lam_viec_response.g.dart';

@JsonSerializable()
class TaoLichLamViecResponse extends Equatable {
  @JsonKey(name: 'data')
  String? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  TaoLichLamViecResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  factory TaoLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$TaoLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaoLichLamViecResponseToJson(this);

  MessageModel toDomain() =>
      MessageModel(code: code ?? '', succeeded: succeeded ?? false);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
