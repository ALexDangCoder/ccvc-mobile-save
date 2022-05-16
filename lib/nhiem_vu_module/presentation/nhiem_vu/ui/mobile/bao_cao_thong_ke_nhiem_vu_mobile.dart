import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class BaoCaoThongKeNhiemVuMobile extends StatefulWidget {
  const BaoCaoThongKeNhiemVuMobile({Key? key}) : super(key: key);

  @override
  _BaoCaoThongKeNhiemVuMobileState createState() => _BaoCaoThongKeNhiemVuMobileState();
}

class _BaoCaoThongKeNhiemVuMobileState extends State<BaoCaoThongKeNhiemVuMobile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.current.bao_cao_thong_ke),
    );
  }
}
