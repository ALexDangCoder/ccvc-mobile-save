import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/mess_dialog_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MessState { error, success, customIcon }

class MessageConfig {
  static BuildContext? _context;

  static void init(BuildContext context) {
    if (_context != null) {
      return;
    }
    _context = context;
  }

  static void show({
    String title = '',
    String title2 = '',
    bool? showTitle2 = false,
    FontWeight? fontWeight,
    double? fontSize,
    String urlIcon = '',
    MessState messState = MessState.success,
    Function()? onDismiss,
  }) {
    final OverlayState? overlayState = Overlay.of(_context!);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return MessageDialogPopup(
          onDismiss: () {
            overlayEntry.remove();
            if (onDismiss != null) {
              onDismiss();
            }
          },
          urlIcon: _urlIcon(messState, urlIcon),
          title: title,
          showTitle2: showTitle2,
          title2: title2,
          fontSize: fontSize ?? 18.0,
          fontWeight: fontWeight ?? FontWeight.w500,
        );
      },
    );

    overlayState?.insert(overlayEntry);
  }

  static String _urlIcon(MessState messState, String urlIcon) {
    switch (messState) {
      case MessState.error:
        return ImageAssets.icError;
      case MessState.success:
        return ImageAssets.icSucces;
      case MessState.customIcon:
        return urlIcon;
    }
  }
}
