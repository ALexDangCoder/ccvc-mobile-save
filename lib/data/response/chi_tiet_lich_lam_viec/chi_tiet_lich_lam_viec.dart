import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_lich_lam_viec.g.dart';

@JsonSerializable()
class DetailCalenderWorkResponse {
  @JsonKey(name: 'data')
  DetailCalenderWorkResponseData data;

  DetailCalenderWorkResponse(this.data);

  factory DetailCalenderWorkResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DetailCalenderWorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCalenderWorkResponseToJson(this);
}

@JsonSerializable()
class DetailCalenderWorkResponseData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'results')
  String? results;
  @JsonKey(name: 'expectedResults')
  String? expectedResults;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'statusName')
  String? statusName;
  @JsonKey(name: 'publishSchedule')
  bool? publishSchedule;
  @JsonKey(name: 'tags')
  String? tags;
  @JsonKey(name: 'rejectReason')
  String? rejectReason;
  @JsonKey(name: 'cancelReason')
  String? cancelReason;
  @JsonKey(name: 'typeScheduleId')
  String? typeScheduleId;
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
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'typeScheduleName')
  String? typeScheduleName;
  @JsonKey(name: 'isLichDonVi')
  bool? isLichDonVi;
  @JsonKey(name: 'isLichLanhDao')
  bool? isLichLanhDao;
  @JsonKey(name: 'scheduleReferenceId')
  String? scheduleReferenceId;
  @JsonKey(name: 'typeRepeat')
  int? typeRepeat;
  @JsonKey(name: 'dateRepeat')
  String? dateRepeat;
  @JsonKey(name: 'isLichLap')
  bool? isLichLap;
  @JsonKey(name: 'isAllDay')
  bool? isAllDay;
  @JsonKey(name: 'days')
  String? days;
  @JsonKey(name: 'dayOfWeek')
  int? dayOfWeek;
  @JsonKey(name: 'isSendMail')
  bool? isSendMail;
  @JsonKey(name: 'createBy')
  CreateByResponse? createBy;
  @JsonKey(name: 'updateBy')
  UpdateByResponse? updateBy;
  @JsonKey(name: 'canBoChuTri')
  CreateByResponse? canBoChuTri;
  @JsonKey(name: 'scheduleCoperatives')
  List<ScheduleCoperativesResponse>? scheduleCoperatives;
  @JsonKey(name: 'files')
  List<FilesResponse>? files;
  @JsonKey(name: 'scheduleReminder')
  ScheduleReminderResponse? scheduleReminder;
  @JsonKey(name: 'tinhId')
  String? tinhId;
  @JsonKey(name: 'tenTinh')
  String? tenTinh;
  @JsonKey(name: 'huyenId')
  String? huyenId;
  @JsonKey(name: 'tenHuyen')
  String? tenHuyen;
  @JsonKey(name: 'xaId')
  String? xaId;
  @JsonKey(name: 'tenXa')
  String? tenXa;
  @JsonKey(name: 'linhVucId')
  String? linhVucId;
  @JsonKey(name: 'countryId')
  String? countryId;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'linhVuc')
  String? linhVuc;

//
  DetailCalenderWorkResponseData();

  factory DetailCalenderWorkResponseData.fromJson(Map<String, dynamic> json) =>
      _$DetailCalenderWorkResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCalenderWorkResponseDataToJson(this);

  ChiTietLichLamViecModel toDomain() => ChiTietLichLamViecModel(
        id: id,
        title: title,
        content: content,
        location: location,
        results: results,
        expectedResults: expectedResults,
        status: status,
        statusName: statusName,
        publishSchedule: publishSchedule,
        tags: tags,
        rejectReason: rejectReason,
        cancelReason: cancelReason,
        typeScheduleId: typeScheduleId,
        dateFrom: dateFrom,
        dateTo: dateTo,
        timeFrom: timeFrom,
        timeTo: timeTo,
        dateTimeFrom: dateTimeFrom,
        dateTimeTo: dateTimeTo,
        createdAt: createdAt,
        updatedAt: updatedAt,
        typeScheduleName: typeScheduleName,
        isLichDonVi: isLichDonVi,
        isLichLanhDao: isLichLanhDao,
        scheduleReferenceId: scheduleReferenceId,
        typeRepeat: typeRepeat,
        dateRepeat: dateRepeat,
        isLichLap: isLichLap,
        isAllDay: isAllDay,
        days: days,
        dayOfWeek: dayOfWeek,
        isSendMail: isSendMail,
        createBy: createBy?.toDomain() ?? CreateBy(),
        updateBy: updateBy?.toDomain() ?? UpdateBy(),
        canBoChuTri: canBoChuTri?.toDomain() ?? CreateBy(),
        scheduleCoperatives:
            scheduleCoperatives?.map((e) => e.toModel()).toList() ?? [],
        files: files?.map((e) => e.toDomain()).toList() ?? [],
        scheduleReminder: scheduleReminder?.toModel() ?? ScheduleReminder(),
        tinhId: tinhId,
        tenTinh: tenTinh,
        huyenId: huyenId,
        tenHuyen: tenHuyen,
        xaId: xaId,
        tenXa: tenXa,
        linhVucId: linhVucId,
        countryId: countryId,
        country: country,
        linhVuc: linhVuc,
      );
}

