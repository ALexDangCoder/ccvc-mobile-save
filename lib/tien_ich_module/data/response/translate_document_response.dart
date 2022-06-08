import 'package:json_annotation/json_annotation.dart';

part 'translate_document_response.g.dart';

@JsonSerializable()
class DataTranslateResponse {
  @JsonKey(name: 'data')
  TranslateResponse? data;

  DataTranslateResponse({
    this.data,
  });

  factory DataTranslateResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTranslateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTranslateResponseToJson(this);
}

@JsonSerializable()
class TranslateResponse {
  @JsonKey(name: 'translations')
  List<TranslatedTextResponse>? translations;

  TranslateResponse(this.translations);

  factory TranslateResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateResponseToJson(this);
}

@JsonSerializable()
class TranslatedTextResponse {
  @JsonKey(name: 'translatedText')
  String? translatedText;

  TranslatedTextResponse(this.translatedText);

  factory TranslatedTextResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslatedTextResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatedTextResponseToJson(this);

  String resToString() {
    return translatedText ?? '';
  }
}
