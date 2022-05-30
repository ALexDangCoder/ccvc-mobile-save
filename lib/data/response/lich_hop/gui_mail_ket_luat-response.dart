import 'package:ccvc_mobile/domain/model/lich_hop/gui_mail_ket_luat_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gui_mail_ket_luat-response.g.dart';

@JsonSerializable()
class GuiMailKetLuanHopResponse {
  @JsonKey(name: 'code')
  String code;

  GuiMailKetLuanHopResponse(this.code);

  factory GuiMailKetLuanHopResponse.fromJson(Map<String, dynamic> json) =>
      _$GuiMailKetLuanHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuiMailKetLuanHopResponseToJson(this);

  GuiMailKetLuatHopModel toModel() => GuiMailKetLuatHopModel(
        code: code,
      );
}
