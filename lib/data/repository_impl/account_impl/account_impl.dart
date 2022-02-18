import 'package:ccvc_mobile/data/request/account_request.dart';
import 'package:ccvc_mobile/data/response/account/login_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/account_service.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';

class AccountImpl implements AccountRepository {
  final AccountService _accountService;

  AccountImpl(this._accountService);

  @override
  Future<Result<DataUser>> login(
      String userName, String passWord, String appCode) {
    return runCatchingAsync<LoginResponse, DataUser>(
        () => _accountService.login(LoginRequest(
            username: userName, password: passWord, appCode: appCode)),
        (response) => response.data.toDomainDataUser());
  }
}
