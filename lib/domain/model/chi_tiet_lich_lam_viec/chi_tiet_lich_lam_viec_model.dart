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
  List<String>? scheduleCoperatives;
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

  Files({
    required this.id,
    required this.name,
    required this.extension,
    required this.size,
    required this.path,
    required this.entityId,
    required this.entityName,
  });
}
