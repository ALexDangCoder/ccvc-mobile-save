import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

class ListPhienHopModel {
  String? id;
  String? lichHopId;
  String? tieuDe;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? canBoId;
  String? donViId;
  int? vaiTroThamGia;
  int? thuTu;
  String? noiDung;
  String? hoTen;
  String? createBy;
  List<Files> files;

  ListPhienHopModel({
    required this.id,
    required this.lichHopId,
    required this.tieuDe,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.canBoId,
    required this.donViId,
    required this.vaiTroThamGia,
    required this.thuTu,
    required this.noiDung,
    required this.hoTen,
    required this.createBy,
    required this.files,
  });

  String dateTimeView() {
    return '${DateTime.parse(thoiGianBatDau ?? '').formatApiListBieuQuyetMobile} - ${DateTime.parse(thoiGianKetThuc ?? '').formatApiDetailSSAM}';
  }
}

class Files {
  String? id;
  String? name;
  String? extension;
  String? size;
  String? path;
  String? entityId;
  String? entityName;

  Files({
    required this.id,
    required this.name,
    required this.extension,
    required this.size,
    required this.path,
    required this.entityId,
    required this.entityName,
  });


  double getSize(){
    try{
      return double.parse(size ?? '');
    }catch(e){
      return 0;
    }
  }
}
