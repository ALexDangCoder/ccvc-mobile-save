import 'dart:convert';

import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';

class ChiTietLichHopResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ChiTietLichHopResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  ChiTietLichHopResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  String? nguoiTaoStr;
  bool? isDuyetPhong;
  bool? isDuyetThietBi;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  bool? isTaoBocBang;
  String? id;
  String? title;
  bool? bitHopTrucTuyen;
  String? linkTrucTuyen;
  bool? bitPhongTrungTamDieuHanh;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? timeStart;
  String? timeTo;
  String? noiDung;
  int? status;
  String? diaDiemHop;
  bool? congKhai;
  bool? lichDonVi;
  ChuTri? chuTri;
  int? mucDo;
  int? typeRepeat;
  bool? isLichLap;
  bool? isAllDay;
  String? donViNguoiTaoId;
  int? typeReminder;
  bool? bitTrongDonVi;
  bool? bitYeuCauDuyet;
  bool? bitLinkTrongHeThong;
  String? days;
  bool? isMulti;
  String? linhVucId;
  String? tenLinhVuc;
  String? typeScheduleId;
  PhongHop? phongHop;
  List<FileData>? fileData;
  String? dateRepeat;
  String? canBoThamGiaStr;
  String? thoiGianKetThuc;
  int? trangThaiDuyetKyThuat;
  String? lichHop_PhienHopStr;
  bool? isDuyetKyThuat;
  List<DsDiemCau>? dsDiemCau;
  List<dynamic>? phongHopThietBi;
  bool? bit_LinkTrongHeThong;
  String? thuMoiFiles;

  Data({
    this.nguoiTaoStr,
    this.isDuyetPhong,
    this.isDuyetThietBi,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.isTaoBocBang,
    this.canBoThamGiaStr,
    this.id,
    this.title,
    this.bitHopTrucTuyen,
    this.thoiGianKetThuc,
    this.linkTrucTuyen,
    this.bitPhongTrungTamDieuHanh,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.timeStart,
    this.timeTo,
    this.noiDung,
    this.status,
    this.diaDiemHop,
    this.congKhai,
    this.lichDonVi,
    this.chuTri,
    this.mucDo,
    this.typeRepeat,
    this.isLichLap,
    this.isAllDay,
    this.donViNguoiTaoId,
    this.typeReminder,
    this.bitTrongDonVi,
    this.bitYeuCauDuyet,
    this.bitLinkTrongHeThong,
    this.days,
    this.isMulti,
    this.linhVucId,
    this.tenLinhVuc,
    this.typeScheduleId,
    this.phongHop,
    this.fileData,
    this.dateRepeat,
    this.trangThaiDuyetKyThuat,
    this.lichHop_PhienHopStr,
    this.dsDiemCau,
    this.bit_LinkTrongHeThong,
    this.phongHopThietBi,
    this.thuMoiFiles,
    this.isDuyetKyThuat,
  });

  Data.fromJson(Map<String, dynamic> json) {
    nguoiTaoStr = json['nguoiTao_str'];
    isDuyetPhong = json['isDuyetPhong'];
    isDuyetThietBi = json['isDuyetThietBi'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    isTaoBocBang = json['isTaoBocBang'];
    id = json['id'];
    canBoThamGiaStr = json['canBoThamGiaStr'];
    title = json['title'];
    trangThaiDuyetKyThuat = json['trangThaiDuyetKyThuat'];
    bitHopTrucTuyen = json['bit_HopTrucTuyen'];
    linkTrucTuyen = json['linkTrucTuyen'];
    bitPhongTrungTamDieuHanh = json['bit_PhongTrungTamDieuHanh'];
    ngayBatDau = json['ngayBatDau'];
    ngayKetThuc = json['ngayKetThuc'];
    timeStart = json['timeStart'];
    timeTo = json['timeTo'];
    noiDung = json['noiDung'];
    status = json['status'];
    diaDiemHop = json['diaDiemHop'];
    congKhai = json['congKhai'];
    lichDonVi = json['lichDonVi'];
    chuTri = json['chuTri'] != null ? ChuTri.fromJson(json['chuTri']) : null;
    phongHop =
        json['phongHop'] != null ? PhongHop.fromJson(json['phongHop']) : null;
    mucDo = json['mucDo'];
    typeRepeat = json['typeRepeat'];
    thoiGianKetThuc = json['thoiGianKetThuc'];
    isLichLap = json['isLichLap'];
    isAllDay = json['isAllDay'];
    donViNguoiTaoId = json['donViNguoiTaoId'];
    typeReminder = json['typeReminder'];
    bitTrongDonVi = json['bit_TrongDonVi'];
    bitYeuCauDuyet = json['bit_YeuCauDuyet'];
    bitLinkTrongHeThong = json['bit_LinkTrongHeThong'];
    days = json['days'];
    isMulti = json['isMulti'];
    linhVucId = json['linhVucId'];
    tenLinhVuc = json['tenLinhVuc'];
    typeScheduleId = json['typeScheduleId'];
    if (json['fileData'] != null) {
      fileData = <FileData>[];
      json['fileData'].forEach((v) {
        fileData!.add(FileData.fromJson(v));
      });
    }
    dateRepeat = json['dateRepeat'];
    lichHop_PhienHopStr = json['lichHop_PhienHopStr'];
    isDuyetKyThuat = json['isDuyetKyThuat'];
    linkTrucTuyen = json['linkTrucTuyen'];
    if (json['dsDiemCau'] != null) {
      dsDiemCau = <DsDiemCau>[];
      json['dsDiemCau'].forEach((rs) {
        dsDiemCau!.add(DsDiemCau.fromJson(rs));
      });
    }
    bit_LinkTrongHeThong = json['bit_LinkTrongHeThong'];
    phongHopThietBi = json['phongHop_ThietBi'];
    thuMoiFiles = json['thuMoiFiles'];
  }

  ChiTietLichHopModel toDomain() {
    final List<FilesChiTietHop> listFileDinhKem = [];
    try{
      if ((thuMoiFiles ?? '').isNotEmpty) {
        final data = json.decode(thuMoiFiles ?? '') as List<dynamic>;
        for (final element in data) {
          listFileDinhKem.add(FilesChiTietHop.fromJson(element));
        }
      }
    }catch(e){
      //
    }
    return ChiTietLichHopModel(
      id: id ?? '',
      typeScheduleId: typeScheduleId ?? '',
      chuTriModel: chuTri?.toDomain() ?? const ChuTriModel(),
      linhVuc: tenLinhVuc ?? '',
      noiDung: noiDung ?? '',
      thoiGianKetThuc: thoiGianKetThuc ?? '',
      title: title ?? '',
      isDuyetThietBi: isDuyetThietBi ?? false,
      isDuyetPhong: isDuyetPhong ?? false,
      canBoThamGiaStr: canBoThamGiaStr ?? '',
      trangThaiDuyetKyThuat: trangThaiDuyetKyThuat ?? -1,
      phongHopMode: phongHop?.toDomain() ?? const PhongHopMode(),
      tenLinhVuc: tenLinhVuc ?? '',
      nguoiTao_str: nguoiTaoStr ?? '',
      timeTo: timeTo ?? '',
      status: status ?? 0,
      timeStart: timeStart ?? '',
      ngayBatDau: ngayBatDau ?? DateTime.now().toString(),
      ngayKetThuc: ngayKetThuc ?? DateTime.now().toString(),
      mucDoHop: mucDo,
      bit_HopTrucTuyen: bitHopTrucTuyen ?? false,
      bit_TrongDonVi: bitTrongDonVi,
      isAllDay: isAllDay ?? false,
      typeReminder: typeReminder,
      bit_YeuCauDuyet: bitYeuCauDuyet ?? false,
      typeRepeat: typeRepeat,
      createdBy: createdBy ?? '',
      fileData: fileData?.map((e) => e.toDomain()).toList() ?? [],
      dateRepeat: dateRepeat,
      days: days,
      isTaoTaoBocBang: isTaoBocBang ?? false,
      bit_PhongTrungTamDieuHanh: bitPhongTrungTamDieuHanh ?? false,
      lichHop_PhienHopStr: lichHop_PhienHopStr ?? '',
      diaDiemHop: diaDiemHop ?? '',
      isCongKhai: congKhai,
      isDuyetKyThuat: isDuyetKyThuat,
      linkTrucTuyen: linkTrucTuyen,
      dsDiemCau: dsDiemCau,
      bit_LinkTrongHeThong: bit_LinkTrongHeThong,
      isLichLap: isLichLap,
      phongHopThietBi:
          phongHopThietBi?.map((e) => PhongHopThietBi.fromJson(e)).toList(),
      lichDonVi: lichDonVi,
      thuMoiFiles: thuMoiFiles,
      linhVucId: linhVucId,
      fileDinhKemWithDecode: listFileDinhKem,
    );
  }
}

