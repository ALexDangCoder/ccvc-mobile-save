import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sua_lich_lam_viec_response.g.dart';

@JsonSerializable()
class SuaLichLamViecResponse extends Equatable {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  SuaLichLamViecResponse(
      { this.statusCode, this.succeeded, this.code, this.message});

  factory SuaLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$SuaLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuaLichLamViecResponseToJson(this);

  MessageModel toDomain() {
    return MessageModel(code: code ?? '', succeeded: succeeded ?? false);
  }

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
