import 'dart:core';

import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tin_tuc_thoi_su_response.g.dart';

@JsonSerializable()
class TinTucThoiSuResponse {
  List<TinTucThoiSuData>? listTinTucThoiSu;

  TinTucThoiSuResponse(
    this.listTinTucThoiSu,
  );

  TinTucThoiSuResponse.fromJson(List<dynamic> json) {
    final data = <TinTucThoiSuData>[];
    for (final element in json) {
      data.add(TinTucThoiSuData.fromJson(element));
    }
    listTinTucThoiSu = data;
  }

  Map<String, dynamic> toJson() => _$TinTucThoiSuResponseToJson(this);

  TinTucRadioResponseModel toDomain() => TinTucRadioResponseModel(
        listTinTucThoiSu:
            listTinTucThoiSu?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class TinTucThoiSuData {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'published_time')
  String? publishedTime;
  @JsonKey(name: 'tts_audio_url')
  String? audioUrl;
  @JsonKey(name: 'tts_audio_duration_seconds')
  double? audioDuration;
  @JsonKey(name: 'domain')
  String? domain;
  @JsonKey(name: 'image_sources')
  List<String>? urlImage;
  @JsonKey(name: 'url')
  String? url;

  TinTucThoiSuData({
    this.title,
    this.content,
    this.publishedTime,
    this.audioUrl,
    this.audioDuration,
    this.domain,
    this.urlImage,
    this.url,
  });

  factory TinTucThoiSuData.fromJson(Map<String, dynamic> json) =>
      _$TinTucThoiSuDataFromJson(json);

  Map<String, dynamic> toJson() => _$TinTucThoiSuDataToJson(this);

  TinTucRadioModel toDomain() => TinTucRadioModel(
        domain,
        urlImage,
        url,
        title: title ?? '',
        content: content ?? '',
        publishedTime: publishedTime ?? '',
        audioUrl: audioUrl ?? '',
        audioDuration: audioDuration ?? 0,
      );
}