class ChuTri {
  String? donViId;
  String? canBoId;
  int? vaiTroThamGia;
  String? soDienThoai;
  String? dauMoiLienHe;
  String? tenCanBo;
  String? tenCoQuan;
  String? id;

  String? canBoTenChucVu;

  ChuTri(
      {this.donViId,
      this.canBoId,
      this.vaiTroThamGia,
      this.soDienThoai,
      this.dauMoiLienHe,
      this.tenCanBo,
      this.tenCoQuan,
      this.id,
      this.canBoTenChucVu});

  ChuTri.fromJson(Map<String, dynamic> json) {
    donViId = json['donViId'];
    canBoId = json['canBoId'];
    vaiTroThamGia = json['vaiTroThamGia'];

    soDienThoai = json['soDienThoai'];
    dauMoiLienHe = json['dauMoiLienHe'];
    tenCanBo = json['tenCanBo'];
    tenCoQuan = json['tenCoQuan'];
    id = json['id'];

    canBoTenChucVu = json['canBo_TenChucVu'];
  }

  ChuTriModel toDomain() => ChuTriModel(
        id: id ?? '',
        tenCanBo: tenCanBo ?? '',
        tenCoQuan: tenCoQuan ?? '',
        dauMoiLienHe: dauMoiLienHe ?? '',
        soDienThoai: soDienThoai ?? '',
        canBoId: canBoId ?? '',
        donViId: donViId ?? '',
      );
}

