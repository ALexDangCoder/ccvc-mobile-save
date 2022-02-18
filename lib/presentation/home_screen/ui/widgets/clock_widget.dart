import 'dart:async';

import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 timer=Timer.periodic(const Duration(seconds: 1), (timer) {
   setState(() {

   });
 });
  }
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final  hour= now.hour<10 ? '0${now.hour}' : now.hour.toString();
    final minute =now.minute <10 ? '0${now.minute}' : now.minute.toString();
    final second = now.second <10 ?'0${now.second}' : now.second.toString();
    return  Text(
      '$hour:$minute:$second',
      style: textNormalCustom(
          fontSize: 28.0.textScale(space: 4),
          fontWeight: FontWeight.w500,
          color: AppTheme.getInstance().titleColor(),),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
}
