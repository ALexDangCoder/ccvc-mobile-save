import 'package:ccvc_mobile/data/di/flutter_transformer.dart';
import 'package:ccvc_mobile/data/repository_impl/account_impl/account_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/home_impl/home_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/lich_lam_viec_dashbroad_impl/lich_lam_viec_dashbroad_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/manager_repo_impl/manager_repository_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/quan_ly_van_ban_impl/qlvb_respository_imlp.dart';
import 'package:ccvc_mobile/data/repository_impl/tinh_xa_huyen_impl/tinh_xa_huyen_impl.dart';
import 'package:ccvc_mobile/data/services/account_service.dart';
import 'package:ccvc_mobile/data/services/home_service/home_service.dart';
import 'package:ccvc_mobile/data/services/lich_lam_viec_dashbroad_service/lich_lam_viec_dashbroad_service.dart';
import 'package:ccvc_mobile/data/services/manager_service/manager_service.dart';
import 'package:ccvc_mobile/data/services/quan_ly_van_ban/qlvb_service.dart';
import 'package:ccvc_mobile/data/services/tinh_huyen_xa_service/tinh_huyen_xa_service.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/repository/home_repository/home_repository.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_dashbroad_repository/lich_lam_viec_dashbroad_repository.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/domain/repository/manager_repository.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/domain/repository/tinh_huyen_xa_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum BaseURLOption { GATE_WAY, COMMON, CCVC }

void configureDependencies() {
  Get.put(
    QuanLyVanBanClient(
      provideDio(baseOption: BaseURLOption.GATE_WAY),
    ),
  );
  Get.put<QLVBRepository>(
    QLVBImlp(Get.find()),
  );
  //login
  Get.put(AccountService(provideDio()));
  Get.put<AccountRepository>(
    AccountImpl(Get.find()),
  );

  Get.put(HomeServiceGateWay(provideDio(baseOption: BaseURLOption.GATE_WAY)));
  Get.put(HomeServiceCCVC(provideDio()));
  Get.put<HomeRepository>(HomeImpl(Get.find(), Get.find()));

  Get.put(ManagerService(provideDio()));
  Get.put<ManagerRepository>(
    ManagerRepositoryImpl(Get.find()),
  );

  Get.put(TinhHuyenXaService(provideDio()));
  Get.put<TinhHuyenXaRepository>(
    TinhXaHuyenRepositoryImpl(Get.find()),
  );

  Get.put(LichLamViecDashBroadService(provideDio()));
  Get.put<LichLamViecDashBroadRepository>(
    LichLamViecDashBroadImlp(Get.find()),
  );
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
