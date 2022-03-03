import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/xoa_lich_lam_viec_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_lich_lam_viec_response.g.dart';

@JsonSerializable()
class DeleteCalenderWorkResponse extends Equatable {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'data')
  String? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'succeeded')
  String? succeeded;

  DeleteCalenderWorkResponse();

  factory DeleteCalenderWorkResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DeleteCalenderWorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCalenderWorkResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  DeleteTietLichLamViecModel toDelete() => DeleteTietLichLamViecModel(
        code: '',
        data: '',
        message: '',
        succeeded: '',
      );
}
