import 'package:ccvc_mobile/domain/model/lich_hop/bieu_quyet_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'them_moi_bieu_quayet_response.g.dart';

@JsonSerializable()
class ThemMoiBieuQuyetResponse {
  @JsonKey(name: 'data')
  ThemMoiBieuQuyetData data;

  ThemMoiBieuQuyetResponse(this.data);

  factory ThemMoiBieuQuyetResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThemMoiBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemMoiBieuQuyetResponseToJson(this);
}

@JsonSerializable()
class ThemMoiBieuQuyetData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'idLichHop')
  String? idLichHop;
  @JsonKey(name: 'loaiBieuQuyet')
  bool? loaiBieuQuyet;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'quyenBieuQuyet')
  bool? quyenBieuQuyet;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianCapNhat')
  String? thoiGianCapNhat;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'thoiGianTaoMoi')
  String? thoiGianTaoMoi;
  @JsonKey(name: 'trangThai')
  int? trangThai;

  ThemMoiBieuQuyetData(
    this.id,
    this.idLichHop,
    this.loaiBieuQuyet,
    this.noiDung,
    this.quyenBieuQuyet,
    this.thoiGianBatDau,
    this.thoiGianCapNhat,
    this.thoiGianKetThuc,
    this.thoiGianTaoMoi,
    this.trangThai,
  );

  factory ThemMoiBieuQuyetData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThemMoiBieuQuyetDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThemMoiBieuQuyetDataToJson(this);

  BieuQuyetModel todoMain() => BieuQuyetModel(
        id: id,
        idLichHop: idLichHop,
        loaiBieuQuyet: loaiBieuQuyet,
        noiDung: noiDung,
        quyenBieuQuyet: quyenBieuQuyet,
        thoiGianBatDau: thoiGianBatDau,
        thoiGianCapNhat: thoiGianCapNhat,
        thoiGianKetThuc: thoiGianKetThuc,
        thoiGianTaoMoi: thoiGianTaoMoi,
        trangThai: trangThai,
      );
}
