import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_bao_cao_ket_qua_response.g.dart';

@JsonSerializable()
class TaoBaoCaoKetQuaResponse extends Equatable {
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

  TaoBaoCaoKetQuaResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  factory TaoBaoCaoKetQuaResponse.fromJson(Map<String, dynamic> json) =>
      _$TaoBaoCaoKetQuaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaoBaoCaoKetQuaResponseToJson(this);

  MessageModel toDomain() =>
      MessageModel(code: code ?? '', succeeded: succeeded ?? false);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
