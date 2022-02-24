import 'package:ccvc_mobile/domain/model/lich_hop/them_y_kien_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'them_y_kien_response.g.dart';

@JsonSerializable()
class ThemYKienResponse {
  @JsonKey(name: 'code')
  String code;

  ThemYKienResponse(this.code);

  factory ThemYKienResponse.fromJson(Map<String, dynamic> json) =>
      _$ThemYKienResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemYKienResponseToJson(this);

  ThemYKiemModel toModel() => ThemYKiemModel(
    code: code,
  );
}
