import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/don_vi_con_phong_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_don_vi_con_phong_res.g.dart';

@JsonSerializable()
class DonViConPhongResponse {
  @JsonKey(name: 'data')
  List<DonViResponse>? listDonVi;

  DonViConPhongResponse(this.listDonVi);

  factory DonViConPhongResponse.fromJson(Map<String, dynamic> json) =>
      _$DonViConPhongResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonViConPhongResponseToJson(this);

  List<DonViConPhong> toListModel() =>
      listDonVi?.map((e) => e.toModel()).toList() ?? [];
}

@JsonSerializable()
class DonViResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'capDonVi')
  int? capDonVi;
  @JsonKey(name: 'donVis')
  dynamic donVis;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;

  DonViResponse(
    this.id,
    this.capDonVi,
    this.donVis,
    this.parentId,
    this.tenDonVi,
  );

  factory DonViResponse.fromJson(Map<String, dynamic> json) =>
      _$DonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonViResponseToJson(this);

  DonViConPhong toModel() => DonViConPhong(
        tenDonVi: tenDonVi ?? '',
        id: id ?? '',
        capDonVi: capDonVi,
        parentId: parentId ?? '',
        donVis: donVis,
      );
}
