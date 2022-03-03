import 'package:ccvc_mobile/generated/l10n.dart';

import 'document_detail_row.dart';

class ChiTietVanBanDenModel {
  String? vanBanId;
  bool? isDonViTrong;
  String? taskId;
  String? taskParentId;
  String? soVanBanId;
  String? soVanBan;
  String? donViNgoaiId;
  String? donViTrongId;
  String? donViBanHanh;
  String? donViVaoSoLanDauId;
  int? soDen;
  int? soPhu;
  String? loaiVanBanId;
  String? loaiVanBan;
  String? soKyHieu;
  String? ngayBanHanh;
  String? ngayDen;
  String? trichYeu;
  bool? isChuyenCaBi;
  bool? isLanhDao;
  bool? isThuTruongDonVi;
  String? doKhanId;
  String? doKhan;
  String? ngayHanXuLy;
  String? hanXuLy;
  String? fileDinhKemIds;
  List<FileDinhKemsVanBanDen>? fileDinhKems;
  String? nguoiKy;
  int? soBan;
  int? soTrang;
  String? phuongThucNhanVanBanId;
  String? phuongThucNhan;
  bool? isQPPL;
  bool? isHoiBao;
  bool? isNhanBanGiay;
  String? ngayNhanBanGiay;
  bool? coTheCapNhatTrangThai;
  String? trangThaiId;
  String? maTrangThai;
  bool? coTheXoa;
  String? ownerTypeCode;
  bool? coTheCapNhat;
  bool? coTheSua;
  bool? coThePhanXuLy;
  bool? coTheTraLai;
  bool? coTheThuHoi;
  String? nguoiTaoId;
  bool? isChoYKien;
  bool? isDaChoYKien;
  bool? isNhanDeBiet;
  bool? choPhepThaoTac;
  String? parentOwnerTaskId;
  String? lanhDaoId;
  bool? isReadOnlyTaskAssignment;
  bool? coTheTuChoi;
  bool? isTrucVanBan;
  String? maPAKN;
  bool? coTheNhanDaXem;
  bool? coTheVaoSo;
  bool? coTheTaoDuThao;
  bool? coTheTaoPAKN;
  bool? coTheXinYKien;
  bool? coTheSaoChep;

  ChiTietVanBanDenModel({
    this.vanBanId,
    this.isDonViTrong,
    this.taskId,
    this.taskParentId,
    this.soVanBanId,
    this.soVanBan,
    this.donViNgoaiId,
    this.donViTrongId,
    this.donViBanHanh,
    this.donViVaoSoLanDauId,
    this.soDen,
    this.soPhu,
    this.loaiVanBanId,
    this.loaiVanBan,
    this.soKyHieu,
    this.ngayBanHanh,
    this.ngayDen,
    this.trichYeu,
    this.isChuyenCaBi,
    this.isLanhDao,
    this.isThuTruongDonVi,
    this.doKhanId,
    this.doKhan,
    this.ngayHanXuLy,
    this.hanXuLy,
    this.fileDinhKemIds,
    this.fileDinhKems,
    this.nguoiKy,
    this.soBan,
    this.soTrang,
    this.phuongThucNhanVanBanId,
    this.phuongThucNhan,
    this.isQPPL,
    this.isHoiBao,
    this.isNhanBanGiay,
    this.ngayNhanBanGiay,
    this.coTheCapNhatTrangThai,
    this.trangThaiId,
    this.maTrangThai,
    this.coTheXoa,
    this.ownerTypeCode,
    this.coTheCapNhat,
    this.coTheSua,
    this.coThePhanXuLy,
    this.coTheTraLai,
    this.coTheThuHoi,
    this.nguoiTaoId,
    this.isChoYKien,
    this.isDaChoYKien,
    this.isNhanDeBiet,
    this.choPhepThaoTac,
    this.parentOwnerTaskId,
    this.lanhDaoId,
    this.isReadOnlyTaskAssignment,
    this.coTheTuChoi,
    this.isTrucVanBan,
    this.maPAKN,
    this.coTheNhanDaXem,
    this.coTheVaoSo,
    this.coTheTaoDuThao,
    this.coTheTaoPAKN,
    this.coTheXinYKien,
    this.coTheSaoChep,
  });

  List<DocumentDetailRow> toListRow() {
    final List<DocumentDetailRow> list = [
      DocumentDetailRow(
        S.current.so_van_ban,
        soVanBan,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.so_den,
        soDen,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(S.current.so_phu, soPhu, TypeDocumentDetailRow.text),
      DocumentDetailRow(
        S.current.noi_gui,
        donViBanHanh,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.loai_van_ban,
        loaiVanBan,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.so_ky_hieu,
        soKyHieu,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ngay_ban_hanh,
        ngayBanHanh,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ngay_den,
        ngayDen,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.do_khan,
        doKhan,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ngay_han_xu_ly,
        ngayHanXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.han_xu_ly,
        hanXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguoi_ky,
        nguoiKy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(S.current.so_ban, soBan, TypeDocumentDetailRow.text),
      DocumentDetailRow(
        S.current.so_trang,
        soTrang,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.phuong_thuc_nhan,
        phuongThucNhan,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.trich_yeu,
        trichYeu,
        TypeDocumentDetailRow.text,
      ),
    ];

    return list;
  }

  List<DocumentDetailRow> toListCheckBox() {
    final List<DocumentDetailRow> listCheckbox = [
      DocumentDetailRow(S.current.van_ban_qppl, isQPPL ?? false,
          TypeDocumentDetailRow.checkbox),
      DocumentDetailRow(
        S.current.hoi_bao_van_ban,
        isHoiBao ?? false,
        TypeDocumentDetailRow.checkbox,
      ),
      DocumentDetailRow(
        S.current.da_nhan_ban_giay,
        isNhanBanGiay ?? false,
        TypeDocumentDetailRow.checkbox,
      )
    ];

    return listCheckbox;
  }
}

class FileDinhKemsVanBanDen {
  int? sTT;
  String? id;
  String? idFileGoc;
  String? nguoiTaoId;
  String? processId;
  String? taskId;
  String? ten;
  String? duongDan;
  String? duoiMoRong;
  String? dungLuong;
  String? kieuDinhKem;
  bool? isSign;
  bool? isEdit;
  bool? qrCreated;
  int? index;
  String? ngayTao;

  FileDinhKemsVanBanDen({
    this.sTT,
    this.id,
    this.idFileGoc,
    this.nguoiTaoId,
    this.processId,
    this.taskId,
    this.ten,
    this.duongDan,
    this.duoiMoRong,
    this.dungLuong,
    this.kieuDinhKem,
    this.isSign,
    this.isEdit,
    this.qrCreated,
    this.index,
    this.ngayTao,
  });
}
