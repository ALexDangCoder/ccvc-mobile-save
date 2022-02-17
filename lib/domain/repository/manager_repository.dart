import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';

mixin ManagerRepository {
  Future<Result<ManagerPersonalInformationModel>> getInfo(
    String id,
  );
}
