import 'package:ccvc_mobile/tien_ich_module/presentation/chuyen_giong_noi_thanh_van_ban/ui/mobile/speech_to_text_mobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BocBangWidget extends StatefulWidget {
  const BocBangWidget({Key? key}) : super(key: key);

  @override
  _BocBangWidgetState createState() => _BocBangWidgetState();
}

class _BocBangWidgetState extends State<BocBangWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text(''), SpeechToTextMobile()],
    );
  }
}
