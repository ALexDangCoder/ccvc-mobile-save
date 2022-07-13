import 'package:json_annotation/json_annotation.dart';

part 'them_moi_vote_request.g.dart';

@JsonSerializable()
class ThemMoiVoteRequest {
  String? lichHopId;
  String? bieuQuyetId;
  String? donViId;
  String? canBoId;
  String? luaChonBietQuyetId;
  String? idPhienhopCanbo;

  ThemMoiVoteRequest({
    this.lichHopId,
    this.bieuQuyetId,
    this.donViId,
    this.canBoId,
    this.luaChonBietQuyetId,
    this.idPhienhopCanbo,
  });

  factory ThemMoiVoteRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThemMoiVoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThemMoiVoteRequestToJson(this);
}
