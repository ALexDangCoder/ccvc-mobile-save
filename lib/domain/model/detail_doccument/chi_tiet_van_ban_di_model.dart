import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class ChiTietVanBanDiModel {
  String? id;
  String? processType;
  String? maPAKN;
  String? processTypeId;
  String? fileNotation;
  String? subject;
  String? dueDate;
  String? ngayTao;
  String? ngayBanHanh;
  int? loaiNguonDuLieu;
  String? tenNguoiSoanThao;
  String? donViSoanThao;
  String? donViBanHanh;
  String? idVanBanGoc;
  String? kyHieuVanBanGoc;
  bool? isDaKyPhieuTrinh;
  List<DonViTrongHeThongs>? donViTrongHeThongs;
  List<DonViNgoaiHeThongs>? donViNgoaiHeThongs;
  String? idDoKhan;
  String? doKhan;
  int? issuedAmount;
  bool? isLaVanBanTraLoi;
  bool? isVanBanQppl;
  bool? isVanBanDiBanHanh;
  bool? isVanBanChiDao;
  List<VanBanDenModel>? vanBanDenResponses;
  List<VanBanChiDaoModel>? vanBanChiDaoResponses;
  List<NguoiTheoDoi>? nguoiTheoDoiResponses;
  List<NguoiKyDuyetModel>? nguoiKyDuyetResponses;
  String? nguoiKy;
  String? noiNhanTrongHeThong;
  String? noiNhanNgoaiHeThong;
  String? nhanDeBiet;
  String? trangThai;
  String? maTrangThai;
  List<FileDinhKemVanBanDiModel>? fileDinhKemVanBanDiResponses;
  bool? isCanTrinhKy;
  bool? isCanHuyTrinhKy;
  bool? isCanThuHoiBanHanh;
  bool? isCanTraLai;
  bool? isCanDuyet;
  bool? isCanHuyDuyet;
  bool? isCanCapSo;
  bool? isCanBanHanh;
  bool? isCanSua;
  bool? isCanTrinhKyTiepTheo;
  bool? isCanBanHanhBoSung;
  bool? isCanXoa;
  bool? isCanChoYKien;
  bool? isCanXinYKien;
  bool? isScan;
  bool? isCanCopy;

  ChiTietVanBanDiModel({
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
    this.kyHieuVanBanGoc,
    this.isDaKyPhieuTrinh,
    this.idDoKhan,
    this.maTrangThai,
    this.trangThai,
    this.doKhan,
    this.issuedAmount,
    this.isLaVanBanTraLoi,
    this.isVanBanQppl,
    this.isVanBanDiBanHanh,
    this.isVanBanChiDao,
    this.vanBanDenResponses,
    this.vanBanChiDaoResponses,
    this.donViTrongHeThongs,
    this.donViNgoaiHeThongs,
    this.nguoiTheoDoiResponses,
    this.nguoiKyDuyetResponses,
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

  List<List<DocumentDetailRow>> toListRowHeadTablet() {
    return [
      <DocumentDetailRow>[
        DocumentDetailRow(
          S.current.loai_van_ban_di,
          vanBanBanhanh(),
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.nguoi_soan_thao,
          tenNguoiSoanThao ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.ngay_ban_hanh,
          ngayBanHanh ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.do_khan,
          doKhan ?? '',
          TypeDocumentDetailRow.priority,
        ),
      ],
      <DocumentDetailRow>[
        DocumentDetailRow(
          S.current.ma_pakn,
          maPAKN ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.loai_van_ban,
          processType ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.ngay_han_xl,
          dueDate ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.trang_thai,
          trangThai ?? '',
          TypeDocumentDetailRow.textStatus,
        ),
      ],
      <DocumentDetailRow>[
        DocumentDetailRow(
          S.current.dv_soan_thao,
          donViSoanThao ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.ky_hieu,
          fileNotation ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.so_ban,
          issuedAmount ?? '',
          TypeDocumentDetailRow.text,
        ),
      ],
    ];
  }

  List<DocumentDetailRow> toListRowHead() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.loai_van_ban_di,
        vanBanBanhanh(),
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ma_pakn,
        maPAKN ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.dv_soan_thao,
        donViSoanThao ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_soan_thao,
        tenNguoiSoanThao ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.loai_van_ban,
        processType ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ky_hieu,
        fileNotation ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.trich_yeu,
        subject ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ngay_ban_hanh,
        (ngayBanHanh ?? '').changeToNewPatternDate(
          DateFormatApp.dateTimeBackEnd,
          DateFormatApp.date,
        ),
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ngay_han_xl,
        dueDate ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.so_ban,
        issuedAmount ?? '',
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.do_khan,
        doKhan ?? '',
        TypeDocumentDetailRow.priority,
      ),
      DocumentDetailRow(
        S.current.trang_thai,
        trangThai ?? '',
        TypeDocumentDetailRow.textStatus,
      ),
    ];

    return list;
  }

  String vanBanBanhanh() {
    if (isVanBanDiBanHanh == true) {
      return S.current.van_ban_di_ban_hanh;
    } else if (isVanBanChiDao == true) {
      return S.current.van_ban_di_noi_bo;
    } else {
      return '';
    }
  }
}

