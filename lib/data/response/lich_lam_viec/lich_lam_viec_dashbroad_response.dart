import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_lam_viec_dashbroad_response.g.dart';

@JsonSerializable()
class LichLamViecDashBroadResponse {
  @JsonKey(name: 'data')
  DataLichLamViecResponse? data;

  LichLamViecDashBroadResponse(this.data);

  factory LichLamViecDashBroadResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LichLamViecDashBroadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichLamViecDashBroadResponseToJson(this);
}

@JsonSerializable()
class DataLichLamViecResponse {
  @JsonKey(name: 'countScheduleCaNhan')
  int? countScheduleCaNhan;
  @JsonKey(name: 'soLichCanBaoCao')
  int? soLichCanBaoCao;
  @JsonKey(name: 'soLichCanChuTriDuyetCho')
  int? soLichCanChuTriDuyetCho;
  @JsonKey(name: 'soLichChoXacNhan')
  int? soLichChoXacNhan;
  @JsonKey(name: 'soLichChuTri')
  int? soLichChuTri;
  @JsonKey(name: 'soLichChuTriDaDuyet')
  int? soLichChuTriDaDuyet;
  @JsonKey(name: 'soLichChuTriTuChoi')
  int? soLichChuTriTuChoi;
  @JsonKey(name: 'soLichChuaCoBaoCao')
  int? soLichChuaCoBaoCao;
  @JsonKey(name: 'soLichChuaThucHienYC')
  int? soLichChuaThucHienYC;
  @JsonKey(name: 'soLichCoBaoCaoChoDuyet')
  int? soLichCoBaoCaoChoDuyet;
  @JsonKey(name: 'soLichCoBaoCaoDaDuyet')
  int? soLichCoBaoCaoDaDuyet;
  @JsonKey(name: 'soLichCoBaoCaoTuChoi')
  int? soLichCoBaoCaoTuChoi;
  @JsonKey(name: 'soLichDaThucHienYC')
  int? soLichDaThucHienYC;
  @JsonKey(name: 'soLichDuyetPhongCho')
  int? soLichDuyetPhongCho;
  @JsonKey(name: 'soLichDuyetPhongTuChoi')
  int? soLichDuyetPhongTuChoi;
  @JsonKey(name: 'soLichDuyetPhongXacNhan')
  int? soLichDuyetPhongXacNhan;
  @JsonKey(name: 'soLichDuyetThietBiCho')
  int? soLichDuyetThietBiCho;
  @JsonKey(name: 'soLichDuyetThietBiTuChoi')
  int? soLichDuyetThietBiTuChoi;
  @JsonKey(name: 'soLichDuyetThietBiXacNhan')
  int? soLichDuyetThietBiXacNhan;
  @JsonKey(name: 'soLichHuyBo')
  int? soLichHuyBo;
  @JsonKey(name: 'soLichPreviewPhong')
  int? soLichPreviewPhong;
  @JsonKey(name: 'soLichSapToi')
  int? soLichSapToi;
  @JsonKey(name: 'soLichTaoHo')
  int? soLichTaoHo;
  @JsonKey(name: 'soLichThamGia')
  int? soLichThamGia;
  @JsonKey(name: 'soLichThuHoi')
  int? soLichThuHoi;
  @JsonKey(name: 'soLichTrung')
  int? soLichTrung;
  @JsonKey(name: 'soLichTuChoi')
  int? soLichTuChoi;
  @JsonKey(name: 'tongLichDuocMoi')
  int? tongLichDuocMoi;
  @JsonKey(name: 'tongSoLichCoBaoCao')
  int? tongSoLichCoBaoCao;
  @JsonKey(name: 'tongSoLichCoYeuCau')
  int? tongSoLichCoYeuCau;
  @JsonKey(name: 'tongSoLichDuyetCuaChuTri')
  int? tongSoLichDuyetCuaChuTri;
  @JsonKey(name: 'tongSoLichDuyetPhong')
  int? tongSoLichDuyetPhong;
  @JsonKey(name: 'tongSoLichDuyetThietBi')
  int? tongSoLichDuyetThietBi;
  @JsonKey(name: 'soLichChoDuyetKyThuat')
  int? soLichChoDuyetKyThuat;
  @JsonKey(name: 'soLichTuChoiDuyetKyThuat')
  int? soLichTuChoiDuyetKyThuat;
  @JsonKey(name: 'soLichDaDuyetKyThuat')
  int? soLichDaDuyetKyThuat;

//

  DataLichLamViecResponse();

  factory DataLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLichLamViecResponseToJson(this);

  List<Object?> get props => throw [];

  DashBoardLichHopModel toDomain() => DashBoardLichHopModel(
        countScheduleCaNhan: countScheduleCaNhan,
        soLichCanBaoCao: soLichCanBaoCao,
        soLichCanChuTriDuyetCho: soLichCanChuTriDuyetCho,
        soLichChoXacNhan: soLichChoXacNhan,
        soLichChuTri: soLichChuTri,
        soLichChuTriDaDuyet: soLichChuTriDaDuyet,
        soLichChuTriTuChoi: soLichChuTriTuChoi,
        soLichChuaCoBaoCao: soLichChuaCoBaoCao,
        soLichChuaThucHienYC: soLichChuaThucHienYC,
        soLichCoBaoCaoChoDuyet: soLichCoBaoCaoChoDuyet,
        soLichCoBaoCaoDaDuyet: soLichCoBaoCaoDaDuyet,
        soLichCoBaoCaoTuChoi: soLichCoBaoCaoTuChoi,
        soLichDaThucHienYC: soLichDaThucHienYC,
        soLichDuyetPhongCho: soLichDuyetPhongCho,
        soLichDuyetPhongTuChoi: soLichDuyetPhongTuChoi,
        soLichDuyetPhongXacNhan: soLichDuyetPhongXacNhan,
        soLichDuyetThietBiCho: soLichDuyetThietBiCho,
        soLichDuyetThietBiTuChoi: soLichDuyetThietBiTuChoi,
        soLichDuyetThietBiXacNhan: soLichDuyetThietBiXacNhan,
        soLichHuyBo: soLichHuyBo,
        soLichPreviewPhong: soLichPreviewPhong,
        soLichSapToi: soLichSapToi,
        soLichTaoHo: soLichTaoHo,
        soLichThamGia: soLichThamGia,
        soLichThuHoi: soLichThuHoi,
        soLichTrung: soLichTrung,
        soLichTuChoi: soLichTuChoi,
        tongLichDuocMoi: tongLichDuocMoi,
        tongSoLichCoBaoCao: tongSoLichCoBaoCao,
        tongSoLichCoYeuCau: tongSoLichCoYeuCau,
        tongSoLichDuyetCuaChuTri: tongSoLichDuyetCuaChuTri,
        tongSoLichDuyetPhong: tongSoLichDuyetPhong,
        tongSoLichDuyetThietBi: tongSoLichDuyetThietBi,
        tongSoLichDuyetKyThuat: 0,
        soLichChoDuyetKyThuat: soLichChoDuyetKyThuat,
        soLichTuChoiDuyetKyThuat: soLichTuChoiDuyetKyThuat,
        soLichDaDuyetKyThuat: soLichDaDuyetKyThuat,
      );
}
