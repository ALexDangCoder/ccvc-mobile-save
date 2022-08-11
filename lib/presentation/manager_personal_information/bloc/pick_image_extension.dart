import 'dart:io';

import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/pick_media_file.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';
import 'package:file_picker/file_picker.dart';

extension PickImageExtension on ManagerPersonalInformationCubit {
  Future<ModelAnh> pickAvatar() async {
    if (Platform.isIOS) {
      final resultMap = await pickImageFunc(tittle: 'Pick avatar');
      final _path = resultMap.stringValueOrEmpty(PATH_OF_FILE);
      final _size = resultMap.intValue(SIZE_OF_FILE);
      return ModelAnh(path: _path, size: _size);
    } else {
      return pickAvatarOnAndroid();
    }
  }

  Future<ModelAnh> pickAvatarOnAndroid() async {
    const allowedExtensions = [
      FileExtensions.JPEG,
      FileExtensions.JPG,
      FileExtensions.PNG,
      FileExtensions.HEIC,
    ];

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions,
      type: FileType.custom,
    );
    if (result == null || result.files.isEmpty) {
      return ModelAnh(
        path: '',
        size: 0,
      );
    }
    if (!allowedExtensions.contains(
      result.files.first.extension?.toLowerCase().replaceAll('.', ''),
    )) {
      return ModelAnh(
        path: '',
        size: 0,
        notAcceptFile: true,
      );
    }
    return ModelAnh(
      path: result.files.first.path ?? '',
      size: result.files.first.size,
    );
  }
}

class ModelAnh {
  String path;
  int size;
  bool notAcceptFile;

  ModelAnh({
    required this.path,
    required this.size,
    this.notAcceptFile = false,
  });
}
