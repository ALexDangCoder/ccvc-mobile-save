import 'dart:ui';

import 'package:flutter/material.dart';

class ListPerSon {
  int tongSoNguoi = 0;
  int soNguoiDongY = 0;
  int soNguoiChoXacNhan = 0;
  List<Person> listPerson = [];

  ListPerSon.Empty();

  ListPerSon({
    required this.tongSoNguoi,
    required this.soNguoiDongY,
    required this.soNguoiChoXacNhan,
    required this.listPerson,
  });
}

class Person {
  Color color = Colors.red;
  String name = '';
  bool isConnect = false;

  Person.Empty();

  Person({
    required this.color,
    required this.name,
    required this.isConnect,
  });
}

enum typeData { text, listperson }

class TypeData {
  String icon;
  dynamic value;
  typeData type;

  TypeData({required this.icon, required this.value, required this.type});
}

class ChiTietLichLamViecModel {
  String? id;
  String? title;
  String? content;
  String? location;
  String? results;
  String? expectedResults;
  int? status;
  String? statusName;
  bool? publishSchedule;
  String? tags;
  String? rejectReason;
  String? cancelReason;
  String? typeScheduleId;
  String? dateFrom;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  String? dateTimeFrom;
  String? dateTimeTo;
  String? createdAt;
  String? updatedAt;
  String? typeScheduleName;
  bool? isLichDonVi;
  bool? isLichLanhDao;
  String? scheduleReferenceId;
  int? typeRepeat;
  String? dateRepeat;
  bool? isLichLap;
  bool? isAllDay;
  String? days;
  int? dayOfWeek;
  bool? isSendMail;
  CreateBy? createBy;
  UpdateBy? updateBy;
  CreateBy? canBoChuTri;
  List<ScheduleCoperatives>? scheduleCoperatives;
  List<Files>? files;
  ScheduleReminder? scheduleReminder;
  String? tinhId;
  String? tenTinh;
  String? huyenId;
  String? tenHuyen;
  String? xaId;
  String? tenXa;
  String? linhVucId;
  String? countryId;
  String? country;
  String? linhVuc;

  ChiTietLichLamViecModel({
    this.id,
    this.title,
    this.content,
    this.location,
    this.results,
    this.expectedResults,
    this.status,
    this.statusName,
    this.publishSchedule,
    this.tags,
    this.rejectReason,
    this.cancelReason,
    this.typeScheduleId,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
    this.dateTimeFrom,
    this.dateTimeTo,
    this.createdAt,
    this.updatedAt,
    this.typeScheduleName,
    this.isLichDonVi,
    this.isLichLanhDao,
    this.scheduleReferenceId,
    this.typeRepeat,
    this.dateRepeat,
    this.isLichLap,
    this.isAllDay,
    this.days,
    this.dayOfWeek,
    this.isSendMail,
    this.createBy,
    this.updateBy,
    this.canBoChuTri,
    this.scheduleCoperatives,
    this.files,
    this.scheduleReminder,
    this.tinhId,
    this.tenTinh,
    this.huyenId,
    this.tenHuyen,
    this.xaId,
    this.tenXa,
    this.linhVucId,
    this.countryId,
    this.country,
    this.linhVuc,
  });

  String lichLap() {
    switch (typeRepeat) {
      case 1:
        return 'Không lặp lại';
      case 2:
        return 'Lặp lại hàng ngày';
      case 3:
        return 'Từ thứ 2 đến thứ 6 hàng tuần';
      case 4:
        return 'Lặp lại hàng tuần';
      case 5:
        return 'Lặp lại hàng tháng';
      case 6:
        return 'Lặp lại hàng năm';
      case 7:
        return 'Tùy chỉnh';
    }
    return '';
  }
}

class ScheduleReminder {
  String? id;
  String? reminderTypeId;
  String? reminderTypeName;
  String? reminderTypeValue;
  String? reminderDate;
  String? reminderEnd;
  int? jobId;
  int? typeReminder;

  ScheduleReminder({
    this.id,
    this.reminderTypeId,
    this.reminderTypeName,
    this.reminderTypeValue,
    this.reminderDate,
    this.reminderEnd,
    this.jobId,
    this.typeReminder,
  });

  String nhacLai() {
    switch (typeReminder) {
      case 1:
        return 'Không bao giờ';
      case 0:
        return 'Sau khi tạo lịch';
      case 5:
        return 'Trước 5 phút';
      case 10:
        return 'Trước 10 phút';
      case 15:
        return 'Trước 15 phút';
      case 30:
        return 'Trước 30 phút';
      case 60:
        return 'Trước 1 giờ';
      case 120:
        return 'Trước 2 giờ';
      case 720:
        return 'Trước 12 giờ';
      case 1140:
        return 'Trước 1 ngày';
      case 10080:
        return 'Trước 1 tuần';
    }
    return 'Không bao giờ';
  }
}

class CreateBy {
  String? id;
  String? chucVu;
  String? chucVuId;
  String? hoTen;
  String? sdtDiDong;
  String? donViId;
  String? tenDonVi;
  String? donViGocId;
  String? tenDonViGoc;

  CreateBy({
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

  String title() {
    return '$hoTen - $tenDonVi';
  }

  String nameUnitPosition() {
    return '$hoTen - $tenDonVi - $chucVu';
  }

  String namePosition() {
    return '$hoTen - $chucVu';
  }
}

class UpdateBy {
  String? id;
  String? chucVu;
  String? chucVuId;
  String? hoTen;
  String? sdtDiDong;
  String? donViId;
  String? tenDonVi;
  String? donViGocId;
  String? tenDonViGoc;

  UpdateBy({
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
}

class Files {
  String? id;
  String? name;
  String? extension;
  String? size;
  String? path;
  String? entityId;
  String? entityName;
  String? taskId;
  String? fileId;

  Files({
    required this.id,
    required this.name,
    required this.extension,
    required this.size,
    required this.path,
    required this.entityId,
    required this.entityName,
    this.taskId,
    this.fileId,
  });

  double getSize(){
    try{
      return double.parse(size ?? '');
    }catch(e){
      return 0;
    }
  }
}

class ScheduleCoperatives {
  String? id;
  String? donViId;
  String? tenDonVi;
  String? canBoId;
  String? hoTen;
  String? userName;
  String? userId;
  String? scheduleId;
  bool? isConfirm;
  int? status;
  String? confirmDate;
  String? taskContent;
  String? parentId;

  ScheduleCoperatives({
    this.id,
    this.donViId,
    this.tenDonVi,
    this.canBoId,
    this.hoTen,
    this.userName,
    this.userId,
    this.scheduleId,
    this.isConfirm,
    this.status,
    this.confirmDate,
    this.taskContent,
    this.parentId,
  });
}
