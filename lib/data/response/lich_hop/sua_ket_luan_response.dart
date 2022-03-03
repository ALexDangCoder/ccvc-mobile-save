import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sua_ket_luan_response.g.dart';

@JsonSerializable()
class SuaKetLuanResponse extends Equatable {
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

  SuaKetLuanResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  MessageModel toDomain() =>
      MessageModel(code: code ?? '', succeeded: succeeded ?? false);

  factory SuaKetLuanResponse.fromJson(Map<String, dynamic> json) =>
      _$SuaKetLuanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuaKetLuanResponseToJson(this);

  @override
  List<Object?> get props => [];
}
