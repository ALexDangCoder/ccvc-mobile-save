import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/select_only_widget.dart';
import 'package:flutter/material.dart';

class TaiLieuWidget extends StatefulWidget {
  const TaiLieuWidget({Key? key}) : super(key: key);

  @override
  _TaiLieuWidgetState createState() => _TaiLieuWidgetState();
}

class _TaiLieuWidgetState extends State<TaiLieuWidget> {
  @override
  Widget build(BuildContext context) {
    return SelectOnlyWidget(
      title: S.current.tai_lieu,
      child: Container(
        color: Colors.red,
        height: 50,
      ),
    );
  }
}
