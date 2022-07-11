import 'package:ccvc_mobile/domain/model/lich_hop/list_status_room_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_status_room_response.g.dart';

@JsonSerializable()
class ListStatusRoomResponse {
  @JsonKey(name: 'data')
  List<DataStatusRoomResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ListStatusRoomResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory ListStatusRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ListStatusRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListStatusRoomResponseToJson(this);

  ListStatusModel toModel() => ListStatusModel(
        data: data?.map((e) => e.toModel()).toList() ?? [],
        statusCode: statusCode,
        succeeded: succeeded,
        code: code,
        message: message,
      );
}

@JsonSerializable()
class DataStatusRoomResponse {
  @JsonKey(name: 'displayName')
  String? displayName;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'id')
  String? id;

  DataStatusRoomResponse({
    this.displayName,
    this.code,
    this.type,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.id,
  });

  factory DataStatusRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$DataStatusRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataStatusRoomResponseToJson(this);

  Data toModel() => Data(
        displayName: displayName,
        code: code,
        type: type,
        createdAt: createdAt,
        createdBy: createdBy,
        updatedAt: updatedAt,
        updatedBy: updatedBy,
        id: id,
      );
}
