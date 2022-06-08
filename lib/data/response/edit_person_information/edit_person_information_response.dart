import 'package:ccvc_mobile/domain/model/edit_personal_information/data_edit_person_information.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_person_information_response.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class EditPersonInformationResponse extends Equatable {
  @JsonKey(name: 'data')
  DataEditPersonInformationResponse data;

  EditPersonInformationResponse(this.data);

  factory EditPersonInformationResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EditPersonInformationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditPersonInformationResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataEditPersonInformationResponse extends Equatable {
  @JsonKey(name: 'data')
  String? data;
  @JsonKey(name: 'isSuccess')
  bool? isSuccess;

  DataEditPersonInformationResponse();

  factory DataEditPersonInformationResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataEditPersonInformationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataEditPersonInformationResponseToJson(this);

  DataEditPersonInformation toDomain() =>
      DataEditPersonInformation(data: data, isSuccess: isSuccess);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
