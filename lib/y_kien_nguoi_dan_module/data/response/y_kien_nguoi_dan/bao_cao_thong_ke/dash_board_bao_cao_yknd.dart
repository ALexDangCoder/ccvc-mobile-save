import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_bao_cao_yknd.g.dart';

@JsonSerializable()
class DashBoardBaoCaoYKNDResponse {
  @JsonKey(name: 'Data')
  List<BaoCaoYKNDData> listData;

  DashBoardBaoCaoYKNDResponse(
    this.listData,
  );

  factory DashBoardBaoCaoYKNDResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoardBaoCaoYKNDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardBaoCaoYKNDResponseToJson(this);

  DashBoardBaoCaoYKNDModel toDomain() => DashBoardBaoCaoYKNDModel(
        listDataDashBoard: listData.map((e) => e.toDomain()).toList(),
      );
}

@JsonSerializable()
class BaoCaoYKNDData {
  @JsonKey(name: 'Code')
  String? code;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'Quantities')
  int? soLuong;

  BaoCaoYKNDData({
    this.code,
    this.name,
    this.soLuong,
  });

  factory BaoCaoYKNDData.fromJson(Map<String, dynamic> json) =>
      _$BaoCaoYKNDDataFromJson(json);

  Map<String, dynamic> toJson() => _$BaoCaoYKNDDataToJson(this);

  DashBoardBaoCaoYKNDData toDomain() => DashBoardBaoCaoYKNDData(
        code: code ?? '',
        name: name ?? '',
        soLuong: soLuong ?? 0,
      );
}
