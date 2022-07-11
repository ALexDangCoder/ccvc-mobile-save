import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static Future<void> showDialogDelete(
    BuildContext context, {
    required String title,
    required Widget icon,
    String okBtnText = '',
    String cancelBtnText = '',
    required Function okBtnFunction,
  }) async {
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Container(
            width: 358.0.textScale(space: 14),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40.0.textScale(space: 4),
                ),
                icon,
                SizedBox(
                  height: 23.0.textScale(space: 4),
                ),
                Text(
                  title,
                  style: textNormalCustom(color: textTitle, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 14.0.textScale(),
                ),
                Text(
                  S.current.ban_co_chac_chan_xoa,
                  style: textNormalCustom(
                    color: infoColor,
                    fontSize: 14.0.textScale(),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24.0.textScale(space: 8),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: DoubleButtonBottom(
                    title2: S.current.xoa,
                    onClickLeft: () {
                      Navigator.pop(context);
                    },
                    onClickRight: () {
                      okBtnFunction();
                    },
                    title1: S.current.huy,
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

Future<bool?> showToast(
  String msg, {
  Toast length = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: length,
    gravity: gravity,
    fontSize: 14,
    backgroundColor: Colors.black,
    textColor: Colors.white.withOpacity(0.8),
  );

}
