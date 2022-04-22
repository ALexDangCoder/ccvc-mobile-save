import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bao_cao_yknd_response.g.dart';

@JsonSerializable()
class BaoCaoYKNDResponse {
  @JsonKey(name: 'Data')
  BaoCaoYKNDData baoCaoYKNDData;

  BaoCaoYKNDResponse(
    this.baoCaoYKNDData,
  );

  factory BaoCaoYKNDResponse.fromJson(Map<String, dynamic> json) =>
      _$BaoCaoYKNDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaoCaoYKNDResponseToJson(this);

  ThongKeYKNDModel toDomain() => ThongKeYKNDModel(
        thongKeYKNDData: baoCaoYKNDData.toDomain(),
      );
}

@JsonSerializable()
class BaoCaoYKNDData {
  @JsonKey(name: 'ChoTiepNhan')
  int? choTiepNhan;
  @JsonKey(name: 'DaXuLy')
  int? daXuLy;
  @JsonKey(name: 'DangTaiCongKhai')
  int? dangTaiCongKhai;
  @JsonKey(name: 'DangXuLy')
  int? dangXuLy;
  @JsonKey(name: 'SoLuongYKien')
  int? soLuongYKien;

  BaoCaoYKNDData(
    this.choTiepNhan,
    this.daXuLy,
    this.dangXuLy,
    this.dangTaiCongKhai,
    this.soLuongYKien,
  );

  factory BaoCaoYKNDData.fromJson(Map<String, dynamic> json) =>
      _$BaoCaoYKNDDataFromJson(json);

  Map<String, dynamic> toJson() => _$BaoCaoYKNDDataToJson(this);

  ThongKeYKNDData toDomain() => ThongKeYKNDData(
        choTiepNhan: choTiepNhan ?? 0,
        daXuLy: daXuLy ?? 0,
        dangXuLy: dangXuLy ?? 0,
        dangTaiCongKhai: dangTaiCongKhai ?? 0,
        soLuongYKien: soLuongYKien ?? 0,
      );
}
