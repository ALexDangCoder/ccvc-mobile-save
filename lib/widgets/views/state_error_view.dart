import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/style_utils.dart';
import 'package:ccvc_mobile/widgets/app_button.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class StateErrorView extends StatelessWidget {
  final String? _message;
  final Function() _retry;
  final String? title;

  const StateErrorView(this._message, this._retry, {Key? key, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title?.isNotEmpty ?? false
          ? AppBarDefaultBack(title.toString())
          : null,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _message ?? S.of(context).something_went_wrong,
              style: textStyle(),
            ),
            spaceH15,
            AppButton(
              S.of(context).retry,
              _retry,
              borderRadius: 8,
              width: 90,
            ),
          ],
        ),
      ),
    );
  }
}
