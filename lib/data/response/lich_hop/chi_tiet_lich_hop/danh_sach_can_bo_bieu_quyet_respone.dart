import 'package:ccvc_mobile/domain/model/lich_hop/danhSachCanBoBieuQuyetModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_can_bo_bieu_quyet_respone.g.dart';

@JsonSerializable()
class DanhSachCanBoBieuQuyetResponse {
  @JsonKey(name: 'data')
  DataCanBoBieuQuyetResponse? data;

  DanhSachCanBoBieuQuyetResponse({
    this.data,
  });

  factory DanhSachCanBoBieuQuyetResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachCanBoBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachCanBoBieuQuyetResponseToJson(this);

  DanhSachCanBoBieuQuyetModel toModel() => DanhSachCanBoBieuQuyetModel(
        data: data?.toModel() ?? DataDanhSachCanBoBieuQuyetModel(),
      );
}

@JsonSerializable()
class DataCanBoBieuQuyetResponse {
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'lichHopTitle')
  String? lichHopTitle;
  @JsonKey(name: 'danhSachCanBoBieuQuyet')
  List<DanhSachCanBoBieuQuyet>? danhSachCanBoBieuQuyet;

  DataCanBoBieuQuyetResponse(
      {this.lichHopId, this.lichHopTitle, this.danhSachCanBoBieuQuyet});

  factory DataCanBoBieuQuyetResponse.fromJson(Map<String, dynamic> json) =>
      _$DataCanBoBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataCanBoBieuQuyetResponseToJson(this);

  DataDanhSachCanBoBieuQuyetModel toModel() => DataDanhSachCanBoBieuQuyetModel(
        lichHopId: lichHopId ?? '',
        lichHopTitle: lichHopTitle ?? '',
        danhSachCanBoBieuQuyet:
            danhSachCanBoBieuQuyet?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class DanhSachCanBoBieuQuyet {
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'hoTenCanBo')
  String? hoTenCanBo;
  @JsonKey(name: 'chucVuCanBo')
  String? chucVuCanBo;
  @JsonKey(name: 'donViCanBo')
  String? donViCanBo;

  DanhSachCanBoBieuQuyet({
    this.canBoId,
    this.hoTenCanBo,
    this.chucVuCanBo,
    this.donViCanBo,
  });

  factory DanhSachCanBoBieuQuyet.fromJson(Map<String, dynamic> json) =>
      _$DanhSachCanBoBieuQuyetFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachCanBoBieuQuyetToJson(this);

  DanhSachCanBoBieuQuyetMd toModel() => DanhSachCanBoBieuQuyetMd(
        canBoId: canBoId ?? '',
        hoTenCanBo: hoTenCanBo ?? '',
        chucVuCanBo: chucVuCanBo ?? '',
        donViCanBo: donViCanBo ?? '',
      );
}
