import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_van_ban_di_response.g.dart';

@JsonSerializable()
class ChiTietVanBanDiDataResponse {
  @JsonKey(name: 'Data')
  ChiTietVanBanDiResponse data;

  ChiTietVanBanDiDataResponse(this.data);

  factory ChiTietVanBanDiDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChiTietVanBanDiDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietVanBanDiDataResponseToJson(this);
}

@JsonSerializable()
class ChiTietVanBanDiResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'ProcessType')
  String? processType;
  @JsonKey(name: 'MaPAKN')
  String? maPAKN;
  @JsonKey(name: 'ProcessTypeId')
  String? processTypeId;
  @JsonKey(name: 'FileNotation')
  String? fileNotation;
  @JsonKey(name: 'Subject')
  String? subject;
  @JsonKey(name: 'DueDate')
  String? dueDate;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'NgayBanHanh')
  String? ngayBanHanh;
  @JsonKey(name: 'LoaiNguonDuLieu')
  String? loaiNguonDuLieu;
  @JsonKey(name: 'TenNguoiSoanThao')
  String? tenNguoiSoanThao;
  @JsonKey(name: 'DonViSoanThao')
  String? donViSoanThao;
  @JsonKey(name: 'DonViBanHanh')
  String? donViBanHanh;
  @JsonKey(name: 'IdVanBanGoc')
  int? idVanBanGoc;
  @JsonKey(name: 'IsDaKyPhieuTrinh')
  bool? isDaKyPhieuTrinh;
  @JsonKey(name: 'IdDoKhan')
  String? idDoKhan;
  @JsonKey(name: 'DoKhan')
  String? doKhan;
  @JsonKey(name: 'IssuedAmount')
  int? issuedAmount;
  @JsonKey(name: 'IsLaVanBanTraLoi')
  bool? isLaVanBanTraLoi;
  @JsonKey(name: 'IsVanBanQppl')
  bool? isVanBanQppl;
  @JsonKey(name: 'IsVanBanDiBanHanh')
  bool? isVanBanDiBanHanh;
  @JsonKey(name: 'IsVanBanChiDao')
  bool? isVanBanChiDao;
  @JsonKey(name: 'VanBanDenResponses')
  String? vanBanDenResponses;
  @JsonKey(name: 'VanBanChiDaoResponses')
  String? vanBanChiDaoResponses;
  @JsonKey(name: 'NguoiTheoDoiResponses')
  List<String>? nguoiTheoDoiResponses;
  @JsonKey(name: 'NguoiKyDuyetResponses')
  List<NguoiKyDuyetDiResponse>? nguoiKyDuyetResponse;
  @JsonKey(name: 'NguoiKy')
  String? nguoiKy;
  @JsonKey(name: 'NoiNhanTrongHeThong')
  String? noiNhanTrongHeThong;
  @JsonKey(name: 'NoiNhanNgoaiHeThong')
  String? noiNhanNgoaiHeThong;
  @JsonKey(name: 'NhanDeBiet')
  String? nhanDeBiet;
  @JsonKey(name: 'FileDinhKemVanBanDiResponses')
  List<FileDinhKemVanBanDiResponse>? fileDinhKemVanBanDiResponses;
  @JsonKey(name: 'DanhSachChoYKien')
  List<String>? danhSachChoYKien;
  @JsonKey(name: 'IsCanTrinhKy')
  bool? isCanTrinhKy;
  @JsonKey(name: 'IsCanHuyTrinhKy')
  bool? isCanHuyTrinhKy;
  @JsonKey(name: 'IsCanThuHoiBanHanh')
  bool? isCanThuHoiBanHanh;
  @JsonKey(name: 'IsCanTraLai')
  bool? isCanTraLai;
  @JsonKey(name: 'IsCanDuyet')
  bool? isCanDuyet;
  @JsonKey(name: 'IsCanHuyDuyet')
  bool? isCanHuyDuyet;
  @JsonKey(name: 'IsCanCapSo')
  bool? isCanCapSo;
  @JsonKey(name: 'IsCanBanHanh')
  bool? isCanBanHanh;
  @JsonKey(name: 'IsCanSua')
  bool? isCanSua;
  @JsonKey(name: 'IsCanTrinhKyTiepTheo')
  bool? isCanTrinhKyTiepTheo;
  @JsonKey(name: 'IsCanBanHanhBoSung')
  bool? isCanBanHanhBoSung;
  @JsonKey(name: 'IsCanXoa')
  bool? isCanXoa;
  @JsonKey(name: 'IsCanChoYKien')
  bool? isCanChoYKien;
  @JsonKey(name: 'IsCanXinYKien')
  bool? isCanXinYKien;
  @JsonKey(name: 'IsScan')
  bool? isScan;
  @JsonKey(name: 'IsCanCopy')
  bool? isCanCopy;

  ChiTietVanBanDiResponse({
    this.id,
    this.processType,
    this.maPAKN,
    this.processTypeId,
    this.fileNotation,
    this.subject,
    this.dueDate,
    this.ngayTao,
    this.ngayBanHanh,
    this.loaiNguonDuLieu,
    this.tenNguoiSoanThao,
    this.donViSoanThao,
    this.donViBanHanh,
    this.idVanBanGoc,
    this.isDaKyPhieuTrinh,
    this.idDoKhan,
    this.doKhan,
    this.issuedAmount,
    this.isLaVanBanTraLoi,
    this.isVanBanQppl,
    this.isVanBanDiBanHanh,
    this.isVanBanChiDao,
    this.vanBanDenResponses,
    this.vanBanChiDaoResponses,
    this.nguoiTheoDoiResponses,
    this.nguoiKyDuyetResponse,
    this.nguoiKy,
    this.noiNhanTrongHeThong,
    this.noiNhanNgoaiHeThong,
    this.nhanDeBiet,
    this.fileDinhKemVanBanDiResponses,
    this.danhSachChoYKien,
    this.isCanTrinhKy,
    this.isCanHuyTrinhKy,
    this.isCanThuHoiBanHanh,
    this.isCanTraLai,
    this.isCanDuyet,
    this.isCanHuyDuyet,
    this.isCanCapSo,
    this.isCanBanHanh,
    this.isCanSua,
    this.isCanTrinhKyTiepTheo,
    this.isCanBanHanhBoSung,
    this.isCanXoa,
    this.isCanChoYKien,
    this.isCanXinYKien,
    this.isScan,
    this.isCanCopy,
  });

  factory ChiTietVanBanDiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChiTietVanBanDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietVanBanDiResponseToJson(this);

  ChiTietVanBanDiModel toModel() => ChiTietVanBanDiModel(
        id: id,
        processType: processType,
        maPAKN: maPAKN,
        processTypeId: processTypeId,
        fileNotation: fileNotation,
        subject: subject,
        dueDate: dueDate,
        ngayTao: ngayTao,
        ngayBanHanh: ngayBanHanh,
        loaiNguonDuLieu: loaiNguonDuLieu,
        tenNguoiSoanThao: tenNguoiSoanThao,
        donViSoanThao: donViSoanThao,
        donViBanHanh: donViBanHanh,
        idVanBanGoc: idVanBanGoc,
        isDaKyPhieuTrinh: isDaKyPhieuTrinh,
        idDoKhan: idDoKhan,
        doKhan: doKhan,
        issuedAmount: issuedAmount,
        isLaVanBanTraLoi: isLaVanBanTraLoi,
        isVanBanQppl: isVanBanQppl,
        isVanBanDiBanHanh: isVanBanDiBanHanh,
        isVanBanChiDao: isVanBanChiDao,
        vanBanDenResponses: vanBanDenResponses,
        vanBanChiDaoResponses: vanBanChiDaoResponses,
        nguoiTheoDoiResponses: nguoiTheoDoiResponses,
        nguoiKyDuyetResponses: nguoiKyDuyetResponse
                ?.map((e) => e.toModelNguoikyDuyet())
                .toList() ??
            [],
        nguoiKy: nguoiKy,
        noiNhanTrongHeThong: noiNhanTrongHeThong,
        noiNhanNgoaiHeThong: noiNhanNgoaiHeThong,
        nhanDeBiet: nhanDeBiet,
        fileDinhKemVanBanDiResponses: fileDinhKemVanBanDiResponses
                ?.map((e) => e.toModelFileDinhKemVanBanDi())
                .toList() ??
            [],
        danhSachChoYKien: danhSachChoYKien,
        isCanTrinhKy: isCanTrinhKy,
        isCanHuyTrinhKy: isCanHuyTrinhKy,
        isCanThuHoiBanHanh: isCanThuHoiBanHanh,
        isCanTraLai: isCanTraLai,
        isCanDuyet: isCanDuyet,
        isCanHuyDuyet: isCanHuyDuyet,
        isCanCapSo: isCanCapSo,
        isCanBanHanh: isCanBanHanh,
        isCanSua: isCanSua,
        isCanTrinhKyTiepTheo: isCanTrinhKyTiepTheo,
        isCanBanHanhBoSung: isCanBanHanhBoSung,
        isCanXoa: isCanXoa,
        isCanChoYKien: isCanChoYKien,
        isCanXinYKien: isCanXinYKien,
        isScan: isScan,
        isCanCopy: isCanCopy,
      );
}

