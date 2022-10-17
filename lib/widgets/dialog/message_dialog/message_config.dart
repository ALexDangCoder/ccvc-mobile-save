import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/mess_dialog_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum MessState { error, success, customIcon }

class MessageConfig {
  static BuildContext? contextConfig;
  static OverlayEntry? _overlayEntry;
  static void init(BuildContext context) {
    if (contextConfig != null) {
      return;
    }
    contextConfig = context;
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
    if (_overlayEntry != null) {
      return;
    }
    final OverlayState? overlayState = Overlay.of(contextConfig!);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return MessageDialogPopup(
          onDismiss: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
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

    overlayState?.insert(_overlayEntry!);
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

  static Future<void> showDialogSetting({
    String? title,
    String? okBtnTxt,
    String? cancelBtnTxt,
  }) async {
    final Widget okButton = TextButton(
      child: Text(
        okBtnTxt ?? S.current.mo_cai_dat,
        style: textNormal(redChart, 14),
      ),
      onPressed: () {
        Navigator.pop(contextConfig!);
        openAppSettings();
      },
    );

    final Widget cancelBtnText = TextButton(
      child: Text(
        cancelBtnTxt ?? S.current.bo_qua,
        style: textNormal(redChart, 14),
      ),
      onPressed: () {
        Navigator.pop(contextConfig!);
      },
    );
    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: Text(title ?? S.current.ban_can_mo_quyen_de_truy_cap_ung_dung,
          style: textNormal(titleColumn, 15)),
      actions: [okButton, cancelBtnText],
    );

    return showDialog(
      context: contextConfig!,
      builder: (_) {
        return alert;
      },
    );
  }
}
