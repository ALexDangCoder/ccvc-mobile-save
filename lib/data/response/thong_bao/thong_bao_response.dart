import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_bao_response.g.dart';

@JsonSerializable()
class ThongBaoResponse {
  @JsonKey(name: 'data')
  List<ThongBaoData> data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ThongBaoResponse(
      this.data, this.statusCode, this.succeeded, this.code, this.message);

  factory ThongBaoResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongBaoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongBaoResponseToJson(this);
  List<ThongBaoModel> toDomain() {
    return data
        .map((e) => e.toModel())
        .where((element) => element.thongBaoType != null)
        .toList();
  }
}

@JsonSerializable()
class ThongBaoData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'unreadCount')
  int? unreadCount;
  @JsonKey(name: 'total')
  int? total;

  ThongBaoData(
    this.id,
    this.name,
    this.code,
    this.description,
    this.unreadCount,
    this.total,
  );

  factory ThongBaoData.fromJson(Map<String, dynamic> json) =>
      _$ThongBaoDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThongBaoDataToJson(this);

  ThongBaoModel toModel() => ThongBaoModel(
        id: id,
        name: name,
        code: code,
        description: description,
        unreadCount: unreadCount,
        total: total,
      );
}
