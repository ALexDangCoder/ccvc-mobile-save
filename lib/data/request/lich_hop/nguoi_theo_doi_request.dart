import 'package:json_annotation/json_annotation.dart';

part 'nguoi_theo_doi_request.g.dart';

@JsonSerializable()
class NguoiTheoDoiRequest {
  bool? isTheoDoi;
  int? pageIndex;
  int? pageSize;
  String? userId;

  NguoiTheoDoiRequest({
    required this.isTheoDoi,
    required this.pageIndex,
    required this.pageSize,
    required this.userId,
  });

  factory NguoiTheoDoiRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NguoiTheoDoiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiTheoDoiRequestToJson(this);
}
