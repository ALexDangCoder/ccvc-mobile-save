import 'package:json_annotation/json_annotation.dart';
part 'linh_vuc_request.g.dart';

@JsonSerializable()
class LinhVucRequest {
  int? pageIndex;
  int? pageSize;

  LinhVucRequest({
    required this.pageIndex,
    required this.pageSize,
  });

  factory LinhVucRequest.fromJson(Map<String, dynamic> json) =>
      _$LinhVucRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucRequestToJson(this);
}
