import 'package:ccvc_mobile/data/di/flutter_transformer.dart';
import 'package:ccvc_mobile/data/repository_impl/account_impl/account_impl.dart';

import 'package:ccvc_mobile/data/repository_impl/home_impl/home_impl.dart';

import 'package:ccvc_mobile/data/services/account_service.dart';
import 'package:ccvc_mobile/data/services/home_service/home_service.dart';


import 'package:ccvc_mobile/data/repository_impl/manager_repo_impl/manager_repository_impl.dart';

import 'package:ccvc_mobile/data/services/manager_service.dart';

import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/repository/home_repository/home_repository.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/domain/repository/manager_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void configureDependencies() {
  //login
  Get.put(AccountService(provideDio()));
  Get.put<AccountRepository>(
    AccountImpl(Get.find()),
  );

  Get.put(HomeService(provideDio()));
  Get.put<HomeRepository>(HomeImpl(Get.find()));

  Get.put(ManagerService(provideDio()));
  Get.put<ManagerRepository>(
    ManagerRepositoryImpl(Get.find()),
  );

}

int _connectTimeOut = 60000;

Dio provideDio() {
  final appConstants = Get.find<AppConstants>();
  final options = BaseOptions(
    baseUrl: appConstants.baseUrl,
    receiveTimeout: _connectTimeOut,
    connectTimeout: _connectTimeOut,
    followRedirects: false,
  );
  final dio = Dio(options);
  dio.transformer = FlutterTransformer();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.baseUrl = options.baseUrl;
        final token = PrefsService.getToken();
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) => handler.next(e),
    ),
  );
  if (Foundation.kDebugMode) {
    dio.interceptors.add(dioLogger());
  }
  return dio;
}

PrettyDioLogger dioLogger() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    maxWidth: 100,
  );
}
