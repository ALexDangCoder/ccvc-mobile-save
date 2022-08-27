import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_lh_response.g.dart';

@JsonSerializable()
class DashBoardLichHopResponse {
  @JsonKey(name: 'data')
  LichHopItemResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DashBoardLichHopResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DashBoardLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoardLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardLichHopResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichHopItemResponse {
  int? countScheduleCaNhan;
  int? soLichHuyBo;
  int? soLichTaoHo;
  int? soLichThuHoi;
  int? tongLichDuocMoi;
  int? soLichChoXacNhan;
  int? soLichThamGia;
  int? soLichTuChoi;
  int? soLichSapToi;
  int? soLichTrung;
  int? soLichCanBaoCao;
  int? tongSoLichDuyetPhong;
  int? soLichDuyetPhongCho;
  int? soLichDuyetPhongXacNhan;
  int? soLichDuyetPhongTuChoi;
  int? tongSoLichDuyetThietBi;
  int? soLichDuyetThietBiCho;
  int? soLichDuyetThietBiXacNhan;
  int? soLichDuyetThietBiTuChoi;
  int? tongSoLichDuyetCuaChuTri;
  int? soLichCanChuTriDuyetCho;
  int? soLichChuTriDaDuyet;
  int? soLichChuTriTuChoi;
  int? soLichChuaThucHienYC;
  int? soLichDaThucHienYC;
  int? tongSoLichCoYeuCau;
  int? soLichChuaCoBaoCao;
  int? soLichCoBaoCaoChoDuyet;
  int? soLichCoBaoCaoDaDuyet;
  int? soLichCoBaoCaoTuChoi;
  int? tongSoLichCoBaoCao;
  int? soLichPreviewPhong;
  int? soLichChuTri;
  int? tongSoLichDuyetKyThuat;
  int? soLichChoDuyetKyThuat;
  int? soLichDaDuyetKyThuat;
  int? soLichTuChoiDuyetKyThuat;
  int? soLichCanBaoCaoV2;

  LichHopItemResponse({
    this.countScheduleCaNhan,
    this.soLichHuyBo,
    this.soLichTaoHo,
    this.soLichThuHoi,
    this.tongLichDuocMoi,
    this.soLichChoXacNhan,
    this.soLichThamGia,
    this.soLichTuChoi,
    this.soLichSapToi,
    this.soLichTrung,
    this.soLichCanBaoCao,
    this.tongSoLichDuyetPhong,
    this.soLichDuyetPhongCho,
    this.soLichDuyetPhongXacNhan,
    this.soLichDuyetPhongTuChoi,
    this.tongSoLichDuyetThietBi,
    this.soLichDuyetThietBiCho,
    this.soLichDuyetThietBiXacNhan,
    this.soLichDuyetThietBiTuChoi,
    this.tongSoLichDuyetCuaChuTri,
    this.soLichCanChuTriDuyetCho,
    this.soLichChuTriDaDuyet,
    this.soLichChuTriTuChoi,
    this.soLichChuaThucHienYC,
    this.soLichDaThucHienYC,
    this.tongSoLichCoYeuCau,
    this.soLichChuaCoBaoCao,
    this.soLichCoBaoCaoChoDuyet,
    this.soLichCoBaoCaoDaDuyet,
    this.soLichCoBaoCaoTuChoi,
    this.tongSoLichCoBaoCao,
    this.soLichPreviewPhong,
    this.soLichChuTri,
    this.tongSoLichDuyetKyThuat,
    this.soLichChoDuyetKyThuat,
    this.soLichDaDuyetKyThuat,
    this.soLichTuChoiDuyetKyThuat,
    this.soLichCanBaoCaoV2,
  });

  factory LichHopItemResponse.fromJson(Map<String, dynamic> json) =>
      _$LichHopItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichHopItemResponseToJson(this);

  DashBoardLichHopModel toModel() => DashBoardLichHopModel(
        countScheduleCaNhan: countScheduleCaNhan,
        soLichHuyBo: soLichHuyBo,
        soLichTaoHo: soLichTaoHo,
        soLichThuHoi: soLichThuHoi,
        tongLichDuocMoi: tongLichDuocMoi,
        soLichChoXacNhan: soLichChoXacNhan,
        soLichThamGia: soLichThamGia,
        soLichTuChoi: soLichTuChoi,
        soLichSapToi: soLichSapToi,
        soLichTrung: soLichTrung,
        soLichCanBaoCao: soLichCanBaoCao,
        tongSoLichDuyetPhong: tongSoLichDuyetPhong,
        soLichDuyetPhongCho: soLichDuyetPhongCho,
        soLichDuyetPhongXacNhan: soLichDuyetPhongXacNhan,
        soLichDuyetPhongTuChoi: soLichDuyetPhongTuChoi,
        tongSoLichDuyetThietBi: tongSoLichDuyetThietBi,
        soLichDuyetThietBiCho: soLichDuyetThietBiCho,
        soLichDuyetThietBiXacNhan: soLichDuyetThietBiXacNhan,
        soLichDuyetThietBiTuChoi: soLichDuyetThietBiTuChoi,
        tongSoLichDuyetCuaChuTri: tongSoLichDuyetCuaChuTri,
        soLichCanChuTriDuyetCho: soLichCanChuTriDuyetCho,
        soLichChuTriDaDuyet: soLichChuTriDaDuyet,
        soLichChuTriTuChoi: soLichChuTriTuChoi,
        soLichChuaThucHienYC: soLichChuaThucHienYC,
        soLichDaThucHienYC: soLichDaThucHienYC,
        tongSoLichCoYeuCau: tongSoLichCoYeuCau,
        soLichChuaCoBaoCao: soLichChuaCoBaoCao,
        soLichCoBaoCaoChoDuyet: soLichCoBaoCaoChoDuyet,
        soLichCoBaoCaoDaDuyet: soLichCoBaoCaoDaDuyet,
        soLichCoBaoCaoTuChoi: soLichCoBaoCaoTuChoi,
        tongSoLichCoBaoCao: tongSoLichCoBaoCao,
        soLichPreviewPhong: soLichPreviewPhong,
        soLichChuTri: soLichChuTri,
        tongSoLichDuyetKyThuat: tongSoLichDuyetKyThuat,
        soLichChoDuyetKyThuat: soLichChoDuyetKyThuat,
        soLichDaDuyetKyThuat: soLichDaDuyetKyThuat,
        soLichTuChoiDuyetKyThuat: soLichTuChoiDuyetKyThuat,
        soLichCanKLCH: soLichCanBaoCao,
      );

}
