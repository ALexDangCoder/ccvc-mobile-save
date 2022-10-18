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
  List<TrangThaiThucHienResponse>? listTrangThaiThucHien;

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
    this.listTrangThaiThucHien,
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
    listTrangThaiThucHien =
        (json['TinhHinhThucHienModel'] as List<dynamic>)
            .map((e) => TrangThaiThucHienResponse.fromJson(e))
            .toList();
  }

  CalendarMeetingModel toDomain() => CalendarMeetingModel(
        loaiNhiemVu: loaiNhiemVu ?? '',
        hanXuLy: hanXuLy ?? '',
        maTrangThai: maTrangThai ?? '',
        id: id ?? '',
        noiDungTheoDoi: noiDungTheoDoi ?? '',
        soNhiemVu: soNhiemVu ?? '',
        tinhHinhThucHienNoiBo: tinhHinhThucHienNoiBo ?? '',
        trangThaiThucHien: listTrangThaiThucHien
                ?.map((e) => e.tinhHinhThucHien())
                .toList()
                .join('\n') ??
            '',
      );
}

class TrangThaiThucHienResponse {
  String? doiTuong;
  String? trangThai;
  String? vaiTroXuLy;

  TrangThaiThucHienResponse.fromJson(Map<String, dynamic> json) {
    doiTuong = json['DoiTuong'];
    trangThai = json['TrangThai'];
    vaiTroXuLy = json['VaiTroXuLy'];
  }

  String tinhHinhThucHien(){
    final list = [];
    if ((doiTuong  ?? '').isNotEmpty){
      list.add(doiTuong ?? '');
    }
    if ((vaiTroXuLy  ?? '').isNotEmpty){
      list.add(vaiTroXuLy ?? '');
    }
    if ((trangThai  ?? '').isNotEmpty){
      list.add(trangThai ?? '');
    }
    return list.join(' - ');
  }
}
