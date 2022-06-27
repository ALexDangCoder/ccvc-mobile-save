import 'package:json_annotation/json_annotation.dart';

part 'envent_calendar_request.g.dart';

@JsonSerializable()
class EventCalendarRequest {
  String? DateFrom;
  String? DateTo;
  String? DonViId;
  int? PageIndex;
  int? PageSize;
  String? UserId;
  bool? isLichCuaToi;
  int? month;
  int? year;
  String? Title;
  bool? isChoXacNhan;
  bool? isChuaCoBaoCao;
  bool? isDaCoBaoCao;
  bool? isDuyetKyThuat;
  bool? isDuyetLich;
  bool? isDuyetPhong;
  bool? isDuyetThietBi;
  bool? isLichDuocMoi;
  bool? isLichHuyBo;
  bool? isLichThamGia;
  bool? isLichThuHoi;
  bool? isLichTuChoi;
  bool? isLichYeuCauChuanBi;
  bool? isLichTaoHo;
  bool? isPublish;

  EventCalendarRequest({
    required this.DateFrom,
    required this.DateTo,
    required this.DonViId,
    required this.PageIndex,
    required this.PageSize,
    required this.UserId,
    required this.isLichCuaToi,
    required this.month,
    required this.year,
    required this.Title,
    this.isChoXacNhan,
    this.isChuaCoBaoCao,
    this.isDaCoBaoCao,
    this.isDuyetKyThuat,
    this.isDuyetLich,
    this.isDuyetPhong,
    this.isDuyetThietBi,
    this.isLichDuocMoi,
    this.isLichHuyBo,
    this.isLichThamGia,
    this.isLichThuHoi,
    this.isLichTuChoi,
    this.isLichYeuCauChuanBi,
    this.isPublish,
    this.isLichTaoHo,
  });

  factory EventCalendarRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCalendarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventCalendarRequestToJson(this);
}
