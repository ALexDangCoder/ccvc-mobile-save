import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:flutter/material.dart';

class YKienCuocHopWidget extends StatefulWidget {
  const YKienCuocHopWidget({Key? key}) : super(key: key);

  @override
  _YKienCuocHopWidgetState createState() => _YKienCuocHopWidgetState();
}

class _YKienCuocHopWidgetState extends State<YKienCuocHopWidget> {
  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.y_kien_cuop_hop,
      child: Container(
        color: Colors.red,
        height: 50,
      ),
    );
  }
}
