import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/document/luong_xu_ly_vb_di.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chi_tiet_van_ban_den_response.dart';

part 'chi_tiet_van_ban_di_response.g.dart';

@JsonSerializable()
class ChiTietVanBanDiDataResponse {
  @JsonKey(name: 'Data')
  ChiTietVanBanDiResponse? data;

  ChiTietVanBanDiDataResponse(this.data);

  factory ChiTietVanBanDiDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ChiTietVanBanDiDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietVanBanDiDataResponseToJson(this);
}

@JsonSerializable()
class YKienXuLyResponse {
  @JsonKey(name: 'Data')
  List<DanhSachChoYKienResponse>? danhSachChoYKien;

  YKienXuLyResponse(this.danhSachChoYKien);

  factory YKienXuLyResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$YKienXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YKienXuLyResponseToJson(this);
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
  int? loaiNguonDuLieu;
  @JsonKey(name: 'TenNguoiSoanThao')
  String? tenNguoiSoanThao;
  @JsonKey(name: 'DonViSoanThao')
  String? donViSoanThao;
  @JsonKey(name: 'DonViBanHanh')
  String? donViBanHanh;
  @JsonKey(name: 'IdVanBanGoc')
  String? idVanBanGoc;
  @JsonKey(name: 'KyHieuVanBanGoc')
  String? kyHieuVanBanGoc;
  @JsonKey(name: 'IsDaKyPhieuTrinh')
  bool? isDaKyPhieuTrinh;
  @JsonKey(name: 'DonViTrongHeThongs')
  List<DonViTrongHeThongsResponse>? donViTrongHeThongs;
  @JsonKey(name: 'DonViNgoaiHeThongs')
  List<DonViNgoaiHeThongsResponse>? donViNgoaiHeThongs;
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
  List<VanBanDenResponse>? vanBanDenResponses;
  @JsonKey(name: 'VanBanChiDaoResponses')
  List<VanBanChiDaoResponse>? vanBanChiDaoResponses;
  @JsonKey(name: 'NguoiTheoDoiResponses')
  List<NguoiTheoDoiResponse>? nguoiTheoDoiResponses;
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
  @JsonKey(name: 'MaTrangThai')
  String? maTrangThai;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'FileDinhKemVanBanDiResponses')
  List<FileDinhKemVanBanDiResponse>? fileDinhKemVanBanDiResponses;

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
    this.donViTrongHeThongs,
    this.donViNgoaiHeThongs,
    this.idDoKhan,
    this.doKhan,
    this.issuedAmount,
    this.maTrangThai,
    this.trangThai,
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
        subject: subject?.parseHtml(),
        dueDate: dueDate == null
            ? ''
            : DateTime.parse(dueDate ?? '').toStringWithListFormat,
        ngayTao: ngayTao,
        ngayBanHanh: ngayBanHanh,
        trangThai:  trangThai,
        maTrangThai:  maTrangThai,
        loaiNguonDuLieu: loaiNguonDuLieu,
        tenNguoiSoanThao: tenNguoiSoanThao,
        donViSoanThao: donViSoanThao,
        donViBanHanh: donViBanHanh,
        idVanBanGoc: idVanBanGoc,
        kyHieuVanBanGoc: kyHieuVanBanGoc,
        isDaKyPhieuTrinh: isDaKyPhieuTrinh,
        donViTrongHeThongs:
            donViTrongHeThongs?.map((e) => e.toModel()).toList() ?? [],
        donViNgoaiHeThongs:
            donViNgoaiHeThongs?.map((e) => e.toModel()).toList() ?? [],
        idDoKhan: idDoKhan,
        doKhan: doKhan,
        issuedAmount: issuedAmount,
        isLaVanBanTraLoi: isLaVanBanTraLoi,
        isVanBanQppl: isVanBanQppl,
        isVanBanDiBanHanh: isVanBanDiBanHanh,
        isVanBanChiDao: isVanBanChiDao,
        vanBanDenResponses:
            vanBanDenResponses?.map((e) => e.toModel()).toList() ?? [],
        vanBanChiDaoResponses:
            vanBanChiDaoResponses?.map((e) => e.toModel()).toList() ?? [],
        nguoiTheoDoiResponses:
            nguoiTheoDoiResponses?.map((e) => e.toModel()).toList() ?? [],
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
class VanBanChiDaoResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IdDonViCaNhan')
  String? idDonViCaNhan;
  @JsonKey(name: 'TenDonViCaNhan')
  String? tenDonViCaNhan;
  @JsonKey(name: 'IsDonVi')
  bool? isDonVi;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NgayXuLy')
  String? ngayXuLy;

  VanBanChiDaoResponse({
    this.id,
    this.idDonViCaNhan,
    this.tenDonViCaNhan,
    this.isDonVi,
    this.noiDung,
    this.ngayXuLy,
  });

  factory VanBanChiDaoResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$VanBanChiDaoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VanBanChiDaoResponseToJson(this);

  VanBanChiDaoModel toModel() => VanBanChiDaoModel(
        id: id ?? '',
        idDonViCaNhan: idDonViCaNhan ?? '',
        tenDonViCaNhan: tenDonViCaNhan ?? '',
        isDonVi: isDonVi ?? false,
        noiDung: noiDung ?? '',
        ngayXuLy: ngayXuLy ?? '',
      );
}

