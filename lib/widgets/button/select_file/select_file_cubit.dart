import 'dart:io';

import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:rxdart/rxdart.dart';

class SelectFileCubit{
  BehaviorSubject<bool> needRebuildListFile = BehaviorSubject();
  BehaviorSubject<List<FileModel>> fileFromApi = BehaviorSubject();

  List<File> selectedFiles = [];
}