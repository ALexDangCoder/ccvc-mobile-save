import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_lich_lv_response.g.dart';

@JsonSerializable()
class ListLichLvResponse {
  @JsonKey(name: 'data')
  DataListLichLvResponse data;

  ListLichLvResponse(this.data);

  factory ListLichLvResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ListLichLvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListLichLvResponseToJson(this);
}

@JsonSerializable()
class DataListLichLvResponse {
  @JsonKey(name: 'items')
  List<ItemListLichLvResponse>? data;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DataListLichLvResponse({
    this.data,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DataListLichLvResponse.fromJson(Map<String, dynamic> json) =>
      _$DataListLichLvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataListLichLvResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  DataLichLvModel toDomain() => DataLichLvModel(
        listLichLVModel: data?.map((e) => e.toDomain()).toList() ?? [],
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );
}

@JsonSerializable()
class ItemListLichLvResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'isLichLap')
  bool? isLichLap;
  @JsonKey(name: 'isAllDay')
  bool? isAllDay;
  @JsonKey(name: 'trangThaiTheoUser')
  int? trangThaiTheoUser;
  @JsonKey(name: 'dateFrom')
  String? dateFrom;
  @JsonKey(name: 'dateTo')
  String? dateTo;
  @JsonKey(name: 'timeFrom')
  String? timeFrom;
  @JsonKey(name: 'timeTo')
  String? timeTo;
  @JsonKey(name: 'dateTimeFrom')
  String? dateTimeFrom;
  @JsonKey(name: 'dateTimeTo')
  String? dateTimeTo;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'color')
  String? color;
  @JsonKey(name: 'typeSchedule')
  String? typeSchedule;

//

  ItemListLichLvResponse();

  factory ItemListLichLvResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemListLichLvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListLichLvResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  ListLichLVModel toDomain() => ListLichLVModel(
        id: id,
        title: title,
        content: content,
        status: status,
        location: location,
        isLichLap: isLichLap,
        isAllDay: isAllDay,
        trangThaiTheoUser: trangThaiTheoUser,
        dateFrom: dateFrom,
        dateTo: dateTo,
        timeFrom: timeFrom,
        timeTo: timeTo,
        dateTimeFrom: dateTimeFrom,
        dateTimeTo: dateTimeTo,
        createAt: createAt,
        color: color,
        typeSchedule: typeSchedule,
      );
}

@JsonSerializable()
class CreateByResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'sdtDiDong')
  String? sdtDiDong;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'donViGocId')
  String? donViGocId;
  @JsonKey(name: 'tenDonViGoc')
  String? tenDonViGoc;

  CreateByResponse({
    this.id,
    this.chucVu,
    this.chucVuId,
    this.hoTen,
    this.sdtDiDong,
    this.donViId,
    this.tenDonVi,
    this.donViGocId,
    this.tenDonViGoc,
  });

  factory CreateByResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateByResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateByResponseToJson(this);

  CreateBys toDomain() => CreateBys(
        id: id,
        chucVu: chucVu,
        chucVuId: chucVuId,
        hoTen: hoTen,
        sdtDiDong: sdtDiDong,
        donViId: donViId,
        tenDonVi: tenDonVi,
        donViGocId: donViGocId,
        tenDonViGoc: tenDonViGoc,
      );
}
