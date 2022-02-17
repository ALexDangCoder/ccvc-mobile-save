import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/repository/manager_repository.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class ManagerPersonalInformationCubit
    extends BaseCubit<ManagerPersonalInformationState> {
  ManagerPersonalInformationCubit() : super(BaseChooseTimeInitial());

  BehaviorSubject<ManagerPersonalInformationModel> managerPersonSubject =
      BehaviorSubject();

  Stream<ManagerPersonalInformationModel> get managerStream =>
      managerPersonSubject.stream;

  ManagerRepository get _managerRepo => Get.find();
  ManagerPersonalInformationModel managerPersonalInformationModel =
      ManagerPersonalInformationModel();

  Future<void> getInfo({
    String id = 'b5a6b584-b4a1-4337-900d-ad2e499ad6c0',
  }) async {
    final result = await _managerRepo.getInfo(id);
    result.when(
      success: (res) {
        managerPersonalInformationModel = res;
        managerPersonSubject.sink.add(managerPersonalInformationModel);
      },
      error: (error) {},
    );
  }
}
