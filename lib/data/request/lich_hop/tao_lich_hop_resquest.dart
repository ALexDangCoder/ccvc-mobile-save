import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

TaoLichHopRequest taoHopFormChiTietHopModel(ChiTietLichHopModel chiTiet) {
  return TaoLichHopRequest(
    typeScheduleId: chiTiet.typeScheduleId,
    linhVucId: chiTiet.linhVucId,
    title: chiTiet.title,
    ngayBatDau: chiTiet.ngayBatDau.changeToNewPatternDate(
      DateFormatApp.monthDayFormat,
      DateTimeFormat.DOB_FORMAT,
    ),
    ngayKetThuc: chiTiet.ngayBatDau.changeToNewPatternDate(
      DateFormatApp.monthDayFormat,
      DateTimeFormat.DOB_FORMAT,
    ),
    timeStart: chiTiet.timeStart,
    timeTo: chiTiet.timeTo,
    mucDo: chiTiet.mucDoHop,
    isLichLap: chiTiet.isLichLap,
    isNhacLich: chiTiet.typeReminder != 0,
    isAllDay: chiTiet.isAllDay,
    congKhai: chiTiet.isCongKhai,
    lichDonVi: chiTiet.lichDonVi,
    noiDung: chiTiet.noiDung,
    bitHopTrucTuyen: chiTiet.bit_HopTrucTuyen,
    chuTri: chiTiet.chuTriModel.toChuTriModel(),
    diaDiemHop: chiTiet.diaDiemHop,
    phongHop: chiTiet.phongHopMode.convertToPhongHopRequest(),
    phongHopThietBi: chiTiet.phongHopThietBi,
    status: chiTiet.status,
    bitYeuCauDuyet: chiTiet.bit_YeuCauDuyet,
    linkTrucTuyen: chiTiet.linkTrucTuyen,
    bitTrongDonVi: chiTiet.bit_TrongDonVi,
    dsDiemCau: chiTiet.dsDiemCau,
    thuMoiFiles: chiTiet.thuMoiFiles,
    typeReminder: chiTiet.typeReminder,
    typeRepeat: chiTiet.typeRepeat,
    dateRepeat: chiTiet.dateRepeat,
    days: chiTiet.days,
    bitLinkTrongHeThong: chiTiet.bit_LinkTrongHeThong,
    isDuyetKyThuat: chiTiet.isDuyetKyThuat,
    id: chiTiet.id,
  );
}
class TaoLichHopRequest {
  String? typeScheduleId;
  String? linhVucId;
  String? title;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? timeStart;
  String? timeTo;
  int? mucDo;
  bool? isLichLap;
  bool? isNhacLich;
  bool? isAllDay;
  bool? congKhai;
  bool? lichDonVi;
  String? noiDung;
  bool? bitHopTrucTuyen;
  ChuTri? chuTri;
  String? diaDiemHop;
  PhongHop? phongHop;
  List<PhongHopThietBi>? phongHopThietBi;
  int? status;
  bool? bitYeuCauDuyet;
  String? linkTrucTuyen;
  bool? bitTrongDonVi;
  List<DsDiemCau>? dsDiemCau;
  String? thuMoiFiles;
  int? typeReminder;
  int? typeRepeat;
  String? dateRepeat;
  String? days;
  bool? bitLinkTrongHeThong;
  bool? isDuyetKyThuat;
  String? id;
  bool? isMulti;

