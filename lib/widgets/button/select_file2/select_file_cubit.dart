import 'dart:io';

import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:rxdart/rxdart.dart';

class SelectFileCubit2 {
  BehaviorSubject<bool> needRebuildListFile = BehaviorSubject();
  BehaviorSubject<List<FileModel>> fileFromApiSubject = BehaviorSubject();

  List<FileModel> filesFromApi = [];
  List<BytesFileModel> selectedFiles = [];

  bool checkOverMaxSize({double? maxSize, List<File>? newFiles}) {
    double totalSize = 0;
    for (final file in selectedFiles) {
      totalSize += file.fileLength;
    }
    for (final file in newFiles ?? []) {
      totalSize += file.lengthSync();
    }
    return totalSize > (maxSize ?? MaxSizeFile.MAX_SIZE_20MB);
  }
}

class BytesFileModel {
  int fileLength;
  List<int> base64File;
  String path;

  BytesFileModel({
    required this.fileLength,
    required this.base64File,
    required this.path,
  });

  MultipartFile convertToMultipart() {
    return MultipartFile.fromBytes(base64File);
  }
}
