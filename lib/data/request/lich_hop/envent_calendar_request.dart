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
  bool? IsLichLanhDao;
  bool? isDaChuanBi;
  bool? isChuaChuanBi;
  List<String>? ListUserId;

  EventCalendarRequest({
    required this.DateFrom,
    required this.DateTo,
    required this.DonViId,
    required this.PageIndex,
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
    this.IsLichLanhDao,
    this.ListUserId,
    this.isChuaChuanBi,
    this.isDaChuanBi,
    this.PageSize,
  });

  factory EventCalendarRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCalendarRequestFromJson(json);

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> json = {
      'DateFrom': DateFrom,
      'DateTo': DateTo,
      'DonViId': DonViId,
      'PageIndex': PageIndex,
      'UserId': UserId,
      'isLichCuaToi': isLichCuaToi,
      'month': month,
      'year': year,
      'Title': Title,
      'isChoXacNhan': isChoXacNhan,
      'isChuaCoBaoCao': isChuaCoBaoCao,
      'isDaCoBaoCao': isDaCoBaoCao,
      'isDuyetKyThuat': isDuyetKyThuat,
      'isDuyetLich': isDuyetLich,
      'isDuyetPhong': isDuyetPhong,
      'isDuyetThietBi': isDuyetThietBi,
      'isLichDuocMoi': isLichDuocMoi,
      'isLichHuyBo': isLichHuyBo,
      'isLichThamGia': isLichThamGia,
      'isLichThuHoi': isLichThuHoi,
      'isLichTuChoi': isLichTuChoi,
      'isLichYeuCauChuanBi': isLichYeuCauChuanBi,
      'isLichTaoHo': isLichTaoHo,
      'isPublish': isPublish,
      'IsLichLanhDao': IsLichLanhDao,
      'isDaChuanBi': isDaChuanBi,
      'isChuaChuanBi': isChuaChuanBi,
      'ListUserId': ListUserId,
    };
    if(PageSize != null){
      json.putIfAbsent('PageSize', () => PageSize);
    }
    return json;
  }
}
