import 'package:ccvc_mobile/data/di/module.dart';
import 'package:get/get.dart';

import '/home_module/data/repository_impl/home_impl/home_impl.dart';
import '/home_module/data/service/home_service/home_service.dart';
import '/home_module/domain/repository/home_repository/home_repository.dart';

void configureDependenciesHome() {
  Get.put(HomeServiceGateWay(provideDio(baseOption: BaseURLOption.GATE_WAY)));
  Get.put(HomeServiceCCVC(provideDio()));
  Get.put(HomeServiceCommon(provideDio(baseOption: BaseURLOption.COMMON)));
  Get.put<HomeRepository>(HomeImpl(Get.find(), Get.find(),Get.find()));
}
