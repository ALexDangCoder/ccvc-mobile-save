import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_lich_hop_response.g.dart';

@JsonSerializable()
class DanhSachLichHopResponse extends Equatable {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'data')
  DanhSachLichHopItemResponse? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;

  DanhSachLichHopResponse(
      this.code, this.data, this.message, this.statusCode, this.succeeded);

  factory DanhSachLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLichHopResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DanhSachLichHopItemResponse extends Equatable {
  @JsonKey(name: 'items')
  List<ItemDanhSachLichHopResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DanhSachLichHopItemResponse({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });

  DanhSachLichHopModel toModel() => DanhSachLichHopModel(
        items: items?.map((e) => e.toModel()).toList() ?? [],
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  factory DanhSachLichHopItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichHopItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLichHopItemResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemDanhSachLichHopResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'soNguoiThamDu')
  dynamic soNguoiThamDu;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'tenPhongHop')
  dynamic tenPhongHop;
  @JsonKey(name: 'linkTrucTuyen')
  String? linkTrucTuyen;
  @JsonKey(name: 'phongHopId')
  dynamic phongHopId;
  @JsonKey(name: 'mucDo')
  int? mucDo;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'statusName')
  String? statusName;
  @JsonKey(name: 'statusCode')
  String? statusCode;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'bit_HopTrucTuyen')
  bool? bit_HopTrucTuyen;
  @JsonKey(name: 'color')
  dynamic color;
  @JsonKey(name: 'isThuKy')
  bool? isThuKy;
  @JsonKey(name: 'isAllDay')
  bool? isAllDay;
  @JsonKey(name: 'isLichLap')
  bool? isLichLap;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'trangThaiTheoUser')
  int? trangThaiTheoUser;
  @JsonKey(name: 'diaDiem')
  String? diaDiem;
  @JsonKey(name: 'trangThaiCuocHop')
  String? trangThaiCuocHop;
  @JsonKey(name: 'timeStart')
  String? timeStart;
  @JsonKey(name: 'timeTo')
  String? timeTo;
  @JsonKey(name: 'dateTimeFrom')
  String? dateTimeFrom;
  @JsonKey(name: 'dateTimeTo')
  String? dateTimeTo;
  @JsonKey(name: 'ngayBatDau')
  String? ngayBatDau;
  @JsonKey(name: 'ngayKetThuc')
  String? ngayKetThuc;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'canBoChuTriInfo')
  CanBoResponse? canBoChuTriInfo;
  @JsonKey(name: 'canBoDangKyInfo')
  CanBoResponse? canBoDangKyInfo;

  ItemDanhSachLichHopResponse({
    required this.id,
    required this.soNguoiThamDu,
    required this.noiDung,
    required this.tenPhongHop,
    required this.linkTrucTuyen,
    required this.phongHopId,
    required this.mucDo,
    required this.status,
    required this.statusName,
    required this.statusCode,
    required this.title,
    required this.bit_HopTrucTuyen,
    required this.color,
    required this.isThuKy,
    required this.isAllDay,
    required this.isLichLap,
    required this.createAt,
    required this.trangThaiTheoUser,
    required this.diaDiem,
    required this.trangThaiCuocHop,
    required this.timeStart,
    required this.timeTo,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.canBoChuTriInfo,
    required this.canBoDangKyInfo,
  });

  factory ItemDanhSachLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDanhSachLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDanhSachLichHopResponseToJson(this);

  ItemDanhSachLichHop toModel() => ItemDanhSachLichHop(
        id: id,
        soNguoiThamDu: soNguoiThamDu,
        noiDung: noiDung,
        tenPhongHop: tenPhongHop,
        linkTrucTuyen: linkTrucTuyen,
        phongHopId: phongHopId,
        mucDo: mucDo,
        status: status,
        statusName: statusName,
        statusCode: statusCode,
        title: title,
        bit_HopTrucTuyen: bit_HopTrucTuyen,
        color: color,
        isThuKy: isThuKy,
        isAllDay: isAllDay,
        isLichLap: isLichLap,
        createAt: createAt,
        trangThaiTheoUser: trangThaiTheoUser,
        diaDiem: diaDiem,
        trangThaiCuocHop: trangThaiCuocHop,
        timeStart: timeStart,
        timeTo: timeTo,
        dateTimeFrom: dateTimeFrom,
        dateTimeTo: dateTimeTo,
        ngayBatDau: ngayBatDau,
        ngayKetThuc: ngayKetThuc,
        thoiGianBatDau: thoiGianBatDau,
        thoiGianKetThuc: thoiGianKetThuc,
        canBoChuTriInfo: canBoChuTriInfo?.toModel() ?? CanBo.empty(),
        canBoDangKyInfo: canBoDangKyInfo?.toModel() ?? CanBo.empty(),
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CanBoResponse extends Equatable {
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'tenChucVu')
  String? tenChucVu;
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'sdtCanBo')
  String? sdtCanBo;
  @JsonKey(name: 'sdtDonVi')
  String? sdtDonVi;
  @JsonKey(name: 'emailDonVi')
  String? emailDonVi;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'donViGocId')
  String? donViGocId;
  @JsonKey(name: 'tenDonViGoc')
  String? tenDonViGoc;

  CanBoResponse({
    required this.canBoId,
    required this.userName,
    required this.tenChucVu,
    required this.chucVuId,
    required this.hoTen,
    required this.sdtCanBo,
    required this.sdtDonVi,
    required this.emailDonVi,
    required this.donViId,
    required this.tenDonVi,
    required this.donViGocId,
    required this.tenDonViGoc,
  });

  CanBoResponse.empty();

  factory CanBoResponse.fromJson(Map<String, dynamic> json) =>
      _$CanBoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CanBoResponseToJson(this);

  CanBo toModel() => CanBo(
        canBoId: canBoId,
        userName: userName,
        tenChucVu: tenChucVu,
        chucVuId: chucVuId,
        hoTen: hoTen,
        sdtCanBo: sdtCanBo,
        sdtDonVi: sdtDonVi,
        emailDonVi: emailDonVi,
        donViId: donViId,
        tenDonVi: tenDonVi,
        donViGocId: donViGocId,
        tenDonViGoc: tenDonViGoc,
      );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
