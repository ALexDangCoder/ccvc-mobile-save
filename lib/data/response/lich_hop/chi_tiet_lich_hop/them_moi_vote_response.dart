import 'package:json_annotation/json_annotation.dart';

part 'them_moi_vote_response.g.dart';

@JsonSerializable()
class ThemMoiVoteResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;

  ThemMoiVoteResponse(this.succeeded, this.code);

  factory ThemMoiVoteResponse.fromJson(Map<String, dynamic> json) =>
      _$ThemMoiVoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemMoiVoteResponseToJson(this);

  bool get isSuccess => succeeded ?? false;
}
