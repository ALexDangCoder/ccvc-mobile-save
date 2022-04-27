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
  }

  ChiTietLichHopModel toDomain() => ChiTietLichHopModel(
        id: id ?? '',
        typeScheduleId: typeScheduleId ?? '',
        chuTriModel: chuTri?.toDomain() ?? const ChuTriModel(),
        linhVuc: tenLinhVuc ?? '',
        noiDung: noiDung ?? '',
        title: title ?? '',
        canBoThamGiaStr: canBoThamGiaStr ?? '',
        phongHopMode: phongHop?.toDomain() ?? const PhongHopMode(),
        tenLinhVuc: tenLinhVuc ?? '',
        timeTo: timeTo ?? '',
        timeStart: timeStart ?? '',
        ngayBatDau: ngayBatDau ?? DateTime.now().toString(),
        ngayKetThuc: ngayKetThuc ?? DateTime.now().toString(),
        mucDoHop: mucDo,
        bit_HopTrucTuyen: bitHopTrucTuyen ?? false,
        bit_TrongDonVi: bitTrongDonVi ?? false,
        isAllDay: isAllDay ?? false,
        typeReminder: typeReminder,
        typeRepeat: typeRepeat,
        fileData: fileData?.map((e) => e.toDomain()).toList() ?? [],
        dateRepeat: dateRepeat,
        days: days,
      );
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

  PhongHop.fromJson(Map<String, dynamic> json) {
    donViId = json['donViId'];
    id = json['id'];
    lichHopId = json['lichHopId'];
    noiDungYeuCau = json['noiDungYeuCau'];
    ten = json['ten'];
  }

  PhongHopMode toDomain() => PhongHopMode(id: id ?? '', ten: ten ?? '');
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

  file toDomain() => file(name: name, path: path);
}
