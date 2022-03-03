import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_phien_hop_response.g.dart';

@JsonSerializable()
class DanhSachPhienHopResponse {
  @JsonKey(name: 'data')
  List<PhienHopData>?listPhienHop;

  DanhSachPhienHopResponse(this.listPhienHop);

  factory DanhSachPhienHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPhienHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachPhienHopResponseToJson(this);

  DanhSachPhienHopModel toModel() => DanhSachPhienHopModel(
   danhSachPhienHop: listPhienHop?.map((e) => e.toModel()).toList()??[],
  );
}
@JsonSerializable()
class PhienHopData{
  @JsonKey(name: 'key')
  String?key;
  @JsonKey(name: 'value')
  String?value;

  PhienHopData(this.key,this.value);

  factory PhienHopData.fromJson(Map<String, dynamic> json) =>
      _$PhienHopDataFromJson(json);

  Map<String, dynamic> toJson() => _$PhienHopDataToJson(this);

  PhienhopModel toModel() => PhienhopModel(
    key: key,
    value: value,
  );
}