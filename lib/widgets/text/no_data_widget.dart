import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class NodataWidget extends StatelessWidget {
  const NodataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.khong_co_du_lieu,
        style: textNormal(
          AppTheme.getInstance().titleColor(),
          14.0.textScale(),
        ),
      ),
    );
  }
}