class VanBanChiDaoModel {
  String id;
  String idDonViCaNhan;
  String tenDonViCaNhan;
  bool isDonVi;
  String noiDung;
  String ngayXuLy;

  VanBanChiDaoModel({
    this.id = '',
    this.idDonViCaNhan = '',
    this.tenDonViCaNhan = '',
    this.isDonVi = false,
    this.noiDung = '',
    this.ngayXuLy = '',
  });

  List<DocumentDetailRow> toListRowView() => [
        DocumentDetailRow(
          S.current.ten_don_vi_cheo_ca_nhan,
          tenDonViCaNhan,
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.just_noi_dung,
          noiDung,
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.ngay_han_xu_ly,
          ngayXuLy.changeToNewPatternDate(
              DateTimeFormat.DATE_TIME_HHT,
              DateTimeFormat.DAY_MONTH_YEAR,
          ),
          TypeDocumentDetailRow.text,
        ),
      ];
}

class VanBanDenModel {
  String? id;
  bool? isKhongTuDongHoanThanh;
  String? soDen;
  String? soKyHieu;
  String? donViBanHanh;
  String? trichYeu;
  String? hanXuLy;
  List<FileDinhKems>? files;

  VanBanDenModel({
    this.id,
    this.isKhongTuDongHoanThanh,
    this.soDen,
    this.soKyHieu,
    this.donViBanHanh,
    this.trichYeu,
    this.hanXuLy,
    this.files,
  });

  List<DocumentDetailRow> toListRowView() => [
        DocumentDetailRow(
          S.current.so_ky_hieu,
          soKyHieu ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.trich_yeu,
          trichYeu ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.don_vi_ban_hanh,
          donViBanHanh ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.ngay_han_xu_ly,
          hanXuLy ?? '',
          TypeDocumentDetailRow.text,
        ),
        DocumentDetailRow(
          S.current.file_dinh_kem,
          files ?? [],
          TypeDocumentDetailRow.fileActacks,
        ),
      ];
}

class NguoiKyDuyetModel {
  String? id;
  String? idHost;
  String? tenNguoiKy;
  String? donViNguoiKy;
  String? vaiTro;
  String? chucVu;
  int? loaiBanHanh;
  int? thuTu;
  String? idUser;

  NguoiKyDuyetModel({
    this.id,
    this.idHost,
    this.chucVu,
    this.tenNguoiKy,
    this.donViNguoiKy,
    this.vaiTro,
    this.loaiBanHanh ,
    this.thuTu,
    this.idUser,
  });

