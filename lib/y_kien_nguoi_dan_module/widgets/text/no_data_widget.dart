
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/config/resources/color.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class NodataWidget extends StatelessWidget {
  const NodataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Text(
          S.current.khong_co_du_lieu,
          style: textNormal(
            titleColor,
            14.0.textScale(),
          ),
        ),
      ),
    );
  }
}
