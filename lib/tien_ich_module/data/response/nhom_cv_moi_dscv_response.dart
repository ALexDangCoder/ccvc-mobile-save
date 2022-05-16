import 'package:ccvc_mobile/tien_ich_module/domain/model/nhom_cv_moi_model.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nhom_cv_moi_dscv_response.g.dart';

@JsonSerializable()
class NhomCVMoiDSCVResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataNhomCVMoiDSCVResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  NhomCVMoiDSCVResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory NhomCVMoiDSCVResponse.fromJson(Map<String, dynamic> json) =>
      _$NhomCVMoiDSCVResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NhomCVMoiDSCVResponseToJson(this);

  List<NhomCVMoiModel> toModel() =>
      data?.map((e) => e.toModel()).toList() ?? [];

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ThemNhomCVMoiDSCVResponse extends Equatable {
  @JsonKey(name: 'data')
  DataNhomCVMoiDSCVResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ThemNhomCVMoiDSCVResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory ThemNhomCVMoiDSCVResponse.fromJson(Map<String, dynamic> json) =>
      _$ThemNhomCVMoiDSCVResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemNhomCVMoiDSCVResponseToJson(this);



  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataNhomCVMoiDSCVResponse extends Equatable {
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'createdOn')
  String? createdOn;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'label')
  String? label;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'updatedOn')
  String? updatedOn;

  DataNhomCVMoiDSCVResponse({
    this.createdBy,
    this.createdOn,
    this.id,
    this.isDeleted,
    this.label,
    this.updatedBy,
    this.updatedOn,
  });

  NhomCVMoiModel toModel() => NhomCVMoiModel(
        createdBy: createdBy ?? '',
        createdOn: createdOn ?? '',
        id: id ?? '',
        isDeleted: isDeleted ?? false,
        label: label ?? '',
        updatedBy: updatedBy ?? '',
        updatedOn: updatedOn ?? '',
      );

  factory DataNhomCVMoiDSCVResponse.fromJson(Map<String, dynamic> json) =>
      _$DataNhomCVMoiDSCVResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataNhomCVMoiDSCVResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
