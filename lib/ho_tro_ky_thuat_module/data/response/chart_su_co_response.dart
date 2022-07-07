import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_su_co_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_su_co_response.g.dart';

@JsonSerializable()
class ChartSuCoResponse {
  @JsonKey(name: 'data')
  DataResponse? data;
  @JsonKey(name: 'message')
  String? message;

  ChartSuCoResponse(
    this.data,
    this.message,
  );

  factory ChartSuCoResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChartSuCoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartSuCoResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'result')
  List<ChartSuCoChildResponse>? result;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'isCanceled')
  bool? isCanceled;
  @JsonKey(name: 'isCompleted')
  bool? isCompleted;
  @JsonKey(name: 'isCompletedSuccessfully')
  bool? isCompletedSuccessfully;
  @JsonKey(name: 'creationOptions')
  int? creationOptions;
  @JsonKey(name: 'isFaulted')
  bool? isFaulted;

  DataResponse(
    this.result,
    this.id,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.isCompletedSuccessfully,
    this.creationOptions,
    this.isFaulted,
  );

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  ChartSuCoModel toModel() => ChartSuCoModel(
        id: id,
        chartSuCoChild: result?.map((e) => e.toModel()).toList() ?? [],
        creationOptions: creationOptions,
        isCanceled: isCanceled,
        isCompleted: isCompleted,
        isCompletedSuccessfully: isCompletedSuccessfully,
        isFaulted: isFaulted,
        status: status,
      );
}

@JsonSerializable()
class ChartSuCoChildResponse {
  @JsonKey(name: 'khuVuc')
  String? khuVuc;
  @JsonKey(name: 'taskId')
  String? taskId;
  @JsonKey(name: 'danhSachSuCo')
  List<DanhSachKhuVucResponse>? danhSachKhuVuc;

  ChartSuCoChildResponse(
    this.khuVuc,
    this.danhSachKhuVuc,
  );

  factory ChartSuCoChildResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChartSuCoChildResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartSuCoChildResponseToJson(this);

  ChartSuCoChild toModel() => ChartSuCoChild(
        khuVuc: khuVuc,
        taskId: taskId,
        danhSachKhuVuc: danhSachKhuVuc?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class DanhSachKhuVucResponse {
  @JsonKey(name: 'loaiSuCoId')
  String? loaiSuCoId;
  @JsonKey(name: 'soLuong')
  int? soLuong;
  @JsonKey(name: 'suCo')
  String? suCo;

  DanhSachKhuVucResponse(
    this.loaiSuCoId,
    this.soLuong,
    this.suCo,
  );

  factory DanhSachKhuVucResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachKhuVucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachKhuVucResponseToJson(this);

  DanhSachKhuVuc toModel() => DanhSachKhuVuc(
        suCo: suCo,
        soLuong: soLuong,
        loaiSuCoId: loaiSuCoId,
      );
}
