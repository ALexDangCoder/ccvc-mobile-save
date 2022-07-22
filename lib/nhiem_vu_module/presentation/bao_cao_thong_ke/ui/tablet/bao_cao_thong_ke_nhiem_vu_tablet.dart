import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class BaoCaoThongKeNhiemVuTablet extends StatefulWidget {
  const BaoCaoThongKeNhiemVuTablet({Key? key}) : super(key: key);

  @override
  _BaoCaoThongKeNhiemVuTabletState createState() =>
      _BaoCaoThongKeNhiemVuTabletState();
}

class _BaoCaoThongKeNhiemVuTabletState
    extends State<BaoCaoThongKeNhiemVuTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.current.bao_cao_thong_ke),
    );
  }
}
