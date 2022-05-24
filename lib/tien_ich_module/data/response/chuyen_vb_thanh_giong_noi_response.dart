import 'package:ccvc_mobile/tien_ich_module/domain/model/ChuyenVBThanhGiong.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chuyen_vb_thanh_giong_noi_response.g.dart';

@JsonSerializable()
class ChuyenVBThanhGiongNoiResponse {
  @JsonKey(name: 'audio_url')
  String? audio_url;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'create_time')
  String? create_time;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'totalPage')
  String? totalPage;
  @JsonKey(name: 'text_id')
  String? text_id;
  @JsonKey(name: 'update_time')
  String? update_time;

  ChuyenVBThanhGiongNoiResponse({
    this.audio_url,
    this.code,
    this.create_time,
    this.id,
    this.message,
    this.text_id,
    this.update_time,
  });

  factory ChuyenVBThanhGiongNoiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChuyenVBThanhGiongNoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChuyenVBThanhGiongNoiResponseToJson(this);

  ChuyenVBThanhGiongModel toDomain() => ChuyenVBThanhGiongModel(
        audio_url: audio_url,
        code: code,
        create_time: create_time,
        id: id,
        message: message,
        text_id: text_id,
        update_time: update_time,
      );
}
