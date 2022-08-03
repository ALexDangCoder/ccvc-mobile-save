
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rxdart/rxdart.dart';

class SelectFileCubit2{
  BehaviorSubject<bool> needRebuildListFile = BehaviorSubject();
  BehaviorSubject<List<FileModel>> fileFromApiSubject = BehaviorSubject();

  List<FileModel> get filesFromApi => fileFromApiSubject.valueOrNull ?? [];
  List<PlatformFile> selectedFiles = [];

  bool checkOverMaxSize({double? maxSize, List<PlatformFile>? newFiles}) {
    double totalSize = 0;
    for (final file in selectedFiles) {
      totalSize += file.size;
    }
    for (final file in filesFromApi) {
      totalSize += file.fileLength ?? 0;
    }
    for (final file in newFiles ?? []) {
      totalSize += file.lengthSync();
    }
    return totalSize > (maxSize ?? MaxSizeFile.MAX_SIZE_20MB);
  }
}