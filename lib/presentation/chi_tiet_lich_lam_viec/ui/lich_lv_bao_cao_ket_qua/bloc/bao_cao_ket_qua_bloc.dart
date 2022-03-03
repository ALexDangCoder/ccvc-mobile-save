import 'dart:developer';
import 'dart:io';

import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:rxdart/rxdart.dart';

class BaoCaoKetQuaCubit {
  final BehaviorSubject<List<FileModel>> _getFileApi =
      BehaviorSubject<List<FileModel>>();

  Stream<List<FileModel>> get getFileApi => _getFileApi.stream;

  final BehaviorSubject<List<File>> _addFile = BehaviorSubject<List<File>>();

  Stream<List<File>> get addFile => _addFile.stream;
  final List<FileModel> listFileModel = [];
  final List<FileModel> listFileRemove = [];
  String idReport = '';
  List<File> filesLocal = [];
  void getFile(List<FileModel> files) {
    listFileModel.addAll(files);
    _getFileApi.sink.add(listFileModel);
  }
void selectReport(String id){
    idReport = id;
}
  void removeFileApi(FileModel fileModel) {
    listFileRemove.add(fileModel);
    listFileModel.remove(fileModel);
    _getFileApi.sink.add(listFileModel);
  }

  void addFilesLocal(List<File> files) {
    filesLocal = files;
    _addFile.sink.add(files);
  }
  void removeFileLocal(File file){
    filesLocal.remove(file);
    _addFile.sink.add(filesLocal);
  }
}
