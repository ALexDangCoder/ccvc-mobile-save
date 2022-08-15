import 'dart:io';

import 'package:ccvc_mobile/widgets/button/button_select_file_lich_lam_viec.dart';

extension ConvertFile on File {
  FileModel convertToFiles() {
    return FileModel(
      size: lengthSync(),
      file: this,
    );
  }

  Future<File> moveToTmpDirectory(String newPath) async {
    try {
      return await rename(newPath);
    } catch (e) {
      final newFile = await copy(newPath);
      return newFile;
    }
  }

}