  List<DocumentDetailRow> toListRowKyDuyet() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
          S.current.ho_va_ten, tenNguoiKy ?? '', TypeDocumentDetailRow.text),
      DocumentDetailRow(
          S.current.don_vi, donViNguoiKy ?? '', TypeDocumentDetailRow.text),
      DocumentDetailRow(
          S.current.vai_tro, vaiTro ?? '', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.ban_hanh, vanBanBanhanh(loaiBanHanh ?? 0),
          TypeDocumentDetailRow.text),
    ];
    return list;
  }

  String vanBanBanhanh(int number) {
    switch (number) {
      case 0:
        return S.current.soan_thao;
      case 1:
        return S.current.ky_duyet;
      case 2:
        return S.current.ky_van_ban;
      case 3:
        return S.current.kiem_tra_the_thuc;
      case 4:
        return S.current.cap_so_ban_hanh;
    }
    return '';
  }
}

class FileDinhKemVanBanDiModel {
  String? id;
  String? idFileGoc;
  String? ten;
  String? isSign;
  String? duongDan;
  String? duoiMoRong;
  bool? qrCreated;
  int? loaiFileDinhKem;

  FileDinhKemVanBanDiModel({
    this.id,
    this.idFileGoc,
    this.ten,
    this.isSign,
    this.duongDan,
    this.duoiMoRong,
    this.qrCreated,
    this.loaiFileDinhKem,
  });
}

class DonViTrongHeThongs {
  int? trangThaiBanHanh;
  bool? isPhaiGuiBanGiay;
  bool? isTrangThaiLienThong;
  String? idDonViCanBo;
  bool? isDonVi;
  int? thuTu;
  String? ten;

  DonViTrongHeThongs({
    this.trangThaiBanHanh,
    this.isPhaiGuiBanGiay,
    this.isTrangThaiLienThong,
    this.idDonViCanBo,
    this.isDonVi,
    this.thuTu,
    this.ten,
  });
}

class DonViNgoaiHeThongs {
  int? trangThaiBanHanh;
  bool? isPhaiGuiBanGiay;
  bool? isTrangThaiLienThong;
  String? idDonViCanBo;
  bool? isDonVi;
  int? thuTu;
  String? ten;

  DonViNgoaiHeThongs(
      {this.trangThaiBanHanh,
      this.isPhaiGuiBanGiay,
      this.isTrangThaiLienThong,
      this.idDonViCanBo,
      this.isDonVi,
      this.thuTu,
      this.ten});
}

class NguoiTheoDoi {
  String? id;
  String? hoTen;
  String? donVi;
  String? chucVu;
  String? idChucVu;
  String? idDonVi;
  String? tenTaiKhoan;
  String? sdt;
  String? ngaySinh;
  String? gioiTinh;
  String? email;
  String? pathAnhDaiDien;
  String? pathChuKy;
  String? user;
  String? anhDaiDien;
  String? anhChuKy;

  NguoiTheoDoi(
      {this.id,
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
      this.anhChuKy});
}

class DanhSachChoYKien {
  String? id;
  String? chucVu;
  bool isInput = false;
  String? user;
  String? tenCanBo;
  String? idCanBo;
  String? idCanBoXinYKien;
  String? tenDonVi;
  String? idDonVi;
  String? idParrent;
  String? noiDung;
  String? ngayTao;
  String? issuer;
  String? signerInfos;
  String? serialNumber;
  String? anhDaiDien;
  String? anhDaiDienCommon;
  List<DanhSachFiles>? danhSachFiles;
  bool? isXinYKien;
  bool? isCanXoa;
  bool? isCanSuaXinYKien;
  bool? isNguoiDangNhapCoTheTraLoi;
  List<DanhSachChoYKien> traLoi;

  DanhSachChoYKien({
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
    required this.traLoi,
  });
}

class DanhSachFiles {
  String? ten;
  String? id;
  String? isSign;

  DanhSachFiles({
    this.ten,
    this.id,
    this.isSign,
  });
}
