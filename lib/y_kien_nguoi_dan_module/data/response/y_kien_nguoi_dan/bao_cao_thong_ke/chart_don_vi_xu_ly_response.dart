import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_don_vi_xu_ly_response.g.dart';

@JsonSerializable()
class DonViXuLyResponse {
  @JsonKey(name: 'Data')
  List<DonViData>? listData;

  DonViXuLyResponse(
    this.listData,
  );

  factory DonViXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DonViXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonViXuLyResponseToJson(this);

  ChartDonViModel toDomain() => ChartDonViModel(
        listChartData: listData?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class DonViData {
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'IsParent')
  bool? isParent;
  @JsonKey(name: 'TenDonVi')
  String? tenLinhVuc;
  @JsonKey(name: 'SoPhanAnhKienNghi')
  int? soPhanAnhKienNghi;

  DonViData(
    this.donViId,
    this.tenLinhVuc,
    this.isParent,
    this.soPhanAnhKienNghi,
  );

  factory DonViData.fromJson(Map<String, dynamic> json) =>
      _$DonViDataFromJson(json);

  Map<String, dynamic> toJson() => _$DonViDataToJson(this);

  DonViYKNDModel toDomain() => DonViYKNDModel(
        donViID: donViId ?? '',
        isParent: isParent??false,
        tenLinhVuc: tenLinhVuc ?? '',
        soPhanAnhKienNghi: soPhanAnhKienNghi ?? 0,
      );
}
