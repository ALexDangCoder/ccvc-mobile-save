import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_lich_lam_viec.g.dart';

@JsonSerializable()
class DetailCalenderWorkResponse extends Equatable {
  @JsonKey(name: 'data')
  DetailCalenderWorkResponseData data;

  DetailCalenderWorkResponse(this.data);

  factory DetailCalenderWorkResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DetailCalenderWorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCalenderWorkResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class DetailCalenderWorkResponseData extends Equatable {
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
  dynamic scheduleReferenceId;
  @JsonKey(name: 'typeRepeat')
  int? typeRepeat;
  @JsonKey(name: 'dateRepeat')
  String? dateRepeat;
  @JsonKey(name: 'isLichLap')
  bool? isLichLap;
  @JsonKey(name: 'isAllDay')
  bool? isAllDay;
  @JsonKey(name: 'days')
  dynamic days;
  @JsonKey(name: 'dayOfWeek')
  int? dayOfWeek;
  @JsonKey(name: 'isSendMail')
  bool? isSendMail;
  @JsonKey(name: 'createBy')
  UserEditingResponse? createBy;
  @JsonKey(name: 'updateBy')
  UserEditingResponse? updateBy;
  @JsonKey(name: 'canBoChuTri')
  UserEditingResponse? canBoChuTri;
  @JsonKey(name: 'scheduleReminder')
  dynamic scheduleReminder;
  @JsonKey(name: 'tinhId')
  String? tinhId;
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
  @JsonKey(name: 'scheduleCoperatives')
  List<dynamic>? scheduleCoperatives;
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



  @override
  List<Object?> get props => throw [];

  ChiTietLichLamViecModel toModel() => ChiTietLichLamViecModel(
        id: id ?? '',
        time: '$timeFrom - $timeTo',
        date: DateTime.parse(dateTimeFrom??'').formatDayCalendar ?? '',
        loaiLich: typeScheduleName ?? '',
        // listPerSon: fakeDataListPerson(),
        nhacLai: '',
        chuTri: (createBy?.toModel() ?? Departments()).tenDonVi ?? '',
        linhVuc: linhVuc ?? '',
        diaDiem: location ?? '',
        noiDung: content ?? '',
      );
}

@JsonSerializable()
class UserEditingResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'chucVuId')
  String? chucVuId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'sdtDiDong')
  dynamic sdtDiDong;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'donViGocId')
  String? donViGocId;
  @JsonKey(name: 'tenDonViGoc')
  String? tenDonViGoc;

//
  UserEditingResponse();

  factory UserEditingResponse.fromJson(Map<String, dynamic> json) =>
      _$UserEditingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserEditingResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  Departments toModel() => Departments(
        id: id,
        chucVuId: chucVuId,
        tenChucVu: chucVu,
        donViId: donViId,
        tenDonVi: tenDonVi,
      );
}
