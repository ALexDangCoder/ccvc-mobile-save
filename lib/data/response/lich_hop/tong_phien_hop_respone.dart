import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tong_phien_hop_respone.g.dart';

@JsonSerializable()
class TongPhienHopResponse {
  @JsonKey(name: 'data')
  List<PhienHopData>? listPhienHop;

  TongPhienHopResponse(this.listPhienHop);

  factory TongPhienHopResponse.fromJson(Map<String, dynamic> json) =>
      _$TongPhienHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TongPhienHopResponseToJson(this);

  TongPhienHopModel toModel() => TongPhienHopModel(
        danhSachPhienHop: listPhienHop?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class PhienHopData {
  @JsonKey(name: 'key')
  String? key;
  @JsonKey(name: 'value')
  String? value;

  PhienHopData(this.key, this.value);

  factory PhienHopData.fromJson(Map<String, dynamic> json) =>
      _$PhienHopDataFromJson(json);

  Map<String, dynamic> toJson() => _$PhienHopDataToJson(this);

  PhienhopModel toModel() => PhienhopModel(
        key: key,
        value: value,
      );
}
