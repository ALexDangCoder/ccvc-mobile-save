import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';

class FileUploadModel {
  String id;
  String idFileGoc;
  String processId;
  String ten;
  String duongDan;
  String duoiMoRong;
  String dungLuong;
  String kieuDinhKem;
  bool isSign;
  bool qrCreated;
  int index;
  String nguoiTaoId;

  FileUploadModel({
    this.id = '',
    this.idFileGoc = '',
    this.processId = '',
    this.ten = '',
    this.duongDan = '',
    this.duoiMoRong = '',
    this.dungLuong = '',
    this.kieuDinhKem = '',
    this.isSign = false,
    this.qrCreated = false,
    this.index = 0,
    this.nguoiTaoId = '',
  });
  FileRequest toRequest() => FileRequest(
        id: id,
        idFileGoc: idFileGoc,
        processId: processId,
        ten: ten,
        duongDan: duongDan,
        duoiMoRong: duoiMoRong,
        dungLuong: dungLuong,
        kieuDinhKem: kieuDinhKem,
        isSign: isSign,
        qrCreated: qrCreated,
        index: index,
        nguoiTaoId: nguoiTaoId,
      );
}
