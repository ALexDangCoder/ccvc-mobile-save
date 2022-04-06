import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/type_data_row.dart';

class DanhSachCongViecChiTietNhiemVuModel {
  int? stt;
  String? id;
  String? tenCv;
  String? maCv;
  int? trangThaiHanXuLy;
  String? noiDungCongViec;
  String? doiTuongThucHien;
  String? donViThucHien;
  String? donViThucHienId;
  String? caNhanThucHien;
  String? nguoiThucHienId;
  String? nguoiThucHien;
  String? hanXuLyFormatDate;
  String? thoiGianGiaoFormatDate;
  String? hanXuLy;
  String? thoiGianGiaoViec;
  String? nguoiGiaoViec;
  String? donViGiaoViec;
  String? donViGiaoViecId;
  String? trangThai;
  String? maTrangThai;
  String? trangThaiId;
  String? maNhiemVu;
  String? nhiemVuId;
  String? mucDoCongViecId;
  String? mucDoCongViec;
  String? noiDungNhiemVu;
  String? nguoiTaoId;
  String? nguoiTao;
  String? currentDonVi;
  String? actionDate;
  String? congViecLienQuan;
  bool? isFromCaNhan;
  int? wTrangThai;
  bool? coTheCapNhatTinhHinh;
  bool? coTheSua;
  bool? coTheHuy;
  bool? coTheGan;
  bool? coTheXoa;

  DanhSachCongViecChiTietNhiemVuModel.empty();

  DanhSachCongViecChiTietNhiemVuModel({
    this.stt,
    this.id,
    this.tenCv,
    this.maCv,
    this.trangThaiHanXuLy,
    this.noiDungCongViec,
    this.doiTuongThucHien,
    this.donViThucHien,
    this.donViThucHienId,
    this.caNhanThucHien,
    this.nguoiThucHienId,
    this.nguoiThucHien,
    this.hanXuLyFormatDate,
    this.thoiGianGiaoFormatDate,
    this.hanXuLy,
    this.thoiGianGiaoViec,
    this.nguoiGiaoViec,
    this.donViGiaoViec,
    this.donViGiaoViecId,
    this.trangThai,
    this.maTrangThai,
    this.trangThaiId,
    this.maNhiemVu,
    this.nhiemVuId,
    this.mucDoCongViecId,
    this.mucDoCongViec,
    this.noiDungNhiemVu,
    this.nguoiTaoId,
    this.nguoiTao,
    this.currentDonVi,
    this.actionDate,
    this.congViecLienQuan,
    this.isFromCaNhan,
    this.wTrangThai,
    this.coTheCapNhatTinhHinh,
    this.coTheSua,
    this.coTheHuy,
    this.coTheGan,
    this.coTheXoa,
  });

  List<RowDataExpandModel> listDSCV() {
    List<RowDataExpandModel> listData = [
      RowDataExpandModel(
        key: S.current.stt,
        value: stt.toString(),
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_xu_ly,
        value: caNhanThucHien ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.don_vi_xu_ly,
        value: donViThucHien ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.thoi_gian_giao_viec,
        value: thoiGianGiaoViec ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.han_xu_ly,
        value: hanXuLy ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.noi_dung_cong_viec,
        value: noiDungCongViec?.parseHtml() ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.nguoi_giao_viec,
        value: nguoiGiaoViec ?? '',
        type: TypeDataNV.text,
      ),
      RowDataExpandModel(
        key: S.current.trang_thai,
        value: maTrangThai ?? '',
        type: TypeDataNV.status,
      ),
    ];

    return listData;
  }
}
