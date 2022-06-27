import 'package:json_annotation/json_annotation.dart';

part 'get_all_files_id_request.g.dart';

@JsonSerializable()
class GetAllFilesRequest {
  @JsonKey(name: 'data')
  String? entityId;
  @JsonKey(name: 'statusCode')
  String? entityName;
  @JsonKey(name: 'succeeded')
  String? fileTypeUpload;

  GetAllFilesRequest({
    required this.entityId,
    required this.entityName,
    required this.fileTypeUpload,
  });

  factory GetAllFilesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAllFilesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFilesRequestToJson(this);
}
