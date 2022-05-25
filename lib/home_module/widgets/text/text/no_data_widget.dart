
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
class NodataWidget extends StatelessWidget {
  const NodataWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Text(
          title ?? S.current.khong_co_du_lieu,
          style: textNormal(
            titleColor,
            14.0.textScale(),
          ),
        ),
      ),
    );
  }
}
