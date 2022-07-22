import 'package:ccvc_mobile/generated/l10n.dart';

class AppException implements Exception {
  String title;
  String message;
  int? code;

  AppException(this.title, this.message, [this.code]);

  @override
  String toString() => '$title $message';
}

class CommonException extends AppException {
  CommonException() : super(S.current.error, S.current.something_went_wrong);
}

class NetworkException extends AppException {
  NetworkException() : super(S.current.error, S.current.no_internet);
}

class NoNetworkException extends NetworkException {

}

class TimeoutException extends NetworkException {}

class ExpiredException extends NetworkException {}

class UnauthorizedException extends NetworkException {}

class MaintenanceException extends NetworkException {}
