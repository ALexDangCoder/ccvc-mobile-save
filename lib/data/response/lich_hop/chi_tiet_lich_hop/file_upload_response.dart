import 'package:ccvc_mobile/domain/model/lich_hop/file_upload_model.dart';

class FileUploadResponse {
  List<Data>? data;
  bool? isSuccess;

  FileUploadResponse({this.data, this.isSuccess});

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
  }
}

class Data {
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

  Data({
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
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    idFileGoc = json['IdFileGoc'];
    processId = json['ProcessId'];
    ten = json['Ten'];
    duongDan = json['DuongDan'];
    duoiMoRong = json['DuoiMoRong'];
    dungLuong = json['DungLuong'];
    kieuDinhKem = json['KieuDinhKem'];
    isSign = json['IsSign'];
    qrCreated = json['QrCreated'];
    index = json['Index'];
    nguoiTaoId = json['NguoiTaoId'];
  }
  FileUploadModel toModel() => FileUploadModel(
        id: id ?? '',
        idFileGoc: idFileGoc ?? '',
        processId: processId ?? '',
        ten: ten ?? '',
        duongDan: duongDan ?? '',
        duoiMoRong: duoiMoRong ?? '',
        dungLuong: dungLuong ?? '',
        kieuDinhKem: kieuDinhKem ?? '',
        isSign: isSign ?? false,
        qrCreated: qrCreated ?? false,
        index: index ?? 0,
        nguoiTaoId: nguoiTaoId ?? '',
      );
}
