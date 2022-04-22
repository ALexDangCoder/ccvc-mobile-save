import 'package:json_annotation/json_annotation.dart';

part 'phan_cong_thu_ky_request.g.dart';

@JsonSerializable()
class PhanCongThuKyRequest {
  String? content;
  List<String>? ids;
  String? lichHopId;

  PhanCongThuKyRequest({
    required this.content,
    required this.ids,
    required this.lichHopId,
  });

  factory PhanCongThuKyRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PhanCongThuKyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PhanCongThuKyRequestToJson(this);
}
