import 'package:json_annotation/json_annotation.dart';

part 'create_image_request.g.dart';

@JsonSerializable()
class CreateImageRequest {
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'fileId')
  String? fileId;
  @JsonKey(name: 'loaiGocAnh')
  String? loaiGocAnh;
  @JsonKey(name: 'loaiAnh')
  String? loaiAnh;

  CreateImageRequest({
    required this.userId,
    required this.fileId,
    required this.loaiGocAnh,
    required this.loaiAnh,
  });

  factory CreateImageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateImageRequestToJson(this);
}