@JsonSerializable()
class VanBanDenResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IsKhongTuDongHoanThanh')
  bool? isKhongTuDongHoanThanh;
  @JsonKey(name: 'SoDen')
  String? soDen;
  @JsonKey(name: 'SoKyHieu')
  String? soKyHieu;
  @JsonKey(name: 'DonViBanHanh')
  String? donViBanHanh;
  @JsonKey(name: 'TrichYeu')
  String? trichYeu;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'Files')
  List<FileDinhKemVanBanDenResponse>? files;

  VanBanDenResponse({
    this.id,
    this.isKhongTuDongHoanThanh,
    this.soDen,
    this.soKyHieu,
    this.donViBanHanh,
    this.trichYeu,
    this.files,
    this.hanXuLy
  });

  factory VanBanDenResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$VanBanDenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VanBanDenResponseToJson(this);

  VanBanDenModel toModel() => VanBanDenModel(
        id: id,
        isKhongTuDongHoanThanh: isKhongTuDongHoanThanh,
        soDen: soDen,
        soKyHieu: soKyHieu,
        donViBanHanh: donViBanHanh,
        hanXuLy: hanXuLy,
        trichYeu: trichYeu?.parseHtml() ?? '',
        files: files?.map((e) => e.toModel().toFileDinhKemModel()).toList() ?? [],
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
  @JsonKey(name: 'ChucVu')
  String? chucVu;
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
    this.chucVu,
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
        vaiTro: LuongXuLyVBDiModel.getLoaiBanHanh(loaiBanHanh).title,
        chucVu: chucVu,
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

@JsonSerializable()
class NguoiTheoDoiResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'HoTen')
  String? hoTen;
  @JsonKey(name: 'DonVi')
  String? donVi;
  @JsonKey(name: 'ChucVu')
  String? chucVu;
  @JsonKey(name: 'IdChucVu')
  String? idChucVu;
  @JsonKey(name: 'IdDonVi')
  String? idDonVi;
  @JsonKey(name: 'TenTaiKhoan')
  String? tenTaiKhoan;
  @JsonKey(name: 'Sdt')
  String? sdt;
  @JsonKey(name: 'NgaySinh')
  String? ngaySinh;
  @JsonKey(name: 'GioiTinh')
  String? gioiTinh;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'PathAnhDaiDien')
  String? pathAnhDaiDien;
  @JsonKey(name: 'PathChuKy')
  String? pathChuKy;
  @JsonKey(name: 'User')
  String? user;
  @JsonKey(name: 'AnhDaiDien')
  String? anhDaiDien;
  @JsonKey(name: 'AnhChuKy')
  String? anhChuKy;

  NguoiTheoDoiResponse({
    this.id,
    this.hoTen,
    this.donVi,
    this.chucVu,
    this.idChucVu,
    this.idDonVi,
    this.tenTaiKhoan,
    this.sdt,
    this.ngaySinh,
    this.gioiTinh,
    this.email,
    this.pathAnhDaiDien,
    this.pathChuKy,
    this.user,
    this.anhDaiDien,
    this.anhChuKy,
  });

  factory NguoiTheoDoiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NguoiTheoDoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiTheoDoiResponseToJson(this);

  NguoiTheoDoi toModel() => NguoiTheoDoi(
        id: id,
        hoTen: hoTen,
        donVi: donVi,
        chucVu: chucVu,
        idChucVu: idChucVu,
        idDonVi: idDonVi,
        tenTaiKhoan: tenTaiKhoan,
        sdt: sdt,
        ngaySinh: ngaySinh,
        gioiTinh: gioiTinh,
        email: email,
        pathAnhDaiDien: pathAnhDaiDien,
        pathChuKy: pathChuKy,
        user: user,
        anhDaiDien: anhDaiDien,
        anhChuKy: anhChuKy,
      );
}

