import '/home_module/domain/model/home/calendar_metting_model.dart';
import '/home_module/utils/extensions/string_extension.dart';

class NhiemVuResponse {
  DanhSachNhiemVuData? data;

  NhiemVuResponse({this.data});

  NhiemVuResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = DanhSachNhiemVuData.fromJson(json['Data']);
    }
  }
}

class DanhSachNhiemVuData {
  List<PageData>? pageData;
  int? totalRows;
  int? currentPage;
  int? pageSize;
  int? totalPage;

  DanhSachNhiemVuData(
      {this.pageData,
      this.totalRows,
      this.currentPage,
      this.pageSize,
      this.totalPage});

  DanhSachNhiemVuData.fromJson(Map<String, dynamic> json) {
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
  String? noiDungTheoDoi;
  String? hanXuLy;

  String? loaiNhiemVuId;
  String? loaiNhiemVu;

  String? trangThai;
  String? maTrangThai;
  String? trangThaiId;
  int? trangThaiHanXuLy;

  PageData(
      {this.id,
      this.noiDungTheoDoi,
      this.hanXuLy,
      this.loaiNhiemVuId,
      this.loaiNhiemVu,
      this.trangThai,
      this.maTrangThai,
      this.trangThaiId,
      this.trangThaiHanXuLy});

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    noiDungTheoDoi = json['NoiDungTheoDoi'];
    hanXuLy = json['HanXuLy'];
    loaiNhiemVuId = json['LoaiNhiemVuId'];
    loaiNhiemVu = json['LoaiNhiemVu'];

    trangThai = json['TrangThai'];
    maTrangThai = json['MaTrangThai'];
    trangThaiId = json['TrangThaiId'];
    trangThaiHanXuLy = json['TrangThaiHanXuLy'];
  }

  CalendarMeetingModel toDomain() => CalendarMeetingModel(
      title: noiDungTheoDoi?.parseHtml() ?? '',
      loaiNhiemVu: loaiNhiemVu ?? '',
      hanXuLy: hanXuLy ?? '',
      maTrangThai: maTrangThai ?? '',
      id: id ?? '',
      trangThaiHanXuLy: trangThaiHanXuLy ?? -1);
}
