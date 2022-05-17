import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

const String TYPE_OF_FILE = 'type';
const String PATH_OF_FILE = 'path';
const String  NAME_OF_FILE = 'name';
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
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type:  FileType.custom,
    allowedExtensions: allowedExtensions,
  );
  if (result != null) {
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
    _filePath = result.files.single.path ?? '';
    _fileSize = result.files.single.size;
    _fileName = result.files.single.name;
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
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null) {
      return _resultMap;
    }
    final extension = (p.extension(newImage.path)).replaceAll('.', '');
    _resultMap[EXTENSION_OF_FILE] = extension;
    _resultMap[VALID_FORMAT_OF_FILE] =
        PickerType.IMAGE_FILE.fileType.contains(extension.toUpperCase());
    _resultMap[SIZE_OF_FILE] =
        File(newImage.path).readAsBytesSync().lengthInBytes;
    _resultMap[PATH_OF_FILE] = newImage.path;
    _resultMap[NAME_OF_FILE] = newImage.name;
    return _resultMap;
  } on PlatformException catch (e) {
    throw 'Cant upload image $e';
  }
}

enum PickerType { MEDIA_FILE, IMAGE_FILE, DOCUMENT, ALL }

extension GetTypeByName on PickerType {
  List<String> get fileType {
    switch (this) {
      case PickerType.MEDIA_FILE:
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF'
        ];
      case PickerType.IMAGE_FILE:
        return ['JPG', 'PNG', 'GIF', 'JPEG'];
      case PickerType.DOCUMENT:
        return ['DOC', 'DOCX', 'PDF', 'XLS', 'XLSX'];
      case PickerType.ALL:
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF',
          'JPG',
          'PNG',
          'GIF',
          'JPEG',
          'DOC',
          'DOCX',
          'PDF',
          'XLS',
          'XLSX'
        ];
    }
  }
}
