import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class TabAnhDeoKinh extends StatelessWidget {
  const TabAnhDeoKinh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(S.current.anh_deo_kinh),
      ),
    );
  }
}
