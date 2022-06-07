import 'package:json_annotation/json_annotation.dart';

part 'cho_y_kien_request.g.dart';

@JsonSerializable()
class GiveCommentRequest {
  @JsonKey(name: 'HashAlg')
  String? hashAlg;
  @JsonKey(name: 'HashValue')
  String hashValue;
  @JsonKey(name: 'IdProcess')
  String idProcess;
  @JsonKey(name: 'ListIdFileDinhKems')
  List<String> files;
  @JsonKey(name: 'NoiDung')
  String noiDung;
  @JsonKey(name: 'IdParent')
  String? idParent;

  GiveCommentRequest({
    this.hashAlg,
    this.hashValue = '',
    required this.idProcess,
    required this.files ,
    required this.noiDung,
    this.idParent,
  });
  factory GiveCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$GiveCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GiveCommentRequestToJson(this);
}
