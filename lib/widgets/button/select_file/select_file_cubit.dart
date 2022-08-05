import 'dart:io';

import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:rxdart/rxdart.dart';

class SelectFileCubit{
  BehaviorSubject<bool> needRebuildListFile = BehaviorSubject();
  BehaviorSubject<List<FileModel>> fileFromApiSubject = BehaviorSubject();

  List<FileModel> filesFromApi = [];
  List<File> selectedFiles = [];

  bool checkOverMaxSize({double? maxSize, List<File>? newFiles}) {
    double totalSize = 0;
    for (final file in selectedFiles) {
      totalSize += file.lengthSync();
    }
    for (final file in newFiles ?? []) {
      totalSize += file.lengthSync();
    }
    return totalSize > (maxSize ?? MaxSizeFile.MAX_SIZE_20MB);
  }
}