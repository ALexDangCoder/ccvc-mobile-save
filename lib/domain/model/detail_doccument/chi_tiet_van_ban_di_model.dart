import 'package:ccvc_mobile/generated/l10n.dart';

import 'document_detail_row.dart';

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
  String? loaiNguonDuLieu;
  String? tenNguoiSoanThao;
  String? donViSoanThao;
  String? donViBanHanh;
  int? idVanBanGoc;
  bool? isDaKyPhieuTrinh;
  String? idDoKhan;
  String? doKhan;
  int? issuedAmount;
  bool? isLaVanBanTraLoi;
  bool? isVanBanQppl;
  bool? isVanBanDiBanHanh;
  bool? isVanBanChiDao;
  String? vanBanDenResponses;
  String? vanBanChiDaoResponses;
  List<String>? nguoiTheoDoiResponses;
  List<NguoiKyDuyetModel>? nguoiKyDuyetResponses;
  String? nguoiKy;
  String? noiNhanTrongHeThong;
  String? noiNhanNgoaiHeThong;
  String? nhanDeBiet;
  List<FileDinhKemVanBanDiModel>? fileDinhKemVanBanDiResponses;
  List<String>? danhSachChoYKien;
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
    this.nguoiKyDuyetResponses,
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
  List<DocumentDetailRow> toListRow() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(S.current.so_van_ban,'soVanBan' , TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.so_den, 'soDen', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.so_phu, 'soPhu', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.noi_gui, 'noiGui', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.loai_van_ban, 'loaivanBan',TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.so_ky_hieu, 'soKyHieu', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.ngay_ban_hanh, ngayBanHanh, TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.ngay_den, 'ngayDen', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.do_khan, doKhan, TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.ngay_han_xu_ly, 'ngayHanXL', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.han_xu_ly,'han xu ly' , TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.nguoi_ky, nguoiKy, TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.so_ban, 'soBan', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.so_trang, 'soTrang', TypeDocumentDetailRow.text),
      DocumentDetailRow(
          S.current.phuong_thuc_nhan, 'phuongThucNhan', TypeDocumentDetailRow.text),
      DocumentDetailRow(S.current.trich_yeu, 'trichYeu', TypeDocumentDetailRow.text),
    ];

    return list;
  }


  List<DocumentDetailRow> toListCheckBox() {
    final List<DocumentDetailRow> listCheckbox = [
      DocumentDetailRow(
          S.current.van_ban_qppl, isVanBanQppl??false, TypeDocumentDetailRow.checkbox),
      DocumentDetailRow(
        S.current.hoi_bao_van_ban,
        isLaVanBanTraLoi??false,
        TypeDocumentDetailRow.checkbox,
      ),
      DocumentDetailRow(
        S.current.da_nhan_ban_giay,
        isVanBanChiDao??false,
        TypeDocumentDetailRow.checkbox,
      )
    ];

    return listCheckbox;
  }
}

class NguoiKyDuyetModel {
  String? id;
  String? idHost;
  String? tenNguoiKy;
  String? donViNguoiKy;
  String? vaiTro;
  int? loaiBanHanh;
  int? thuTu;
  String? idUser;

  NguoiKyDuyetModel({
    this.id,
    this.idHost,
    this.tenNguoiKy,
    this.donViNguoiKy,
    this.vaiTro,
    this.loaiBanHanh,
    this.thuTu,
    this.idUser,
  });
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
