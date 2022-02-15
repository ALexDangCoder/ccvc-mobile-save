import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class PhatBieuWidgetTablet extends StatefulWidget {
  const PhatBieuWidgetTablet({Key? key}) : super(key: key);

  @override
  _PhatBieuWidgetTabletState createState() => _PhatBieuWidgetTabletState();
}

class _PhatBieuWidgetTabletState extends State<PhatBieuWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.phat_bieu,
      ),
    );
  }
}
