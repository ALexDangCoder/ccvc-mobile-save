import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
class DanhSachCongViecResponse {
  List<PageData>? pageData;
  int? totalRows;
  int? currentPage;
  int? pageSize;
  int? totalPage;

  DanhSachCongViecResponse(
      {this.pageData,
      this.totalRows,
      this.currentPage,
      this.pageSize,
      this.totalPage});

  DanhSachCongViecResponse.fromJson(Map<String, dynamic> json) {
    if (json['PageData'] != null) {
      pageData = <PageData>[];
      json['PageData'].forEach((v) {
        pageData!.add(PageData.fromJson(v));
      });
    }
    totalRows = json['TotalRows'];
    currentPage = json['CurrentPage'];
    pageSize = json['PageSize'];
    totalPage = json['TotalPage'];
  }
}

class PageData {
  String? id;

  int? trangThaiHanXuLy;
  String? noiDungCongViec;
  String? doiTuongThucHien;

  String? donViThucHienId;

  String? nguoiThucHienId;

  String? hanXuLyFormatDate;

  String? hanXuLy;

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

  PageData(
      {this.id,
      this.trangThaiHanXuLy,
      this.noiDungCongViec,
      this.doiTuongThucHien,
      this.donViThucHienId,
      this.nguoiThucHienId,
      this.hanXuLyFormatDate,
      this.hanXuLy,
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
      this.currentDonVi,
      this.actionDate,
      this.congViecLienQuan,
      this.isFromCaNhan,
      this.wTrangThai,
      this.coTheCapNhatTinhHinh,
      this.coTheSua,
      this.coTheHuy,
      this.coTheGan,
      this.coTheXoa});

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];

    trangThaiHanXuLy = json['TrangThaiHanXuLy'];
    noiDungCongViec = json['NoiDungCongViec'];
    doiTuongThucHien = json['DoiTuongThucHien'];

    donViThucHienId = json['DonViThucHienId'];

    nguoiThucHienId = json['NguoiThucHienId'];

    hanXuLyFormatDate = json['HanXuLyFormatDate'];

    hanXuLy = json['HanXuLy'];

    nguoiGiaoViec = json['NguoiGiaoViec'];
    donViGiaoViec = json['DonViGiaoViec'];
    donViGiaoViecId = json['DonViGiaoViecId'];
    trangThai = json['TrangThai'];
    maTrangThai = json['MaTrangThai'];
    trangThaiId = json['TrangThaiId'];
    maNhiemVu = json['MaNhiemVu'];
    nhiemVuId = json['NhiemVuId'];
    mucDoCongViecId = json['MucDoCongViecId'];
    mucDoCongViec = json['MucDoCongViec'];
    noiDungNhiemVu = json['NoiDungNhiemVu'];
    nguoiTaoId = json['NguoiTaoId'];

    currentDonVi = json['CurrentDonVi'];
    actionDate = json['ActionDate'];
    congViecLienQuan = json['CongViecLienQuan'];
    isFromCaNhan = json['IsFromCaNhan'];
    wTrangThai = json['WTrangThai'];
    coTheCapNhatTinhHinh = json['CoTheCapNhatTinhHinh'];
    coTheSua = json['CoTheSua'];
    coTheHuy = json['CoTheHuy'];
    coTheGan = json['CoTheGan'];
    coTheXoa = json['CoTheXoa'];
  }
  CalendarMeetingModel toDomain() => CalendarMeetingModel(
    title: noiDungCongViec?.parseHtml() ?? '',
    loaiNhiemVu: nguoiGiaoViec ?? '',
    hanXuLy: hanXuLy ?? '',
    maTrangThai: maTrangThai ?? '',
    id: id ?? '',

  );
}
