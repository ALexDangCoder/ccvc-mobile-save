

class DanhSachLichLamViecRequest {
  String? DateFrom;
  String? Title;
  String? DateTo;
  String? UserId;
  String? DonViId;
  bool? IsLichLanhDao;
  int? PageIndex;
  int? PageSize;
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
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'DateFrom': DateFrom,
        'Title': Title,
        'DateTo': DateTo,
        'UserId': UserId,
        'DonViId': DonViId,
        'IsLichLanhDao': IsLichLanhDao,
        if (PageIndex!= null)'PageIndex': PageIndex,
        if (PageIndex!= null)'PageSize': PageSize,
        'isLichCuaToi': isLichCuaToi,
        'isLichDuocMoi': isLichDuocMoi,
        'isLichHuyBo': isLichHuyBo,
        'isLichTaoHo': isLichTaoHo,
        'isLichThamGia': isLichThamGia,
        'isLichThuHoi': isLichThuHoi,
        'isLichTuChoi': isLichTuChoi,
        'isPublish': isPublish,
        'isChoXacNhan': isChoXacNhan,
        'isChuaCoBaoCao': isChuaCoBaoCao,
        'isDaCoBaoCao': isDaCoBaoCao,
        'ListUserId': ListUserId,
      };

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
