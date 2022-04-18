import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bao_cao_tong_quan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tin_tong_hop_response.g.dart';

@JsonSerializable()
class TinTongHopResponse {
  @JsonKey(name: 'top_interactions')
  List<DataTopInteractions>? tinTongHop;

  TinTongHopResponse(
    this.tinTongHop,
  );

  factory TinTongHopResponse.fromJson(Map<String, dynamic> json) =>
      _$TinTongHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TinTongHopResponseToJson(this);

}

@JsonSerializable()
class DataTopInteractions {
  @JsonKey(name: 'data')
  InteractionStatistic interactionStatistic;

  DataTopInteractions(
    this.interactionStatistic,
  );

  factory DataTopInteractions.fromJson(Map<String, dynamic> json) =>
      _$DataTopInteractionsFromJson(json);

  Map<String, dynamic> toJson() => _$DataTopInteractionsToJson(this);
}

@JsonSerializable()
class InteractionStatistic {
  @JsonKey(name: 'interaction_statistic')
  TinTongHopData tinTongHopData;

  InteractionStatistic(
    this.tinTongHopData,
  );

  factory InteractionStatistic.fromJson(Map<String, dynamic> json) =>
      _$InteractionStatisticFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionStatisticToJson(this);
}

@JsonSerializable()
class TinTongHopData {
  @JsonKey(name: 'reachCount')
  double? reach;
  @JsonKey(name: 'likeCount')
  double? like;
  @JsonKey(name: 'shareCount')
  double? share;
  @JsonKey(name: 'commentCount')
  double? comment;

  TinTongHopData(
    this.reach,
    this.like,
    this.share,
    this.comment,
  );

  factory TinTongHopData.fromJson(Map<String, dynamic> json) =>
      _$TinTongHopDataFromJson(json);

  Map<String, dynamic> toJson() => _$TinTongHopDataToJson(this);

  TinTongHopModel toDomain() => TinTongHopModel(
        reach: reach??0,
        like: like??0,
        share: share??0,
        comment: comment??0,
      );
}
