import 'package:ccvc_mobile/data/di/flutter_transformer.dart';
import 'package:ccvc_mobile/data/repository_impl/account_impl/account_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/lich_hop/lich_hop_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/lich_lam_viec_impl/lich_lam_viec_impl.dart';
import 'package:ccvc_mobile/data/repository_impl/quan_ly_van_ban_impl/qlvb_respository_imlp.dart';
import 'package:ccvc_mobile/data/repository_impl/thanh_phan_tham_gia_impl/thanh_phan_tham_gia_impl.dart';
import 'package:ccvc_mobile/data/services/account_service.dart';
import 'package:ccvc_mobile/data/services/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_service.dart';
import 'package:ccvc_mobile/data/services/lich_hop/hop_services.dart';
import 'package:ccvc_mobile/data/services/lich_lam_viec_service/lich_lam_viec_service.dart';
import 'package:ccvc_mobile/data/services/quan_ly_van_ban/qlvb_service.dart';
import 'package:ccvc_mobile/data/services/thanh_phan_tham_gia/thanh_phan_tham_gia_service.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/ket_noi_module/data/repository_impl/ket_noi_repo.dart';
import 'package:ccvc_mobile/ket_noi_module/data/service/ket_noi_service.dart';
import 'package:ccvc_mobile/ket_noi_module/domain/repository/ket_noi_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/data/repository_impl/tien_ich_repository_impl.dart';
import 'package:ccvc_mobile/tien_ich_module/data/service/tien_ich_service.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
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
  Get.put(AccountService(provideDio(baseOption: BaseURLOption.COMMON)));
  Get.put(
      AccountServiceGateWay(provideDio(baseOption: BaseURLOption.GATE_WAY)));
  Get.put<AccountRepository>(
    AccountImpl(Get.find(), Get.find()),
  );

  // lich lam viec
  Get.put(
    LichLamViecService(
      provideDio(baseOption: BaseURLOption.GATE_WAY),
    ),
  );
  Get.put<LichLamViecRepository>(
    LichLamViecImlp(Get.find()),
  );

  Get.put(
    ThanhPhanThamGiaService(provideDio(baseOption: BaseURLOption.GATE_WAY)),
  );
  Get.put<ThanhPhanThamGiaReponsitory>(ThanhPhanThamGiaImpl(Get.find()));

  Get.put(
    HopServices(
      provideDio(baseOption: BaseURLOption.GATE_WAY),
    ),
  );
  Get.put<HopRepository>(HopRepositoryImpl(Get.find()));

  Get.put(
    BaoChiMangXaHoiService(
      provideDio(),
    ),
  );
  Get.put<BaoChiMangXaHoiRepository>(BaoChiMangXaHoiImpl(Get.find()));
  Get.put(
    KetNoiService(
      provideDio(),
    ),
  );
  Get.put<KetNoiRepository>(KetNoiRepoImpl(Get.find()));

  Get.put(
    TienIchService(
      provideDio(),
    ),
  );
  Get.put<TienIchRepository>(TienIchRepositoryImpl(Get.find()));
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
