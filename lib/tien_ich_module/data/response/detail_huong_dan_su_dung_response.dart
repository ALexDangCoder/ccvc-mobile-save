import 'package:ccvc_mobile/tien_ich_module/domain/model/detail_huong_dan_su_dung.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_huong_dan_su_dung_response.g.dart';

@JsonSerializable()
class DataDetailHuongDanSuDungResponse extends Equatable {
  @JsonKey(name: 'data')
  DetailHuongDanSuDungResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataDetailHuongDanSuDungResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DataDetailHuongDanSuDungResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataDetailHuongDanSuDungResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataDetailHuongDanSuDungResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailHuongDanSuDungResponse extends Equatable {
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'topic')
  String? topic;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'order')
  String? order;
  @JsonKey(name: 'inUsed')
  bool? inUsed;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'createdOn')
  String? createdOn;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedOn')
  String? updatedOn;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;

  DetailHuongDanSuDungResponse({
    this.content,
    this.topic,
    this.type,
    this.id,
    this.title,
    this.order,
    this.inUsed,
    this.isDeleted,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
  });

  DetailHuongDanSuDung toModel() => DetailHuongDanSuDung(
        content: content,
        topic: topic,
        type: type,
        id: id,
        title: title,
        order: order,
        inUsed: inUsed,
        isDeleted: isDeleted,
        createdOn: createdOn,
        createdBy: createdBy,
        updatedOn: updatedOn,
        updatedBy: updatedBy,
      );

  factory DetailHuongDanSuDungResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailHuongDanSuDungResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailHuongDanSuDungResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
