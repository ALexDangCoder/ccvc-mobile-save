import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_lich_lam_viec_request.g.dart';

@JsonSerializable()
class DanhSachLichLamViecRequest extends Equatable {
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
  bool? isChoXacNhan;
  bool? isChuaCoBaoCao;
  bool? isDaCoBaoCao;
  String? ListUserId;

  DanhSachLichLamViecRequest({
    required this.DateFrom,
    required this.DateTo,
    required this.UserId,
    required this.DonViId,
    this.IsLichLanhDao,
    required this.PageIndex,
    required this.PageSize,
    this.Title,
    required this.isLichCuaToi,
    this.isLichDuocMoi,
    this.isLichHuyBo,
    this.isLichTaoHo,
    this.isLichThamGia,
    this.isLichThuHoi,
    this.isLichTuChoi,
    this.isPublish,
    this.isChoXacNhan,
    this.isChuaCoBaoCao,
    this.isDaCoBaoCao,
    this.ListUserId,
  });

  factory DanhSachLichLamViecRequest.fromJson(Map<String, dynamic> json) =>
      _$DanhSachLichLamViecRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachLichLamViecRequestToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

DanhSachLichLamViecRequest dataBodyRequetDanhSachLLV =
    DanhSachLichLamViecRequest(
  DateFrom: "2022-02-11",
  DateTo: "2022-02-11",
  DonViId: "0bf3b2c3-76d7-4e05-a587-9165c3624d76",
  IsLichLanhDao: null,
  PageIndex: 1,
  PageSize: 10,
  Title: null,
  UserId: "39227131-3db7-48f8-a1b2-57697430cc69",
  isChoXacNhan: null,
  isChuaCoBaoCao: null,
  isDaCoBaoCao: null,
  isLichCuaToi: null,
  isLichDuocMoi: null,
  ListUserId: null,
  isLichHuyBo: null,
  isLichTaoHo: null,
  isLichThamGia: null,
  isLichThuHoi: null,
  isLichTuChoi: null,
  isPublish: null,
);
