import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class DetailHuongDanSuDung {
  String? content;
  String? topic;
  String? type;
  String? id;
  String? title;
  String? order;
  bool? inUsed;
  bool? isDeleted;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;

  DetailHuongDanSuDung({
    this.content,
    this.topic,
    this.type,
    this.id,
    this.title,
    this.order,
    this.inUsed,
    this.isDeleted,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
  });
}

String addDomainImage(String content) {
  final appConstants = Get.find<AppConstants>();
  return content.replaceAll('src="/', 'src="${appConstants.baseUrlCCVC}/');
}
