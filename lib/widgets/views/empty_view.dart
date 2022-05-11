import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String? _message;

  const EmptyView(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _message ?? '',
        style: textNormal(AppTheme.getInstance().dfTxtColor(), 16),
      ),
    );
  }
}
