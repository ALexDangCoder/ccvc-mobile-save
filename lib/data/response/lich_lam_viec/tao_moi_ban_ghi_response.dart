import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_moi_ban_ghi_response.g.dart';

@JsonSerializable()
class TaoMoiBanGhiResponse extends Equatable {
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

  TaoMoiBanGhiResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  MessageModel toDomain() =>
      MessageModel(code: code ?? '', succeeded: succeeded ?? false);

  factory TaoMoiBanGhiResponse.fromJson(Map<String, dynamic> json) =>
      _$TaoMoiBanGhiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaoMoiBanGhiResponseToJson(this);

  @override
  List<Object?> get props => [];
}
