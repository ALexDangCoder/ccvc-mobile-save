import 'package:json_annotation/json_annotation.dart';

part 'bao_cao_pie_chart_response.g.dart';

@JsonSerializable()
class BaoCaoPieChartResponse {
  @JsonKey(name: 'DanhSachKetQua')
  DataListItem listitems;

  BaoCaoPieChartResponse(
      this.listitems,
      );

  factory BaoCaoPieChartResponse.fromJson(Map<String, dynamic> json) =>
      _$BaoCaoPieChartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaoCaoPieChartResponseToJson(this);

  List<int> toDomain(){
    final List<int> data=[];
    for (final element in listitems.listData??[]) {
      data.add(element.soLuong??0);
    }
    return data;
  }
}
@JsonSerializable()
class DataListItem {
  @JsonKey(name: 'ListItems')
  List<DataItem>? listData;

  DataListItem(
      this.listData,
      );

  factory DataListItem.fromJson(Map<String, dynamic> json) =>
      _$DataListItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataListItemToJson(this);

}

@JsonSerializable()
class DataItem {
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'SoLuong')
  int? soLuong;

  DataItem(
      this.ten,
      this.soLuong,
      );

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataItemToJson(this);
}
