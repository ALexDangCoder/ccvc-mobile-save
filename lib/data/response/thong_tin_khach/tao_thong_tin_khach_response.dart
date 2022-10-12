import 'package:ccvc_mobile/domain/model/thong_tin_khach/tao_thong_tin_khach_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_thong_tin_khach_response.g.dart';

@JsonSerializable()
class DataTaoThongTinKhachResponse {
  @JsonKey(name: 'rc')
  TaoThongTinKhachResponse? rc;

  DataTaoThongTinKhachResponse({
    required this.rc,
  });

  factory DataTaoThongTinKhachResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTaoThongTinKhachResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTaoThongTinKhachResponseToJson(this);

  TaoThongTinKhachModel toModel() => TaoThongTinKhachModel(
        code: rc?.code,
        desc: rc?.desc,
      );
}

@JsonSerializable()
class TaoThongTinKhachResponse {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'desc')
  String? desc;

  TaoThongTinKhachResponse({
    required this.code,
    required this.desc,
  });

  factory TaoThongTinKhachResponse.fromJson(Map<String, dynamic> json) =>
      _$TaoThongTinKhachResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaoThongTinKhachResponseToJson(this);
}
