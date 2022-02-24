import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_lich_hop_request.g.dart';

@JsonSerializable()
class DanhSachLichHopRequest {
  String? DateFrom;
  String? DateTo;
  String? UserId;
  String? DonViId;
  bool? IsLichLanhDao;
  int? PageIndex;
  int? PageSize;
  String? Title;
  bool? isLichCuaToi;
  bool? isLichDuocMoi;
  bool? isLichHuyBo;
  bool? isLichTaoHo;
  bool? isLichThamGia;
  bool? isLichThuHoi;
  bool? isLichTuChoi;
  bool? isPublish;
  bool? isDuyetLich;
  bool? isDuyetThietBi;
  bool? isLichYeuCauChuanBi;
  bool? isChuaCoBaoCao;
  bool? isDaCoBaoCao;
  bool? isChoXacNhan;
  bool? isDuyetPhong;

  DanhSachLichHopRequest({
    required this.DateFrom,
    required this.DateTo,
    required this.UserId,
    required this.DonViId,
    required this.IsLichLanhDao,
    required this.PageIndex,
    required this.PageSize,
    required this.Title,
    required this.isLichCuaToi,
    required this.isLichDuocMoi,
    required this.isLichHuyBo,
    required this.isLichTaoHo,
    required this.isLichThamGia,
    required this.isLichThuHoi,
    required this.isLichTuChoi,
    required this.isPublish,
    required this.isDuyetLich,
    required this.isDuyetThietBi,
    required this.isLichYeuCauChuanBi,
    required this.isChuaCoBaoCao,
    required this.isDaCoBaoCao,
    required this.isChoXacNhan,
    required this.isDuyetPhong,
  });

  factory DanhSachLichHopRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLichHopRequestToJson(this);
}
DanhSachLichHopRequest fakeDataBody = DanhSachLichHopRequest(
  DateFrom: DateTime.now().formatApi,
  DateTo:  DateTime.now().formatApi,
  DonViId: "0bf3b2c3-76d7-4e05-a587-9165c3624d76",
  IsLichLanhDao: null,
  PageIndex: 1,
  PageSize: 10,
  Title: null,
  UserId: "19266143-feee-44d0-828a-e29df215f481",
  isChoXacNhan: null,
  isChuaCoBaoCao: null,
  isDaCoBaoCao: null,
  isDuyetLich: null,
  isDuyetPhong: null,
  isDuyetThietBi: null,
  isLichCuaToi: true,
  isLichDuocMoi: null,
  isLichHuyBo: null,
  isLichTaoHo: null,
  isLichThamGia: null,
  isLichThuHoi: null,
  isLichTuChoi: null,
  isLichYeuCauChuanBi: null,
  isPublish: null,
);