class PhongHop {
  String? donViId;
  String? id;
  String? lichHopId;
  String? noiDungYeuCau;
  String? ten;
  String? phongHopId;
  bool? bit_TTDH;

  PhongHop.fromJson(Map<String, dynamic> json) {
    donViId = json['donViId'];
    id = json['id'];
    lichHopId = json['lichHopId'];
    noiDungYeuCau = json['noiDungYeuCau'];
    ten = json['ten'];
    bit_TTDH = json['bit_TTDH'];
    phongHopId = json['phongHopId'];
  }

  PhongHopMode toDomain() => PhongHopMode(
        id: id ?? '',
        ten: ten ?? '',
        bit_TTDH: bit_TTDH ?? false,
        donViId: donViId,
        noiDungYeuCau: noiDungYeuCau,
        phongHopId: phongHopId,
      );
}

class DiemCau {
  String? canBoDauMoi_ChucVu;
  String? canBoDauMoi_DiaChi;
  String? canBoDauMoi_HoTen;
  String? canBoDauMoi_SDT;
  String? id;
  String? id_LichHop;
  int? loaiDiemCau;
  String? tenDiemCau;

  DiemCau.fromJson(Map<String, dynamic> json) {
    canBoDauMoi_ChucVu = json['canBoDauMoi_ChucVu'];
    canBoDauMoi_DiaChi = json['canBoDauMoi_DiaChi'];
    canBoDauMoi_HoTen = json['canBoDauMoi_HoTen'];
    canBoDauMoi_SDT = json['canBoDauMoi_SDT'];
    loaiDiemCau = json['loaiDiemCau'];
    id = json['id'];
    id_LichHop = json['id_LichHop'];
  }

  DsDiemCau toDomain() => DsDiemCau(
        canBoDauMoiChucVu: canBoDauMoi_ChucVu ?? '',
        canBoDauMoiHoTen: canBoDauMoi_HoTen ?? '',
        canBoDauMoiSDT: canBoDauMoi_SDT ?? '',
        loaiDiemCau: loaiDiemCau,
        tenDiemCau: tenDiemCau,
        id: id,
        id_LichHop: id_LichHop,
      );
}

class FileData {
  String? createdAt;

  String? createdBy;
  String? entityId;
  String? entityId_DM;
  String? entityName;
  int? entityType;
  String? extension;
  String? id;
  bool? isPrivate;
  String? name;
  String? path;
  double? size;
  String? updatedAt;
  String? updatedBy;

  FileData({
    this.createdAt,
    this.createdBy,
    this.entityId,
    this.entityId_DM,
    this.entityName,
    this.entityType,
    this.extension,
    this.id,
    this.isPrivate,
    this.name,
    this.path,
    this.size,
    this.updatedAt,
    this.updatedBy,
  });

  FileData.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    entityId = json['entityId'];
    entityId_DM = json['entityId_DM'];
    entityName = json['entityName'];
    entityType = json['entityType'];
    extension = json['extension'];
    id = json['id'];
    isPrivate = json['isPrivate'];
    name = json['name'];
    path = json['path'];
    size = json['size'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  FilesChiTietHop toDomain() => FilesChiTietHop(
        name: name,
        path: path,
        id: id,
      );
}
