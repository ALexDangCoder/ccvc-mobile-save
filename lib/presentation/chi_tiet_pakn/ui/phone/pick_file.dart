import 'dart:io';

import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

const String TYPE_OF_FILE = 'type';
const String PATH_OF_FILE = 'path';
const String SIZE_OF_FILE = 'size';
const String EXTENSION_OF_FILE = 'extension';
const String VALID_FORMAT_OF_FILE = 'valid_format';
const String NAME_OF_FILE = 'name';
const String FILE_RESULT = 'file_result';

const String MEDIA_VIDEO = 'VIDEO';
const String MP3 = 'MP3';
const String MP4 = 'MP4';
const String APK = 'APK';
const String IPA = 'IPA';
const String DEB = 'DEB';
const String GIF = 'GIF';

Future<Map<String, dynamic>> pickFile() async {
  String _filePath = '';
  String _fileExtension = '';
  int _fileSize = 0;
  String _fileName = '';
  try {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _fileExtension = (result.files.single.extension ?? '').toUpperCase();
      _filePath = result.files.single.path ?? '';
      _fileSize = result.files.single.size;
      _fileName = p.basename(_filePath);
    } else {
      return {};
    }
    return {
      PATH_OF_FILE: _filePath,
      SIZE_OF_FILE: _fileSize,
      EXTENSION_OF_FILE: _fileExtension,
      NAME_OF_FILE: _fileName,
      FILE_RESULT: result.paths.map((path) => File(path!)).toList()
    };
  } on PlatformException catch (e) {
    const permission = Permission.storage;
    final status = await permission.status;
    if (status.isPermanentlyDenied) {
      await MessageConfig.showDialogSetting();
    }
    throw 'Cant pick file $e';
  }
}

Future<Map<String, dynamic>> pickImageAndroid() async {
  final Map<String, dynamic> _resultMap = {
    PATH_OF_FILE: '',
    SIZE_OF_FILE: 0,
    EXTENSION_OF_FILE: '',
    NAME_OF_FILE: '',
    FILE_RESULT: '',
  };
  const permission = Permission.storage;
  final status = await permission.status;
  if (status.isGranted || status.isLimited) {
    try {
      final newImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (newImage == null) {
        return _resultMap;
      }
      final extension = (p.extension(newImage.path)).replaceAll('.', '');
      _resultMap[EXTENSION_OF_FILE] = extension.toUpperCase();
      _resultMap[SIZE_OF_FILE] =
          File(newImage.path).readAsBytesSync().lengthInBytes;
      _resultMap[PATH_OF_FILE] = newImage.path;
      _resultMap[NAME_OF_FILE] = p.basename(p.basename(newImage.path));
      _resultMap[FILE_RESULT] = [File(newImage.path)];
      return _resultMap;
    } on PlatformException catch (e) {
      throw 'Cant upload images $e';
    }
  } else {
    await MessageConfig.showDialogSetting();
    return {};
  }
}

Future<Map<String, dynamic>> pickImageIos({bool fromCamera = false}) async {
  final Map<String, dynamic> _resultMap = {
    PATH_OF_FILE: '',
    SIZE_OF_FILE: 0,
    EXTENSION_OF_FILE: '',
    NAME_OF_FILE: '',
    FILE_RESULT: '',
  };
  try {
    final newImage = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (newImage == null) {
      return _resultMap;
    }
    final extension = (p.extension(newImage.path)).replaceAll('.', '');
    _resultMap[EXTENSION_OF_FILE] = extension.toUpperCase();
    _resultMap[SIZE_OF_FILE] =
        File(newImage.path).readAsBytesSync().lengthInBytes;
    _resultMap[PATH_OF_FILE] = newImage.path;
    _resultMap[NAME_OF_FILE] = p.basename(p.basename(newImage.path));
    _resultMap[FILE_RESULT] = [File(newImage.path)];
    return _resultMap;
  } on PlatformException catch (e) {
    final permission =
        !fromCamera ? Permission.photosAddOnly : Permission.camera;
    final status = await permission.status;
    if (status.isDenied) {
      await MessageConfig.showDialogSetting();
    }
    throw 'Cant upload images $e';
  }
}
