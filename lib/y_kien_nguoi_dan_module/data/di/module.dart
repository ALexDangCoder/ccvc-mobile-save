
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '/home_module/data/repository_impl/home_impl/home_impl.dart';
import '/home_module/data/service/home_service/home_service.dart';
import '/home_module/domain/repository/home_repository/home_repository.dart';
import 'flutter_transformer.dart';

enum BaseURLOption { GATE_WAY, COMMON, CCVC }

void configureDependenciesHome() {


  Get.put(HomeServiceGateWay(provideDio(baseOption: BaseURLOption.GATE_WAY)));
  Get.put(HomeServiceCCVC(provideDio()));
  Get.put<HomeRepository>(HomeImpl(Get.find(), Get.find()));



}

int _connectTimeOut = 60000;

Dio provideDio({BaseURLOption baseOption = BaseURLOption.CCVC}) {
  final appConstants = Get.find<AppConstants>();
  String baseUrl = appConstants.baseUrlCCVC;
  switch (baseOption) {
    case BaseURLOption.GATE_WAY:
      baseUrl = appConstants.baseUrlGateWay;
      break;
    case BaseURLOption.COMMON:
      baseUrl = appConstants.baseUrlCommon;
      break;
    case BaseURLOption.CCVC:
      baseUrl = appConstants.baseUrlCCVC;
      break;
  }
  final options = BaseOptions(
    baseUrl: baseUrl,
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
