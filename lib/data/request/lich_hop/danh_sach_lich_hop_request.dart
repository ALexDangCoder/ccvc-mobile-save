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
  bool? isLichDonVi;
  bool? isPreviewPhong;
  bool? isChuaChuanBi;
  bool? isDaChuanBi;
  bool? isDuyetKyThuat;
  int? trangThaiDuyetKyThuat;

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
    this.isLichDonVi,
    this.isPreviewPhong,
    this.isChuaChuanBi,
    this.isDaChuanBi,
    this.isDuyetKyThuat,
    this.trangThaiDuyetKyThuat,
  });

  factory DanhSachLichHopRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichHopRequestFromJson(json);

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> json = {
      'DateFrom': DateFrom,
      'DateTo': DateTo,
      'UserId': UserId,
      'DonViId': DonViId,
      'IsLichLanhDao': IsLichLanhDao,
      'PageIndex': PageIndex,
      'Title': Title,
      'isLichCuaToi': isLichCuaToi,
      'isLichDuocMoi': isLichDuocMoi,
      'isLichHuyBo': isLichHuyBo,
      'isLichTaoHo': isLichTaoHo,
      'isLichThamGia': isLichThamGia,
      'isLichThuHoi': isLichThuHoi,
      'isLichTuChoi': isLichTuChoi,
      'isPublish': isPublish,
      'isDuyetLich': isDuyetLich,
      'isDuyetThietBi': isDuyetThietBi,
      'isLichYeuCauChuanBi': isLichYeuCauChuanBi,
      'isChuaCoBaoCao': isChuaCoBaoCao,
      'isDaCoBaoCao': isDaCoBaoCao,
      'isChoXacNhan': isChoXacNhan,
      'isDuyetPhong': isDuyetPhong,
      'isLichDonVi': isLichDonVi,
      'isPreviewPhong': isPreviewPhong,
      'isChuaChuanBi': isChuaChuanBi,
      'isDaChuanBi': isDaChuanBi,
      'isDuyetKyThuat': isDuyetKyThuat,
      'trangThaiDuyetKyThuat': trangThaiDuyetKyThuat,
    };
    if(PageSize != null){
      json.putIfAbsent('PageSize', () => PageSize);
    }
    return json;
  }
}
