import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tinh_huyen_xa_request.g.dart';
@JsonSerializable()
class TinhSelectRequest extends Equatable {
  int? pageIndex;
  int? pageSize;
  TinhSelectRequest({
    this.pageIndex,
    this.pageSize,
  });

  factory TinhSelectRequest.fromJson(Map<String, dynamic> json) =>
      _$TinhSelectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TinhSelectRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class HuyenSelectRequest extends Equatable {
  int? pageIndex;
  int? pageSize;
  String? provinceId;

  HuyenSelectRequest({
    this.pageIndex,
    this.pageSize,
    this.provinceId,
  });

  factory HuyenSelectRequest.fromJson(Map<String, dynamic> json) =>
      _$HuyenSelectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HuyenSelectRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
@JsonSerializable()
class XaSelectRequest extends Equatable {
  int? pageIndex;
  int? pageSize;
  String? disytrictId;

  XaSelectRequest({
    this.pageIndex,
    this.pageSize,
    this.disytrictId,
  });

  factory XaSelectRequest.fromJson(Map<String, dynamic> json) =>
      _$XaSelectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$XaSelectRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
@JsonSerializable()
class DatNuocSelectRequest extends Equatable {
  int? pageIndex;
  int? pageSize;

  DatNuocSelectRequest({
    this.pageIndex,
    this.pageSize,
  });

  factory DatNuocSelectRequest.fromJson(Map<String, dynamic> json) =>
      _$DatNuocSelectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DatNuocSelectRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}