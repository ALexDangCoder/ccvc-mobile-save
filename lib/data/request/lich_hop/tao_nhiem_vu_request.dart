class ThemNhiemVuRequest {
  String? processTypeId;
  String? idCuocHop;
  String? processContent;
  String? hanXuLyVPCP;
  String? hanXuLy;
  List<DanhSachVanBanRequest> danhSachVanBan;
  List<MeTaDaTaRequest>? metaData;

  ThemNhiemVuRequest({
    this.processTypeId,
    this.idCuocHop,
    this.processContent,
    this.hanXuLyVPCP,
    this.hanXuLy,
    this.danhSachVanBan = const [],
    this.metaData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProcessTypeId'] = processTypeId;
    data['IdCuocHop'] = idCuocHop;
    data['ProcessContent'] = processContent;
    data['HanXuLyVPCP'] = hanXuLyVPCP;
    data['HanXuLy'] = hanXuLy;

      data['danhSachVanBan'] = danhSachVanBan.map((v) => v.toJson()).toList();

    if (metaData != null) {
      data['MetaData'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DanhSachVanBanRequest {
  String? soVanBan;
  String? trichYeu;
  String? ngayVanBan;
  String? hinhThucVanBan;
  List<FileRequest>? file;

  DanhSachVanBanRequest({
    this.soVanBan,
    this.trichYeu,
    this.ngayVanBan,
    this.hinhThucVanBan,
    this.file,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SoVanBan'] = soVanBan;
    data['TrichYeu'] = trichYeu;
    data['NgayVanBan'] = ngayVanBan;
    data['HinhThucVanBan'] = hinhThucVanBan;
    if (file != null) {
      data['File'] = file!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FileRequest {
  String? id;
  String? idFileGoc;
  String? processId;
  String? ten;
  String? duongDan;
  String? duoiMoRong;
  String? dungLuong;
  String? kieuDinhKem;
  bool? isSign;
  bool? qrCreated;
  int? index;
  String? nguoiTaoId;
  String? nguoiTao;
  String? pathIOC;

  FileRequest({
    this.id,
    this.idFileGoc,
    this.processId,
    this.ten,
    this.duongDan,
    this.duoiMoRong,
    this.dungLuong,
    this.kieuDinhKem,
    this.isSign,
    this.qrCreated,
    this.index,
    this.nguoiTaoId,
    this.nguoiTao,
    this.pathIOC,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['IdFileGoc'] = idFileGoc;
    data['ProcessId'] = processId;
    data['Ten'] = ten;
    data['DuongDan'] = duongDan;
    data['DuoiMoRong'] = duoiMoRong;
    data['DungLuong'] = dungLuong;
    data['KieuDinhKem'] = kieuDinhKem;
    data['IsSign'] = isSign;
    data['QrCreated'] = qrCreated;
    data['Index'] = index;
    data['NguoiTaoId'] = nguoiTaoId;
    data['NguoiTao'] = nguoiTao;
    data['PathIOC'] = pathIOC;
    return data;
  }
}

class MeTaDaTaRequest {
  String? key;
  String? value;

  MeTaDaTaRequest({this.key, this.value});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Key'] = key;
    data['Value'] = value;
    return data;
  }
}