@JsonSerializable()
class ScheduleReminderResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'reminderTypeId')
  String? reminderTypeId;
  @JsonKey(name: 'reminderTypeName')
  String? reminderTypeName;
  @JsonKey(name: 'reminderTypeValue')
  String? reminderTypeValue;
  @JsonKey(name: 'reminderDate')
  String? reminderDate;
  @JsonKey(name: 'reminderEnd')
  String? reminderEnd;
  @JsonKey(name: 'jobId')
  int? jobId;
  @JsonKey(name: 'typeReminder')
  int? typeReminder;

  ScheduleReminderResponse({
    this.id,
    this.reminderTypeId,
    this.reminderTypeName,
    this.reminderTypeValue,
    this.reminderDate,
    this.reminderEnd,
    this.jobId,
    this.typeReminder,
  });

  factory ScheduleReminderResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleReminderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleReminderResponseToJson(this);

  ScheduleReminder toModel() => ScheduleReminder(
        reminderTypeId: reminderTypeId,
        reminderTypeName: reminderTypeName,
        reminderTypeValue: reminderTypeValue,
        reminderDate: reminderDate,
        reminderEnd: reminderEnd,
        jobId: jobId,
        typeReminder: typeReminder,
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

  CreateBy toDomain() => CreateBy(
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

@JsonSerializable()
class UpdateByResponse {
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

  UpdateByResponse({
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

  factory UpdateByResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateByResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateByResponseToJson(this);

  UpdateBy toDomain() => UpdateBy(
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

@JsonSerializable()
class FilesResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'extension')
  String? extension;
  @JsonKey(name: 'size')
  String? size;
  @JsonKey(name: 'path')
  String? path;
  @JsonKey(name: 'entityId')
  String? entityId;
  @JsonKey(name: 'entityName')
  String? entityName;

  FilesResponse({
    this.id,
    this.name,
    this.extension,
    this.size,
    this.path,
    this.entityId,
    this.entityName,
  });

  factory FilesResponse.fromJson(Map<String, dynamic> json) =>
      _$FilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilesResponseToJson(this);

  Files toDomain() => Files(
        id: id,
        name: name,
        extension: extension,
        size: size,
        path: path,
        entityId: entityId,
        entityName: entityName,

      );
}

@JsonSerializable()
class ScheduleCoperativesResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'userName')
  String? userName;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'scheduleId')
  String? scheduleId;
  @JsonKey(name: 'isConfirm')
  bool? isConfirm;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'confirmDate')
  String? confirmDate;
  @JsonKey(name: 'taskContent')
  String? taskContent;
  @JsonKey(name: 'parentId')
  String? parentId;

  ScheduleCoperativesResponse({
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

  factory ScheduleCoperativesResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleCoperativesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleCoperativesResponseToJson(this);

  ScheduleCoperatives toModel() => ScheduleCoperatives(
        id: id,
        donViId: donViId,
        tenDonVi: tenDonVi,
        canBoId: canBoId,
        hoTen: hoTen,
        userName: userName,
        userId: userId,
        scheduleId: scheduleId,
        isConfirm: isConfirm,
        status: status,
        confirmDate: confirmDate,
        taskContent: taskContent,
        parentId: parentId,
      );
}
