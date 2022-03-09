import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/generated/l10n.dart';
import 'package:get/get.dart';
import '/home_module/config/resources/styles.dart';

class IOSDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final String? ok;
  final String? cancel;
  final Function? onConfirm;
  final Function? onCancel;

  const IOSDialog({
    Key? key,
    this.title,
    @required this.content,
    this.titleStyle,
    this.contentStyle,
    this.ok,
    this.cancel,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[];
    if (cancel != null) actions.add(cancelButton());
    actions.add(okButton());
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title ?? '',
              style: textNormal(null, 16),
            )
          : null,
      content: Text(
        content ?? '',
        style: contentStyle ?? textNormal(null, 14),
      ),
      actions: actions,
    );
  }

  Widget cancelButton() {
    return CupertinoDialogAction(
      child: Text(
        cancel ?? S.current.cancel,
        style: textNormal(null, 14),
      ),
      onPressed: () {
        Get.back();
        if (onCancel != null) onCancel!();
      },
    );
  }

  Widget okButton() {
    return CupertinoDialogAction(
      child: Text(
        ok ?? S.current.ok,
        style: textNormal(null, 14),
      ),
      onPressed: () {
        Get.back();
        if (onConfirm != null) onConfirm!();
      },
    );
  }
}
