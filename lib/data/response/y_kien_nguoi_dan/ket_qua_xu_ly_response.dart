import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket%20_qua_xu_ly.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ket_qua_xu_ly_response.g.dart';

@JsonSerializable()
class KetQuaXuLyResponse {
  @JsonKey(name: 'PageData')
  List<KetQuaXuLyData> listKetQuaXuLy;

  KetQuaXuLyResponse(
    this.listKetQuaXuLy,
  );

  factory KetQuaXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$KetQuaXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KetQuaXuLyResponseToJson(this);
}

@JsonSerializable()
class KetQuaXuLyData {
  @JsonKey(name: 'ID')
  String? id;
  @JsonKey(name: 'depth')
  int? depth;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'CanBoId')
  String? canBoId;
  @JsonKey(name: 'SoVanBanDi')
  String? soVanBanDi;
  @JsonKey(name: 'NgayKyVanBanDi')
  String? ngayKyVanBanDi;
  @JsonKey(name: 'CoQuanBanHanh')
  String? coQuanBanHanh;
  @JsonKey(name: 'NguoiKyDuyet')
  String? nguoiKyDuyet;
  @JsonKey(name: 'TrichYeu')
  String? trichYeu;
  @JsonKey(name: 'TenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'TenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'TaskContent')
  String? taskContent;
  @JsonKey(name: 'TrangThai')
  int? trangThai;
  @JsonKey(name: 'IsChuTri')
  bool? isChuTri;
  @JsonKey(name: 'DSFile')
  String? dSFile;

  KetQuaXuLyData(
    this.id,
    this.depth,
    this.location,
    this.donViId,
    this.canBoId,
    this.soVanBanDi,
    this.ngayKyVanBanDi,
    this.coQuanBanHanh,
    this.nguoiKyDuyet,
    this.trichYeu,
    this.tenDonVi,
    this.tenCanBo,
    this.taskContent,
    this.trangThai,
    this.isChuTri,
    this.dSFile,
  );

  factory KetQuaXuLyData.fromJson(Map<String, dynamic> json) =>
      _$KetQuaXuLyDataFromJson(json);

  Map<String, dynamic> toJson() => _$KetQuaXuLyDataToJson(this);

  KetQuaXuLyModel toDomain() => KetQuaXuLyModel(
        iD: id ?? '',
        depth: depth ?? 0,
        location: location ?? '',
        donViId: donViId ?? '',
        canBoId: canBoId ?? '',
        soVanBanDi: soVanBanDi ?? '',
        ngayKyVanBanDi: ngayKyVanBanDi ?? '',
        coQuanBanHanh: coQuanBanHanh ?? '',
        nguoiKyDuyet: nguoiKyDuyet ?? '',
        trichYeu: trichYeu ?? '',
        tenDonVi: tenDonVi ?? '',
        tenCanBo: tenCanBo ?? '',
        dSFile: dSFile ?? '',
        taskContent: taskContent ?? '',
        trangThai: trangThai ?? 0,
        isChuTri: isChuTri ?? false,
      );
}

