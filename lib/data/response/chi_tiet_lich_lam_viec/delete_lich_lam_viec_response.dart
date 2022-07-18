import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/time_config_response.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/xoa_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_lich_lam_viec_response.g.dart';

@JsonSerializable()
class MessageResponse extends Equatable {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'data')
  dynamic? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'succeeded')
  bool? succeeded;

  MessageResponse();

  factory MessageResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  DeleteTietLichLamViecModel toDelete() => DeleteTietLichLamViecModel(
        code: '',
        data: '',
        message: '',
        succeeded: '',
      );

  MessageModel toModel() => MessageModel(
        code: '',
        message: '',
      );

  List<TimeConfigResponse> castData() {
    final response = data as List<TimeConfigResponse>;
    return response;
  }
}
