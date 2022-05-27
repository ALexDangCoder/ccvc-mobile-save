import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class MangXaHoiNoiBoTablet extends StatefulWidget {
  const MangXaHoiNoiBoTablet({Key? key}) : super(key: key);

  @override
  _MangXaHoiNoiBoTabletState createState() => _MangXaHoiNoiBoTabletState();
}

class _MangXaHoiNoiBoTabletState extends State<MangXaHoiNoiBoTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.mang_xa_hoi_noi_bo),
      body: Container(),
    );
  }
}
