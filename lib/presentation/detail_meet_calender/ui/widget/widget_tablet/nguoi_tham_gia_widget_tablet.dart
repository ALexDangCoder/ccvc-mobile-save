import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
class MoiNguoiThamGiaWidgetTablet extends StatefulWidget {
  const MoiNguoiThamGiaWidgetTablet({Key? key}) : super(key: key);

  @override
  _MoiNguoiThamGiaWidgetTabletState createState() => _MoiNguoiThamGiaWidgetTabletState();
}

class _MoiNguoiThamGiaWidgetTabletState extends State<MoiNguoiThamGiaWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.thanh_phan_tham_gia,
      ),
    );
  }
}