@JsonSerializable()
class NguoiKyDuyetDiResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IdHost')
  String? idHost;
  @JsonKey(name: 'TenNguoiKy')
  String? tenNguoiKy;
  @JsonKey(name: 'DonViNguoiKy')
  String? donViNguoiKy;
  @JsonKey(name: 'VaiTro')
  String? vaiTro;
  @JsonKey(name: 'LoaiBanHanh')
  int? loaiBanHanh;
  @JsonKey(name: 'ThuTu')
  int? thuTu;
  @JsonKey(name: 'IdUser')
  String? idUser;

  NguoiKyDuyetDiResponse({
    this.id,
    this.idHost,
    this.tenNguoiKy,
    this.donViNguoiKy,
    this.vaiTro,
    this.loaiBanHanh,
    this.thuTu,
    this.idUser,
  });

  factory NguoiKyDuyetDiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NguoiKyDuyetDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiKyDuyetDiResponseToJson(this);

  NguoiKyDuyetModel toModelNguoikyDuyet() => NguoiKyDuyetModel(
        id: id,
        idHost: idHost,
        tenNguoiKy: tenNguoiKy,
        donViNguoiKy: donViNguoiKy,
        vaiTro: vaiTro,
        loaiBanHanh: loaiBanHanh,
        thuTu: thuTu,
        idUser: idUser,
      );
}

@JsonSerializable()
class FileDinhKemVanBanDiResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IdFileGoc')
  String? idFileGoc;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'IsSign')
  String? isSign;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'DuoiMoRong')
  String? duoiMoRong;
  @JsonKey(name: 'QrCreated')
  bool? qrCreated;
  @JsonKey(name: 'LoaiFileDinhKem')
  int? loaiFileDinhKem;

  FileDinhKemVanBanDiResponse({
    this.id,
    this.idFileGoc,
    this.ten,
    this.isSign,
    this.duongDan,
    this.duoiMoRong,
    this.qrCreated,
    this.loaiFileDinhKem,
  });

  factory FileDinhKemVanBanDiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$FileDinhKemVanBanDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileDinhKemVanBanDiResponseToJson(this);

  FileDinhKemVanBanDiModel toModelFileDinhKemVanBanDi() =>
      FileDinhKemVanBanDiModel(
        id: id,
        idFileGoc: idFileGoc,
        ten: ten,
        isSign: isSign,
        duongDan: duongDan,
        duoiMoRong: duoiMoRong,
        qrCreated: qrCreated,
        loaiFileDinhKem: loaiFileDinhKem,
      );
}
