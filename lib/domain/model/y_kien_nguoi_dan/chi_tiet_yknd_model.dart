import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

enum DoiTuongType { CANHAN, DOANHNGHIEP, TOCHUC, COQUANNHANUOC }

class ChiTietYKNDDataModel {
  ChiTietYKNDModel chiTietYKNDModel;

  ChiTietYKNDDataModel({required this.chiTietYKNDModel});
}

class ChiTietYKNDModel {
  List<FileData> fileDinhKem;
  String taskFileDinhKem;
  String luongXuLy;
  String yKienChiDao;
  String task;
  String donViDuocPhanXuLy;
  bool isDuyet;
  bool isDraft;
  int linhVucId;
  String tenLuat;
  String phanLoaiPAKN;
  String soPAKN;
  String tieuDe;
  String noiDung;
  int nguonPAKNId;
  int luatId;
  int noiDungPAKNId;
  int linhVucPAKNId;
  String dSTaiLieuDinhKem;
  int doiTuongId;
  String tenNguoiPhanAnh;
  String cMTND;
  String email;
  String soDienThoai;
  String diaChi;
  int tinhId;
  int huyenId;
  int xaId;
  String donViXuLyId;
  int trangThai;
  String nguoiTaoId;
  String ngayNhan;
  String ngayPhanAnh;
  int noiTao;
  String diaChiChiTiet;
  String hanXuLy;
  String nguoiXuLyId;
  bool laPAKNChuyenLaiChoTiepNhan;
  bool laPAKNChuyenLaiChoChuyenXuLy;
  bool laPAKNChuyenLaiChoTiepNhanXuLy;
  String id;
  String thoiGianTaoMoi;
  String thoiGianCapNhat;
  String tenNguonPAKN;

  ChiTietYKNDModel(
    this.fileDinhKem,
    this.taskFileDinhKem,
    this.luongXuLy,
    this.yKienChiDao,
    this.task,
    this.donViDuocPhanXuLy,
    this.isDuyet,
    this.isDraft,
    this.linhVucId,
    this.tenLuat,
    this.phanLoaiPAKN,
    this.soPAKN,
    this.tieuDe,
    this.noiDung,
    this.nguonPAKNId,
    this.luatId,
    this.noiDungPAKNId,
    this.linhVucPAKNId,
    this.dSTaiLieuDinhKem,
    this.doiTuongId,
    this.tenNguoiPhanAnh,
    this.cMTND,
    this.email,
    this.soDienThoai,
    this.diaChi,
    this.tinhId,
    this.huyenId,
    this.xaId,
    this.donViXuLyId,
    this.trangThai,
    this.nguoiTaoId,
    this.ngayNhan,
    this.ngayPhanAnh,
    this.noiTao,
    this.diaChiChiTiet,
    this.hanXuLy,
    this.nguoiXuLyId,
    this.laPAKNChuyenLaiChoTiepNhan,
    this.laPAKNChuyenLaiChoChuyenXuLy,
    this.laPAKNChuyenLaiChoTiepNhanXuLy,
    this.id,
    this.thoiGianTaoMoi,
    this.thoiGianCapNhat,
    this.tenNguonPAKN,
  );

  List<DocumentDetailRow> toListHeader() {
    final List<DocumentDetailRow> listCheckbox = [
      DocumentDetailRow(
        S.current.tieu_de,
        tieuDe,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.noidung,
        noiDung,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.nguon_pakn,
        tenNguoiPhanAnh,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.phan_loai_pakn,
        phanLoaiPAKN,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.ngay_phan_anh,
        ngayPhanAnh,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.han_xu_ly,
        hanXuLy,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.lien_quan_quy_dinh,
        tenLuat,
        TypeDocumentDetailRow.text,
      ),
      DocumentDetailRow(
        S.current.tai_lieu_dinh_kem_cong_dan,
        getFile(),
        TypeDocumentDetailRow.text,
      ),
    ];

    return listCheckbox;
  }

  getFile() {
    if (fileDinhKem.isNotEmpty) {
      final List<String> listFileName = [];
      for (final element in fileDinhKem) {
        listFileName.add(element.tenFile);
      }
    }
  }
}

class HeaderChiTietYKNDModel {
  final String? tieuDe;
  final String? noiDung;
  final String? nguonPAKN;
  final String? phanLoaiPAKN;
  final String? ngayPhanAnh;
  final String? hanXuLy;
  final String? quyDinhLuat;
  final String? taiLieuCongDan;

  HeaderChiTietYKNDModel({
    this.tieuDe,
    this.noiDung,
    this.nguonPAKN,
    this.phanLoaiPAKN,
    this.ngayPhanAnh,
    this.hanXuLy,
    this.quyDinhLuat,
    this.taiLieuCongDan,
  });
}

class DataRowChiTietKienNghi {
  final String title;
  final String? content;

  DataRowChiTietKienNghi({required this.title, this.content});
}

class ListRowYKND {
  final String title;
  final List<String>? content;

  ListRowYKND({required this.title, this.content});
}

class NguoiPhanAnhModel {
  int? doiTuong;
  String? tenCaNhan;
  String? cmnd;
  String? diaChiEmail;
  String? soDienthoai;
  String? diaChiChiTiet;
  String? tinhThanhPho;
  String? quanHuyen;
  String? xaPhuong;
  String? idTinhTp;
  String? idQuanHuyen;
  String? idXaPhuong;

  NguoiPhanAnhModel({
    this.doiTuong,
    this.tenCaNhan,
    this.cmnd,
    this.diaChiEmail,
    this.soDienthoai,
    this.diaChiChiTiet,
    this.tinhThanhPho,
    this.quanHuyen,
    this.xaPhuong,
    this.idTinhTp,
    this.idQuanHuyen,
    this.idXaPhuong,
  });
}

class ThongTinXuLy {
  String? tenDonVi;
  String? vaiTro;

  ThongTinXuLy({this.vaiTro, this.tenDonVi});
}

class KetQuaXuLy {
  final String? chuyenVienXuLy;
  final String? donViXuLy;
  final String? vaiTroXuLy;
  final String? noiDungXuLy;
  final String? soHieuVanBan;
  final String? ngayBanHanh;
  final String? trichYeu;
  final String? coQuanBanHanh;
  final String? fileDinhKem;

  KetQuaXuLy({
    this.chuyenVienXuLy,
    this.donViXuLy,
    this.vaiTroXuLy,
    this.noiDungXuLy,
    this.soHieuVanBan,
    this.ngayBanHanh,
    this.trichYeu,
    this.coQuanBanHanh,
    this.fileDinhKem,
  });
}

class FileData {
  int dungLuong;
  String duoiMoRong;
  String duongDan;
  String kieuDinhKem;
  String tenFile;

  FileData({
    required this.dungLuong,
    required this.duoiMoRong,
    required this.duongDan,
    required this.kieuDinhKem,
    required this.tenFile,
  });
}

class ChiTietYKienNguoiDanRow {
  final List<DataRowChiTietKienNghi> thongTinPhanAnhRow;

  ChiTietYKienNguoiDanRow(
    this.thongTinPhanAnhRow,
  );
}
