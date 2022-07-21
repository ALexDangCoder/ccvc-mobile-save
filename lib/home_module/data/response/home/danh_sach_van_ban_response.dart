import '/home_module//utils/extensions/string_extension.dart';
import '/home_module/domain/model/home/document_model.dart';

class DanhSachVanBanResponse {
  List<String>? messages;
  Data? data;
  bool? isSuccess;

  DanhSachVanBanResponse({this.messages, this.data, this.isSuccess});

  DanhSachVanBanResponse.fromJson(Map<String, dynamic> json) {
    messages = json['Messages'].cast<String>();
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;

    isSuccess = json['IsSuccess'];
  }
}

class Data {
  List<PageData>? pageData;
  int? totalRows;
  int? currentPage;
  int? pageSize;
  int? totalPage;

  Data({
    this.pageData,
    this.totalRows,
    this.currentPage,
    this.pageSize,
    this.totalPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
  String? soKyHieu;
  String? trichYeu;
  String? noiGui;
  String? doKhan;
  String? codeDoKhan;
  String? taskId;
  int? trangThaiXuLy;
  PageData({
    this.id,
    this.soKyHieu,
    this.trichYeu,
    this.noiGui,
    this.doKhan,
    this.codeDoKhan,
    this.taskId,
    this.trangThaiXuLy,
  });

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];

    soKyHieu = json['SoKyHieu'];
    trichYeu = json['TrichYeu'];
    noiGui = json['NoiGui'];
    doKhan = json['DoKhan'];
    codeDoKhan = json['CodeDoKhan'];
    taskId = json['TaskId'];
    trangThaiXuLy = json['TrangThaiXuLy'];
  }

  DocumentModel toDomain() => DocumentModel(
      id: id ?? '',
      kyHieu: soKyHieu ?? '',
      title: trichYeu?.parseHtml() ?? '',
      noiGui: noiGui ?? '',
      code: (trangThaiXuLy ?? 0).toString(),
      status: doKhan ?? '',
      taskId: taskId ?? '',
      trangThaiXuLy: trangThaiXuLy ?? 0);
}

class SearchDanhSachVanBanResponse {
  String? messages;
  DataDsVB? data;
  int? statusCode;
  bool? isSuccess;

  SearchDanhSachVanBanResponse({
    this.messages,
    this.data,
    this.statusCode,
    this.isSuccess,
  });

  SearchDanhSachVanBanResponse.fromJson(Map<String, dynamic> json) {
    messages = json['Messages'];
    data = json['Data'] != null ? DataDsVB.fromJson(json['Data']) : null;
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
  }
}

class DataDsVB {
  List<PageDataDSSearch>? pageData;
  int? totalRows;
  int? currentPage;
  int? pageSize;
  int? totalPage;

  DataDsVB({
    this.pageData,
    this.totalRows,
    this.currentPage,
    this.pageSize,
    this.totalPage,
  });

  DataDsVB.fromJson(Map<String, dynamic> json) {
    if (json['PageData'] != null) {
      pageData = <PageDataDSSearch>[];
      json['PageData'].forEach((v) {
        pageData!.add(PageDataDSSearch.fromJson(v));
      });
    }
    totalRows = json['TotalRows'];
    currentPage = json['CurrentPage'];
    pageSize = json['PageSize'];
    totalPage = json['TotalPage'];
  }
}

class PageDataDSSearch {
  String? id;
  String? nguoiTaoId;
  String? soKyHieu;
  String? trichYeu;
  String? codeDoKhan;
  String? doKhan;
  String? donViBanHanh;

  PageDataDSSearch({
    this.id,
    this.nguoiTaoId,
    this.soKyHieu,
    this.trichYeu,
    this.donViBanHanh,
  });

  PageDataDSSearch.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nguoiTaoId = json['NguoiTaoId'];
    soKyHieu = json['SoKyHieu'];
    trichYeu = json['TrichYeu'];
    donViBanHanh = json['DonViBanHanh'];
    codeDoKhan = json['CodeDoKhan'];
    doKhan = json['DoKhan'];
  }

  DocumentModel toDomain() => DocumentModel(
        kyHieu: soKyHieu ?? '',
        noiGui: donViBanHanh ?? '',
        status: doKhan ?? '',
        code: codeDoKhan ?? '',
        title: trichYeu?.parseHtml() ?? '',
        id: id ?? '',
      );
}