@JsonSerializable()
class DonViTrongHeThongsResponse {
  @JsonKey(name: 'TrangThaiBanHanh')
  int? trangThaiBanHanh;
  @JsonKey(name: 'IsPhaiGuiBanGiay')
  bool? isPhaiGuiBanGiay;
  @JsonKey(name: 'IsTrangThaiLienThong')
  bool? isTrangThaiLienThong;
  @JsonKey(name: 'IdDonViCanBo')
  String? idDonViCanBo;
  @JsonKey(name: 'IsDonVi')
  bool? isDonVi;
  @JsonKey(name: 'ThuTu')
  int? thuTu;
  @JsonKey(name: 'Ten')
  String? ten;

  DonViTrongHeThongsResponse({
    this.trangThaiBanHanh,
    this.isPhaiGuiBanGiay,
    this.isTrangThaiLienThong,
    this.idDonViCanBo,
    this.isDonVi,
    this.thuTu,
    this.ten,
  });

  factory DonViTrongHeThongsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DonViTrongHeThongsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonViTrongHeThongsResponseToJson(this);

  DonViTrongHeThongs toModel() => DonViTrongHeThongs(
        trangThaiBanHanh: trangThaiBanHanh,
        isPhaiGuiBanGiay: isPhaiGuiBanGiay,
        isTrangThaiLienThong: isTrangThaiLienThong,
        idDonViCanBo: idDonViCanBo,
        isDonVi: isDonVi,
        thuTu: thuTu,
        ten: ten,
      );
}

@JsonSerializable()
class DonViNgoaiHeThongsResponse {
  @JsonKey(name: 'TrangThaiBanHanh')
  int? trangThaiBanHanh;
  @JsonKey(name: 'IsPhaiGuiBanGiay')
  bool? isPhaiGuiBanGiay;
  @JsonKey(name: 'IsTrangThaiLienThong')
  bool? isTrangThaiLienThong;
  @JsonKey(name: 'IdDonViCanBo')
  String? idDonViCanBo;
  @JsonKey(name: 'IsDonVi')
  bool? isDonVi;
  @JsonKey(name: 'ThuTu')
  int? thuTu;
  @JsonKey(name: 'Ten')
  String? ten;

  DonViNgoaiHeThongsResponse({
    this.trangThaiBanHanh,
    this.isPhaiGuiBanGiay,
    this.isTrangThaiLienThong,
    this.idDonViCanBo,
    this.isDonVi,
    this.thuTu,
    this.ten,
  });

  factory DonViNgoaiHeThongsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DonViNgoaiHeThongsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonViNgoaiHeThongsResponseToJson(this);

  DonViNgoaiHeThongs toModel() => DonViNgoaiHeThongs(
        trangThaiBanHanh: trangThaiBanHanh,
        isPhaiGuiBanGiay: isPhaiGuiBanGiay,
        isTrangThaiLienThong: isTrangThaiLienThong,
        idDonViCanBo: idDonViCanBo,
        isDonVi: isDonVi,
        thuTu: thuTu,
        ten: ten,
      );
}

