import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> saveFile(String _fileName, dynamic data, {bool? http}) async {
  bool success = false;
  if (http == true) {
    final HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    const String dir = '/storage/emulated/0/Download';
    final request = await httpClient.getUrl(Uri.parse(data));
    final responses = await request.close();
    if (responses.statusCode == 200) {
      final bytes = await consolidateHttpClientResponseBytes(responses);
      if(Platform.isAndroid){
        try {
          filePath = '$dir/$_fileName';
          file = File(filePath);
          await file.writeAsBytes(bytes);
        } catch(e){
          final tempDir = await getExternalStorageDirectory();
          file = File(tempDir?.path ?? '');
          await file.writeAsBytes(bytes);
        }
      } else {
        final tempDir = await getApplicationDocumentsDirectory();
        file = File(tempDir.path);
        await file.writeAsBytes(bytes);
      }
      success = true;
    } else {
      success = false;
    }
  } else {
    final response = await Dio()
        .get(
          data,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 60000,
          ),
        )
        .catchError((error) {});
    final dynamic dataSave = response;
    if (Platform.isAndroid) {
      try {
        const String dir = '/storage/emulated/0/Download';
        await writeFile(dir, _fileName, dataSave);
      } catch (e) {
        final tempDir = await getExternalStorageDirectory();
        await writeFile(tempDir?.path ?? '', _fileName, dataSave);
        success = true;
      }
    } else if (Platform.isIOS) {
      final tempDir = await getApplicationDocumentsDirectory();
      await writeFile(tempDir.path, _fileName, dataSave);
      success = false;
    }
  }
  return success;
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
