import 'dart:io';

import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:rxdart/rxdart.dart';

class SelectFileCubit{
  BehaviorSubject<bool> needRebuildListFile = BehaviorSubject();
  BehaviorSubject<List<FileModel>> fileFromApiSubject = BehaviorSubject();
  BehaviorSubject<String> errMessageSubject = BehaviorSubject();


  List<FileModel> get filesFromApi => fileFromApiSubject.valueOrNull ?? [];
  List<File> selectedFiles = [];

  bool checkOverMaxSize({double? maxSize, List<File>? newFiles}) {
    if (maxSize == null) {
      return false;
    }
    double totalSize = 0;
    for (final file in selectedFiles) {
      totalSize += file.lengthSync();
    }
    for (final file in filesFromApi) {
      totalSize += file.fileLength ?? 0;
    }
    for (final file in newFiles ?? []) {
      totalSize += file.lengthSync();
    }
    return totalSize > maxSize;
  }
}