@JsonSerializable()
class DanhSachChoYKienResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'ChucVu')
  String? chucVu;
  @JsonKey(name: 'User')
  String? user;
  @JsonKey(name: 'TenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'IdCanBo')
  String? idCanBo;
  @JsonKey(name: 'IdCanBoXinYKien')
  String? idCanBoXinYKien;
  @JsonKey(name: 'TenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'IdDonVi')
  String? idDonVi;
  @JsonKey(name: 'IdParrent')
  String? idParrent;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'Issuer')
  String? issuer;
  @JsonKey(name: 'SignerInfos')
  String? signerInfos;
  @JsonKey(name: 'SerialNumber')
  String? serialNumber;
  @JsonKey(name: 'AnhDaiDien')
  String? anhDaiDien;
  @JsonKey(name: 'AnhDaiDienCommon')
  String? anhDaiDienCommon;
  @JsonKey(name: 'DanhSachFiles')
  List<DanhSachFilesResponse>? danhSachFiles;
  @JsonKey(name: 'IsXinYKien')
  bool? isXinYKien;
  @JsonKey(name: 'IsCanXoa')
  bool? isCanXoa;
  @JsonKey(name: 'IsCanSuaXinYKien')
  bool? isCanSuaXinYKien;
  @JsonKey(name: 'IsNguoiDangNhapCoTheTraLoi')
  bool? isNguoiDangNhapCoTheTraLoi;
  @JsonKey(name: 'TraLois')
  List<DanhSachChoYKienResponse>? traLois;

  DanhSachChoYKienResponse({
    this.id,
    this.chucVu,
    this.user,
    this.tenCanBo,
    this.idCanBo,
    this.idCanBoXinYKien,
    this.tenDonVi,
    this.idDonVi,
    this.idParrent,
    this.noiDung,
    this.ngayTao,
    this.issuer,
    this.signerInfos,
    this.serialNumber,
    this.anhDaiDien,
    this.anhDaiDienCommon,
    this.danhSachFiles,
    this.isXinYKien,
    this.isCanXoa,
    this.isCanSuaXinYKien,
    this.isNguoiDangNhapCoTheTraLoi,
  });

  factory DanhSachChoYKienResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachChoYKienResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachChoYKienResponseToJson(this);

  DanhSachChoYKien toModel() => DanhSachChoYKien(
        id: id,
        chucVu: chucVu,
        user: user,
        tenCanBo: tenCanBo,
        idCanBo: idCanBo,
        idCanBoXinYKien: idCanBoXinYKien,
        tenDonVi: tenDonVi,
        idDonVi: idDonVi,
        idParrent: idParrent,
        noiDung: noiDung?.parseHtml(),
        ngayTao: ngayTao?.changeToNewPatternDate(
          DateTimeFormat.DATE_TIME_RECEIVE,
          DateTimeFormat.DATE_DD_MM_HM,
        ) ??
            '',
        issuer: issuer,
        signerInfos: signerInfos,
        serialNumber: serialNumber,
        anhDaiDien: anhDaiDien,
        anhDaiDienCommon: anhDaiDienCommon,
        danhSachFiles: danhSachFiles?.map((e) => e.toModel()).toList() ?? [],
        isXinYKien: isXinYKien,
        isCanXoa: isCanXoa,
        isCanSuaXinYKien: isCanSuaXinYKien,
        isNguoiDangNhapCoTheTraLoi: isNguoiDangNhapCoTheTraLoi,
        traLoi: traLois?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class DanhSachFilesResponse {
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IsSign')
  String? isSign;

  DanhSachFilesResponse({
    this.ten,
    this.id,
    this.isSign,
  });

  factory DanhSachFilesResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachFilesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachFilesResponseToJson(this);

  DanhSachFiles toModel() => DanhSachFiles(
        ten: ten,
        id: id,
        isSign: isSign,
      );
}
