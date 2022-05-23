import 'package:json_annotation/json_annotation.dart';

part 'theo_doi_van_ban_response.g.dart';

@JsonSerializable()
class DataTheoDoiVanBanResponse {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<dynamic>? data;
  @JsonKey(name: 'StatusCode')
  int? statusCode;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataTheoDoiVanBanResponse({
    this.messages,
    this.data,
    this.statusCode,
    this.isSuccess,
  });

  factory DataTheoDoiVanBanResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTheoDoiVanBanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTheoDoiVanBanResponseToJson(this);

}
