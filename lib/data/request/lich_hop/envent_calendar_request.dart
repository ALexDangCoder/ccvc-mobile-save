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
  bool? IsLichLanhDao;
  List<String>? ListUserId;
  bool? isChoXacNhan;
  bool? isChuaCoBaoCao;
  bool? isDaCoBaoCao;
  bool? isLichDuocMoi;
  bool? isLichHuyBo;
  bool? isLichTaoHo;
  bool? isLichThamGia;
  bool? isLichThuHoi;
  bool? isLichTuChoi;
  bool? isPublish;

  EventCalendarRequest(
      {this.DateFrom,
      this.DateTo,
      this.DonViId,
      this.PageIndex,
      this.PageSize,
      this.UserId,
      this.isLichCuaToi,
      this.month,
      this.year,
      this.Title,
      this.IsLichLanhDao,
      this.ListUserId,
      this.isChoXacNhan,
      this.isChuaCoBaoCao,
      this.isDaCoBaoCao,
      this.isLichDuocMoi,
      this.isLichHuyBo,
      this.isLichTaoHo,
      this.isLichThamGia,
      this.isLichThuHoi,
      this.isLichTuChoi,
      this.isPublish}); //

  factory EventCalendarRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCalendarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventCalendarRequestToJson(this);
}
