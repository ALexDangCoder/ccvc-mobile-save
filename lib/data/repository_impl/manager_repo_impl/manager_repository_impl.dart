import 'package:ccvc_mobile/data/response/manager_personal_information/manager_personal_information_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/manager_service/manager_service.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/repository/manager_repository.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final ManagerService _managerService;

  ManagerRepositoryImpl(this._managerService);

  @override
  Future<Result<ManagerPersonalInformationModel>> getInfo(String id) {
    return runCatchingAsync<ManagerPersonalInformationResponse,
        ManagerPersonalInformationModel>(
      () => _managerService.getInfo(id),
      (response) => response.data.toModel(),
    );
  }
}
