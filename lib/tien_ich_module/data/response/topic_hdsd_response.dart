import 'package:ccvc_mobile/tien_ich_module/domain/model/topic_hdsd.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_hdsd_response.g.dart';

@JsonSerializable()
class DataTopicHDSDResponse extends Equatable {
  @JsonKey(name: 'data')
  List<TopicHDSDResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataTopicHDSDResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DataTopicHDSDResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTopicHDSDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTopicHDSDResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class TopicHDSDResponse extends Equatable {
  @JsonKey(name: 'maTopic')
  String? maTopic;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'order')
  int? order;
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

  TopicHDSDResponse({
    this.maTopic,
    this.icon,
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

  factory TopicHDSDResponse.fromJson(Map<String, dynamic> json) =>
      _$TopicHDSDResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopicHDSDResponseToJson(this);

  TopicHDSD toModel() => TopicHDSD(
        maTopic: maTopic,
        icon: icon,
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

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
