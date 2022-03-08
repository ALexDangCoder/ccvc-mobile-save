import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

class LichLamViecResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  LichLamViecResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  LichLamViecResponse.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.items,
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPage});

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
  String? title;
  String? content;
  int? status;
  String? location;
  bool? isLichLap;
  bool? isAllDay;
  int? trangThaiTheoUser;
  String? dateFrom;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  String? dateTimeFrom;
  String? dateTimeTo;
  String? createAt;
  String? typeSchedule;
  CreateBy? createBy;
  CreateBy? canBoChuTri;

  Items(
      {this.id,
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
      this.typeSchedule,
      this.createBy,
      this.canBoChuTri});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    status = json['status'];
    location = json['location'];
    isLichLap = json['isLichLap'];
    isAllDay = json['isAllDay'];
    trangThaiTheoUser = json['trangThaiTheoUser'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    timeFrom = json['timeFrom'];
    timeTo = json['timeTo'];
    dateTimeFrom = json['dateTimeFrom'];
    dateTimeTo = json['dateTimeTo'];
    createAt = json['createAt'];
    typeSchedule = json['typeSchedule'];
    createBy =
        json['createBy'] != null ? CreateBy.fromJson(json['createBy']) : null;
    canBoChuTri = json['canBoChuTri'] != null
        ? CreateBy.fromJson(json['canBoChuTri'])
        : null;
  }
  CalendarMeetingModel toDomain() {
    return CalendarMeetingModel(
      nguoiChuTri: canBoChuTri?.hoTen ?? '',
      title: title ?? '',
      timeFrom: timeFrom ?? '',
      timeTo: timeTo ?? '',
      dataTimeFrom: dateTimeFrom ?? DateTime.now().toString(),
      dateTimeTo: dateTimeTo ?? DateTime.now().toString(),
      nguoiChuTriId: canBoChuTri?.id ?? '',
      trangThaiTheoUser: trangThaiTheoUser ?? 0,
      id: id ?? '',
    );
  }
}

class CreateBy {
  String? id;
  String? chucVu;
  String? chucVuId;
  String? hoTen;

  String? donViId;
  String? tenDonVi;

  CreateBy({
    this.id,
    this.chucVu,
    this.chucVuId,
    this.hoTen,
    this.donViId,
    this.tenDonVi,
  });

  CreateBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chucVu = json['chucVu'];
    chucVuId = json['chucVuId'];
    hoTen = json['hoTen'];
    donViId = json['donViId'];
    tenDonVi = json['tenDonVi'];
  }
}
