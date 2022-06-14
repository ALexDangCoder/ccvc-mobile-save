import 'dart:developer';
import 'dart:io';

import 'package:ccvc_mobile/data/di/flutter_transformer.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DomainDownloadType { GATEWAY, COMMON, CCVC, QLNV, PAKN }
Future<String?> saveFile(
    {bool? http,
    required String fileName,
    required String url,
    Map<String, dynamic>? query,
    DomainDownloadType downloadType = DomainDownloadType.GATEWAY}) async {
  try {
    final response = await provideDio(baseOption: downloadType)
        .post(url, queryParameters: query);
    await _saveFile(fileName, response.data);
    return null;
  } on Exception catch (e) {
    return e.toString();
  }
  // bool success = false;

  // if (http == true) {
  //   final HttpClient httpClient = HttpClient();
  //   File file;
  //   String filePath = '';
  //   const String dir = '/storage/emulated/0/Download';
  //   final request = await httpClient.getUrl(Uri.parse(data));
  //   final responses = await request.close();
  //   if (responses.statusCode == 200) {
  //     final bytes = await consolidateHttpClientResponseBytes(responses);
  //     if (Platform.isAndroid) {
  //       try {
  //         const String dir = '/storage/emulated/0/Download';
  //         await writeFile(dir, _fileName, bytes);
  //       } catch (e) {
  //         final tempDir = await getExternalStorageDirectory();
  //         await writeFile(tempDir?.path ?? '', _fileName, bytes);
  //         success = true;
  //       }
  //     } else if (Platform.isIOS) {
  //       final tempDir = await getApplicationDocumentsDirectory();
  //       await writeFile(tempDir.path, _fileName, bytes);
  //       success = true;
  //     }
  //   } else {
  //     success = false;
  //   }
  // } else {
  //   final response = await Dio()
  //       .get(
  //         data,
  //         queryParameters: query,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           receiveTimeout: 60000,
  //         ),
  //       )
  //       .catchError((error) {});
  //   final dynamic dataSave = response.data;
  //   if (Platform.isAndroid) {
  //     try {
  //       const String dir = '/storage/emulated/0/Download';
  //       await writeFile(dir, _fileName, dataSave);
  //     } catch (e) {
  //       final tempDir = await getExternalStorageDirectory();
  //       await writeFile(tempDir?.path ?? '', _fileName, dataSave);
  //       success = true;
  //     }
  //   } else if (Platform.isIOS) {
  //     final tempDir = await getApplicationDocumentsDirectory();
  //     await writeFile(tempDir.path, _fileName, dataSave);
  //     success = false;
  //   }
  // }
  // return success;
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
  log('${fullPath}');
  final raf = file.openSync(mode: FileMode.write);
  raf.writeFromSync(data);
  await raf.close();
}

int _connectTimeOut = 60000;
Dio provideDio({DomainDownloadType baseOption = DomainDownloadType.CCVC}) {
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
    baseUrl: url,
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
