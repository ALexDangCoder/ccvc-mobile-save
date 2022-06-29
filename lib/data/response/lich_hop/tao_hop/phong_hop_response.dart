import 'dart:convert';

import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phong_hop_response.g.dart';

@JsonSerializable()
class DSPhongHopResponse {
  @JsonKey(name: 'data')
  List<PhongHopResponse>? listPhong;

  DSPhongHopResponse(this.listPhong);

  factory DSPhongHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DSPhongHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DSPhongHopResponseToJson(this);

  List<PhongHopModel> toListModel() =>
      listPhong?.map((e) => e.toModel()).toList() ?? [];
}

@JsonSerializable()
class PhongHopResponse {
  @JsonKey(name: 'dsThietBiStr')
  String? dsThietBiStr;
  @JsonKey(name: 'donViDuyetId')
  String? donViDuyetId;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'ten')
  String? ten;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'sucChua')
  int? sucChua;
  @JsonKey(name: 'bit_TTDH')
  bool? isBitTTDH;
  @JsonKey(name: 'ban')
  int? ban;

  PhongHopResponse(
    this.dsThietBiStr,
    this.donViDuyetId,
    this.id,
    this.ten,
    this.diaChi,
    this.sucChua,
    this.isBitTTDH,
    this.ban,
  );

  factory PhongHopResponse.fromJson(Map<String, dynamic> json) =>
      _$PhongHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhongHopResponseToJson(this);

  PhongHopModel toModel() => PhongHopModel(
        id: id ?? '',
        bit_TTDH: isBitTTDH ?? false,
        diaChi: diaChi ?? '',
        donViDuyetId: donViDuyetId ?? '',
        sucChua: sucChua ?? 0,
        ten: ten ?? '',
        trangThai: ban ?? 0,
        listThietBi: (jsonDecode(dsThietBiStr ?? '[]') as List<dynamic>)
            .map((e) => ThietBiModel.fromJson(e))
            .toList(),
      );
}
