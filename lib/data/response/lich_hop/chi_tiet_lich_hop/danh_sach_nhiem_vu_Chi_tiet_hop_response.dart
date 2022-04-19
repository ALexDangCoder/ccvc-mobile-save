import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class ListNhiemVuChiTietLichHopResponse {
  List<PageData>? pageData;
  int? totalRows;
  int? currentPage;
  int? pageSize;
  int? totalPage;

  ListNhiemVuChiTietLichHopResponse(
      {this.pageData,
      this.totalRows,
      this.currentPage,
      this.pageSize,
      this.totalPage});

  ListNhiemVuChiTietLichHopResponse.fromJson(Map<String, dynamic> json) {
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
  String? soNhiemVu;
  String? tinhHinhThucHienNoiBo;

  PageData({
    this.id,
    this.noiDungTheoDoi,
    this.hanXuLy,
    this.loaiNhiemVuId,
    this.loaiNhiemVu,
    this.trangThai,
    this.maTrangThai,
    this.trangThaiId,
    this.soNhiemVu,
    this.tinhHinhThucHienNoiBo,
  });

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    noiDungTheoDoi = json['NoiDungTheoDoi'];
    hanXuLy = json['HanXuLy'];
    loaiNhiemVuId = json['LoaiNhiemVuId'];
    loaiNhiemVu = json['LoaiNhiemVu'];

    trangThai = json['TrangThai'];
    maTrangThai = json['MaTrangThai'];
    trangThaiId = json['TrangThaiId'];
    soNhiemVu = json['SoNhiemVu'];
    tinhHinhThucHienNoiBo = json['TinhHinhThucHienNoiBo'];
  }

  CalendarMeetingModel toDomain() => CalendarMeetingModel(
        title: noiDungTheoDoi?.parseHtml() ?? '',
        loaiNhiemVu: loaiNhiemVu ?? '',
        hanXuLy: hanXuLy ?? '',
        maTrangThai: maTrangThai ?? '',
        id: id ?? '',
        noiDungTheoDoi: noiDungTheoDoi ?? '',
        soNhiemVu: soNhiemVu ?? '',
        tinhHinhThucHienNoiBo: tinhHinhThucHienNoiBo ?? '',
      );
}
