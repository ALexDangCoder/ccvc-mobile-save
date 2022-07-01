import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class NetworkHandler {
  static AppException handleError(DioError error) {
    return _handleError(error);
  }

  static AppException _handleError(error) {
    if (error is! DioError) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    if (_isNetWorkError(error)) {
      return TimeoutException();
    }
    final parsedException = _parseError(error);
    final errorCode = error.response?.statusCode;
    if (errorCode == 503) {
      return MaintenanceException();
    }

    if (errorCode == 401) {
      handleUnauthorized();
    }

    try {
      if (error.response?.data['message'] != null) {
        return AppException(
          S.current.error,
          error.response?.data['message'] ?? S.current.something_went_wrong,
          error.response?.statusCode,
        );
      } else {
        return parsedException;
      }
    } catch (e) {
      return parsedException;
    }
  }

  static Future<void> handleUnauthorized() async {
    final AccountRepository _loginRepo = Get.find();
    //API LỖI
    // await _loginRepo.refreshToken(
    //   PrefsService.getToken(),
    //   PrefsService.getRefreshToken(),
    final rs = await _loginRepo.login(
      PrefsService.getLoginUserName(),
      PrefsService.getLoginPassWord(),
      APP_CODE,
    );
    rs.when(success: (res) {
      PrefsService.saveToken(res.dataUser?.accessToken ?? '');
      PrefsService.saveRefreshToken(res.dataUser?.refreshToken ?? '');
    }, error: (error) {});
  }

  static bool _isNetWorkError(DioError error) {
    final errorType = error.type;
    switch (errorType) {
      case DioErrorType.cancel:
        return true;
      case DioErrorType.connectTimeout:
        return true;
      case DioErrorType.receiveTimeout:
        return true;
      case DioErrorType.sendTimeout:
        return true;
      case DioErrorType.other:
        return true;
      case DioErrorType.response:
        return false;
      default:
        return true;
    }
  }

  static AppException _parseError(DioError error) {
    if (error.response?.data is! Map<String, dynamic>) {
      return AppException(S.current.error, S.current.something_went_wrong,
          error.response?.statusCode);
    }
    return AppException(S.current.error, S.current.something_went_wrong,
        error.response?.statusCode);
  }
}
