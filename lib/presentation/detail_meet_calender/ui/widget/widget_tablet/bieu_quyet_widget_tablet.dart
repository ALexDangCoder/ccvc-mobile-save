import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class BieuQuyetWidgetTablet extends StatefulWidget {
  const BieuQuyetWidgetTablet({Key? key}) : super(key: key);

  @override
  _BieuQuyetWidgetTabletState createState() => _BieuQuyetWidgetTabletState();
}

class _BieuQuyetWidgetTabletState extends State<BieuQuyetWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.bieu_quyet,
      ),
    );
  }
}
