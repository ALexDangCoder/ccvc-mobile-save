import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ds_vbdi_response.g.dart';

@JsonSerializable()
class DanhSachVBDiResponse {
  @JsonKey(name: 'Data')
  DataResponseVBDi? danhSachVB;

  DanhSachVBDiResponse(this.danhSachVB);

  factory DanhSachVBDiResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVBDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachVBDiResponseToJson(this);
}

@JsonSerializable()
class DataResponseVBDi {
  @JsonKey(name: 'PageData')
  List<PageDataResponseVBDi>? pageData;

  DataResponseVBDi(
    this.pageData,
  );

  factory DataResponseVBDi.fromJson(Map<String, dynamic> json) =>
      _$DataResponseVBDiFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseVBDiToJson(this);

  DanhSachVanBanModel toDomain() => DanhSachVanBanModel(
        pageData: pageData
            ?.map(
              (e) => e.toDomain(),
            )
            .toList(),
      );
}

@JsonSerializable()
class PageDataResponseVBDi {
  @JsonKey(name: 'DoKhan')
  String? doKhan;
  @JsonKey(name: 'LoaiVanBan')
  String? loaiVanBan;
  @JsonKey(name: 'NgayTao')
  String? ngayDen;
  @JsonKey(name: 'NguoiSoanThao')
  String? nguoiSoanThao;
  @JsonKey(name: 'Id')
  String? iD;
  @JsonKey(name: 'DonViSoanThao')
  String? donViSoanThao;
  @JsonKey(name: 'CodeDoKhan')
  String? codeDoKhan;
  @JsonKey(name: 'TrichYeu')
  String? trichYeu;
  @JsonKey(name: 'ChucVuNguoiSoanThao')
  String? chucVuNguoiSoanThao;

  PageDataResponseVBDi(
    this.iD,
    this.doKhan,
    this.loaiVanBan,
    this.ngayDen,
    this.nguoiSoanThao,
    this.donViSoanThao,
    this.codeDoKhan,
    this.trichYeu,
    this.chucVuNguoiSoanThao,
  );

  factory PageDataResponseVBDi.fromJson(Map<String, dynamic> json) =>
      _$PageDataResponseVBDiFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataResponseVBDiToJson(this);

  VanBanModel toDomain() => VanBanModel(
        nguoiSoanThao: nguoiSoanThao,
        loaiVanBan: loaiVanBan,
        doKhan: doKhan,
        ngayDen: ngayDen,
        iD: iD,
        donViSoanThao: donViSoanThao,
        priorityCode: codeDoKhan,
        trichYeu: trichYeu,
        chucVuNguoiSoanThao: chucVuNguoiSoanThao,
      );
}
