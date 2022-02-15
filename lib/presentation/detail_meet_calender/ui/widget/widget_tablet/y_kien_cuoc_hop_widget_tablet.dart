import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class YKienCuocHopWidgetTablet extends StatefulWidget {
  const YKienCuocHopWidgetTablet({Key? key}) : super(key: key);

  @override
  _YKienCuocHopWidgetTabletState createState() =>
      _YKienCuocHopWidgetTabletState();
}

class _YKienCuocHopWidgetTabletState extends State<YKienCuocHopWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.phat_bieu,
      ),
    );
  }
}
