import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_di_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ds_vbdi_response.g.dart';

@JsonSerializable()
class DanhSachVBDiResponse {
  @JsonKey(name: 'Data')
  DataResponseVBDi danhSachVB;

  DanhSachVBDiResponse(this.danhSachVB);

  factory DanhSachVBDiResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachVBDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachVBDiResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponseVBDi {
  @JsonKey(name: 'PageData')
  List<PageDataResponseVBDi> pageData;

  DataResponseVBDi(
    this.pageData,
  );

  factory DataResponseVBDi.fromJson(Map<String, dynamic> json) =>
      _$DataResponseVBDiFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseVBDiToJson(this);

  DanhSachVanBanDiModel toDomain() => DanhSachVanBanDiModel(
        pageData: pageData
            .map(
              (e) => VanBanDiModel(
                doKhan: e.doKhan,
                loaiVanBan: e.loaiVanBan,
                ngayTao: e.ngaytao,
                nguoiSoanThao: e.nguoiSoanThao,
              ),
            )
            .toList(),
      );

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PageDataResponseVBDi {
  @JsonKey(name: 'DoKhan')
  String? doKhan;
  @JsonKey(name: 'LoaiVanBan')
  String? loaiVanBan;
  @JsonKey(name: 'NgayTao')
  String? ngaytao;
  @JsonKey(name: 'NguoiSoanThao')
  String? nguoiSoanThao;

  PageDataResponseVBDi(
      this.doKhan, this.loaiVanBan, this.ngaytao, this.nguoiSoanThao);

  factory PageDataResponseVBDi.fromJson(Map<String, dynamic> json) =>
      _$PageDataResponseVBDiFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataResponseVBDiToJson(this);

  VanBanDiModel toDomain() => VanBanDiModel(
        nguoiSoanThao: nguoiSoanThao,
        loaiVanBan: loaiVanBan,
        doKhan: doKhan,
        ngayTao: ngaytao,
      );

  @override
  List<Object?> get props => [];
}
