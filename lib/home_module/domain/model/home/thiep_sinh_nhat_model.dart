import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:get/get.dart';

class ThiepSinhNhatModel{
 final String id;
 final String imgUrl;

  ThiepSinhNhatModel({required this.id,required this.imgUrl});
String get urlImgBase => '${Get.find<AppConstants>().baseUrlCCVC}/${imgUrl}';
}