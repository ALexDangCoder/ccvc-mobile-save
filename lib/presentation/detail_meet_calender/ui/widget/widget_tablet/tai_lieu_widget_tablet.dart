import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class TaiLieuWidgetTablet extends StatefulWidget {
  const TaiLieuWidgetTablet({Key? key}) : super(key: key);

  @override
  _TaiLieuWidgetTabletState createState() => _TaiLieuWidgetTabletState();
}

class _TaiLieuWidgetTabletState extends State<TaiLieuWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.tai_lieu,
      ),
    );
  }
}
