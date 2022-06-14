import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sua_lich_lam_viec_response.g.dart';

@JsonSerializable()
class SuaLicLamViecResponse extends Equatable {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  SuaLicLamViecResponse(
      {this.statusCode, this.succeeded, this.code, this.message});

  factory SuaLicLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$SuaLicLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuaLicLamViecResponseToJson(this);

  MessageModel toDomain() {
    return MessageModel(code: code ?? '', succeeded: succeeded ?? false);
  }

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
