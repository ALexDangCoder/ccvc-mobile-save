import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

const String TYPE_OF_FILE = 'type';
const String PATH_OF_FILE = 'path';
const String SIZE_OF_FILE = 'size';
const String EXTENSION_OF_FILE = 'extension';
const String VALID_FORMAT_OF_FILE = 'valid_format';
const String NAME_OF_FILE = 'name';
const String FILE_RESULT = 'file_result';

const String MEDIA_VIDEO_FILE = 'video';
const String MEDIA_IMAGE_FILE = 'image';
const String MEDIA_AUDIO_FILE = 'audio';
const String DOCUMENT_FILE = 'document';
const String AVATAR_PHOTO = 'AVATAR';
const String COVER_PHOTO = 'COVER_PHOTO';
const String FEATURE_PHOTO = 'FEATURE_PHOTO';
const String VIDEO_ACTIVITY = 'video/MP4';

Future<Map<String, dynamic>> pickFile() async {
  String _filePath = '';
  String _fileExtension = '';
  int _fileSize = 0;
  String _fileName = '';
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
}

Future<Map<String, dynamic>> pickImage({bool fromCamera = false}) async {
  final Map<String, dynamic> _resultMap = {
    PATH_OF_FILE: '',
    SIZE_OF_FILE: 0,
    EXTENSION_OF_FILE: '',
    NAME_OF_FILE: '',
    FILE_RESULT: '',
  };
  try {
    final newImage = await ImagePicker().pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    if (newImage == null) {
      return _resultMap;
    }
    final extension = (p.extension(newImage.path)).replaceAll('.', '');
    _resultMap[EXTENSION_OF_FILE] = extension;
    _resultMap[SIZE_OF_FILE] =
        File(newImage.path).readAsBytesSync().lengthInBytes;
    _resultMap[PATH_OF_FILE] = newImage.path;
    _resultMap[NAME_OF_FILE] = p.basename(p.basename(newImage.path));
    _resultMap[FILE_RESULT] = newImage;
    return _resultMap;
  } on PlatformException catch (e) {
    throw 'Cant upload image $e';
  }
}
