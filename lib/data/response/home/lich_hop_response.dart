import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';

class LichHopResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  LichHopResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  LichHopResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  List<Items>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  Data({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
  }
  List<CalendarMeetingModel> toDomain() {
    return items?.map((e) => e.toDomain()).toList() ?? [];
  }
}

class Items {
  String? id;

  String? noiDung;
  String? tenPhongHop;
  String? linkTrucTuyen;

  int? mucDo;
  int? status;
  String? statusName;
  String? statusCode;
  String? title;
  bool? bitHopTrucTuyen;

  bool? isThuKy;
  bool? isAllDay;
  bool? isLichLap;
  String? createAt;
  int? trangThaiTheoUser;
  String? diaDiem;
  String? trangThaiCuocHop;
  String? timeStart;
  String? timeTo;
  String? dateTimeFrom;
  String? dateTimeTo;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  CanBoChuTriInfo? canBoChuTriInfo;
  CanBoChuTriInfo? canBoDangKyInfo;

  Items({
    this.id,
    this.noiDung,
    this.tenPhongHop,
    this.linkTrucTuyen,
    this.mucDo,
    this.status,
    this.statusName,
    this.statusCode,
    this.title,
    this.bitHopTrucTuyen,
    this.isThuKy,
    this.isAllDay,
    this.isLichLap,
    this.createAt,
    this.trangThaiTheoUser,
    this.diaDiem,
    this.trangThaiCuocHop,
    this.timeStart,
    this.timeTo,
    this.dateTimeFrom,
    this.dateTimeTo,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.canBoChuTriInfo,
    this.canBoDangKyInfo,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    noiDung = json['noiDung'];
    tenPhongHop = json['tenPhongHop'];
    linkTrucTuyen = json['linkTrucTuyen'];

    mucDo = json['mucDo'];
    status = json['status'];
    statusName = json['statusName'];
    statusCode = json['statusCode'];
    title = json['title'];
    bitHopTrucTuyen = json['bit_HopTrucTuyen'];
    isThuKy = json['isThuKy'];
    isAllDay = json['isAllDay'];
    isLichLap = json['isLichLap'];
    createAt = json['createAt'];
    trangThaiTheoUser = json['trangThaiTheoUser'];
    diaDiem = json['diaDiem'];
    trangThaiCuocHop = json['trangThaiCuocHop'];
    timeStart = json['timeStart'];
    timeTo = json['timeTo'];
    dateTimeFrom = json['dateTimeFrom'];
    dateTimeTo = json['dateTimeTo'];
    ngayBatDau = json['ngayBatDau'];
    ngayKetThuc = json['ngayKetThuc'];
    thoiGianBatDau = json['thoiGianBatDau'];
    thoiGianKetThuc = json['thoiGianKetThuc'];
    canBoChuTriInfo = json['canBoChuTriInfo'] != null
        ? CanBoChuTriInfo.fromJson(json['canBoChuTriInfo'])
        : null;
    canBoDangKyInfo = json['canBoDangKyInfo'] != null
        ? CanBoChuTriInfo.fromJson(json['canBoDangKyInfo'])
        : null;
  }
  CalendarMeetingModel toDomain() => CalendarMeetingModel(
      title: title ?? '',
      nguoiChuTri: canBoChuTriInfo?.hoTen ?? '',
      dataTimeFrom: dateTimeFrom ?? DateTime.now().toString(),
      dateTimeTo: dateTimeTo ?? DateTime.now().toString(),
      timeFrom: timeStart ?? '',
      timeTo: timeTo ?? '',
      isHopTrucTuyen: bitHopTrucTuyen ?? false);
}

class CanBoChuTriInfo {
  String? canBoId;
  String? tenChucVu;
  String? chucVuId;
  String? hoTen;

  String? donViId;
  String? tenDonVi;

  CanBoChuTriInfo({
    this.canBoId,
    this.tenChucVu,
    this.chucVuId,
    this.hoTen,
    this.donViId,
    this.tenDonVi,
  });

  CanBoChuTriInfo.fromJson(Map<String, dynamic> json) {
    canBoId = json['canBoId'];

    tenChucVu = json['tenChucVu'];
    chucVuId = json['chucVuId'];
    hoTen = json['hoTen'];

    donViId = json['donViId'];
    tenDonVi = json['tenDonVi'];
  }
}
