import 'dart:developer';
import 'dart:io';

import 'package:ccvc_mobile/data/di/flutter_transformer.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/cupertino_loading.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DomainDownloadType { GATEWAY, COMMON, CCVC, QLNV, PAKN }

Future<String?> saveFile({
  required String fileName,
  required String url,
  Map<String, dynamic>? query,
  bool useBaseURL = true,
  DomainDownloadType downloadType = DomainDownloadType.GATEWAY,
}) async {
  late OverlayEntry overlayEntry = _showLoading();
  try {
    final OverlayState? overlayState = Overlay.of(MessageConfig.contextConfig!);
    overlayState?.insert(overlayEntry);
    final response = await provideDio(
      baseOption: downloadType,
      useBaseURL: useBaseURL,
    ).get(url, queryParameters: query);
    await _saveFile(fileName, response.data);
    overlayEntry.remove();
    MessageConfig.show(title: S.current.tai_file_thanh_cong);

    return null;
  } on Exception catch (e) {
    overlayEntry.remove();
    MessageConfig.show(
      title: S.current.tai_file_that_bai,
      messState: MessState.error,
    );
    return e.toString();
  }
}

Future<void> _saveFile(String _fileName, dynamic data) async {
  if (Platform.isAndroid) {
    try {
      const String dir = '/storage/emulated/0/Download';
      await writeFile(dir, _fileName, data);
    } catch (e) {
      final tempDir = await getExternalStorageDirectory();
      await writeFile(tempDir?.path ?? '', _fileName, data);
    }
  } else if (Platform.isIOS) {
    final tempDir = await getApplicationDocumentsDirectory();
    await writeFile(tempDir.path, _fileName, data);
  }
}

Future<void> writeFile(String path, String _fileName, dynamic data) async {
  int count = 1;
  final List<String> listName = _fileName.split('.');
  String nameFile = '';
  for (var index = 0; index < listName.length - 1; index++) {
    if (index != listName.length - 2) {
      nameFile += '${listName[index]}.';
    } else {
      nameFile += listName[index];
    }
  }
  final String extension = listName.last;
  String fullPath = '$path/$_fileName';
  File file = File(fullPath);
  while (file.existsSync()) {
    fullPath = '$path/$nameFile($count).$extension';
    count += 1;
    file = File(fullPath);
  }
  final raf = file.openSync(mode: FileMode.write);
  raf.writeFromSync(data);
  await raf.close();
}

int _connectTimeOut = 60000;

Dio provideDio({
  DomainDownloadType baseOption = DomainDownloadType.CCVC,
  bool useBaseURL = true,
}) {
  String url = '';
  final appConstants = Get.find<AppConstants>();
  switch (baseOption) {
    case DomainDownloadType.GATEWAY:
      url = appConstants.baseUrlGateWay;
      break;
    case DomainDownloadType.CCVC:
      url = appConstants.baseUrlCCVC;

      break;
    case DomainDownloadType.QLNV:
      url = appConstants.baseUrlQLNV;

      break;
    case DomainDownloadType.PAKN:
      url = appConstants.baseUrlPAKN;
      break;
    case DomainDownloadType.COMMON:
      url = appConstants.baseUrlCommon;
      break;
  }
  final options = BaseOptions(
    baseUrl: useBaseURL ? url : '',
    receiveTimeout: _connectTimeOut,
    connectTimeout: _connectTimeOut,
    followRedirects: false,
  );
  options.responseType = ResponseType.bytes;
  options.followRedirects = false;
  final dio = Dio(options);
  log('${dio.options}');
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

OverlayEntry _showLoading() {
  return OverlayEntry(
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.3),
        body: const Center(child: CupertinoLoading()),
      );
    },
  );
}
