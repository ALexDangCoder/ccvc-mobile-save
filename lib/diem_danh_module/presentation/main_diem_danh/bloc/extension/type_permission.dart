import 'dart:io';

import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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

enum ImageSelection {
  /// chưa có quyền truy cập ảnh
  NO_STORAGE_PERMISSION,

  ///Từ chối quyền truy cập ảnh
  NO_STORAGE_PERMISSION_PERMANENT,

  /// Chấp nhận quyền truy cập ảnh
  PICK_IMAGE,
}

Future<ModelAnh> pickAvatarOnAndroid() async {
  const allowedExtensions = [
    FileExtensions.JPEG,
    FileExtensions.JPG,
    FileExtensions.PNG,
    FileExtensions.HEIC,
  ];
  try {
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
  } on PlatformException catch (_) {
    await MessageConfig.showDialogSetting();
    return ModelAnh(
      path: '',
      size: 0,
    );
  }
}

class ImagePermission {
  ImageSelection perrmission = ImageSelection.NO_STORAGE_PERMISSION;

  Future<void> requestFilePermission() async {
    PermissionStatus result;

    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }

    if (result.isGranted) {
      perrmission = ImageSelection.PICK_IMAGE;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      perrmission = ImageSelection.NO_STORAGE_PERMISSION_PERMANENT;
    } else {
      perrmission = ImageSelection.NO_STORAGE_PERMISSION;
    }
  }

  Future<void> checkFilePermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.storage.status;
    } else {
      result = await Permission.photos.status;
    }

    if (result.isGranted) {
      perrmission = ImageSelection.PICK_IMAGE;
    } else if (result.isPermanentlyDenied) {
      perrmission = ImageSelection.NO_STORAGE_PERMISSION_PERMANENT;
    } else {
      perrmission = ImageSelection.NO_STORAGE_PERMISSION;
    }
  }

  Future<void> openSettingApp() async {
    await MessageConfig.showDialogSetting();
  }
}