  TaoLichHopRequest({
    this.typeScheduleId,
    this.linhVucId,
    this.title,
    this.ngayBatDau,
    this.ngayKetThuc,
    this.timeStart,
    this.timeTo,
    this.mucDo,
    this.isLichLap,
    this.isNhacLich,
    this.isAllDay,
    this.congKhai,
    this.lichDonVi,
    this.noiDung,
    this.bitHopTrucTuyen,
    this.chuTri,
    this.diaDiemHop,
    this.phongHop,
    this.phongHopThietBi,
    this.status,
    this.bitYeuCauDuyet,
    this.linkTrucTuyen,
    this.bitTrongDonVi,
    this.dsDiemCau,
    this.thuMoiFiles,
    this.typeReminder,
    this.typeRepeat,
    this.dateRepeat,
    this.days,
    this.bitLinkTrongHeThong,
    this.isDuyetKyThuat,
    this.id,
    this.isMulti,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeScheduleId'] = typeScheduleId;
    data['linhVucId'] = linhVucId;
    data['title'] = title;
    data['ngayBatDau'] = ngayBatDau;
    data['ngayKetThuc'] = ngayKetThuc;
    data['timeStart'] = timeStart;
    data['timeTo'] = timeTo;
    data['mucDo'] = mucDo;
    data['isLichLap'] = isLichLap;
    data['isNhacLich'] = isNhacLich;
    data['isAllDay'] = isAllDay;
    data['congKhai'] = congKhai;
    data['lichDonVi'] = lichDonVi;
    data['noiDung'] = noiDung;
    data['bit_HopTrucTuyen'] = bitHopTrucTuyen;
    if (chuTri != null) {
      data['chuTri'] = chuTri!.toJson();
    }
    data['diaDiemHop'] = diaDiemHop;
    if (phongHop != null) {
      data['phongHop'] = phongHop!.toJson();
    }
    if (phongHopThietBi != null) {
      data['phongHop_ThietBi'] =
          phongHopThietBi!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['bit_YeuCauDuyet'] = bitYeuCauDuyet;
    data['linkTrucTuyen'] = linkTrucTuyen;
    data['bit_TrongDonVi'] = bitTrongDonVi;
    if (dsDiemCau != null) {
      data['dsDiemCau'] = dsDiemCau!.map((v) => v.toJson()).toList();
    }
    data['thuMoiFiles'] = thuMoiFiles;
    data['typeReminder'] = typeReminder;
    data['typeRepeat'] = typeRepeat;
    data['dateRepeat'] = dateRepeat;
    data['days'] = days;
    data['bit_LinkTrongHeThong'] = bitLinkTrongHeThong;
    data['isDuyetKyThuat'] = isDuyetKyThuat;
    if (id != null) {
      data['id'] =id;
    }
    if (isMulti != null) {
      data['isMulti'] = isMulti;
    }
    return data;
  }


}

class ChuTri {
  String? donViId;
  String? canBoId;
  String? tenCanBo;
  String? tenCoQuan;
  String? dauMoiLienHe;
  String? soDienThoai;

  ChuTri({
    this.donViId,
    this.canBoId,
    this.tenCanBo,
    this.tenCoQuan,
    this.dauMoiLienHe,
    this.soDienThoai,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['donViId'] = donViId;
    data['canBoId'] = canBoId;
    data['tenCanBo'] = tenCanBo;
    data['tenCoQuan'] = tenCoQuan;
    data['dauMoiLienHe'] = dauMoiLienHe;
    data['soDienThoai'] = soDienThoai;
    return data;
  }
}

class PhongHop {
  String? phongHopId;
  String? noiDungYeuCau;
  String? ten;
  String? donViId;
  bool? bitTTDH;

  PhongHop(
      {this.phongHopId,
      this.noiDungYeuCau,
      this.ten,
      this.donViId,
      this.bitTTDH});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phongHopId'] = phongHopId;
    data['noiDungYeuCau'] = noiDungYeuCau;
    data['ten'] = ten;
    data['donViId'] = donViId;
    data['bit_TTDH'] = bitTTDH;
    return data;
  }
}

class PhongHopThietBi {
  String? tenThietBi;
  String? soLuong;

  PhongHopThietBi({this.tenThietBi, this.soLuong});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenThietBi'] = tenThietBi;
    data['soLuong'] = soLuong;
    return data;
  }

  PhongHopThietBi.fromJson(Map<String, dynamic> json) {
    tenThietBi = json['tenThietBi'];
    soLuong = json['soLuong'];
  }
}

class DsDiemCau {
  String? tenDiemCau;
  String? canBoDauMoiHoTen;
  String? canBoDauMoiChucVu;
  String? canBoDauMoiSDT;
  int? loaiDiemCau;
  String? id;
  String? id_LichHop;

  DsDiemCau({
    this.tenDiemCau,
    this.canBoDauMoiHoTen,
    this.canBoDauMoiChucVu,
    this.canBoDauMoiSDT,
    this.loaiDiemCau,
    this.id,
    this.id_LichHop,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenDiemCau'] = tenDiemCau;
    data['canBoDauMoi_HoTen'] = canBoDauMoiHoTen;
    data['canBoDauMoi_ChucVu'] = canBoDauMoiChucVu;
    data['canBoDauMoi_SDT'] = canBoDauMoiSDT;
    data['loaiDiemCau'] = loaiDiemCau;
    if (id != null) {
      data['id'] = id;
    }
    if (id_LichHop != null) {
      data['id_LichHop'] = id_LichHop;
    }
    return data;
  }

  String getLoaiDiemCau(){
    if(loaiDiemCau == 1){
      return S.current.diem_chinh;
    }else if(loaiDiemCau == 2){
      return S.current.diem_phu;
    }else{
      return '';
    }
  }
}
