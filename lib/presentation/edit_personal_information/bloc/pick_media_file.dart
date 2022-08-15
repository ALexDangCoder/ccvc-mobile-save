import 'dart:io';

import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/file_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const String TYPE_OF_FILE = 'type';
const String PATH_OF_FILE = 'path';
const String NAME_OF_FILE = 'name';
const String SIZE_OF_FILE = 'size';
const String EXTENSION_OF_FILE = 'extension';
const String VALID_FORMAT_OF_FILE = 'valid_format';
const String DOCUMENT_FILE = 'document_file';
const String MEDIA_VIDEO_FILE = 'media_video_file';
const String MEDIA_AUDIO_FILE = 'media_audio_file';
const String MEDIA_IMAGE_FILE = 'media_image_file';

Future<Map<String, dynamic>> pickMediaFile({
  required PickerType type,
}) async {
  final List<String> allowedExtensions = type.fileType;
  String _filePath = '';
  String _fileType = '';
  String _fileName = '';
  String _fileExtension = '';
  bool _validFormat = true;
  int _fileSize = 0;
  final tempDirectory = await getTemporaryDirectory();
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
  );
  if (result != null && result.files.isNotEmpty) {
    File file = File(result.files.first.path ?? '');
    if (Platform.isIOS) {
      file = await file.moveToTmpDirectory(
        '${tempDirectory.path}/${p.basename(file.path)}',
      );
    }
    _fileExtension = (result.files.single.extension ?? '').toUpperCase();
    _validFormat = allowedExtensions.contains(_fileExtension);
    if (PickerType.DOCUMENT.fileType.contains(_fileExtension)) {
      _fileType = DOCUMENT_FILE;
    } else {
      if (_fileExtension == 'MP4' || _fileExtension == 'WEBM') {
        _fileType = MEDIA_VIDEO_FILE;
      } else if (_fileExtension == 'MP3' ||
          _fileExtension == 'WAV' ||
          _fileExtension == 'OOG') {
        _fileType = MEDIA_AUDIO_FILE;
      } else {
        _fileType = MEDIA_IMAGE_FILE;
      }
    }
    _filePath = file.path;
    _fileSize = file.lengthSync();
    _fileName = p.basename(p.basename(file.path));
  } else {
    // User canceled the picker
  }
  return {
    TYPE_OF_FILE: _fileType,
    PATH_OF_FILE: _filePath,
    NAME_OF_FILE: _fileName,
    SIZE_OF_FILE: _fileSize,
    EXTENSION_OF_FILE: _fileExtension,
    VALID_FORMAT_OF_FILE: _validFormat,
  };
}

Future<Map<String, dynamic>> pickImageFunc({
  required String tittle,
  ImageSource source = ImageSource.gallery,
}) async {
  final Map<String, dynamic> _resultMap = {
    PATH_OF_FILE: '',
    SIZE_OF_FILE: 0,
    EXTENSION_OF_FILE: '',
    VALID_FORMAT_OF_FILE: '',
    NAME_OF_FILE: '',
  };
  try {
    final tempDirectory = await getTemporaryDirectory();
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null) {
      return _resultMap;
    }
    File file = File(newImage.path);
    if (Platform.isIOS) {
      file = await file.moveToTmpDirectory(
        '${tempDirectory.path}/${p.basename(newImage.path)}',
      );
    }
    final extension = (p.extension(file.path)).replaceAll('.', '');
    _resultMap[EXTENSION_OF_FILE] = extension;
    _resultMap[VALID_FORMAT_OF_FILE] =
        PickerType.IMAGE_FILE.fileType.contains(extension.toUpperCase());
    _resultMap[SIZE_OF_FILE] = file.lengthSync();
    _resultMap[PATH_OF_FILE] = file.path;
    _resultMap[NAME_OF_FILE] = p.basename(p.basename(file.path));
    return _resultMap;
  } on PlatformException catch (e) {
    final permission =
        Platform.isIOS ? Permission.photosAddOnly : Permission.storage;
    final status = await permission.status;
    if (status.isDenied) {
      await MessageConfig.showDialogSetting();
    }
    throw 'Cant upload image $e';
  }
}
