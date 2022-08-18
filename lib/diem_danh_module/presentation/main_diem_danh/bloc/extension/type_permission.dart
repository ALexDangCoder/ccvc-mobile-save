import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';

enum ImageSelection {
  /// chưa có quyền truy cập ảnh
  NO_STORAGE_PERMISSION,

  ///Từ chối quyền truy cập ảnh
  NO_STORAGE_PERMISSION_PERMANENT,

  /// Chấp nhận quyền truy cập ảnh
  PICK_IMAGE,
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
