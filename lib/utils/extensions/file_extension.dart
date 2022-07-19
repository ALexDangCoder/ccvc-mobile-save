import 'dart:io';

import 'package:ccvc_mobile/widgets/button/button_select_file_lich_lam_viec.dart';

extension ConvertFile on File {
  FileModel convertToFiles() {
    return FileModel(
      size: lengthSync(),
      file: this,
    );
  }
}
