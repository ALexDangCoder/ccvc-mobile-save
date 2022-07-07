import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/account/unauthorized_model.dart';

import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:get/get.dart';

class HandleUnauthorized {
  static final List<_ResultRefreshTokenCallBack> _callBackUnauthorized = [];
  static void resignRefreshToken({
    required Function(String) onRefreshToken,
    required Function(AppException) onError,
  }) {
    if (_callBackUnauthorized.isEmpty) {
      _handleUnauthorized().then((value) {
        value.when(
          success: (res)  {
             PrefsService.saveToken(res.accessToken);
             PrefsService.saveRefreshToken(
              res.refreshToken,
            );
            for (final element in _callBackUnauthorized) {
              element.onRefreshToken.call(res.accessToken);
            }
            _callBackUnauthorized.clear();
          },
          error: (error) {
            for (final element in _callBackUnauthorized) {
              element.onError.call(error);
            }
            _callBackUnauthorized.clear();
          },
        );
      });
    }
    _callBackUnauthorized
        .add(_ResultRefreshTokenCallBack(onRefreshToken, onError));
  }

  static Future<Result<UnauthorizedModel>> _handleUnauthorized() async {
    final AccountRepository _loginRepo = Get.find();

    return _loginRepo.refreshToken(
      PrefsService.getToken(),
      PrefsService.getRefreshToken(),
    );
  }
}

class _ResultRefreshTokenCallBack {
  final Function(String) onRefreshToken;
  final Function(AppException) onError;
  _ResultRefreshTokenCallBack(this.onRefreshToken, this.onError);
}
