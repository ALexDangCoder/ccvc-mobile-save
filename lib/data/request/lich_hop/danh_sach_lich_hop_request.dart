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
     this.DateFrom,
     this.DateTo,
     this.UserId,
     this.DonViId,
     this.IsLichLanhDao,
     this.PageIndex,
     this.PageSize,
     this.Title,
     this.isLichCuaToi,
     this.isLichDuocMoi,
     this.isLichHuyBo,
     this.isLichTaoHo,
     this.isLichThamGia,
     this.isLichThuHoi,
     this.isLichTuChoi,
     this.isPublish,
     this.isDuyetLich,
     this.isDuyetThietBi,
     this.isLichYeuCauChuanBi,
     this.isChuaCoBaoCao,
     this.isDaCoBaoCao,
     this.isChoXacNhan,
     this.isDuyetPhong,
  });

  factory DanhSachLichHopRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLichHopRequestToJson(this);
}