import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class KetLuanHopWidgetTablet extends StatefulWidget {
  const KetLuanHopWidgetTablet({Key? key}) : super(key: key);

  @override
  _KetLuanHopWidgetTabletState createState() => _KetLuanHopWidgetTabletState();
}

class _KetLuanHopWidgetTabletState extends State<KetLuanHopWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.ket_luan_hop,
      ),
    );
  }
}
