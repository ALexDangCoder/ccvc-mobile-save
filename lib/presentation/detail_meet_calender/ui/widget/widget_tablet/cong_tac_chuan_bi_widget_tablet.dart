import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class CongTacChuanBiWidgetTablet extends StatefulWidget {
  const CongTacChuanBiWidgetTablet({Key? key}) : super(key: key);

  @override
  _CongTacChuanBiWidgetTabletState createState() => _CongTacChuanBiWidgetTabletState();
}

class _CongTacChuanBiWidgetTabletState extends State<CongTacChuanBiWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.cong_tac_chuan_bi,
      ),
    );
  }
}
