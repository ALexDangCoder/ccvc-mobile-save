import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:flutter/material.dart';

class KetLuanHopWidget extends StatefulWidget {
  const KetLuanHopWidget({Key? key}) : super(key: key);

  @override
  _KetLuanHopWidgetState createState() => _KetLuanHopWidgetState();
}

class _KetLuanHopWidgetState extends State<KetLuanHopWidget> {
  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.ket_luan_hop,
      child: Container(
        color: Colors.red,
        height: 50,
      ),
    );
  }
}
