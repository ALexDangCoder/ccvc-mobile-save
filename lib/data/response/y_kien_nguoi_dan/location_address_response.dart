import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/location_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_address_response.g.dart';

@JsonSerializable()
class LocationAddressTotal {
  List<LocationAddressResponse>? listLocationAddress;

  LocationAddressTotal(this.listLocationAddress);

  factory LocationAddressTotal.fromJson(Map<String, dynamic> json) =>
      _$LocationAddressTotalFromJson(json);

  Map<String, dynamic> toJson() => _$LocationAddressTotalToJson(this);
}

@JsonSerializable()
class LocationAddressResponse {
  @JsonKey(name: 'Id')
  int? Id;

  @JsonKey(name: 'Name')
  String? name;

  LocationAddressResponse(this.Id, this.name);

  factory LocationAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationAddressResponseToJson(this);

  LocationModel toModel() => LocationModel(Id, name);
}
