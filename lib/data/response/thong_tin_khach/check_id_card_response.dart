import 'package:ccvc_mobile/domain/model/thong_tin_khach/check_id_card_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_id_card_response.g.dart';

@JsonSerializable()
class CheckIdCardResponse {
  @JsonKey(name: 'request_id')
  final String? requestId;
  @JsonKey(name: 'front_content')
  final FrontContentResponse? frontContent;
  @JsonKey(name: 'back_content')
  final BackContentResponse? backContent;

  factory CheckIdCardResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckIdCardResponseFromJson(json);

  CheckIdCardResponse({
    required this.requestId,
    required this.frontContent,
    required this.backContent,
  });

  Map<String, dynamic> toJson() => _$CheckIdCardResponseToJson(this);

  CheckIdCardModel toModel() =>
      CheckIdCardModel(requestId: requestId,
        frontContent: frontContent?.toModel(),
        backContent: backContent?.toModel(),);
}

@JsonSerializable()
class FrontContentResponse {
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @JsonKey(name: 'content')
  final FContentResponse? content;

  factory FrontContentResponse.fromJson(Map<String, dynamic> json) =>
      _$FrontContentResponseFromJson(json);

  FrontContentResponse({
    required this.statusCode,
    required this.content,
  });

  Map<String, dynamic> toJson() => _$FrontContentResponseToJson(this);

  FrontContent toModel() =>
      FrontContent(
        statusCode: statusCode,
        content: content?.toModel(),
      );

}

@JsonSerializable()
class FContentResponse {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'doe')
  final String? doe;
  @JsonKey(name: 'v')
  final String? dob;
  @JsonKey(name: 'hometown')
  final String? hometown;
  @JsonKey(name: 'residence')
  final String? residence;
  @JsonKey(name: 'nationality')
  final String? nationality;
  @JsonKey(name: 'ethnicity')
  final String? ethnicity;

  factory FContentResponse.fromJson(Map<String, dynamic> json) =>
      _$FContentResponseFromJson(json);

  FContentResponse({
    required this.name,
    required this.gender,
    required this.id,
    required this.doe,
    required this.dob,
    required this.hometown,
    required this.residence,
    required this.nationality,
    required this.ethnicity,
  });

  Map<String, dynamic> toJson() => _$FContentResponseToJson(this);

  FContent toModel() =>
      FContent(
        name: name,
        gender: gender,
        id: id,
        doe: doe,
        dob: dob,
        hometown: hometown,
        residence: residence,
        nationality: nationality,
        ethnicity: ethnicity,
      );
}

@JsonSerializable()
class BackContentResponse {
  @JsonKey(name: 'status_code')
  final String? statusCode;
  @JsonKey(name: 'content')
  final BContentResponse? content;

  factory BackContentResponse.fromJson(Map<String, dynamic> json) =>
      _$BackContentResponseFromJson(json);

  BackContentResponse({
    required this.statusCode,
    required this.content,
  });

  Map<String, dynamic> toJson() => _$BackContentResponseToJson(this);

  BackContent toModel() =>
      BackContent(
        statusCode: statusCode,
        content: content?.toModel(),
      );
}

@JsonSerializable()
class BContentResponse {
  @JsonKey(name: 'ethnicity')
  final String? ethnicity;
  @JsonKey(name: 'doi')
  final String? doi;
  @JsonKey(name: 'poi')
  final String? poi;

  factory BContentResponse.fromJson(Map<String, dynamic> json) =>
      _$BContentResponseFromJson(json);

  BContentResponse({
    this.ethnicity,
    this.doi,
    this.poi,
  });

  Map<String, dynamic> toJson() => _$BContentResponseToJson(this);

  BContent toModel() =>
      BContent(
        ethnicity: ethnicity,
        doi: doi,
        poi: poi,
      );
}
