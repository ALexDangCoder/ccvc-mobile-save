import '/home_module/utils/extensions/date_time_extension.dart';

import '/home_module/utils/constants/app_constants.dart';

class YKienNguoiDanModel {
  final String id;
  final String kyHieu;
  final String noiGui;
  final String status;
  final String code;
  final String title;
  final String taskId;
  final int soNgayDenHan;
  final String hanXuLy;

  YKienNguoiDanModel(
      {required this.kyHieu,
      required this.noiGui,
      required this.status,
      required this.code,
      required this.title,
      this.hanXuLy = '',
      this.id = '',
      this.taskId = '',
      this.soNgayDenHan = 0});
  String get hanXuLyCover{
    try{
      return DateTime.parse(hanXuLy).toStringWithListFormat;
    }catch(e){
      return '';
    }
  }

}
