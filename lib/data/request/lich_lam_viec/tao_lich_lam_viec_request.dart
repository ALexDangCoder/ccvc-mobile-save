import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tao_lich_lam_viec_request.g.dart';

Map<String, dynamic> repeatCalendar = {
  'typeRepeat': 1,
  'dateRepeat': ['2022-02-24', '2022-02-24'],
  'only': true
};
Map<String, dynamic> scheduleReminderRequest = {'typeRemider': 1};

@JsonSerializable()
class TaoLichLamViecRequest extends Equatable {
  String? title;
  String? typeScheduleId;
  String? linhVucId;
  String? TenTinh;
  String? TenHuyen;
  String? TenXa;
  String? dateFrom;
  String? timeFrom;
  String? dateTo;
  String? timeTo;
  String? content;
  String? location;
  String? vehicle;
  String? expectedResults;
  String? results;
  int? status;
  String? rejectReason;
  bool? publishSchedule;
  String? tags;
  bool? isLichDonVi;
  String? canBoChuTriId;
  String? donViId;
  String? note;
  bool? isAllDay;
  bool? isSendMail;
  int? typeRemider;
  int? typeRepeat;
  String? dateRepeat;
  String? dateRepeat1;
  bool? only;

  TaoLichLamViecRequest({
    this.title,
    this.typeScheduleId,
    this.linhVucId,
    this.TenTinh,
    this.TenHuyen,
    this.TenXa,
    this.dateFrom,
    this.timeFrom,
    this.dateTo,
    this.timeTo,
    this.content,
    this.location,
    this.vehicle,
    this.expectedResults,
    this.results,
    this.status,
    this.rejectReason,
    this.publishSchedule,
    this.tags,
    this.isLichDonVi,
    this.canBoChuTriId,
    this.donViId,
    this.note,
    this.isAllDay,
    this.isSendMail,
    this.typeRemider,
    this.typeRepeat,
    this.dateRepeat,
    this.dateRepeat1,
    this.only,
  });

  factory TaoLichLamViecRequest.fromJson(Map<String, dynamic> json) =>
      _$TaoLichLamViecRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaoLichLamViecRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

TaoLichLamViecRequest dataBodyTaoLichLamViec = TaoLichLamViecRequest(
  title: 'tao6dd',
  typeScheduleId: 'a0602d4e-d4cb-4259-a7ea-0260360852f3',
  linhVucId: 'a9e5475f-040e-4f89-bb4e-da227a5dd0b6',
  TenTinh: '',
  TenHuyen: '',
  TenXa: '',
  dateFrom: '2022-02-24',
  timeFrom: '13:45',
  dateTo: '2022-02-24',
  timeTo: '15:45',
  content: '',
  location: 'assd',
  vehicle: '',
  expectedResults: '',
  results: '',
  status: 2,
  rejectReason: '',
  publishSchedule: false,
  tags: '',
  isLichDonVi: false,
  canBoChuTriId: 'a9e5475f-040e-4f89-bb4e-da227a5dd0b6',
  donViId: '0bf3b2c3-76d7-4e05-a587-9165c3624d76',
  note: '',
  isAllDay: false,
  isSendMail: true,
  typeRemider: 1,
  typeRepeat: 1,
  dateRepeat: '2022-02-24',
  dateRepeat1: '2022-02-24',
  only: true,
);
