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

  TaoLichHopRequest(
      {this.typeScheduleId,
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
      this.bitLinkTrongHeThong});

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

  ChuTri(
      {this.donViId,
      this.canBoId,
      this.tenCanBo,
      this.tenCoQuan,
      this.dauMoiLienHe,
      this.soDienThoai});

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
}

class DsDiemCau {
  String? tenDiemCau;
  String? canBoDauMoiHoTen;
  String? canBoDauMoiChucVu;
  String? canBoDauMoiSDT;
  int? loaiDiemCau;

  DsDiemCau(
      {this.tenDiemCau,
      this.canBoDauMoiHoTen,
      this.canBoDauMoiChucVu,
      this.canBoDauMoiSDT,
      this.loaiDiemCau});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenDiemCau'] = tenDiemCau;
    data['canBoDauMoi_HoTen'] = canBoDauMoiHoTen;
    data['canBoDauMoi_ChucVu'] = canBoDauMoiChucVu;
    data['canBoDauMoi_SDT'] = canBoDauMoiSDT;
    data['loaiDiemCau'] = loaiDiemCau;
    return data;
  }
}
