import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/add_task_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_task_response.g.dart';
@JsonSerializable()
class AddTaskResponse{
  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'message')
  String? message;

  AddTaskResponse(this.code, this.message);

  factory AddTaskResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AddTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskResponseToJson(this);

  AddTaskResponseModel toModel() => AddTaskResponseModel(code, message);
}
