import 'package:ccvc_mobile/domain/model/lich_lam_viec/danh_sach_lich_lam_viec.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_lich_lam_viec_response.g.dart';

@JsonSerializable()
class DanhSachLichLamViecResponse extends Equatable {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'data')
  DanhSachLichLamViecItemResponse? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;

  DanhSachLichLamViecResponse(
      {this.code, this.data, this.message, this.statusCode, this.succeeded});

  factory DanhSachLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLichLamViecResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DanhSachLichLamViecItemResponse extends Equatable {
  @JsonKey(name: 'items')
  List<ItemDanhSachLichLamViecResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DanhSachLichLamViecItemResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DanhSachLichLamViecItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichLamViecItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachLichLamViecItemResponseToJson(this);

  DanhSachLichlamViecModel toModel() => DanhSachLichlamViecModel(
      item: items?.map((e) => e.toModel()).toList() ?? [],
      pageIndex: pageIndex,
      pageSize: pageSize,
      totalCount: totalCount,
      totalPage: totalPage);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemDanhSachLichLamViecResponse extends Equatable {
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
  dynamic color;
  @JsonKey(name: 'typeSchedule')
  String? typeSchedule;
  @JsonKey(name: 'createBy')
  CanBoChuTriResponse? canBoChuTriInfo;
  @JsonKey(name: 'canBoChuTri')
  CanBoChuTriResponse? canBoChuTriDangKyInfo;

  ItemDanhSachLichLamViecResponse({
    this.id,
    this.title,
    this.content,
    this.status,
    this.location,
    this.isLichLap,
    this.isAllDay,
    this.trangThaiTheoUser,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
    this.dateTimeFrom,
    this.dateTimeTo,
    this.createAt,
    this.color,
    this.typeSchedule,
    this.canBoChuTriInfo,
    this.canBoChuTriDangKyInfo,
  });

  factory ItemDanhSachLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDanhSachLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ItemDanhSachLichLamViecResponseToJson(this);

  ItemDanhSachLichLamViec toModel() => ItemDanhSachLichLamViec(
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
        canBoChuTriInfo: canBoChuTriInfo?.toModel() ?? CanBoChuTri.empty(),
        canBoChuTriDangKyInfo:
            canBoChuTriDangKyInfo?.toModel() ?? CanBoChuTri.empty(),
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CanBoChuTriResponse extends Equatable {
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

  CanBoChuTriResponse({
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

  factory CanBoChuTriResponse.fromJson(Map<String, dynamic> json) =>
      _$CanBoChuTriResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CanBoChuTriResponseToJson(this);

  CanBoChuTri toModel() => CanBoChuTri(
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

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
